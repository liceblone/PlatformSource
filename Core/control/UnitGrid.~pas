unit UnitGrid;

interface
 uses     Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,math,
  Dialogs, StdCtrls,DBCtrls,ComCtrls,ADODB,Grids, menus,DBGrids,ActnList,FhlKnl,DB,StrUtils;
type TModelDbGrid=class(TDBGrid)
  Private
      FColor1:Tcolor;
      FColor2:Tcolor;

      FtoolID:string     ;
      FToolMenuItem:Tmenuitem;
      FLoginInfo:TLoginInfo;
      FFhlKnl :TFhlKnl;

      FGridPrivorSel:integer;//    MouseMove   里之前选择的行

      blSelect: Boolean;  //mul select  Mouseup
      BookMark: TBookMark;
      CurrNo, OldNo: integer;

      { Private declarations }
      //兄弟列子标题,当前列子标题
      BrerLayerTitles, CurLayerTitles: TStringList;
      SaveFont: TFont;
      FNeedSumRow: Boolean;
      //根据当前数据列号和表头的层号获取表头的区域
      function TitleLayerRect(LayerTitles: TStrings; TitleRect: TRect; LayerID, ACol: Integer): TRect;
      //解出当前数据列标题为子标题并返回标题层数(子标题数)
      function ExtractSubTitle(LayerTitles: TStrings; ACol: Integer): Integer;

      procedure SetColor1(Pcolor:Tcolor);
      procedure SetColor2(Pcolor:Tcolor);
      function GetColor1:Tcolor;
      function GetColor2:Tcolor;
      procedure WMMmouseWheel(var Message: TMessage);message WM_MOUSEWHEEL;
      procedure MouseMove(Sender: TObject;  Shift: TShiftState; X, Y: Integer);
      procedure WMSize(var Message: TWMSize); message WM_SIZE;
//      procedure KeyDown(Sender: TObject; var Key: Word;     Shift: TShiftState);
      procedure Mouseup(Sender: TObject; Button: TMouseButton;   Shift: TShiftState; X, Y: Integer);

      procedure DrawCell(ACol, ARow: Longint; ARect: TRect; AState: TGridDrawState); override;
      procedure Paint; override;
      procedure KeyDown(var Key: Word; Shift: TShiftState); override;
      procedure SetNeedSumRow(const Value: Boolean);
      function getFixedCol: integer;
      procedure setFixedCol(const Value: integer);
  public
       Procedure SetToolID(PtoolID:string);
       Procedure SetLoginInfo(PLoginInfo:TLoginInfo);
       procedure setfhlknl(pFhlKnl :TFhlKnl);
       Procedure SetPopupMenu(PPopupMenu:TPopupMenu);
       procedure ToolMenuClick(sender:Tobject);

       procedure Dg_DrawZebraBackgroud(Sender: TObject;const Rect: TRect; DataCol: Integer; Column: TColumn;State: TGridDrawState);
       constructor create(aowner:Tcomponent);override;
       destructor Destroy; override;
       procedure DrawColumnCellFntClr(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;  State: TGridDrawState);
       procedure TitleClick(Column: TColumn);
       Procedure ReflashSumValues;
       Function  GetColbyFieldName(FieldName:string ):TColumn;


  published
      property Color1 :Tcolor read getcolor1 write setcolor1 default clWhite;
      property Color2 :Tcolor read getcolor2 write setcolor2 default clCream;
      Property NeedSumRow:Boolean read FNeedSumRow write SetNeedSumRow default false;
      property FixedColCount :integer read getFixedCol write setFixedCol default 1;
  end;


implementation
{ TModelDbGrid }
     uses UnitCreateComponent,UPublicCtrl;


var
  DrawBitmap: TBitmap;
  UserCount: Integer;

procedure UsesBitmap;
begin
  if UserCount = 0 then
    DrawBitmap := TBitmap.Create;
  Inc(UserCount);
end;

procedure ReleaseBitmap;
begin
  Dec(UserCount);
  if UserCount = 0 then DrawBitmap.Free;
end;

procedure WriteText(ACanvas: TCanvas; ARect: TRect; DX, DY: Integer;
  const Text: string; Alignment: TAlignment; ARightToLeft: Boolean);
