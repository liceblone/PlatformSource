object FrmChgPwd: TFrmChgPwd
  Left = 307
  Top = 354
  Width = 368
  Height = 197
  Caption = 'FrmChgPwd'
  Color = 16761220
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 96
    Top = 56
    Width = 48
    Height = 13
    Caption = #21407#23494#30721#65306
  end
  object Label2: TLabel
    Left = 96
    Top = 80
    Width = 48
    Height = 13
    Caption = #26032#23494#30721#65306
  end
  object Label3: TLabel
    Left = 80
    Top = 104
    Width = 60
    Height = 13
    Caption = #23494#30721#30830#35748#65306
  end
  object Label4: TLabel
    Left = 96
    Top = 32
    Width = 48
    Height = 13
    Caption = #29992#25143#21517#65306
  end
  object warningLabel: TLabel
    Left = 114
    Top = 7
    Width = 9
    Height = 16
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -16
    Font.Name = #23435#20307
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    Visible = False
  end
  object edtOriPwd: TEdit
    Left = 144
    Top = 56
    Width = 121
    Height = 21
    PasswordChar = '@'
    TabOrder = 0
  end
  object edtNewPwd: TEdit
    Left = 144
    Top = 80
    Width = 121
    Height = 21
    PasswordChar = '*'
    TabOrder = 1
  end
  object edtConfirmPwd: TEdit
    Left = 144
    Top = 104
    Width = 121
    Height = 21
    PasswordChar = '*'
    TabOrder = 2
  end
  object BtnOk: TButton
    Left = 88
    Top = 128
    Width = 75
    Height = 21
    Caption = #30830#23450
    TabOrder = 3
    OnClick = BtnOkClick
  end
  object BtnCancel: TButton
    Left = 216
    Top = 128
    Width = 75
    Height = 21
    Caption = #21462#28040
    ModalResult = 2
    TabOrder = 4
  end
  object edtUserName: TEdit
    Left = 144
    Top = 32
    Width = 121
    Height = 21
    TabOrder = 5
  end
end
