unit RepCard;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls,db;

type
  TRepCardFrm = class(TQuickRep)
    DetailBand1: TQRBand;
    PageHeaderBand1: TQRBand;
  private

  public

  end;

implementation

{$R *.DFM}

end.
