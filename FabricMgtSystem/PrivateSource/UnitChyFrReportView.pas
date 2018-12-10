unit UnitChyFrReportView;

interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FR_Class, StdCtrls, FR_Combo, FR_Ctrls,FR_BarC ,frBarcod, DB,ExtCtrls,
  ADODB  ,barcode, jpeg ,DelphiZXingQRCode;

type TFrDigitalImageView = class(TfrPictureView)
      procedure LoadPicture;virtual;
end ;
type TChyFrBarCodeView = class(TFrDigitalImageView)
 private
    FBarcodeShowText: boolean;
    FFormatSerialText: boolean;
    FCacheBarcodeImage: boolean;
    FRatio: double;
    FLineWidth: integer;
    FBarCodeType: integer;
    FBarcodeFileName: string;
     FImage:TImage;
    procedure SetBarcodeShowText(const Value: boolean);
    procedure setBarCodeType(const Value: integer);
    procedure SetCacheBarcodeImage(const Value: boolean);
    procedure SetFormatSerialText(const Value: boolean);
    procedure setLineWidth(const Value: integer);
    procedure setRatio(const Value: double);
    procedure SetBarcodeFileName(const Value: string);

    public
    Barcode1 : TAsBarcode;
    constructor Create; override;
    destructor Destroy; override;
    procedure Draw(Canvas: TCanvas); override;
    procedure LoadPicture; override;
    procedure ResetWidthHeight(fwidth, fheight: Integer);
    procedure SaveToJpg(Bitmap:TBitmap);
    property Ratio:double read FRatio write setRatio  ;
    property BarCodeType :integer read FBarCodeType write setBarCodeType default 6;
    property LineWidth:integer read FLineWidth write setLineWidth default 1;
    property FormatSerialText :boolean read FFormatSerialText write SetFormatSerialText default false;
    property CacheBarcodeImage:boolean read FCacheBarcodeImage write SetCacheBarcodeImage   ;
    property BarCodeShowText:boolean read FBarcodeShowText write SetBarcodeShowText default True ;
    property BarcodeFileName:string read FBarcodeFileName write SetBarcodeFileName ;

end;


type TChyFrQRCodeView = class(TFrDigitalImageView)
    private
    FBarcodeFileName: string;
    FImage:TImage; 
    QRCode: TDelphiZXingQRCode;
    FCacheBarcodeImage: boolean;
    procedure SetCacheBarcodeImage(const Value: boolean);
    procedure SetBarcodeFileName(const Value: string);
    public
    constructor Create; override;
    destructor Destroy; override;
    procedure Draw(Canvas: TCanvas); override;
    procedure LoadPicture;override;
    procedure ResetWidthHeight(fwidth, fheight: Integer);
    procedure SaveToJpg(Bitmap:TBitmap);
    
    property BarcodeFileName:string read FBarcodeFileName write SetBarcodeFileName ;
    property CacheBarcodeImage:boolean read FCacheBarcodeImage write SetCacheBarcodeImage   ;
    
end;

implementation

{ TChyFrBarCodeView }

constructor TChyFrBarCodeView.Create;
begin
  inherited;
  FImage:=TImage.Create(nil);
  Fimage.Top:=0;
  FImage.Left:=0;
  FImage.Width := self.dy ;
  FImage.Height := self.dx  ;
  Barcode1 := TAsBarcode.Create(nil);
  Barcode1.Left := 0  ;
  Barcode1.Top:=0;
  Barcode1.Width:=self.dy ;
  Barcode1.Height:=self.dx ;
end;

destructor TChyFrBarCodeView.Destroy;
begin
  freeandnil(Barcode1);
  freeandnil(FImage);
  inherited;
end;

procedure TChyFrBarCodeView.Draw(Canvas: TCanvas);
begin
  inherited;

end;

procedure TChyFrBarCodeView.LoadPicture;
var JPeg: TJPegImage;
begin
  try
      if not DirectoryExists('barcodeImages') then
        createdir('barcodeImages');

      if FBarcodeFileName='' then
        FBarcodeFileName := './barcodeImages/1.jpg';

     
      //if DataSet.fieldbyname(self.FDataField).AsString <>'' then
      begin
        if self.BarCodeShowText then
        Barcode1.ShowText :=TBarcodeOption(1)
        else
         Barcode1.ShowText :=TBarcodeOption(0);

        Barcode1.Top :=0;
        Barcode1.Left := 1 ;   // self.Left;
        Barcode1.Typ :=  TBarcodeType( self.BarCodeType ); //TBarcodeType;// bcCode128C;
        Barcode1.Modul := self.LineWidth;
        Barcode1.Ratio := self.Ratio;
        Barcode1.Height := self.dx-Barcode1.Top;
        Barcode1.Text:= self.Memo.Text ; 

        Barcode1.DrawBarcode(self.FImage.Canvas );

        FImage.Width :=  Barcode1.Width ;
       //  dx:= Barcode1.Width +20;
        if self.CacheBarcodeImage then
        begin
            // if not fileExists(barcodeFileName) then
            begin
              SaveToJpg(FImage.Picture.Bitmap);
            end ;
        end ;

        self.Picture.Assign (FImage.Picture) ;
      end;
  finally
  
  end;


