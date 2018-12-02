object FrmEditCtrl: TFrmEditCtrl
  Left = 191
  Top = 187
  Width = 696
  Height = 480
  Caption = 'FrmEditCtrl'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object spl1: TSplitter
    Left = 0
    Top = 105
    Width = 688
    Height = 16
    Cursor = crVSplit
    Align = alTop
  end
  object grpTool: TGroupBox
    Left = 0
    Top = 0
    Width = 688
    Height = 105
    Align = alTop
    Caption = 'grpTool'
    TabOrder = 0
    object btnCreate: TButton
      Left = 40
      Top = 16
      Width = 75
      Height = 25
      Caption = 'btnCreate'
      TabOrder = 0
      OnClick = btnCreateClick
    end
    object btnClear: TButton
      Left = 112
      Top = 16
      Width = 75
      Height = 25
      Caption = 'btnClear'
      TabOrder = 1
    end
    object btnsave: TButton
      Left = 184
      Top = 16
      Width = 75
      Height = 25
      Caption = 'btnsave'
      TabOrder = 2
    end
    object lbledtLintCnt: TLabeledEdit
      Left = 16
      Top = 64
      Width = 49
      Height = 21
      EditLabel.Width = 44
      EditLabel.Height = 13
      EditLabel.Caption = 'Cnt /Line'
      TabOrder = 3
      Text = '3'
    end
    object lbledtPosX: TLabeledEdit
      Left = 72
      Top = 64
      Width = 33
      Height = 21
      EditLabel.Width = 50
      EditLabel.Height = 13
      EditLabel.Caption = 'lbledtPosX'
      TabOrder = 4
      Text = '40'
    end
    object lbledtPosy: TLabeledEdit
      Left = 136
      Top = 64
      Width = 41
      Height = 21
      EditLabel.Width = 48
      EditLabel.Height = 13
      EditLabel.Caption = 'lbledtPosy'
      TabOrder = 5
      Text = '40'
    end
    object lbledtgap: TLabeledEdit
      Left = 199
      Top = 64
      Width = 41
      Height = 21
      EditLabel.Width = 27
      EditLabel.Height = 13
      EditLabel.Caption = 'GapX'
      TabOrder = 6
      Text = '30'
    end
    object lbledtCtrlGap: TLabeledEdit
      Left = 271
      Top = 64
      Width = 33
      Height = 21
      EditLabel.Width = 67
      EditLabel.Height = 13
      EditLabel.Caption = 'lbledtCtrlGapX'
      TabOrder = 7
      Text = '5'
    end
    object lbledtGapY: TLabeledEdit
      Left = 360
      Top = 64
      Width = 65
      Height = 21
      EditLabel.Width = 27
      EditLabel.Height = 13
      EditLabel.Caption = 'GapY'
      TabOrder = 8
      Text = '30'
    end
    object lbledtLabelFont: TLabeledEdit
      Left = 458
      Top = 64
      Width = 47
      Height = 21
      EditLabel.Width = 47
      EditLabel.Height = 13
      EditLabel.Caption = 'LabelFont'
      TabOrder = 9
      Text = '8'
    end
    object lbledtFont: TLabeledEdit
      Left = 552
      Top = 64
      Width = 57
      Height = 21
      EditLabel.Width = 46
      EditLabel.Height = 13
      EditLabel.Caption = 'lbledtFont'
      TabOrder = 10
      Text = '8'
    end
  end
  object grpparent: TGroupBox
    Left = 0
    Top = 121
    Width = 688
    Height = 332
    Align = alClient
    Caption = 'grpparent'
    TabOrder = 1
  end
  object dlgFontFont: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Left = 16
    Top = 137
  end
  object actlst1: TActionList
    Left = 40
    Top = 136
    object actChangeFont: TAction
      Caption = 'actChangeLabelsFont'
      OnExecute = actChangeFontExecute
    end
    object actChgALblFont: TAction
      Caption = 'actChgALblFont'
    end
  end
end
