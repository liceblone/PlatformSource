object FrmUpdateQLabel: TFrmUpdateQLabel
  Left = 410
  Top = 274
  Width = 548
  Height = 273
  Caption = #25913#26631#31614
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnShow = FormShow
  DesignSize = (
    540
    246)
  PixelsPerInch = 96
  TextHeight = 13
  object lblPreView: TLabel
    Left = 0
    Top = 128
    Width = 49
    Height = 13
    Anchors = [akLeft, akBottom]
    Caption = 'lblPreView'
  end
  object mmCaption: TMemo
    Left = 0
    Top = 0
    Width = 540
    Height = 89
    Lines.Strings = (
      'mmCaption')
    TabOrder = 0
    OnKeyUp = mmCaptionKeyUp
  end
  object btnOK: TButton
    Left = 438
    Top = 186
    Width = 75
    Height = 27
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 1
  end
end