const
  AlignFlags : array [TAlignment] of Integer =
    ( DT_LEFT or DT_WORDBREAK or DT_EXPANDTABS or DT_NOPREFIX,
      DT_RIGHT or DT_WORDBREAK or DT_EXPANDTABS or DT_NOPREFIX,
      DT_CENTER or DT_WORDBREAK or DT_EXPANDTABS or DT_NOPREFIX );
  RTL: array [Boolean] of Integer = (0, DT_RTLREADING);
var
  B, R: TRect;
  Hold, Left: Integer;
  I: TColorRef;
begin
  I := ColorToRGB(ACanvas.Brush.Color);
  if GetNearestColor(ACanvas.Handle, I) = I then
  begin                       { Use ExtTextOut for solid colors }
    { In BiDi, because we changed the window origin, the text that does not
      change alignment, actually gets its alignment changed. }
    if (ACanvas.CanvasOrientation = coRightToLeft) and (not ARightToLeft) then
      ChangeBiDiModeAlignment(Alignment);
    case Alignment of
      taLeftJustify:
        Left := ARect.Left + DX;
      taRightJustify:
        Left := ARect.Right - ACanvas.TextWidth(Text) - 3;
    else { taCenter }
      Left := ARect.Left + (ARect.Right - ARect.Left) shr 1
        - (ACanvas.TextWidth(Text) shr 1);
    end;
    ACanvas.TextRect(ARect, Left, ARect.Top + DY, Text);
  end
  else begin                  { Use FillRect and Drawtext for dithered colors }
    DrawBitmap.Canvas.Lock;
    try
      with DrawBitmap, ARect do { Use offscreen bitmap to eliminate flicker and }
      begin                     { brush origin tics in painting / scrolling.    }
        Width := Max(Width, Right - Left);
        Height := Max(Height, Bottom - Top);
        R := Rect(DX, DY, Right - Left - 1, Bottom - Top - 1);
        B := Rect(0, 0, Right - Left, Bottom - Top);
      end;
      with DrawBitmap.Canvas do
      begin
        Font := ACanvas.Font;
        Font.Color := ACanvas.Font.Color;
        Brush := ACanvas.Brush;
        Brush.Style := bsSolid;
        FillRect(B);
        SetBkMode(Handle, TRANSPARENT);
        if (ACanvas.CanvasOrientation = coRightToLeft) then
          ChangeBiDiModeAlignment(Alignment);
        DrawText(Handle, PChar(Text), Length(Text), R,
          AlignFlags[Alignment] or RTL[ARightToLeft]);
      end;
      if (ACanvas.CanvasOrientation = coRightToLeft) then
      begin
        Hold := ARect.Left;
        ARect.Left := ARect.Right;
        ARect.Right := Hold;
      end;
      ACanvas.CopyRect(ARect, DrawBitmap.Canvas, B);
    finally
      DrawBitmap.Canvas.Unlock;
    end;
  end;
end;

constructor TModelDbGrid.create(aowner: Tcomponent);
begin
    inherited ;
    self.FColor1 :=clWhite;
    self.FColor2 :=clCream;

    self.onDrawColumnCell := self.Dg_DrawZebraBackgroud;
//    self.OnKeyDown :=self.KeyDown;
    self.OnMouseMove :=self.MouseMove;
    self.OnMouseup:=Mouseup;
    self.OnDrawColumnCell :=self.DrawColumnCellFntClr;
    self.OnTitleClick :=TitleClick ;
    
    BrerLayerTitles := TStringList.Create;
    curLayerTitles := TStringList.Create;
    SaveFont := TFont.Create;

end;

