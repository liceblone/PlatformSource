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
    QRDBRichText1: TQRDBRichText;
    jnhjknhjknkjnjknjkjnkj: TQRDBText;

  private

  public

    procedure SetBillRep(fTopBoxId:String;fMasterDataSet:TDataSet; Title:string='');overload;

  end;

var
  EditorReport: TEditorReport;

implementation
uses datamodule;
{$R *.DFM}

 procedure TEditorReport.SetBillRep(fTopBoxId: String;
  fMasterDataSet: TDataSet; Title: string);
begin


   with LoginInfo do
  begin


  FhlUser.SetDataSet(FhlKnl1.FreeQuery,'471',fTopBoxId);
  FhlKnl1.Rp_SetRepCtrl(FhlKnl1.FreeQuery,fMasterDataSet,    TQRBand(TopBand1),0);


  

   Page.PaperSize:=Custom;
   Page.Width:=421;
   Page.Length:=613;

//  Prepare;


  try
  //  pgcount.Caption:=intTostr(QRPrinter.PageCount);
  finally
    QRPrinter.Free;
  end;
end;

end;


end.
