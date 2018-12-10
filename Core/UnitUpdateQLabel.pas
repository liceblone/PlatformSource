unit UnitUpdateQLabel;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, FR_Combo;

type
  TFrmUpdateQLabel = class(TForm)
    mmCaption: TMemo;
    btnOK: TButton;
    lblPreView: TLabel;
    edtFontSize: TEdit;
    Label1: TLabel;
    UpDown1: TUpDown;
    FontCombox: TfrFontComboBox;
    procedure mmCaptionKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure edtFontSizeChange(Sender: TObject);
    procedure FontComboxChange(Sender: TObject);
  private
    { Private declarations }
  public
    QLabel: Tlabel;
    { Public declarations }
  end;

var
  FrmUpdateQLabel: TFrmUpdateQLabel;

implementation

{$R *.dfm}

procedure TFrmUpdateQLabel.mmCaptionKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  lblPreView.Caption:= mmCaption.Text;
end;

procedure TFrmUpdateQLabel.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
    QLabel.Caption  := lblPreView.Caption;
    QLabel.Font.Assign( lblPreView.Font );
    QLabel.WordWrap := mmCaption.Lines.Count>1;
end;

procedure TFrmUpdateQLabel.FormShow(Sender: TObject);
begin
   mmCaption.Font.Assign(QLabel.Font);
  // mmCaption.Width:= QLabel.Width;
   mmCaption.Text:=QLabel.Caption ;
   lblPreView.Caption:= QLabel.Caption ;
   lblPreView.Font.Assign(QLabel.Font );

end;

procedure TFrmUpdateQLabel.edtFontSizeChange(Sender: TObject);
begin
self.lblPreView.Font.Size:= strtoint(self.edtFontSize.Text );

end;

procedure TFrmUpdateQLabel.FontComboxChange(Sender: TObject);
begin
  Tlabel( lblPreView ).Font.Name := FontCombox.Font.Name;
end;

end.
