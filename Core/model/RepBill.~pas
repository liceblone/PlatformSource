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
    TopBand1: TQRChildBand;
    PageHeaderBand1: TQRBand;
    ColumnHeaderBand1: TQRBand;
    lblTitle: TQRLabel;
    pgcount: TQRLabel;
    QRLabel8: TQRLabel;
    pgnumber: TQRSysData;
    QRSysData1: TQRSysData;
    QRLabel1: TQRLabel;
    QRLabel3: TQRLabel;

  private

  public
    PdrawGrid:boolean;
    procedure SetBillRep(fTopBoxId,fprintid,fBtmBoxId,modelID:String;fMasterDataSet:TDataSet;fdbGrid:TDbGrid);overload;
    procedure SetBillRep(fTopBoxId:String;fMasterDataSet:TDataSet  );overload;


  end;

var
  RepBillFrm: TRepBillFrm;

implementation
uses datamodule;
{$R *.DFM}

procedure TRepBillFrm.SetBillRep(fTopBoxId,fprintid,fBtmBoxId,modelID:String;fMasterDataSet:TDataSet;fdbGrid:TDbGrid );
begin
  detailband1.ForceNewPage:=FALSE;

  FhlUser.SetDataSet(FhlKnl1.FreeQuery,'471',fTopBoxId+','+modelID+','+fprintid);
  FhlKnl1.Rp_SetRepCtrl(FhlKnl1.FreeQuery,fMasterDataSet,    TQRBand(TopBand1),0);

  FhlUser.SetDataSet(FhlKnl1.FreeQuery,'471',fBtmBoxId+','+modelID+','+fprintid);
  FhlKnl1.Rp_SetRepCtrl(FhlKnl1.FreeQuery,fMasterDataSet,TQRBand(BtmBand1),0);

  FhlKnl1.Rp_SetRepGrid(fdbGrid,DetailBand1,TQRBand(ColumnHeaderBand1),self.PdrawGrid );
  DataSet:=fdbGrid.DataSource.DataSet;
  Prepare;
  try
    pgcount.Caption:=intTostr(QRPrinter.PageCount);
  finally
    QRPrinter.Free;
  end;
  QRPrinter:=Nil;
end;

procedure TRepBillFrm.SetBillRep(fTopBoxId: String;
  fMasterDataSet: TDataSet );
begin


  detailband1.ForceNewPage:=FALSE;// 加它就连续了。


  FhlUser.SetDataSet(FhlKnl1.FreeQuery,'471',fTopBoxId);
  FhlKnl1.Rp_SetRepCtrl(FhlKnl1.FreeQuery,fMasterDataSet,    TQRBand(TopBand1),0);

  FhlUser.SetDataSet(FhlKnl1.FreeQuery,'471',fTopBoxId);
  FhlKnl1.Rp_SetRepCtrl(FhlKnl1.FreeQuery,fMasterDataSet,BtmBand1,0);

//  FhlKnl1.Rp_SetRepGrid(fdbGrid,DetailBand1,TQRBand(ColumnHeaderBand1),False);
//  DataSet:=fdbGrid.DataSource.DataSet;


  Prepare;
  try
    pgcount.Caption:=intTostr(QRPrinter.PageCount);
  finally
    QRPrinter.Free;
  end;
  QRPrinter:=Nil;
end;



end.
