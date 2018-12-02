unit RepBill;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls,Db,DbGrids;

type
  TRepBillFrm = class(TQuickRep)
    TitleBand1: TQRBand;
    DetailBand1: TQRBand;
    BtmBand1: TQRBand;
    PageFooterBand1: TQRBand;
    ChildBand1: TQRChildBand;
    QRLabel5: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel2: TQRLabel;
    QrLabel1: TQRLabel;
    TopBand1: TQRChildBand;
    PageHeaderBand1: TQRBand;
    pgnumber: TQRSysData;
    QRLabel8: TQRLabel;
    pgcount: TQRLabel;
    ColumnHeaderBand1: TQRBand;
    procedure SetBillRep(fTopBoxId,fBtmBoxId:String;fMasterDataSet:TDataSet;fdbGrid:TDbGrid);
  private

  public

  end;

var
  RepBillFrm: TRepBillFrm;

implementation
uses datamodule;
{$R *.DFM}

procedure TRepBillFrm.SetBillRep(fTopBoxId,fBtmBoxId:String;fMasterDataSet:TDataSet;fdbGrid:TDbGrid);
begin                  //2513
  //Self.Page.Length:=200+(fDbGrid.DataSource.DataSet.RecordCount*8);
  detailband1.ForceNewPage:=FALSE;// 加它就连续了。
  with LoginInfo do
  begin
    QrLabel1.Caption:=FirmCnName;
//    QrLabel3.Caption:=FirmEnName;
    QrLabel4.Caption:=format('地址:%s           邮编:%s',[Address,Zip]);
    QrLabel5.Caption:=format('电话:%s      传真:%s',[Tel,Fax]);
  end;
{
  FhlUser.SetDataSet(FhlKnl1.FreeQuery,'527',LoginInfo.YdId);
  with FhlKnl1.FreeQuery do
  begin
    QrLabel1.Caption:=FieldByName('Name').asString;
//    QrLabel3.Caption:=FieldByName('eName').asString;
    QrLabel4.Caption:='地址:'+FieldByName('Addr').asString+'           邮编:'+FieldByName('Zip').asString;
    QrLabel5.Caption:='电话:'+FieldByName('Tel').asString+'      传真:'+FieldByName('Fax').asString;
    Close;
  end;
}
  FhlUser.SetDataSet(FhlKnl1.FreeQuery,'471',fTopBoxId);
  FhlKnl1.Rp_SetRepCtrl(FhlKnl1.FreeQuery,fMasterDataSet,TQRBand(TopBand1),0);

  FhlUser.SetDataSet(FhlKnl1.FreeQuery,'471',fBtmBoxId);
  FhlKnl1.Rp_SetRepCtrl(FhlKnl1.FreeQuery,fMasterDataSet,BtmBand1,0);

  FhlKnl1.Rp_SetRepGrid(fdbGrid,DetailBand1,TQRBand(ColumnHeaderBand1),False);
  DataSet:=fdbGrid.DataSource.DataSet;
//  QrLabel1.Caption:=intTostr(50+(fDbGrid.DataSource.DataSet.RecordCount*5));
  Prepare;
  try
    pgcount.Caption:=intTostr(QRPrinter.PageCount);
  finally
    QRPrinter.Free;
    QRPrinter:=Nil;
  end;
 
end;

end.
