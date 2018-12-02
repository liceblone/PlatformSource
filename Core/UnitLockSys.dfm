object frmLockSys: TfrmLockSys
  Left = 484
  Top = 425
  BorderIcons = []
  BorderStyle = bsNone
  Caption = #31995#32479#33258#21160#38145#23631
  ClientHeight = 131
  ClientWidth = 352
  Color = 16761220
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object lbl1: TLabel
    Left = 24
    Top = 40
    Width = 120
    Height = 13
    Caption = #35831#36755#20837#23494#30721#24182#22238#36710#65306'    '
  end
  object lbl2: TLabel
    Left = 104
    Top = 10
    Width = 120
    Height = 13
    Caption = #23494#30721#38169#35823#65292#20877#37325#35797'        '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    Visible = False
  end
  object bvl1: TBevel
    Left = 0
    Top = 0
    Width = 352
    Height = 131
    Align = alClient
  end
  object edtPassword: TEdit
    Left = 152
    Top = 40
    Width = 121
    Height = 21
    PasswordChar = '*'
    TabOrder = 0
  end
  object btnOK: TButton
    Left = 72
    Top = 88
    Width = 75
    Height = 25
    Caption = #30830#23450
    ModalResult = 1
    TabOrder = 1
  end
  object btnClear: TButton
    Left = 216
    Top = 88
    Width = 75
    Height = 25
    Caption = #37325#35797
    TabOrder = 2
    OnClick = btnClearClick
  end
  object tmr1: TTimer
    Enabled = False
    Interval = 300
    OnTimer = tmr1Timer
    Left = 304
    Top = 32
  end
end
