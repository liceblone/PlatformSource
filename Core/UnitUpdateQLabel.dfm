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
  object Label1: TLabel
    Left = 144
    Top = 96
    Width = 48
    Height = 13
    Caption = #23383#20307#22823#23567
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
  object edtFontSize: TEdit
    Left = 200
    Top = 96
    Width = 121
    Height = 21
    TabOrder = 2
    Text = '0'
    OnChange = edtFontSizeChange
  end
  object UpDown1: TUpDown
    Left = 321
    Top = 96
    Width = 15
    Height = 21
    Associate = edtFontSize
    TabOrder = 3
  end
  object FontCombox: TfrFontComboBox
    Left = 352
    Top = 96
    Width = 150
    Height = 19
    MRURegKey = '\Software\FastReport\MRUFont'
    Text = 'FontCombox'
    DropDownCount = 12
    ItemHeight = 13
    TabOrder = 4
    OnChange = FontComboxChange
  end
end
