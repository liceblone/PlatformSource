unit Sort;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Grids,dbGrids,Adodb,db;

type
  TSortFrm = class(TForm)
    StringGrid1: TStringGrid;
    Label2: TLabel;
    upBtn: TButton;
    DownBtn: TButton;
    Button1: TButton;
    Button2: TButton;
    BtnSave: TButton;
    procedure SetRightVals(Value:wideString);
    procedure InitFrm(fDbGrid:TDbGrid;ContainInVisible:Boolean=true);
    procedure StringGrid1DblClick(Sender: TObject);
    procedure upBtnClick(Sender: TObject);
    procedure MoveRow(FromIndex,ToIndex:Integer);
    procedure StringGrid1RowMoved(Sender: TObject; FromIndex,
      ToIndex: Integer);
    procedure Button1Click(Sender: TObject);
    procedure DownBtnClick(Sender: TObject);
    procedure UptSelection(Left,Right,Top,Bottom:Integer);
    procedure StringGrid1SelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure BtnSaveClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    fRightVals:wideString;
    lvals,rvals,LstCaption:TStringList;
    fRow:integer;
    fDestDbGrid:TDbGrid   ;
  public
    property RightVals:wideString read fRightVals write SetRightVals;

  end;

Const o1='升序'; v1='ASC';
      o2='降序'; v2='DESC';
      o3='';     v3='';

implementation
      uses datamodule;
{$R *.DFM}

procedure TSortFrm.InitFrm(fDbGrid:TDbGrid;ContainInVisible:Boolean=true);
 var i:integer;
begin
   fDestDbGrid:=fDbGrid;
   StringGrid1.RowCount:=fDbGrid.Columns.Count;
   with fDbGrid do
   begin
     for i:=0 to Columns.Count-1 do
     begin//是否包含不可视的列字段
         if  Columns[i].Field<>nil then
            if (Columns[i].Field.FieldKind=fkData) and (Columns[i].Visible or ContainInVisible) then
            begin
              self.LstCaption.Add (Columns[i].Title.caption);
              lvals.Append(Columns[i].FieldName);
              rvals.Append('');
              StringGrid1.Cols[0].Append(Columns[i].Title.Caption);
            end;
     end;
   end;
   StringGrid1.RowCount:=lVals.Count;
   SetRightVals(TCustomAdoDataSet(fDbGrid.DataSource.DataSet).Sort);
end;

procedure TSortFrm.SetRightVals(Value:wideString);
 var f:TStringList;i,ii,iii:integer;
begin
 fRightVals:=Value;
 f:=TStringList.Create;
 f.CommaText:=fRightVals;
 i:=0;iii:=0;//剖析排序字串,如: "PartNo ASC,Brand ASC,TaxRate DESC"
 while i<f.Count-1 do begin
     ii:=lVals.IndexOf(f.strings[i]);
     //赋
     rVals.Strings[ii]:=f.strings[i+1];
     if f.strings[i+1]=trim(v1) then
        StringGrid1.Cols[1].Strings[ii]:=o1
     else if f.strings[i+1]=trim(v2) then
        StringGrid1.Cols[1].Strings[ii]:=o2;
     //排
     MoveRow(ii,iii);iii:=iii+1;
     i:=i+2;
 end;
 f.Free;
end;

procedure TSortFrm.StringGrid1DblClick(Sender: TObject);
 var o:String;
begin
 fRow:=StringGrid1.Selection.Top;
 o:=StringGrid1.Cells[1,fRow];
 if o=o1 then begin
    o:=o2;
    rvals.Strings[fRow]:=v2;
 end
 else if o=o2 then begin
    o:=o3;
    rvals.Strings[fRow]:=v3;
 end
 else begin
    o:=o1;
    rvals.Strings[fRow]:=v1;
 end;
 StringGrid1.Cells[1,fRow]:=o;
end;

procedure TSortFrm.upBtnClick(Sender: TObject);
begin
 fRow:=StringGrid1.Selection.Top;
 MoveRow(fRow,fRow-1);
 fRow:=fRow-1;
 UptSelection(1,1,fRow,fRow);
end;

procedure TSortFrm.StringGrid1RowMoved(Sender: TObject; FromIndex,
  ToIndex: Integer);
begin
  lvals.Move(FromIndex,ToIndex);
  rvals.Move(FromIndex,ToIndex);
  DownBtn.Enabled:=ToIndex<StringGrid1.Cols[1].Count-1;
  UpBtn.Enabled:=ToIndex>0;
end;

procedure TSortFrm.Button1Click(Sender: TObject);
  var i:integer;
begin
  fRightVals:='';
  for i:=0 to lvals.Count-1 do begin
     if rvals.Strings[i]<>v3 then
        fRightVals:=fRightVals+','+lvals.Strings[i]+' '+rvals.Strings[i];
  end;
  Delete(fRightVals,1,1);
end;

procedure TSortFrm.DownBtnClick(Sender: TObject);
begin
 fRow:=StringGrid1.Selection.Top;
 MoveRow(fRow,fRow+1);
 fRow:=fRow+1;
 UptSelection(1,1,fRow,fRow);
end;

procedure TSortFrm.MoveRow(FromIndex,ToIndex:Integer);
 var s:TStringList;
begin
 s:=TStringList.Create;
 s.Assign(StringGrid1.Cols[0]);
 s.Move(FromIndex,ToIndex);
 StringGrid1.Cols[0].Assign(s);

 s.Assign(StringGrid1.Cols[1]);
 s.Move(FromIndex,ToIndex);
 StringGrid1.Cols[1].Assign(s);
 s.Free;

 lvals.Move(FromIndex,ToIndex);
 rvals.Move(FromIndex,ToIndex);
 LstCaption.Move(FromIndex,ToIndex);
end;

procedure TSortFrm.UptSelection(Left,Right,Top,Bottom:Integer);
 var myRect: TGridRect;
begin
  myRect.Left := Left;
  myRect.Right := Right;
  myRect.Top := Top;
  myRect.Bottom := Bottom;
  StringGrid1.Selection := myRect;
  DownBtn.Enabled:=Bottom<StringGrid1.Cols[1].Count-1;
  UpBtn.Enabled:=Top>0;
end;

procedure TSortFrm.StringGrid1SelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  DownBtn.Enabled:=ARow<StringGrid1.Cols[1].Count-1;
  UpBtn.Enabled:=ARow>0;
end;

procedure TSortFrm.FormCreate(Sender: TObject);
begin
 lVals:=TStringList.Create;
 rVals:=TStringList.Create;
 LstCaption:=TStringList.Create;
end;

procedure TSortFrm.BtnSaveClick(Sender: TObject);
var i,SortOrder:integer;
var sql:string;

begin
  for i:=0 to lvals.Count-1 do
  begin
         if rvals.Strings[i]=v1 then   SortOrder :=1;
         if rvals.Strings[i]=v2 then   SortOrder :=2;
         if rvals.Strings[i]=v3 then   SortOrder :=0;
         sql:='update T505 set F28= '+inttostr(SortOrder)+'  where F02='+inttostr(fDestDbGrid.Tag )+'  and F14='+quotedstr(self.LstCaption[i] )+' and isnull(F28,0)<> '+inttostr(SortOrder);
         fhlknl1.Kl_GetQuery2( sql,false);
  end;
  showmessage('保存成功！');
end;

procedure TSortFrm.FormDestroy(Sender: TObject);
begin
 lVals.Free  ;
 rVals.Free  ;
 LstCaption.Free  ;
end;

end.
