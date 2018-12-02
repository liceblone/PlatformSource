unit ADBGrid;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, DBGrids, Math;

type
  TADBGrid = class(TDBGrid)
  private
    { Private declarations }
    //兄弟列子标题,当前列子标题
    BrerLayerTitles, CurLayerTitles: TStringList;
    SaveFont: TFont;
    //根据当前数据列号和表头的层号获取表头的区域
    function TitleLayerRect(LayerTitles: TStrings; TitleRect: TRect; LayerID, ACol: Integer): TRect;
    //解出当前数据列标题为子标题并返回标题层数(子标题数)
    function ExtractSubTitle(LayerTitles: TStrings; ACol: Integer): Integer;
  protected
    { Protected declarations }
    procedure DrawCell(ACol, ARow: Longint; ARect: TRect; AState: TGridDrawState); override;
    procedure Paint; override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    { Published declarations }
  end;


implementation


constructor TADBGrid.Create(AOwner: TComponent);
begin
  inherited;
  BrerLayerTitles := TStringList.Create;
  curLayerTitles := TStringList.Create;
  SaveFont := TFont.Create;
end;

destructor TADBGrid.Destroy;
begin
  BrerLayerTitles.Free;
  curLayerTitles.Free;
  SaveFont.Free;
  inherited;
end;

procedure TADBGrid.DrawCell(ACol, ARow: Integer; ARect: TRect;
  AState: TGridDrawState);
var
  SubTitleRT, CaptionRt, IndicatorRT: TRect;
  Column: TColumn;
  SubTitle: string;
  i: Integer;
begin
  if (ARow = 0) and (ACol > 0) then
  begin
    ExtractSubTitle(curLayerTitles, RawToDataColumn(ACol));
    for i := 0 to curLayerTitles.Count - 1 do
    begin
      SubTitleRT := TitleLayerRect(curLayerTitles, ARect, i, RawToDataColumn(ACol));
      CaptionRt := SubTitleRT;
      Canvas.Brush.Color := FixedColor;
      Canvas.FillRect(SubTitleRT);

      DrawEdge(Canvas.Handle, SubTitleRT, BDR_RAISEDINNER, BF_TOPLEFT);
      if i <> CurLayerTitles.Count - 1 then
      begin
        DrawEdge(Canvas.Handle, SubTitleRT, BDR_RAISEDOUTER, BF_BOTTOM);
        Dec(SubTitleRT.Bottom, 2);
      end else Dec(SubTitleRT.Bottom, 1);
      Canvas.Pen.Color := clWhite;
      Dec(SubTitleRT.Right, 1);
      Canvas.MoveTo(SubTitleRT.Right, SubTitleRT.Top);
      Canvas.LineTo(SubTitleRT.Right, SubTitleRT.Bottom);
      Canvas.LineTo(SubTitleRT.Left, SubTitleRT.Bottom);
      Column := Columns[RawToDataColumn(ACol)];
      SubTitle := '';
      if Assigned(Column) then
      begin
        SubTitle := CurLayerTitles[i];
        SaveFont.Assign(Canvas.Font);
        Canvas.Font.Assign(TitleFont);
        try
          InflateRect(SubTitleRT, -1, -1);
          DrawText(Canvas.Handle, PChar(SubTitle), Length(SubTitle),
            SubTitleRT, DT_CENTER or DT_SINGLELINE or DT_VCENTER);
        finally
          Canvas.Font.Assign(SaveFont);
        end;
      end;
    end;
    if dgIndicator in Options then
    begin
      IndicatorRT := Rect(0, 0, IndicatorWidth + 1, RowHeights[0]);
      Canvas.FillRect(IndicatorRT);
      IndicatorRT.Right := IndicatorRT.Right - 1;
      Canvas.Rectangle(IndicatorRT);
      IndicatorRT.Right := IndicatorRT.Right + 1;
      DrawEdge(Canvas.Handle, IndicatorRT, BDR_RAISEDOUTER, BF_RIGHT);
    end;
  end
  else begin
    inherited;
    if ACol = 0 then
      DrawEdge(Canvas.Handle, ARect, BDR_SUNKENOUTER, BF_BOTTOMRIGHT);
  end;
