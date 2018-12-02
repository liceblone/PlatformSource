object FrmInstall: TFrmInstall
  Left = 331
  Top = 229
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = #25968#25454#24211#20449#24687
  ClientHeight = 208
  ClientWidth = 441
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object lbl1: TLabel
    Left = 64
    Top = 32
    Width = 72
    Height = 13
    Caption = #20027#25968#25454#24211'        '
  end
  object lbl2: TLabel
    Left = 64
    Top = 64
    Width = 60
    Height = 13
    Caption = #29992#25143#21517'        '
  end
  object lbl3: TLabel
    Left = 80
    Top = 96
    Width = 48
    Height = 13
    Caption = #23494#30721'        '
  end
  object lblInstallPath: TLabel
    Left = 64
    Top = 8
    Width = 59
    Height = 13
    Caption = 'lblInstallPath'
    Visible = False
  end
  object lblMsg: TLabel
    Left = 168
    Top = 128
    Width = 3
    Height = 13
  end
  object edtPubDB: TEdit
    Left = 132
    Top = 32
    Width = 148
    Height = 21
    ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
    ReadOnly = True
    TabOrder = 0
  end
  object edtPubDBUserName: TEdit
    Left = 132
    Top = 64
    Width = 148
    Height = 21
    ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
    TabOrder = 1
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
    TabOrder = 2
  end
  object btnTest: TButton
    Left = 296
    Top = 88
    Width = 75
    Height = 25
    Caption = #27979#35797
    TabOrder = 3
    OnClick = btnTestClick
  end
  object GrpInstall: TGroupBox
    Left = 0
    Top = 150
    Width = 441
    Height = 58
    Align = alBottom
    Caption = #20840#26032#23433#35013
    TabOrder = 4
    object BtnCreateVirtual: TButton
      Left = 16
      Top = 16
      Width = 153
      Height = 25
      Caption = #24314#31435#29992#20110#26356#26032#30340#32593#31449
      Enabled = False
      TabOrder = 0
      OnClick = BtnCreateVirtualClick
    end
    object BtnAttachUserAndSysDataBase: TButton
      Left = 176
      Top = 16
      Width = 161
      Height = 25
      Caption = #38468#21152#31995#32479#21644#29992#25143#25968#25454#24211
      Enabled = False
      TabOrder = 1
      OnClick = BtnAttachUserAndSysDataBaseClick
    end
    object btnExit: TButton
      Left = 344
      Top = 16
      Width = 81
      Height = 25
      Caption = #36864#20986
      Enabled = False
      TabOrder = 2
      OnClick = btnExitClick
    end
  end
  object Qry1: TADOQuery
    Parameters = <>
    Left = 304
    Top = 8
  end
end
