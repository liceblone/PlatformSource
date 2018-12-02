unit RepGrid;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls,DbGrids,Printers;

type
  TRepGridFrm = class(TQuickRep)
    QuickRep1: TQuickRep;
    DetailBand1: TQRBand;
    ColumnHeaderBand1: TQRBand;
    PageHeaderBand1: TQRBand;
    QRTitle: TQRLabel;
    QRUnit: TQRLabel;
    QRTitle2: TQRLabel;
    PageFooterBand1: TQRBand;
    pgnumber: TQRSysData;
    QRLabel8: TQRLabel;
    pgcount: TQRLabel;
    QRLabel2: TQRLabel;
    QRSysData2: TQRSysData;
    QRShape1: TQRShape;
  private

  public

  end;

implementation

{$R *.DFM}

end.
