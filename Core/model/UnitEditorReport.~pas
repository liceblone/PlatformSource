unit UnitEditorReport;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,qrprntr,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls,Db,DbGrids;


    

type
  TEditorReport = class(TQuickRep)
    TitleBand1: TQRBand;
    TopBand1: TQRChildBand;
    PageHeaderBand1: TQRBand;
    pgnumber: TQRSysData;
    QRLabel8: TQRLabel;
    pgcount: TQRLabel;
    QRChildBandHead: TQRChildBand;
    QRChildBandBtm: TQRChildBand;

  private

  public

    procedure SetBillRep(fTopBoxId,printid:String;fMasterDataSet:TDataSet;fgrid:Tdbgrid; Title:string='');overload;

  end;

var
  EditorReport: TEditorReport;

implementation
uses datamodule;
{$R *.DFM}

 procedure TEditorReport.SetBillRep(fTopBoxId,printid: String;
  fMasterDataSet: TDataSet; fgrid:Tdbgrid; Title: string);
begin

  with LoginInfo do
  begin
    FhlUser.SetDataSet(FhlKnl1.FreeQuery,'471',fTopBoxId+','+printid);
    FhlKnl1.Rp_SetRepCtrl(FhlKnl1.FreeQuery,fMasterDataSet,    TQRBand(TopBand1),0);
   Page.PaperSize:=Custom;
   Page.Width:=421;
   Page.Length:=613;
   try
  finally
    QRPrinter.Free;
  end;
end;

end;


end.
