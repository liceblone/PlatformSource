object BillOpenDlgFrm: TBillOpenDlgFrm
  Left = 226
  Top = 157
  Width = 598
  Height = 470
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = #25171#24320
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
  OnClose = FormClose
  OnCreate = FormCreate
  OnDblClick = FormDblClick
  OnKeyDown = FormKeyDown
  DesignSize = (
    590
    443)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 18
    Top = 392
    Width = 67
    Height = 13
    Anchors = [akLeft, akBottom]
    Caption = #21333#25454#21495'(&N):'
    FocusControl = FileNameComboBox
  end
  object Label2: TLabel
    Left = 18
    Top = 419
    Width = 80
    Height = 13
    Anchors = [akLeft, akBottom]
    Caption = #21333#25454#31867#22411'(&T):'
    FocusControl = FileTypeComboBox
  end
  object Label3: TLabel
    Left = 12
    Top = 9
    Width = 40
    Height = 13
    Caption = '&A.'#21333#21495
    FocusControl = EdtCode1
  end
  object Label4: TLabel
    Left = 165
    Top = 8
    Width = 73
    Height = 13
    Caption = '&B.'#31616#31216'/'#30005#35805
    FocusControl = EdtKey1
  end
  object Label5: TLabel
    Left = 417
    Top = 8
    Width = 26
    Height = 13
    Anchors = [akTop, akRight]
    Caption = #20854#23427
  end
  object Button1: TButton
    Left = 452
    Top = 386
    Width = 97
    Height = 23
    Anchors = [akRight, akBottom]
    Caption = #25171#24320'(&O)'
    ModalResult = 1
    TabOrder = 5
  end
  object Button2: TButton
    Left = 452
    Top = 414
    Width = 97
    Height = 22
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = #21462#28040
    ModalResult = 2
    TabOrder = 6
  end
  object DBGrid1: TDBGrid
    Left = 12
    Top = 31
    Width = 570
    Height = 351
    Anchors = [akLeft, akTop, akRight, akBottom]
    Ctl3D = True
    DataSource = DataSource1
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
    ParentCtl3D = False
    PopupMenu = dmFrm.DbGridPopupMenu1
    ReadOnly = True
    TabOrder = 7
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -13
    TitleFont.Name = #23435#20307
    TitleFont.Style = []
    OnDrawColumnCell = DBGrid1DrawColumnCell
    OnDblClick = DBGrid1DblClick
  end
  object FileNameComboBox: TComboBox
    Left = 101
    Top = 388
    Width = 322
    Height = 21
    BevelKind = bkSoft
    Anchors = [akLeft, akRight, akBottom]
    Ctl3D = False
    Enabled = False
    ItemHeight = 13
    ParentCtl3D = False
    TabOrder = 3
  end
  object FileTypeComboBox: TComboBox
    Left = 101
    Top = 414
    Width = 322
    Height = 21
    BevelKind = bkSoft
    Style = csDropDownList
    Anchors = [akLeft, akRight, akBottom]
    Ctl3D = False
    ItemHeight = 13
    ParentCtl3D = False
    TabOrder = 4
    OnChange = FileTypeComboBoxChange
  end
  object EdtCode1: TEdit
    Left = 55
    Top = 5
    Width = 104
    Height = 21
    TabOrder = 1
  end
  object EdtKey1: TEdit
    Left = 241
    Top = 4
    Width = 169
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 0
  end
  object ComboBox1: TComboBox
    Left = 449
    Top = 5
    Width = 129
    Height = 21
    Style = csDropDownList
    Anchors = [akTop, akRight]
    ItemHeight = 13
    TabOrder = 2
    Items.Strings = (
      #26410#23457#26680#30340
      #20170#22825#30340
      #26368#36817'2'#22825#30340
      #26368#36817'3'#22825#30340
      #26368#36817#19968#20010#26143#26399#30340
      ' ')
  end
  object DataSource1: TDataSource
    DataSet = ADODataSet1
    Left = 216
    Top = 128
  end
  object ADODataSet1: TADODataSet
    Connection = dmFrm.ADOConnection1
    AfterScroll = AdoDataSet1AfterScroll
    CommandTimeout = 120
    Parameters = <>
    Left = 160
    Top = 136
  end
end