end;

function TADBGrid.ExtractSubTitle(LayerTitles: TStrings;
  ACol: Integer): Integer;
var L, P: Integer;
  SubTitle: string;
begin
  Result := 0;
  if Assigned(Columns[ACol]) then
    SubTitle := Columns[ACol].Title.Caption
  else Exit;
  if LayerTitles <> nil then LayerTitles.Clear;
  L := 0;
  repeat
    P := Pos('|', SubTitle);
    if P = 0 then
    begin
      if LayerTitles <> nil then LayerTitles.Add(SubTitle);
    end
    else begin
      if LayerTitles <> nil then LayerTitles.Add(Copy(SubTitle, 1, P - 1));
      SubTitle := Copy(SubTitle, P + 1, Length(SubTitle) - P);
    end;
    L := L + 1;
  until P = 0;
  Result := L;
end;

procedure TADBGrid.Paint;
var
  i, MaxLayer, Layer: Integer;
  TM: TTextMetric;
begin
  if ([csLoading, csDestroying] * ComponentState) <> [] then Exit;
  MaxLayer := 0;
  //获取表头最大层数
  for i := 0 to Columns.Count - 1 do
  begin
    Layer := ExtractSubTitle(nil, i);
    if Layer > MaxLayer then MaxLayer := Layer;
  end;
  SaveFont.Assign(Canvas.Font);
  Canvas.Font.Assign(TitleFont);
  try
    GetTextMetrics(Canvas.Handle, TM);
    //调整DBGrid的标题行高度
    RowHeights[0] := (TM.tmHeight + TM.tmInternalLeading + 3) * MaxLayer;
  finally
    Canvas.Font.Assign(SaveFont);
  end;
  inherited;
end;

function TADBGrid.TitleLayerRect(LayerTitles: TStrings; TitleRect: TRect;
  LayerID, ACol: Integer): TRect;
var
  SubTitle: string;
  i, j: Integer;
  bBrer: Boolean;
begin
  Result := TitleRect;
  if Assigned(Columns[ACol]) then
    SubTitle := Columns[ACol].Title.Caption
  else Exit;
  ExtractSubTitle(LayerTitles, ACol);
  //联合左边的兄弟列
  for i := ACol - 1 downto 0 do
  begin
    ExtractSubTitle(BrerLayerTitles, i);
    bBrer := False;
    //判断是否为兄弟列
    if (BrerLayerTitles.Count = LayerTitles.Count) then
    begin
      for j := 0 to LayerID do
      begin
        bBrer := BrerLayerTitles[j] = LayerTitles[j];
        if not bBrer then
          Break;
      end;
    end;
    if bBrer then
    begin
      Result.Left := Result.Left - Columns[i].Width;
      if dgColLines in Options then
        Result.Left := Result.Left - 1;
    end
    else Break;
  end;
  //联合右边的兄弟列
  for i := ACol + 1 to Columns.Count - 1 do
  begin
    ExtractSubTitle(BrerLayerTitles, i);
    bBrer := False;
    //判断是否为兄弟列
    if BrerLayerTitles.Count = LayerTitles.Count then
    begin
      for j := 0 to LayerID do
      begin
        bBrer := BrerLayerTitles[j] = LayerTitles[j];
        if not bBrer then
          Break;
      end;
    end;
    if bBrer then
    begin
      Result.Right := Result.Right + Columns[i].Width;
      if dgColLines in Options then
        Result.Right := Result.Right + 1;
    end
    else Break;
  end;
  //调整表头区域
  Result.Top := (RowHeights[0] div LayerTitles.Count) * LayerID;
  Result.Bottom := (RowHeights[0] div LayerTitles.Count) * (LayerID + 1);
end;

end.


