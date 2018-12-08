unit UnitUserQrRptEx;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls,Db,DbGrids, QRPrntr ,ADODB ,UnitGrid ;

Const CPrtitemHeight: integer=26;
type TQRDBRichTextEx= class(TQRDBRichText)
    procedure Print(OfsX, OfsY : integer); override;
    procedure GetFieldString( var DataStr : string);override;
    published property Lines  ;
    published property Canvas ;

end;

type
  TFrmUserQrRptEx = class(TForm)
    QuickRep1: TQuickRep;
    TopBand1: TQRChildBand;
    TitleBand1: TQRBand;
    lblTitle: TQRLabel;
    PageHeaderBand1: TQRBand;
    pgcount: TQRLabel;
    QRLabel8: TQRLabel;
    pgnumber: TQRSysData;
    QRSysData1: TQRSysData;
    QRLabel1: TQRLabel;
    PageFooterBand1: TQRBand;
    DetailBand1: TQRBand;
    ColumnHeaderBand1: TQRBand;
    BtmBand1: TQRBand;
    Button1: TButton;
    BandSUM: TQRBand;
    ShpSum: TQRShape;
    lblCompany: TQRLabel;
    procedure Button1Click(Sender: TObject);
    procedure QuickRep1Preview(Sender: TObject);
  private
    { Private declarations }
  public
    PdrawGrid:boolean;
    procedure SetBillRep(fTopBoxId,fprintid,fBtmBoxId,modelID:String;fMasterDataSet:TDataSet;fdbGrid:TModelDbGrid);overload;
    procedure SetBillRep(fTopBoxId:String;fMasterDataSet:TDataSet  );overload;

    { Public declarations }
  end;

var
  FrmUserQrRptEx: TFrmUserQrRptEx;

implementation
uses datamodule ,Myprv;
{$R *.dfm}

procedure TFrmUserQrRptEx.SetBillRep(fTopBoxId, fprintid, fBtmBoxId,
  modelID: String; fMasterDataSet: TDataSet; fdbGrid: TModelDbGrid);
var I:integer;
var sql:string;
var maxControlTop :integer;
begin
  detailband1.ForceNewPage:=FALSE;

  sql:=  'select r.*,f.F02 as F99 from '+dmfrm.ADOConnection1.DefaultDatabase
           +'.dbo.T506 r left outer join T102 f on r.F16=f.F01 where r.F02='+ quotedstr(  fTopBoxId ) +' AND r.f20='
           +quotedstr( modelID )+' and r.F22='+quotedstr( fprintid )+' and r.F18=1 order by r.f13' ;
  FhlKnl1.Kl_GetQuery2(sql);
  FhlKnl1.Rp_SetRepCtrl(FhlKnl1.FreeQuery,fMasterDataSet,    TQRBand(TopBand1),0,fdbGrid);

  maxControlTop:=0;
  for i:=0 to TopBand1.ControlCount -1 do             // move coltrols downward in  top pnl      
  begin
      TopBand1.Controls[i].Top :=    TopBand1.Controls[i].Top+10;
      if TopBand1.Controls[i].Top  > maxControlTop then
        maxControlTop:= TopBand1.Controls[i].Top+TopBand1.Controls[i].Height  ;
  end;
  TopBand1.Height := maxControlTop+3;

  sql:=  '';
  if TModelDbGrid( fdbGrid).NeedSumRow  then           // move coltrols downward in  btm pnl     4/30/2011
    sql:=  sql+  'select isnull( r.F13 ,0)+20 as F13 ,'
  else
    sql:=  sql+  'select r.F13 ,';

  sql:=  sql+  'r.F01,r.F02,r.F03,r.F04,r.F05,r.F06,r.F07,r.F08,r.F09,r.F10,  ';
  sql:=  sql+  'r.F11,r.F12,r.F14,r.F15,r.F16,r.F17,r.F18,r.F19,r.F200,r.F20,r.F21,r.F22,r.F23,   ';
  sql:=  sql+  'r.FLeftMargin,r.FRightMargin,r.FTopMargin,r.FBtmMargin,r.FRptWidth,r.FRptHeight,r.FHasVline, ';
  sql:=  sql+  'r.FIsPortrait,r.FTitleFontName,r.FTitleFontSize,r.FHasPageNumber,r.FHasPrintTime,r.FFreezeBtmPnlPosition,f.F02 as F99 ';

  sql:=  sql+'  from '+dmfrm.ADOConnection1.DefaultDatabase
           +'.dbo.T506 r left outer join T102 f on r.F16=f.F01 where r.F02='+ quotedstr(  fBtmBoxId ) +' AND r.f20='
           +quotedstr( modelID )+' and r.F22='+quotedstr( fprintid )+' and r.F18=1 order by r.f13' ;
  FhlKnl1.Kl_GetQuery2(sql);

  FhlKnl1.Rp_SetRepCtrlWithSumRow(FhlKnl1.FreeQuery,fMasterDataSet,TQRBand(BtmBand1),0 ,fdbGrid );
