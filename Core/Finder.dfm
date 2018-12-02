object FinderFrm: TFinderFrm
  Left = 238
  Top = 210
  BorderStyle = bsDialog
  Caption = ' '#33258#23450#20041#26597#35810
  ClientHeight = 230
  ClientWidth = 661
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = #23435#20307
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  OnActivate = FormActivate
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 169
    Height = 65
    Caption = #26465#30446
    TabOrder = 0
    object FldComboBox: TComboBox
      Left = 8
      Top = 24
      Width = 153
      Height = 19
      BevelKind = bkSoft
      Style = csOwnerDrawFixed
      Ctl3D = False
      DropDownCount = 16
      ItemHeight = 13
      ParentCtl3D = False
      TabOrder = 0
      OnSelect = FldComboBoxSelect
    end
  end
  object ValGroupBox: TGroupBox
    Left = 352
    Top = 8
    Width = 201
    Height = 65
    Caption = #20540
    TabOrder = 1
  end
  object GroupBox4: TGroupBox
    Left = 8
    Top = 87
    Width = 337
    Height = 119
    Caption = #26465#20214#21015#34920
    TabOrder = 2
    object ListBox1: TListBox
      Left = 2
      Top = 15
      Width = 333
      Height = 102
      Align = alClient
      Ctl3D = False
      ItemHeight = 13
      ParentCtl3D = False
      TabOrder = 0
      OnClick = ListBox1Click
    end
  end
  object GroupBox2: TGroupBox
    Left = 185
    Top = 9
    Width = 161
    Height = 64
    Caption = #27604#36739#26041#24335
    TabOrder = 3
    object oprtComboBox: TComboBox
      Left = 7
      Top = 24
      Width = 145
      Height = 19
      BevelKind = bkFlat
      Style = csOwnerDrawFixed
      Ctl3D = False
      DropDownCount = 16
      ItemHeight = 13
      ParentCtl3D = False
      TabOrder = 0
      OnSelect = oprtComboBoxSelect
    end
  end
  object Button1: TButton
    Left = 565
    Top = 9
    Width = 75
    Height = 21
    Caption = #29983#25104
    Default = True
    TabOrder = 4
    OnClick = GetOneSql
  end
  object Button2: TButton
    Left = 566
    Top = 33
    Width = 75
    Height = 21
    Cancel = True
    Caption = #28165#38500
    TabOrder = 5
    OnClick = DeleteSqlItem
  end
  object OkBtn: TButton
    Left = 565
    Top = 154
    Width = 75
    Height = 21
    Caption = #30830#23450
    ModalResult = 1
    TabOrder = 6
  end
  object Button4: TButton
    Left = 565
    Top = 179
    Width = 75
    Height = 21
    Caption = #21462#28040
    ModalResult = 2
    TabOrder = 7
  end
  object RadioGroup1: TRadioGroup
    Left = 352
    Top = 87
    Width = 201
    Height = 55
    Caption = #36816#31639#39034#24207
    Columns = 3
    Items.Strings = (
      #24038#25324#21495
      #21491#25324#21495
      #26080#25324#21495)
    TabOrder = 8
    OnClick = RadioGroup1Click
  end
  object RadioGroup2: TRadioGroup
    Left = 352
    Top = 150
    Width = 201
    Height = 55
    Caption = #36816#31639#36923#36753
    Columns = 3
    Items.Strings = (
      #24182#19988
      #25110#32773
      #26080#20851#31995)
    TabOrder = 9
    OnClick = RadioGroup2Click
  end
  object Panel1: TPanel
    Left = 0
    Top = 208
    Width = 661
    Height = 22
    Alignment = taLeftJustify
    BevelOuter = bvLowered
    TabOrder = 10
  end
  object Button5: TButton
    Left = 566
    Top = 73
    Width = 75
    Height = 21
    Caption = #33258#23450#20041'...'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
    TabOrder = 11
    Visible = False
  end
  object Button3: TButton
    Left = 565
    Top = 117
    Width = 75
    Height = 21
    Caption = #25490#24207
    TabOrder = 12
    Visible = False
  end
  object ADODataSet2: TADODataSet
    LockType = ltReadOnly
    Parameters = <>
    Left = 424
    Top = 40
  end
  object ADODataSet3: TADODataSet
    LockType = ltBatchOptimistic
    Parameters = <>
    Left = 472
    Top = 48
  end
end