procedure TModelDbGrid.Dg_DrawZebraBackgroud(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
   if Not (dgMultiselect in self.Options ) then
        if Not (gdSelected in State) then
        with TDbGrid(Sender) do
        begin
            if DataSource.DataSet.RecNo mod 2=1 then
                Canvas.Brush.Color:=self.FColor1
             else
                Canvas.Brush.Color:=FColor2;
            DefaultDrawDataCell(Rect,Column.Field,State);
        end;
end;

procedure TModelDbGrid.DrawColumnCellFntClr(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  if self.DataSource.DataSet.IsEmpty then exit;

  if assigned(self.DataSource.DataSet.FindField ('FntClr') ) then
     Canvas.Font.Color:=StringToColor(self.DataSource.dataset.FieldByName('FntClr').AsString)
  else
     if (column.Field is Tnumericfield) and (column.Field.Value <>null) and (column.Field.Value<0) then
          Canvas.Font.Color:=StringToColor('clred');


  self.fFhlKnl.Dg_DrawLineFont(Sender,Rect,DataCol,Column,State,self.Canvas.Font);
end;

function TModelDbGrid.GetColor1: Tcolor;
begin
result:=self.FColor1 ;
end;

function TModelDbGrid.GetColor2: Tcolor;
begin
result:=self.FColor2 ;
end;



procedure TModelDbGrid.Mouseup(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
//self.FixedCols :=5;
//self.FixedRows :=3;
// self.FixedColor :=stringtocolor('clwhite');

Windows.SetFocus(Handle);

if   Columns.Count >1 then
begin
  self.Columns[1].Expanded:=true;
  if self.DataSource<>nil then
  if (Button = mbLeft) and (self.DataSource.DataSet.Active )then
  begin
    if not blSelect then
    begin
      BookMark := self.DataSource.DataSet.GetBookMark;
      OldNo := self.DataSource.DataSet.RecNo;
      blSelect := True;
      Exit;
    end
    else
    begin
      if ssShift in Shift then
      begin
        CurrNo := self.DataSource.DataSet.RecNo;
        self.DataSource.DataSet.DisableControls;
        self.DataSource.DataSet.GotoBookmark(BookMark);
        self.SelectedRows.CurrentRowSelected := True;
        if CurrNo > OldNo then
        begin
          while CurrNo > self.DataSource.DataSet.RecNo do
          begin
            self.SelectedRows.CurrentRowSelected := True;
            self.DataSource.DataSet.Next;
          end;
        end
        else
        begin
          while CurrNo < self.DataSource.DataSet.RecNo do
          begin
            self.SelectedRows.CurrentRowSelected := True;
            self.DataSource.DataSet.Prior;
          end;
        end;
        self.DataSource.DataSet.EnableControls;
        self.DataSource.DataSet.FreeBookmark(BookMark);
        blSelect := False;
        CurrNo := 0;
        OldNo := 0;
      end
      else
      begin
        BookMark := self.DataSource.DataSet.GetBookMark;
        OldNo := self.DataSource.DataSet.RecNo;
        blSelect := True;
        Exit;
      end;
    end;
  end;
end;
end;

procedure TModelDbGrid.MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
  var i :integer;
  var Cell: TGridCoord;
begin
if shift= [ssLeft,ssAlt, ssCtrl] then
self.BeginDrag(true);



{if  (ssLeft  in Shift) then
begin
     if dgRowSelect in self.Options  then
     begin
            Cell:= self.MouseCoord(x,y);
            if  Cell.y >0 then
            begin
                self.DataSource.DataSet.MoveBy(Cell.Y-self.DataSource.DataSet.RecNo );
                if FGridPrivorSel<>  Cell.Y then
                self.SelectedRows.CurrentRowSelected:=not self.SelectedRows.CurrentRowSelected ;

                if FGridPrivorSel=Cell.Y then
                self.SelectedRows.CurrentRowSelected:=true;

                FGridPrivorSel:=  Cell.Y;
            end;
      end;
end;    }

end;
procedure TModelDbGrid.SetColor1(Pcolor: Tcolor);
begin
self.FColor1 :=Pcolor;

end;

procedure TModelDbGrid.SetColor2(Pcolor: Tcolor);
begin
self.FColor2 :=Pcolor;
end;



procedure TModelDbGrid.setfhlknl(pFhlKnl: TFhlKnl);
begin
self.FFhlKnl :=pFhlKnl;
end;

procedure TModelDbGrid.SetLoginInfo(PLoginInfo: TLoginInfo);
begin
self.FLoginInfo :=    PLoginInfo;
end;

procedure TModelDbGrid.SetPopupMenu(PPopupMenu: TPopupMenu);
begin
  self.PopupMenu :=   PPopupMenu;

   if   self.FLoginInfo.Sys then                         //保留
   begin
     if PopupMenu.Items.Find('ConfigGrid')=nil then
     begin
        FToolMenuItem:=Tmenuitem.Create(self);
        FToolMenuItem.OnClick :=self.ToolMenuClick ;
        FToolMenuItem.Caption :='ConfigGrid';
        self.PopupMenu.Items.Add(FToolMenuItem);
     end;
   end;

   if assigned(self.OnDblClick)   then
   begin
        FToolMenuItem:=Tmenuitem.Create(self);
        FToolMenuItem.OnClick :=self.OnDblClick  ;
        FToolMenuItem.Caption :='打开';
        self.PopupMenu.Items.Insert (0,FToolMenuItem);
   end;
end;

procedure TModelDbGrid.SetToolID(PtoolID: string);
begin
self.FtoolID :=  PtoolID;


end;



procedure TModelDbGrid.ToolMenuClick(sender: Tobject);
var dbgrid:TdbGrid;

var CrtCom:TfrmCreateComponent    ;
begin
//
   dbgrid:=Tdbgrid(self.PopupMenu.PopupComponent);


  if FLoginInfo.Sys  then  begin
        CrtCom:=TfrmCreateComponent.Create(self);
        CrtCom.Hide;


        CrtCom.mtDataSet1:= Tadodataset(dbgrid.datasource.dataset );
        CrtCom.mtDataSetId :=inttostr(dbgrid.datasource.dataset.tag);
        CrtCom.TopOrBtm :=true;
        CrtCom.DLGrid := dbgrid;


        CrtCom.DlGridId :=inttostr(dbgrid.Tag );

       try
    CrtCom.Show;
finally

end;
  end;


end;


procedure TModelDbGrid.WMMmouseWheel(var Message: TMessage);
begin
 inherited;

 if DataSource.DataSet.Active then
 if not DataSource.DataSet.IsEmpty then
 if Message.wParam> 0 then
    self.DataSource.DataSet.Prior
  else
     self.DataSource.DataSet.Next ;
  Invalidate;
end;

function TModelDbGrid.ExtractSubTitle(LayerTitles: TStrings;
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

function TModelDbGrid.TitleLayerRect(LayerTitles: TStrings;
  TitleRect: TRect; LayerID, ACol: Integer): TRect;
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

procedure TModelDbGrid.DrawCell(ACol, ARow: Integer; ARect: TRect;
  AState: TGridDrawState);
var
  SubTitleRT, CaptionRt, IndicatorRT: TRect;
  Column: TColumn;
  SubTitle: string;
  i,LastLine ,adjrowcnt: Integer;
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
      //  Canvas.Font.Assign(TitleFont);
        Canvas.Font.Assign(Column.Title.Font );   //2010-1-10

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
  else
  begin

    inherited;
    if ACol = 0 then
      DrawEdge(Canvas.Handle, ARect, BDR_SUNKENOUTER, BF_BOTTOMRIGHT);

   // if (not   FNeedSumRow )and DataSource.DataSet.Active  then
     // rowcount:=self.DataSource.DataSet.RecordCount+curLayerTitles.Count   ;

    if FNeedSumRow and DataSource.DataSet.Active then
    if not DataSource.DataSet.IsEmpty then
    if not (DataSource.DataSet.State in [dsinsert,dsedit]) then
    begin

        //if FbAddedSumingline then    adjrowcnt:=1 else adjrowcnt:=0;

      adjrowcnt:=0;
      if  DataSource.DataSet.RecordCount <VisibleRowCount  then
      if curLayerTitles.Count>1 then
      adjrowcnt:=1;

       if  DataSource.DataSet.RecordCount <VisibleRowCount  then
         rowcount:=DataSource.DataSet.RecordCount+curLayerTitles.Count+1-adjrowcnt
       else
         rowcount:=VisibleRowCount  +curLayerTitles.Count+1 -adjrowcnt;


      if (gdFixed in AState) and (ACol < 0) then
      begin
      end
      else
      begin
        if  DataSource.DataSet.RecordCount <VisibleRowCount  then
        begin
          LastLine:=rowcount-1;
        end
        else
        begin
          LastLine:=VisibleRowCount +1 ;
        end;

        if (ARow=LastLine   ) and (ACol>0) then // and (ACol<columns.Count)      //3/22/2011    ARow>=LastLine =>ARow=LastLine 
        begin

         // application.Title :=inttostr(Arow);
              ARect.Top :=ARect.Top +2;
                  WriteText(Canvas, ARect, 2, 2, ( TChyColumn(Columns[Acol-1]).GroupValue ),self.Columns[Acol-1].Alignment  ,
                    UseRightToLeftAlignmentForField(Columns[Acol-1].Field, Columns[Acol-1].Alignment));

        end;
      end;
    end;

  end;
end;

procedure TModelDbGrid.Paint;
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

destructor TModelDbGrid.Destroy;
begin
  BrerLayerTitles.Free;
  curLayerTitles.Free;
  SaveFont.Free;
  inherited;

end;

procedure TModelDbGrid.TitleClick(Column: TColumn);
var fieldname,strtmp,OriCaption:string;
    i:integer;
begin
  if self.DataSource=nil then exit;
  if not self.DataSource.DataSet.Active then exit;
  if Column.Field=nil then exit;

  strtmp:=Column.Title.Caption;
  fieldname:= Column.FieldName;
  if (Column.Field.FieldKind  =  fkLookup ) then
   fieldname:= Column.Field.LookupKeyFields  ;

  if (Column.Field.FieldKind  =  fkCalculated ) then
    if  Tadodataset( self.DataSource.DataSet).FindField (leftstr( fieldname,length(fieldName)-3))<>nil then
        fieldname:=leftstr( fieldname,length(fieldName)-3)
    else
       exit;    

  if  Tadodataset( self.DataSource.DataSet).FindField ( fieldname)<>nil then
    if  TChyColumn(Column ).isAsc     then
    begin
     Tadodataset( self.DataSource.DataSet).Sort :=fieldname +' ASC';
    end
    else
    begin
        Tadodataset( self.DataSource.DataSet).Sort :=fieldname+' DESC';
    end   ;
       TChyColumn(Column ).isAsc  :=not   TChyColumn(Column ).isAsc     ;


end;

procedure TModelDbGrid.KeyDown(var Key: Word; Shift: TShiftState);
begin
  if (Key=VK_DOWN )and (DataLink.dataset.recordcount=DataLink.dataset.RecNo ) then
  begin
   // showmessage('');
  end
  else
    inherited;
end;

 

procedure TModelDbGrid.SetNeedSumRow(const Value: Boolean);
begin
  FNeedSumRow := Value;
end;

procedure TModelDbGrid.ReflashSumValues;
var i,j:Integer;
var SumValue,AVG,MinValue,MaxValue,FirstValue,LastValue,Value:Double;
var pdbgrid:TdbGrid;
var progress:TprogressBar;
begin
{ftUnknown, ftString, ftSmallint, ftInteger, ftWord,
    ftBoolean, ftFloat, ftCurrency, ftBCD, ftDate, ftTime, ftDateTime,
    ftBytes, ftVarBytes, ftAutoInc, ftBlob, ftMemo, ftGraphic, ftFmtMemo,
    ftParadoxOle, ftDBaseOle, ftTypedBinary, ftCursor, ftFixedChar, ftWideString,
    ftLargeint, ftADT, ftArray, ftReference, ftDataSet, ftOraBlob, ftOraClob,
    ftVariant, ftInterface, ftIDispatch, ftGuid, ftTimeStamp, ftFMTBcd}
    if not datasource.DataSet.Active then exit;
    try
    screen.Cursor :=crSQLWait;
     pdbgrid:=self;
     progress:=TprogressBar.Create (nil);

     progress.Align :=albottom;
     progress.Parent :=self.Parent;
     progress.Max :=DataSource.DataSet.RecordCount ;

     SumValue:=0;AVG:=0;MinValue:=0;MaxValue:=0;FirstValue:=0;LastValue:=0;Value:=0; 

     if self.DataSource.DataSet.RecordCount =0then exit;
     TADODataSet (pdbgrid.DataSource.DataSet).DisableControls ;

     for i:=0 to pdbgrid.Columns.Count -1 do
     begin
         progress.Position :=i;
         if not pdbgrid.Columns[i].Visible then continue;
         if  TChyColumn (Columns[i]).SumType=STEmpty then
         continue;

         SumValue:=0;
         MaxValue:=0;
         pdbgrid.DataSource.DataSet.First ;

         if pdbgrid.Columns[i].Field.DataType in [ftSmallint,ftInteger,ftFloat,ftCurrency,ftLargeint,ftBCD,ftDate] then //, ftTime, ftDateTime
         begin
             TChyColumn (Columns[i]).GroupValue:='0';
             if DataSource.DataSet.FieldByName (columns[i].FieldName ).Value<>null then
             FirstValue:=DataSource.DataSet.FieldByName (columns[i].FieldName ).Value ;
             for j:=0 to pdbgrid.DataSource.DataSet.RecordCount -1 do
             begin
      //       sleep(200);
               application.ProcessMessages;

               if  DataSource.DataSet.FieldByName (columns[i].FieldName ).value<>null then
               begin
                    if not ( DataSource.DataSet.FieldByName (columns[i].FieldName ).DataType
                               in [ftDate, ftTime, ftDateTime] )then
                      SumValue:=SumValue+DataSource.DataSet.FieldByName (columns[i].FieldName ).Value ;
                   if DataSource.DataSet.FieldByName (columns[i].FieldName ).Value  >MaxValue then
                      MaxValue := DataSource.DataSet.FieldByName (columns[i].FieldName ).Value ;
                   if DataSource.DataSet.FieldByName (columns[i].FieldName ).Value  <MinValue then
                      MinValue := DataSource.DataSet.FieldByName (columns[i].FieldName ).Value ;

               end;
               pdbgrid.DataSource.DataSet.Next ;
            end;
            if DataSource.DataSet.FieldByName (columns[i].FieldName ).Value<>null then
            LastValue:=DataSource.DataSet.FieldByName (columns[i].FieldName ).Value ;
            AVG:=SumValue/DataSource.DataSet.RecordCount;

             case     TChyColumn (Columns[i]).SumType  of
             STSum: Value:=SumValue;
             STAvg: Value:=AVG;
             STFirst: Value:=FirstValue;
             STLast:Value:=LastValue;
             STMax:  Value:=MaxValue ;
             STMin :Value:=MinValue ;
             end;
             if TChyColumn (Columns[i]).DeciamlFormat <>''  then
              TChyColumn (Columns[i]).GroupValue  := formatfloat ( TChyColumn (Columns[i]).DeciamlFormat,   Value )
             else
              TChyColumn (Columns[i]).GroupValue  := floattostr( Value);
        end;
     end;
     {
     DataSource.DataSet.Append;
     for i:=0 to self.Columns.Count -1 do
 //     if   DataSource.DataSet.findfield(columns[i].FieldName )<>nil  then
  //    if not  DataSource.DataSet.FieldByName(columns[i].FieldName ).ReadOnly  then
       if TChyColumn (Columns[i]).GroupValue<>'' then
       if not  DataSource.DataSet.FieldByName(columns[i].FieldName ).ReadOnly  then
      DataSource.DataSet.FieldByName(columns[i].FieldName ).Value   :=TChyColumn (Columns[i]).GroupValue ;
//     DataSource.DataSet.Post;
      }
      TADODataSet (pdbgrid.DataSource.DataSet).EnableControls ;

   finally
       screen.Cursor :=crdefault;
     progress.Free ;
   end;
end;
procedure TModelDbGrid.WMSize(var Message: TWMSize);
var tmpNeedSum:Boolean;
begin
  tmpNeedSum:=self.FNeedSumRow  ;
  if tmpNeedSum then  FNeedSumRow:=False;//2010-7-17
  inherited;
  self.FNeedSumRow :=tmpNeedSum;
end;

function TModelDbGrid.GetColbyFieldName(FieldName: string): TColumn;
var i:integer;
begin

  RESULT:=NIL;
  for i:=0 to self.Columns.Count -1 do
  begin
   if columns[i].FieldName =FieldName then
   result:=TColumn( columns[i]) ;
  end;

end;

function TModelDbGrid.getFixedCol: integer;
begin
result:=FixedCols;
end;

procedure TModelDbGrid.setFixedCol(const Value: integer);
begin
 //

 self.FixedCols :=Value;
end;

end.