//  FhlKnl1.Rp_SetRepCtrl(FhlKnl1.FreeQuery,fMasterDataSet,TQRBand(BtmBand1),0 ,fdbGrid );

  FhlKnl1.Rp_SetRepGrid(fdbGrid,DetailBand1,TQRBand(ColumnHeaderBand1),   self.PdrawGrid ); //2010-6-8以设置 的界面为主

  ShpSum.Width := DetailBand1.Width ;
  if TModelDbGrid( fdbGrid).NeedSumRow  then
    ShpSum.Width := DetailBand1.Width
  else
    ShpSum.Width:= 0;

  QuickRep1.DataSet:=fdbGrid.DataSource.DataSet;
  QuickRep1.Prepare;
  try
    pgcount.Caption:=intTostr(QuickRep1.QRPrinter.PageCount);
  finally
    QuickRep1.QRPrinter.Free;
  end;
  QuickRep1.QRPrinter:=Nil;
end;

procedure TFrmUserQrRptEx.SetBillRep(fTopBoxId: String;
  fMasterDataSet: TDataSet);
begin
  detailband1.ForceNewPage:=FALSE;// 加它就连续了。

  FhlUser.SetDataSet(FhlKnl1.FreeQuery,'471',fTopBoxId);
  FhlKnl1.Rp_SetRepCtrl(FhlKnl1.FreeQuery,fMasterDataSet,    TQRBand(TopBand1),0);

  FhlUser.SetDataSet(FhlKnl1.FreeQuery,'471',fTopBoxId);
  FhlKnl1.Rp_SetRepCtrl(FhlKnl1.FreeQuery,fMasterDataSet,BtmBand1,0);

//  DataSet:=fdbGrid.DataSource.DataSet;


  QuickRep1.Prepare;
  try
    pgcount.Caption:=intTostr(QuickRep1.QRPrinter.PageCount);
  finally
    QuickRep1.QRPrinter.Free;
  end;
  QuickRep1.QRPrinter:=Nil;
end;

procedure TFrmUserQrRptEx.Button1Click(Sender: TObject);
begin
 
self.QuickRep1.Preview ;

end;

procedure TFrmUserQrRptEx.QuickRep1Preview(Sender: TObject);
begin
with TMyPreview.Create(Application) do
begin
     QRPreview1.QRPrinter := TQRPrinter(Sender);
     CurRep := self.QuickRep1 ;
Show;
end;
{ }

end;

{ TQRDBRichTextEx }

procedure TQRDBRichTextEx.GetFieldString(var DataStr: string);
var Field:Tfield;
begin
  Field:=DataSet.FieldByName(self.DataField );
  if IsEnabled then
  begin
    Prepare;
    if assigned(Field) then
    begin
      try
        if (Field is TMemoField) or (Field is TBlobField) then
        begin
          // caution : Lines is a property of self
          Lines.Text := TMemoField(Field).AsString;
        end
        else
        begin
          if (Field is TStringField) then
          begin
            if not (Field is TBlobField) then
              DataStr := Field.DisplayText
            else
              DataStr := Field.AsString;
          end
          else
          begin
             if   Field.DataType in [ftSmallint,ftInteger,ftFloat,ftCurrency,ftLargeint,ftBCD,ftDate] then //, ftTime, ftDateTime
             DataStr:=formatfloat ( TNumericField(Field).DisplayFormat  ,   Field.Value )
          end;
        end;
      except
        DataStr := '';
      end;
    end
    else
      DataStr := '';
  end;

end;

procedure TQRDBRichTextEx.Print(OfsX, OfsY: integer);
var i,MaxHeight:integer;
begin

    Lines.Clear;
    Lines.Add(   self.DataSet.FieldByName(self.DataField ).AsString ) ;

    MaxHeight:=(lines.Count+1)*Canvas.TextHeight( Lines.Text  ) ;
    if MaxHeight > self.Parent.Height then
    begin
        self.Parent.Height :=   MaxHeight;
        for i:=0 to self.Parent.ControlCount-1 do
        begin
          if self.Parent.Controls[i]is   TQRShape then
          BEGIN
          if self.Parent.Controls[i].Height< self.Parent.Height  then
          self.Parent.Controls[i].Height :=  self.Parent.Height  ;//* SELF.DataSet.RecordCount  ;
          END;
        end;
    end;
   inherited;

end;

end.