end;

procedure TChyFrBarCodeView.ResetWidthHeight(fwidth, fheight: Integer);
begin
  dx:=fwidth;
   dy:=fheight;
  FImage.Width:=fwidth;
  Fimage.Height:=fheight;

  Barcode1.Width:= fwidth;
  Barcode1.Height:= fheight;
end;

procedure TChyFrBarCodeView.SaveToJpg(Bitmap:TBitmap);
var JPeg:TJPegImage ;
begin
  JPeg:= TJPegImage.Create;

  JPeg.Assign(  Bitmap);
  JPeg.SaveToFile(barcodeFileName);
  freeandnil(JPeg);

end;
procedure TChyFrBarCodeView.SetBarcodeFileName(const Value: string);
begin
FBarcodeFileName:=value;
end;

procedure TChyFrBarCodeView.SetBarcodeShowText(const Value: boolean);
begin
    FBarcodeShowText := value;
end;

procedure TChyFrBarCodeView.setBarCodeType(const Value: integer);
begin
       FBarCodeType :=Value;
end;

procedure TChyFrBarCodeView.SetCacheBarcodeImage(const Value: boolean);
begin
     FCacheBarcodeImage  :=value;
end;

procedure TChyFrBarCodeView.SetFormatSerialText(const Value: boolean);
begin
   FFormatSerialText  :=value;
end;

procedure TChyFrBarCodeView.setLineWidth(const Value: integer);
begin
  FLineWidth := value;
end;

procedure TChyFrBarCodeView.setRatio(const Value: double);
begin
   FRatio := Value;
end;

{ TChyFrQRCodeView }

constructor TChyFrQRCodeView.Create;
begin
  inherited;
  FImage:=TImage.Create(nil);
  Fimage.Top:=0;
  FImage.Left:=0;
  FImage.Width := self.dy ;
  FImage.Height := self.dx  ;


  QRCode := TDelphiZXingQRCode.Create;
  
end;

destructor TChyFrQRCodeView.Destroy;
begin
  freeandnil(FImage);
  freeandnil(QRCode);
  inherited;
end;

procedure TChyFrQRCodeView.Draw(Canvas: TCanvas);
begin
  inherited;

end;

procedure TChyFrQRCodeView.LoadPicture;
var  Row, Column: Integer;
begin
  try
      if not DirectoryExists('barcodeImages') then
          createdir('barcodeImages');

      if FBarcodeFileName='' then
          FBarcodeFileName := './barcodeImages/1.jpg';

      QRCode.Data := self.Memo.Text;
      QRCode.Encoding := TQRCodeEncoding(4);   //4 utf8 ow bom
      QRCode.QuietZone := StrToIntDef('4', 4);
      FImage.Width := QRCode.Rows;
      FImage.Height := QRCode.Columns ; 
      for Row := 0 to QRCode.Rows - 1 do
      begin
        for Column := 0 to QRCode.Columns - 1 do
        begin
          if (QRCode.IsBlack[Row, Column]) then
          begin
            FImage.Canvas.Pixels[Column, Row] := clBlack;
          end else
          begin
            FImage.Canvas.Pixels[Column, Row] := clWhite;
          end;
        end;
      end;
      if self.CacheBarcodeImage then
      begin
            // if not fileExists(barcodeFileName) then
              SaveToJpg(FImage.Picture.Bitmap);
      end ;
       self.Picture.Assign (FImage.Picture) ;
    finally
    end;
 end;

procedure TChyFrQRCodeView.ResetWidthHeight(fwidth, fheight: Integer);
begin
  dx:=fwidth;
   dy:=fheight;
  FImage.Width:=fwidth;
  Fimage.Height:=fheight;
 
end;

procedure TChyFrQRCodeView.SaveToJpg(Bitmap: TBitmap);
var JPeg:TJPegImage ;
begin
  JPeg:= TJPegImage.Create;

  JPeg.Assign(  Bitmap);
  JPeg.SaveToFile(barcodeFileName);
  freeandnil(JPeg);
end;

procedure TChyFrQRCodeView.SetBarcodeFileName(const Value: string);
begin
FBarcodeFileName:=value;
end;

procedure TChyFrQRCodeView.SetCacheBarcodeImage(const Value: boolean);
begin
FCacheBarcodeImage := value;
end;

{ TFrDigitalImageView }

procedure TFrDigitalImageView.LoadPicture;
begin
//
end;

end.
