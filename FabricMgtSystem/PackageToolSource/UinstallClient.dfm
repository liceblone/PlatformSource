object FrmInstallClient: TFrmInstallClient
  Left = 520
  Top = 338
  Width = 400
  Height = 181
  Caption = #23433#35013#23458#25143#31471
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object lbl1: TLabel
    Left = 64
    Top = 24
    Width = 70
    Height = 13
    Caption = #26381#21153#22120'IP        '
  end
  object lbl2: TLabel
    Left = 38
    Top = 72
    Width = 96
    Height = 13
    Caption = #25968#25454#24211#29992#25143#21517'        '
  end
  object lbl3: TLabel
    Left = 50
    Top = 104
    Width = 84
    Height = 13
    Caption = #25968#25454#24211#23494#30721'        '
  end
  object lblMsg: TLabel
    Left = 168
    Top = 128
    Width = 3
    Height = 13
  end
  object Label1: TLabel
    Left = 62
    Top = 48
    Width = 72
    Height = 13
    Caption = #20027#25968#25454#24211'        '
  end
  object edtIP: TEdit
    Left = 132
    Top = 24
    Width = 148
    Height = 21
    ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
    TabOrder = 0
  end
  object edtPubDBUserName: TEdit
    Left = 132
    Top = 72
    Width = 148
    Height = 21
    ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
    TabOrder = 2
    Text = 'sa'
  end
  object edtPubDbPassword: TEdit
    Left = 132
    Top = 96
    Width = 148
    Height = 21
    ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
    MaxLength = 30
    PasswordChar = '*'
    TabOrder = 3
  end
  object btnTest: TButton
    Left = 296
    Top = 56
    Width = 75
    Height = 25
    Caption = #27979#35797
    TabOrder = 4
    OnClick = btnTestClick
  end
  object edtPubDB: TEdit
    Left = 132
    Top = 48
    Width = 148
    Height = 21
    ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
    TabOrder = 1
  end
  object btnclose: TButton
    Left = 296
    Top = 96
    Width = 75
    Height = 25
    Caption = #36864#20986
    TabOrder = 5
    OnClick = btncloseClick
  end
  object Qry1: TADOQuery
    Parameters = <>
    Left = 304
    Top = 8
  end
end
