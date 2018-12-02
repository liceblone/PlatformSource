object frmGetGridID: TfrmGetGridID
  Left = 201
  Top = 241
  Width = 676
  Height = 315
  Caption = #21462#24471'dlgridID'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object pgc1: TPageControl
    Left = 0
    Top = 57
    Width = 668
    Height = 231
    ActivePage = tsGetTreeViewID
    Align = alClient
    TabOrder = 0
    object ts1: TTabSheet
      Caption = 'ts1'#21152'T504 '#21462#24471'dlgridID  '
      object lbl1: TLabel
        Left = 16
        Top = 16
        Width = 50
        Height = 13
        Caption = 'F01,id, pk '
        FocusControl = dbedt1
      end
      object lbl2: TLabel
        Left = 16
        Top = 56
        Width = 50
        Height = 13
        Caption = 'F02,name '
        FocusControl = dbedt2
      end
      object lbl3: TLabel
        Left = 8
        Top = 96
        Width = 114
        Height = 13
        Caption = 'F03,DataSetId ,t201.f01'
        FocusControl = dbedt3
      end
      object lbl4: TLabel
        Left = 128
        Top = 56
        Width = 44
        Height = 13
        Caption = 'F06,Note'
        FocusControl = dbedt4
      end
      object lbl5: TLabel
        Left = 128
        Top = 96
        Width = 43
        Height = 13
        Caption = 'F07,Tag '
        FocusControl = dbedt5
      end
      object dbedt1: TDBEdit
        Left = 16
        Top = 32
        Width = 100
        Height = 21
        DataField = 'F01'
        DataSource = ds2
        TabOrder = 0
      end
      object dbedt2: TDBEdit
        Left = 16
        Top = 72
        Width = 100
        Height = 21
        DataField = 'F02'
        DataSource = ds2
        TabOrder = 1
      end
      object dbedt3: TDBEdit
        Left = 16
        Top = 112
        Width = 100
        Height = 21
        DataField = 'F03'
        DataSource = ds2
        TabOrder = 2
      end
      object dbchk1: TDBCheckBox
        Left = 128
        Top = 32
        Width = 97
        Height = 17
        Caption = 'F04,ReadOnly '
        DataField = 'F04'
        DataSource = ds2
        TabOrder = 3
        ValueChecked = 'True'
        ValueUnchecked = 'False'
      end
      object dbchk2: TDBCheckBox
        Left = 224
        Top = 32
        Width = 97
        Height = 17
        Caption = 'F05,dgEditing '
        DataField = 'F05'
        DataSource = ds2
        TabOrder = 4
        ValueChecked = 'True'
        ValueUnchecked = 'False'
      end
      object dbedt4: TDBEdit
        Left = 128
        Top = 72
        Width = 185
        Height = 21
        DataField = 'F06'
        DataSource = ds2
        TabOrder = 5
      end
      object dbedt5: TDBEdit
        Left = 128
        Top = 112
        Width = 185
        Height = 21
        DataField = 'F07'
        DataSource = ds2
        TabOrder = 6
      end
      object dbchk3: TDBCheckBox
        Left = 360
        Top = 32
        Width = 97
        Height = 17
        Caption = 'F08,Sys '
        DataField = 'F08'
        DataSource = ds2
        TabOrder = 7
        ValueChecked = 'True'
        ValueUnchecked = 'False'
      end
      object dbchk4: TDBCheckBox
        Left = 360
        Top = 72
        Width = 97
        Height = 17
        Caption = 'F09,dgMultiSelect '
        DataField = 'F09'
        DataSource = ds2
        TabOrder = 8
        ValueChecked = 'True'
        ValueUnchecked = 'False'
      end
      object dbchk5: TDBCheckBox
        Left = 360
        Top = 112
        Width = 97
        Height = 17
        Caption = 'F10,dgRowSelect '
        DataField = 'F10'
        DataSource = ds2
        TabOrder = 9
        ValueChecked = 'True'
        ValueUnchecked = 'False'
      end
      object dbchk6: TDBCheckBox
        Left = 480
        Top = 32
        Width = 97
        Height = 17
        Caption = 'F11,dgColLines'#13#10' '
        DataField = 'F11'
        DataSource = ds2
        TabOrder = 10
        ValueChecked = 'True'
        ValueUnchecked = 'False'
      end
      object dbchk7: TDBCheckBox
        Left = 480
        Top = 72
        Width = 97
        Height = 17
        Caption = 'F12,dgRowLines '
        DataField = 'F12'
        DataSource = ds2
        TabOrder = 11
        ValueChecked = 'True'
        ValueUnchecked = 'False'
      end
      object dbchk8: TDBCheckBox
        Left = 480
        Top = 112
        Width = 153
        Height = 17
        Caption = 'F13dgAlwaysShowEditor '
        DataField = 'F13'
        DataSource = ds2
        TabOrder = 12
        ValueChecked = 'True'
        ValueUnchecked = 'False'
      end
    end
    object ts2: TTabSheet
      Caption = #21152't201 '#20889'commandtext  '
      ImageIndex = 1
      object lbl6: TLabel
        Left = 16
        Top = 16
        Width = 32
        Height = 13
        Caption = 'F01,id '
        FocusControl = dbedt6
      end
      object lbl7: TLabel
        Left = 16
        Top = 56
        Width = 50
        Height = 13
        Caption = 'F02,name '
        FocusControl = dbedt7
      end
      object lbl8: TLabel
        Left = 16
        Top = 96
        Width = 65
        Height = 13
        Caption = 'F03,cmdText '
        FocusControl = dbedt8
      end
      object lbl9: TLabel
        Left = 16
        Top = 136
        Width = 110
        Height = 13
        Caption = 'F04,cmdType 0,1=proc'
        FocusControl = dbedt9
      end
      object lbl10: TLabel
        Left = 144
        Top = 16
        Width = 68
        Height = 13
        Caption = 'F05,lockType '
        FocusControl = dbedt10
      end
      object lbl11: TLabel
        Left = 144
        Top = 56
        Width = 43
        Height = 13
        Caption = 'F06,filter '
        FocusControl = dbedt11
      end
      object lbl12: TLabel
        Left = 144
        Top = 96
        Width = 41
        Height = 13
        Caption = 'F07,sort '
        FocusControl = dbedt12
      end
      object lbl13: TLabel
        Left = 264
        Top = 16
        Width = 85
        Height = 13
        Caption = 'F09,BeforePostId '
        FocusControl = dbedt13
      end
      object lbl14: TLabel
        Left = 264
        Top = 56
        Width = 78
        Height = 13
        Caption = 'F10,AfterInsertId'
        FocusControl = dbedt14
      end
      object lbl15: TLabel
        Left = 264
        Top = 96
        Width = 92
        Height = 13
        Caption = 'F11,BeforeDeleteId'
        FocusControl = dbedt15
      end
      object lbl16: TLabel
        Left = 264
        Top = 136
        Width = 76
        Height = 13
        Caption = 'F12,AfterPostId '
        FocusControl = dbedt16
      end
      object lbl17: TLabel
        Left = 440
        Top = 16
        Width = 91
        Height = 13
        Caption = 'F13,SysParams '#65311' '
        FocusControl = dbedt17
      end
      object lbl18: TLabel
        Left = 440
        Top = 56
        Width = 87
        Height = 13
        Caption = 'F14,OnCalcFieldId'
        FocusControl = dbedt18
      end
      object lbl19: TLabel
        Left = 440
        Top = 96
        Width = 81
        Height = 13
        Caption = 'F15,AfterOpenId '
        FocusControl = dbedt19
      end
      object lbl20: TLabel
        Left = 88
        Top = 0
        Width = 216
        Height = 13
        Caption = '0:ltBatchOptimistic;1:ltOptimistic;3:ltReadOnly;'
      end
      object dbedt6: TDBEdit
        Left = 16
        Top = 32
        Width = 100
        Height = 21
        DataField = 'F01'
        DataSource = ds1
        TabOrder = 0
      end
      object dbedt7: TDBEdit
        Left = 16
        Top = 72
        Width = 100
        Height = 21
        DataField = 'F02'
        DataSource = ds1
        TabOrder = 1
      end
      object dbedt8: TDBEdit
        Left = 16
        Top = 112
        Width = 100
        Height = 21
        DataField = 'F03'
        DataSource = ds1
        TabOrder = 2
      end
      object dbedt9: TDBEdit
        Left = 16
        Top = 152
        Width = 100
        Height = 21
        DataField = 'F04'
        DataSource = ds1
        TabOrder = 3
      end
      object dbedt10: TDBEdit
        Left = 144
        Top = 32
        Width = 100
        Height = 21
        DataField = 'F05'
        DataSource = ds1
        TabOrder = 4
      end
      object dbedt11: TDBEdit
        Left = 144
        Top = 72
        Width = 100
        Height = 21
        DataField = 'F06'
        DataSource = ds1
        TabOrder = 5
      end
      object dbedt12: TDBEdit
        Left = 144
        Top = 112
        Width = 100
        Height = 21
        DataField = 'F07'
        DataSource = ds1
        TabOrder = 6
      end
      object dbchk9: TDBCheckBox
        Left = 144
        Top = 152
        Width = 97
        Height = 17
        Caption = 'F08,sys '
        DataField = 'F08'
        DataSource = ds1
        TabOrder = 7
        ValueChecked = 'True'
        ValueUnchecked = 'False'
      end
      object dbedt13: TDBEdit
        Left = 264
        Top = 32
        Width = 134
        Height = 21
        DataField = 'F09'
        DataSource = ds1
        TabOrder = 8
      end
      object dbedt14: TDBEdit
        Left = 264
        Top = 72
        Width = 134
        Height = 21
        DataField = 'F10'
        DataSource = ds1
        TabOrder = 9
      end
      object dbedt15: TDBEdit
        Left = 264
        Top = 112
        Width = 134
        Height = 21
        DataField = 'F11'
        DataSource = ds1
        TabOrder = 10
      end
      object dbedt16: TDBEdit
        Left = 264
        Top = 152
        Width = 134
        Height = 21
        DataField = 'F12'
        DataSource = ds1
        TabOrder = 11
      end
      object dbedt17: TDBEdit
        Left = 440
        Top = 32
        Width = 100
        Height = 21
        DataField = 'F13'
        DataSource = ds1
        TabOrder = 12
      end
      object dbedt18: TDBEdit
        Left = 440
        Top = 72
        Width = 100
        Height = 21
        DataField = 'F14'
        DataSource = ds1
        TabOrder = 13
      end
      object dbedt19: TDBEdit
        Left = 440
        Top = 112
        Width = 100
        Height = 21
        DataField = 'F15'
        DataSource = ds1
        TabOrder = 14
      end
    end
    object tsGetTreeViewID: TTabSheet
      Caption = 'tsGetTreeViewID'
      ImageIndex = 2
    end
  end
  object tlb1: TToolBar
    Left = 0
    Top = 0
    Width = 668
    Height = 57
    ButtonHeight = 21
    ButtonWidth = 46
    Caption = 'tlb1'
    ShowCaptions = True
    TabOrder = 1
    object btnopen: TToolButton
      Left = 0
      Top = 2
      Caption = 'btnopen'
      ImageIndex = 0
      OnClick = btnopenClick
    end
    object btnadd: TButton
      Left = 46
      Top = 2
      Width = 75
      Height = 21
      Caption = 'btnadd'
      TabOrder = 0
      OnClick = btnaddClick
    end
    object btncancel: TButton
      Left = 121
      Top = 2
      Width = 75
      Height = 21
      Caption = 'btncancel'
      TabOrder = 1
      OnClick = btncancelClick
    end
    object btndelete: TButton
      Left = 196
      Top = 2
      Width = 75
      Height = 21
      Caption = 'btndelete'
      TabOrder = 2
      OnClick = btndeleteClick
    end
    object btnsave: TButton
      Left = 271
      Top = 2
      Width = 75
      Height = 21
      Caption = 'btnsave'
      TabOrder = 3
      OnClick = btnsaveClick
    end
  end
  object dsT201: TADODataSet
    Parameters = <>
    Left = 420
    object dsT201F01: TAutoIncField
      FieldName = 'F01'
      ReadOnly = True
    end
    object dsT201F02: TStringField
      FieldName = 'F02'
      Size = 50
    end
    object dsT201F03: TStringField
      FieldName = 'F03'
      Size = 1000
    end
    object dsT201F04: TIntegerField
      FieldName = 'F04'
    end
    object dsT201F05: TIntegerField
      FieldName = 'F05'
    end
    object dsT201F06: TStringField
      FieldName = 'F06'
      Size = 300
    end
    object dsT201F07: TStringField
      FieldName = 'F07'
      Size = 100
    end
    object dsT201F08: TBooleanField
      FieldName = 'F08'
    end
    object dsT201F09: TIntegerField
      FieldName = 'F09'
    end
    object dsT201F10: TIntegerField
      FieldName = 'F10'
    end
    object dsT201F11: TIntegerField
      FieldName = 'F11'
    end
    object dsT201F12: TIntegerField
      FieldName = 'F12'
    end
    object dsT201F13: TStringField
      FieldName = 'F13'
      Size = 50
    end
    object dsT201F14: TIntegerField
      FieldName = 'F14'
    end
    object dsT201F15: TIntegerField
      FieldName = 'F15'
    end
  end
  object dsT504: TADODataSet
    Parameters = <>
    Left = 360
    object dsT504F01: TAutoIncField
      FieldName = 'F01'
      ReadOnly = True
    end
    object dsT504F02: TStringField
      FieldName = 'F02'
      Size = 50
    end
    object dsT504F03: TIntegerField
      FieldName = 'F03'
    end
    object dsT504F04: TBooleanField
      FieldName = 'F04'
    end
    object dsT504F05: TBooleanField
      FieldName = 'F05'
    end
    object dsT504F06: TStringField
      FieldName = 'F06'
      Size = 50
    end
    object dsT504F07: TIntegerField
      FieldName = 'F07'
    end
    object dsT504F08: TBooleanField
      FieldName = 'F08'
    end
    object dsT504F09: TBooleanField
      FieldName = 'F09'
    end
    object dsT504F10: TBooleanField
      FieldName = 'F10'
    end
    object dsT504F11: TBooleanField
      FieldName = 'F11'
    end
    object dsT504F12: TBooleanField
      FieldName = 'F12'
    end
    object dsT504F13: TBooleanField
      FieldName = 'F13'
    end
  end
  object ds1: TDataSource
    DataSet = dsT201
    Left = 448
  end
  object ds2: TDataSource
    DataSet = dsT504
    Left = 384
  end
end
