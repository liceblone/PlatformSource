object frmDesignMainMenu: TfrmDesignMainMenu
  Left = 186
  Top = 149
  Width = 826
  Height = 347
  Caption = #35774#35745#20027#30028#38754#33756#21333
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = mmMain
  OldCreateOrder = False
  PopupMenu = pmDesignMainMenu
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 56
    Top = 88
    Width = 104
    Height = 26
    Caption = 'F01,Code,MenuName'#13#10
  end
  object Label2: TLabel
    Left = 56
    Top = 184
    Width = 62
    Height = 13
    Caption = 'F03,MenuID '
  end
  object Label3: TLabel
    Left = 176
    Top = 88
    Width = 59
    Height = 13
    Caption = 'F04,caption '
  end
  object Label5: TLabel
    Left = 176
    Top = 184
    Width = 67
    Height = 13
    Caption = 'F06,tag,formid'
  end
  object Label6: TLabel
    Left = 352
    Top = 88
    Width = 60
    Height = 13
    Caption = 'F07,shortCut'
  end
  object Label7: TLabel
    Left = 352
    Top = 136
    Width = 50
    Height = 13
    Caption = 'F08,imgidx'
  end
  object Label8: TLabel
    Left = 352
    Top = 184
    Width = 38
    Height = 13
    Caption = 'F09,hint'
  end
  object Label9: TLabel
    Left = 504
    Top = 136
    Width = 52
    Height = 13
    Caption = 'F11,shotxt '
  end
  object Label11: TLabel
    Left = 504
    Top = 216
    Width = 58
    Height = 13
    Caption = 'F13, grupidx'
  end
  object lbl1: TLabel
    Left = 176
    Top = 136
    Width = 107
    Height = 13
    Caption = 'f05,procid,whichModel'
  end
  object lbl2: TLabel
    Left = 120
    Top = 240
    Width = 51
    Height = 13
    Caption = 'F14 sysDB'
  end
  object lbl3: TLabel
    Left = 8
    Top = 256
    Width = 144
    Height = 13
    Caption = #22914#26524#24050#35774#32622#26435#38480#23601#19981#33021#26356#25913
  end
  object Label4: TLabel
    Left = 504
    Top = 176
    Width = 24
    Height = 13
    Caption = 'RitID'
  end
  object ToolBar1: TToolBar
    Left = 0
    Top = 0
    Width = 802
    Height = 49
    ButtonHeight = 36
    ButtonWidth = 65
    Caption = 'ToolBar1'
    Color = 16776176
    EdgeInner = esNone
    EdgeOuter = esNone
    Images = dmFrm.ImageList1
    ParentColor = False
    ShowCaptions = True
    TabOrder = 0
    object ToolButton1: TToolButton
      Left = 0
      Top = 2
      Caption = 'ToolButton1'
      ImageIndex = 0
      ParentShowHint = False
      ShowHint = True
    end
  end
  object grp1: TGroupBox
    Left = 0
    Top = 269
    Width = 802
    Height = 52
    Align = alBottom
    TabOrder = 1
    object btnsave: TButton
      Left = 296
      Top = 14
      Width = 75
      Height = 25
      Caption = 'btnsave'
      TabOrder = 0
      OnClick = btnsaveClick
    end
    object btncancel: TButton
      Left = 146
      Top = 14
      Width = 75
      Height = 25
      Caption = 'btncancel'
      TabOrder = 1
      OnClick = btncancelClick
    end
    object btndelete: TButton
      Left = 221
      Top = 14
      Width = 75
      Height = 25
      Caption = 'btndelete'
      TabOrder = 2
      OnClick = btndeleteClick
    end
    object btnadd: TButton
      Left = 68
      Top = 14
      Width = 75
      Height = 25
      Caption = 'btnadd'
      TabOrder = 3
      OnClick = btnaddClick
    end
  end
  object DBCheckBox1: TDBCheckBox
    Left = 56
    Top = 152
    Width = 97
    Height = 17
    Caption = 'F02,IsUse'
    DataField = 'F02'
    DataSource = ds2
    TabOrder = 2
    ValueChecked = 'True'
    ValueUnchecked = 'False'
  end
  object DBCheckBox2: TDBCheckBox
    Left = 496
    Top = 96
    Width = 137
    Height = 25
    Caption = 'F10,tlbtn,'#25918#22312#24037#20855#26629#19978
    DataField = 'F10'
    DataSource = ds2
    TabOrder = 3
    ValueChecked = 'True'
    ValueUnchecked = 'False'
  end
  object edtMenuName: TEdit
    Left = 56
    Top = 64
    Width = 97
    Height = 21
    TabOrder = 4
    Text = 'edtMenuName'
  end
  object cbb1: TComboBoxEx
    Left = 376
    Top = 152
    Width = 97
    Height = 22
    ItemsEx = <
      item
      end
      item
        ImageIndex = 0
        SelectedImageIndex = 0
      end>
    ItemHeight = 16
    TabOrder = 5
    OnClick = cbb1Click
    Images = dmFrm.ImageList1
    DropDownCount = 8
  end
  object cbb2: TComboBox
    Left = 200
    Top = 152
    Width = 135
    Height = 21
    ItemHeight = 13
    TabOrder = 6
    OnClick = cbb2Click
  end
  object dbedt1: TDBEdit
    Left = 56
    Top = 112
    Width = 100
    Height = 21
    DataField = 'F01'
    DataSource = ds2
    TabOrder = 7
  end
  object dbedt2: TDBEdit
    Left = 56
    Top = 200
    Width = 100
    Height = 21
    DataField = 'F03'
    DataSource = ds2
    TabOrder = 8
  end
  object dbedt3: TDBEdit
    Left = 176
    Top = 104
    Width = 159
    Height = 21
    DataField = 'F04'
    DataSource = ds2
    TabOrder = 9
  end
  object dbedt4: TDBEdit
    Left = 176
    Top = 152
    Width = 25
    Height = 21
    DataField = 'F05'
    DataSource = ds2
    TabOrder = 10
    OnChange = dbedt4Change
  end
  object dbedt5: TDBEdit
    Left = 176
    Top = 200
    Width = 159
    Height = 21
    DataField = 'F06'
    DataSource = ds2
    TabOrder = 11
  end
  object dbedt6: TDBEdit
    Left = 352
    Top = 104
    Width = 121
    Height = 21
    DataField = 'F07'
    DataSource = ds2
    TabOrder = 12
  end
  object dbedt7: TDBEdit
    Left = 352
    Top = 152
    Width = 25
    Height = 21
    DataField = 'F08'
    DataSource = ds2
    TabOrder = 13
  end
  object dbedt8: TDBEdit
    Left = 352
    Top = 200
    Width = 121
    Height = 21
    DataField = 'F09'
    DataSource = ds2
    TabOrder = 14
  end
  object dbedt9: TDBEdit
    Left = 504
    Top = 152
    Width = 100
    Height = 21
    DataField = 'F11'
    DataSource = ds2
    TabOrder = 15
  end
  object dbedt11: TDBEdit
    Left = 504
    Top = 240
    Width = 100
    Height = 21
    DataField = 'F13'
    DataSource = ds2
    TabOrder = 16
  end
  object dbchkIsTool: TDBCheckBox
    Left = 352
    Top = 240
    Width = 97
    Height = 17
    Caption = 'f15 IsTool'
    DataField = 'f15'
    DataSource = ds2
    TabOrder = 17
    ValueChecked = 'True'
    ValueUnchecked = 'False'
    OnClick = dbchkIsToolClick
  end
  object dblkcbbSysDb: TDBLookupComboBox
    Left = 176
    Top = 240
    Width = 105
    Height = 21
    DataField = 'F14'
    DataSource = ds2
    TabOrder = 18
  end
  object DBEdit1: TDBEdit
    Left = 504
    Top = 192
    Width = 100
    Height = 21
    DataField = 'F12'
    DataSource = ds2
    ReadOnly = True
    TabOrder = 19
  end
  object pmDesignMainMenu: TPopupMenu
    Left = 544
    Top = 16
    object N2: TMenuItem
      Caption = #21152#36733#20027#33756#21333
      OnClick = N2Click
    end
    object NCreateMenuItem: TMenuItem
      Caption = #21019#24314#33756#21333
    end
  end
  object mmMain: TMainMenu
    Left = 568
    Top = 16
  end
  object actlst1: TActionList
    Left = 632
    Top = 16
    object actSelectMenuItem: TAction
      Caption = 'actSelectMenuItem'
      OnExecute = actSelectMenuItemExecute
    end
  end
  object dsOPerateMenu: TADODataSet
    CommandText = 'select  * from t511 where f01=:f01'
    Parameters = <>
    Left = 600
    Top = 16
  end
  object ds2: TDataSource
    DataSet = dsOPerateMenu
    Left = 600
    Top = 56
  end
end
