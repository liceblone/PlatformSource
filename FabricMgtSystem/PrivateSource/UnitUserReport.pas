unit UnitUserReport;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls, DBGrids,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls, DB, ADODB;

type
  TUserQkRpt = class(TQuickRep)
    PageHeaderBand1: TQRBand;
    pgnumber: TQRSysData;
    QRLabel8: TQRLabel;
    pgcount: TQRLabel;
    TitleBand1: TQRBand;
    QRLabel2: TQRLabel;
    TopBand1: TQRChildBand;
    ColumnHeaderBand1: TQRBand;
    BtmBand1: TQRBand;
    PageFooterBand1: TQRBand;
    DetailBand1: TQRBand;
    QRlblFirmCnName: TQRLabel;
    QRLblTitle: TQRLabel;
    BandSUM: TQRBand;
  private
    FMtDataset:Tdataset;
    procedure CreatePrtCtrl(boxid:string;dataset:Tdataset;fParent :Tqrchildband);
  public
    procedure SetBillRep(fTopBoxId,fBtmBoxId:String;fMasterDataSet:TDataSet;fdbGrid:TDbGrid;Title:string='');
  end;

var
  UserQkRpt: TUserQkRpt;

implementation
   uses datamodule;
{$R *.DFM}

{ TUserQkRpt }

procedure TUserQkRpt.SetBillRep(fTopBoxId, fBtmBoxId: String;
  fMasterDataSet: TDataSet; fdbGrid: TDbGrid; Title: string);
begin
 //Self.Page.Length:=200+(fDbGrid.DataSource.DataSet.RecordCount*8);

  FMtDataset:= fMasterDataSet;
  detailband1.ForceNewPage:=FALSE;// 加它就连续了。
  with LoginInfo do
  begin

    if    Title='' then
      QRLblTitle.Visible :=false
    else
      QRLblTitle.Caption :=   Title;

    QRlblFirmCnName.Caption:=FirmCnName;

  //  QrLabel4.Caption:=format('地址:%s           邮编:%s',[Address,Zip]);
  //  QrLabel5.Caption:=format('电话:%s           传真:%s',[Tel,Fax]);
  end;

  {
  FhlUser.SetDataSet(FhlKnl1.FreeQuery,'471',fTopBoxId);
  FhlKnl1.Rp_SetRepCtrl(FhlKnl1.FreeQuery,fMasterDataSet,TQRBand(TopBand1),0);

  FhlUser.SetDataSet(FhlKnl1.FreeQuery,'471',fBtmBoxId);
  FhlKnl1.Rp_SetRepCtrl(FhlKnl1.FreeQuery,fMasterDataSet,BtmBand1,0);
                  }
  if ((fTopBoxId<>'-1')and (fTopBoxId<>'')) then
  CreatePrtCtrl(fTopBoxId,FMtDataset,self.TopBand1 );

  if ((fBtmBoxId<>'-1')and (fBtmBoxId<>'')) then
  CreatePrtCtrl(fBtmBoxId,FMtDataset,TQRchildBand(BtmBand1) );

  FhlKnl1.Rp_SetRepGrid(fdbGrid,DetailBand1,TQRBand(ColumnHeaderBand1),False);
  DataSet:=fdbGrid.DataSource.DataSet;
  Prepare;
  try
    pgcount.Caption:=intTostr(QRPrinter.PageCount);
  finally
    QRPrinter.Free;
  end;
  QRPrinter:=Nil;
end;
procedure TUserQkRpt.CreatePrtCtrl(boxid:string;dataset:Tdataset;fParent :Tqrchildband);

var qry:Tadoquery;
var sql,fontname:string;
var sender:  Tcontrol;
var fontsize :integer;

var loadCtrl:TQRDBText;
var i:integer;
var  Fnt:TFont;
var maxTop:integer;
begin
      Fnt:=TFont.Create;
      Fnt.Assign(fParent.Font);

      qry:=Tadoquery.Create (nil);
      qry.Connection :=FhlKnl1.UserConnection ;
      sql:='select * from T629  where f11='+BOXID ;

      qry.SQL.Clear ;
      qry.SQL.Add(sql);
      qry.Open ;

      if  (not qry.IsEmpty ) then
      for i:=0 to qry.RecordCount -1 do
       begin
         if qry.FieldByName('f03').Value>maxTop then
         maxTop :=qry.FieldByName('f03').Value;

         Fnt.Name  :=qry.FieldByName('f06').Value;
         Fnt.Size := qry.FieldByName('f07').Value ;
         fnt.Color := StringToColor(qry.FieldByName('f08').asString);

         if  DataSet.FindField (qry.FieldByName('f09').AsString) =nil then
          begin
              with TQRLabel.Create(fParent) do
              begin
              Parent:=fParent;
              Left:=qry.FieldByName('f02').Value;
              Top:=qry.FieldByName('f03').Value;

              Caption:= qry.FieldByName('f09').AsString;

              Font.Assign(Fnt);
              end;
          end
          else
          begin
             loadCtrl:=TQRDBText.Create (fparent);
              loadCtrl.Parent := Twincontrol(   fparent);

              loadCtrl.Left:=qry.FieldByName('f02').Value;
              loadCtrl.Top:=qry.FieldByName('f03').Value;
              loadCtrl.Height :=qry.FieldByName('f04').Value;
              loadCtrl.Width :=qry.FieldByName('f05').Value;
              loadCtrl.AutoSize:=False;
              loadCtrl.DataSet:=DataSet;
              loadCtrl.DataField:=qry.FieldByName('F09').asString;
              loadCtrl.Font.Assign(Fnt);

          end;
            qry.Next ;
         end;
       fparent.Height := maxTop+20;

end;
end.
