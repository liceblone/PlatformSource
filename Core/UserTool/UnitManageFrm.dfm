object FrmManageFrm: TFrmManageFrm
  Left = 76
  Top = 161
  Width = 948
  Height = 423
  Caption = 'FrmManageFrm'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Scaled = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object lbl21: TLabel
    Left = 608
    Top = 32
    Width = 34
    Height = 13
    Caption = 'FormID'
  end
  object pgc1: TPageControl
    Left = 0
    Top = 69
    Width = 940
    Height = 327
    ActivePage = tsAnalyser
    Align = alBottom
    TabOrder = 0
    object tsTreeEdit: TTabSheet
      Caption = 'tsTreeEdit T611'
      Enabled = False
      object lbl1: TLabel
        Left = 24
        Top = 16
        Width = 99
        Height = 13
        Caption = 'F01,  id,   PrimaryKey'
        FocusControl = dbedt1
      end
      object lbl2: TLabel
        Left = 24
        Top = 96
        Width = 46
        Height = 13
        Caption = 'F03,boxid'
        FocusControl = dbedt2
      end
      object lbl3: TLabel
        Left = 200
        Top = 16
        Width = 58
        Height = 13
        Caption = 'F04,dbgridid'
        FocusControl = dbedt3
      end
      object lbl4: TLabel
        Left = 200
        Top = 56
        Width = 74
        Height = 26
        Caption = 'F05,rootcaption'#13#10
        FocusControl = dbedt4
      end
      object lbl5: TLabel
        Left = 24
        Top = 56
        Width = 70
        Height = 13
        Caption = 'F02,frmcaption'
        FocusControl = dbedt5
      end
      object lbl6: TLabel
        Left = 200
        Top = 96
        Width = 56
        Height = 13
        Caption = 'F06,codefld'
        FocusControl = dbedt6
      end
      object lbl7: TLabel
        Left = 368
        Top = 16
        Width = 58
        Height = 13
        Caption = 'F07,namefld'
        FocusControl = dbedt7
      end
      object lbl8: TLabel
        Left = 368
        Top = 56
        Width = 68
        Height = 26
        Caption = 'F08,WriteRitId'#13#10
        FocusControl = dbedt8
      end
      object lbl9: TLabel
        Left = 368
        Top = 96
        Width = 64
        Height = 26
        Caption = 'F09,PrintRitId'#13#10
        FocusControl = dbedt9
      end
      object dbedt1: TDBEdit
        Left = 24
        Top = 32
        Width = 134
        Height = 21
        DataField = 'F01'
        DataSource = ds2
        ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
        TabOrder = 0
      end
      object dbedt2: TDBEdit
        Left = 24
        Top = 112
        Width = 134
        Height = 21
        DataField = 'F03'
        DataSource = ds2
        ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
        TabOrder = 1
      end
      object dbedt3: TDBEdit
        Left = 200
        Top = 32
        Width = 129
        Height = 21
        DataField = 'F04'
        DataSource = ds2
        ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
        TabOrder = 2
        OnDblClick = dbedt3DblClick
      end
      object dbedt4: TDBEdit
        Left = 200
        Top = 72
        Width = 129
        Height = 21
        DataField = 'F05'
        DataSource = ds2
        ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
        TabOrder = 3
      end
      object dbedt5: TDBEdit
        Left = 24
        Top = 72
        Width = 137
        Height = 21
        DataField = 'F02'
        DataSource = ds2
        ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
        TabOrder = 4
      end
      object dbedt6: TDBEdit
        Left = 200
        Top = 112
        Width = 129
        Height = 21
        DataField = 'F06'
        DataSource = ds2
        ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
        TabOrder = 5
      end
      object dbedt7: TDBEdit
        Left = 368
        Top = 32
        Width = 121
        Height = 21
        DataField = 'F07'
        DataSource = ds2
        ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
        TabOrder = 6
      end
      object dbedt8: TDBEdit
        Left = 368
        Top = 72
        Width = 121
        Height = 21
        DataField = 'F08'
        DataSource = ds2
        ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
        TabOrder = 7
      end
      object dbedt9: TDBEdit
        Left = 368
        Top = 112
        Width = 121
        Height = 21
        DataField = 'F09'
        DataSource = ds2
        ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
        TabOrder = 8
      end
    end
    object tsTreeGrid: TTabSheet
      Caption = 'tsTreeGrid T612'
      Enabled = False
      ImageIndex = 1
      object lbl10: TLabel
        Left = 16
        Top = 16
        Width = 30
        Height = 13
        Caption = 'F01 Id'
        FocusControl = dbedt10
      end
      object lbl11: TLabel
        Left = 16
        Top = 56
        Width = 83
        Height = 13
        Caption = 'F02'#65292'FrmCaption'
        FocusControl = dbedt11
      end
      object lbl12: TLabel
        Left = 16
        Top = 96
        Width = 72
        Height = 13
        Caption = 'F04'#65292'DbGridId'
        FocusControl = dbedt12
      end
      object lbl13: TLabel
        Left = 128
        Top = 16
        Width = 146
        Height = 13
        Caption = 'F05,EditorId,'#32534#36753#26102'TabformID'
        FocusControl = dbedt13
      end
      object lbl14: TLabel
        Left = 128
        Top = 56
        Width = 56
        Height = 13
        Caption = 'F09,Actions'
        FocusControl = dbedt14
      end
      object lbl15: TLabel
        Left = 128
        Top = 96
        Width = 59
        Height = 13
        Caption = 'F10,FinderId'
        FocusControl = dbedt15
      end
      object lbl16: TLabel
        Left = 400
        Top = 56
        Width = 60
        Height = 13
        Caption = 'F12,ClassFld'
        FocusControl = dbedt16
      end
      object lbl17: TLabel
        Left = 400
        Top = 96
        Width = 68
        Height = 13
        Caption = 'F13,WriteRitId'
        FocusControl = dbedt17
      end
      object lbl18: TLabel
        Left = 528
        Top = 16
        Width = 74
        Height = 13
        Caption = 'F14,DeleteRitId'
        FocusControl = dbedt18
      end
      object lbl19: TLabel
        Left = 528
        Top = 56
        Width = 64
        Height = 13
        Caption = 'F15,PrintRitId'
        FocusControl = dbedt19
      end
      object lbl20: TLabel
        Left = 528
        Top = 96
        Width = 52
        Height = 13
        Caption = 'F16,TreeId'
        FocusControl = dbedt20
      end
      object dbedt10: TDBEdit
        Left = 16
        Top = 32
        Width = 100
        Height = 21
        DataField = 'F01'
        DataSource = ds1
        ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
        TabOrder = 0
      end
      object dbedt11: TDBEdit
        Left = 16
        Top = 72
        Width = 100
        Height = 21
        DataField = 'F02'
        DataSource = ds1
        ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
        TabOrder = 1
      end
      object dbedt12: TDBEdit
        Left = 16
        Top = 112
        Width = 100
        Height = 21
        DataField = 'F04'
        DataSource = ds1
        ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
        TabOrder = 2
        OnDblClick = dbedt12DblClick
      end
      object dbedt13: TDBEdit
        Left = 128
        Top = 32
        Width = 265
        Height = 21
        DataField = 'F05'
        DataSource = ds1
        ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
        TabOrder = 3
      end
      object dbedt14: TDBEdit
        Left = 128
        Top = 72
        Width = 105
        Height = 21
        DataField = 'F09'
        DataSource = ds1
        ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
        TabOrder = 4
      end
      object dbedt15: TDBEdit
        Left = 128
        Top = 112
        Width = 265
        Height = 21
        DataField = 'F10'
        DataSource = ds1
        ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
        TabOrder = 5
      end
      object dbchk1: TDBCheckBox
        Left = 400
        Top = 32
        Width = 97
        Height = 17
        Caption = 'F11,IsOpen'
        DataField = 'F11'
        DataSource = ds1
        TabOrder = 6
        ValueChecked = 'True'
        ValueUnchecked = 'False'
      end
      object dbedt16: TDBEdit
        Left = 400
        Top = 72
        Width = 100
        Height = 21
        DataField = 'F12'
        DataSource = ds1
        ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
        TabOrder = 7
      end
      object dbedt17: TDBEdit
        Left = 400
        Top = 112
        Width = 100
        Height = 21
        DataField = 'F13'
        DataSource = ds1
        ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
        TabOrder = 8
      end
      object dbedt18: TDBEdit
        Left = 528
        Top = 32
        Width = 100
        Height = 21
        DataField = 'F14'
        DataSource = ds1
        ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
        TabOrder = 9
      end
      object dbedt19: TDBEdit
        Left = 528
        Top = 72
        Width = 100
        Height = 21
        DataField = 'F15'
        DataSource = ds1
        ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
        TabOrder = 10
      end
      object dbedt20: TDBEdit
        Left = 528
        Top = 112
        Width = 100
        Height = 21
        DataField = 'F16'
        DataSource = ds1
        ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
        TabOrder = 11
        OnDblClick = dbedt20DblClick
      end
      object cbbTreeGridActions: TComboBox
        Left = 232
        Top = 72
        Width = 161
        Height = 21
        ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
        ItemHeight = 0
        TabOrder = 12
        OnClick = cbbTreeGridActionsClick
      end
    end
    object tsTsBill: TTabSheet
      Caption = '    tsTsBill  t602     '
      ImageIndex = 2
      object lbl22: TLabel
        Left = 8
        Top = 8
        Width = 49
        Height = 13
        Caption = 'F01,formid'
        FocusControl = dbedt21
      end
      object lbl25: TLabel
        Left = 8
        Top = 48
        Width = 54
        Height = 13
        Caption = 'F04,BillTitle'
        FocusControl = dbedt24
      end
      object lbl26: TLabel
        Left = 8
        Top = 88
        Width = 89
        Height = 13
        Caption = 'F05,TitleFontColor '
        FocusControl = dbedt25
      end
      object lbl27: TLabel
        Left = 8
        Top = 128
        Width = 85
        Height = 13
        Caption = 'F06,TitleFontSize '
        FocusControl = dbedt26
      end
      object lbl28: TLabel
        Left = 8
        Top = 168
        Width = 93
        Height = 13
        Caption = 'F07,TitleFontName '
        FocusControl = dbedt27
      end
      object lbl29: TLabel
        Left = 128
        Top = 8
        Width = 135
        Height = 13
        Caption = 'F09,mttblid , bill Pre , sys_id  '
        FocusControl = dbedt28
      end
      object lbl31: TLabel
        Left = 128
        Top = 48
        Width = 162
        Height = 13
        Caption = 'F11,mkeyfld  fieldname of billcode '
        FocusControl = dbedt30
      end
      object lbl32: TLabel
        Left = 128
        Top = 88
        Width = 157
        Height = 13
        Caption = 'F12,fkeyfld  fieldname of billcode '
        FocusControl = dbedt31
      end
      object lbl35: TLabel
        Left = 128
        Top = 128
        Width = 70
        Height = 13
        Caption = 'F15,TopBoxId '
        FocusControl = dbedt34
      end
      object lbl36: TLabel
        Left = 128
        Top = 168
        Width = 69
        Height = 13
        Caption = 'F16,BtmBoxId '
        FocusControl = dbedt35
      end
      object lbl37: TLabel
        Left = 309
        Top = 8
        Width = 60
        Height = 13
        Caption = 'F17,dlGridId '
        FocusControl = dbedt36
      end
      object lbl38: TLabel
        Left = 309
        Top = 48
        Width = 83
        Height = 13
        Caption = 'F18,mtDataSetId '
        FocusControl = dbedt37
      end
      object lbl39: TLabel
        Left = 309
        Top = 88
        Width = 62
        Height = 13
        Caption = 'F19,savproc '
        FocusControl = dbedt38
      end
      object lbl40: TLabel
        Left = 309
        Top = 128
        Width = 109
        Height = 13
        Caption = 'F20,mtGridId  OPen Bill'
        FocusControl = dbedt39
      end
      object lbl41: TLabel
        Left = 309
        Top = 168
        Width = 63
        Height = 13
        Caption = 'F21,chkproc '
        FocusControl = dbedt40
      end
      object lbl42: TLabel
        Left = 413
        Top = 8
        Width = 105
        Height = 13
        Caption = 'F22,PickId  '#31354#20026#26080#25928
        FocusControl = dbedt41
      end
      object lbl43: TLabel
        Left = 421
        Top = 48
        Width = 67
        Height = 13
        Caption = 'F23,dlSumFld '
        FocusControl = dbedt42
      end
      object lbl44: TLabel
        Left = 421
        Top = 88
        Width = 67
        Height = 26
        Caption = 'F24,mtSumFld'#13#10' '
        FocusControl = dbedt43
      end
      object lbl45: TLabel
        Left = 421
        Top = 128
        Width = 78
        Height = 13
        Caption = 'F25,QtyFld '#25968#37327
        FocusControl = dbedt44
      end
      object lbl46: TLabel
        Left = 421
        Top = 168
        Width = 72
        Height = 13
        Caption = 'F26,ReadRitId '
        FocusControl = dbedt45
      end
      object lbl47: TLabel
        Left = 533
        Top = 8
        Width = 71
        Height = 13
        Caption = 'F27,WriteRitId '
        FocusControl = dbedt46
      end
      object lbl48: TLabel
        Left = 533
        Top = 48
        Width = 77
        Height = 13
        Caption = 'F28,CheckRitId '
        FocusControl = dbedt47
      end
      object lbl49: TLabel
        Left = 533
        Top = 88
        Width = 67
        Height = 13
        Caption = 'F29,PrintRitId '
        FocusControl = dbedt48
      end
      object lbl50: TLabel
        Left = 533
        Top = 128
        Width = 89
        Height = 13
        Caption = 'F30,vldproc   '#30830#35748
        FocusControl = dbedt49
      end
      object lbl51: TLabel
        Left = 533
        Top = 168
        Width = 89
        Height = 13
        Caption = 'F31,clsproc   close'
        FocusControl = dbedt50
      end
      object lbl52: TLabel
        Left = 128
        Top = 208
        Width = 79
        Height = 13
        Caption = 'F32,UnChkRitId '
        FocusControl = dbedt51
      end
      object lbl53: TLabel
        Left = 309
        Top = 208
        Width = 79
        Height = 13
        Caption = 'F33,UnChkProc '
        FocusControl = dbedt52
      end
      object Label14: TLabel
        Left = 424
        Top = 216
        Width = 96
        Height = 13
        Caption = 'F34 '#24847#20041#23578#19981#28165#26970' '
        FocusControl = DBEdit14
      end
      object Label15: TLabel
        Left = 536
        Top = 216
        Width = 135
        Height = 13
        Caption = 'F35 pickMULPAGE ID T623'
        FocusControl = DBEdit15
      end
      object dbedt21: TDBEdit
        Left = 8
        Top = 24
        Width = 100
        Height = 21
        DataField = 'F01'
        DataSource = ds3
        ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
        TabOrder = 0
        OnDblClick = dbedt21DblClick
      end
      object dbedt24: TDBEdit
        Left = 8
        Top = 64
        Width = 100
        Height = 21
        DataField = 'F04'
        DataSource = ds3
        ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
        TabOrder = 1
      end
      object dbedt25: TDBEdit
        Left = 8
        Top = 104
        Width = 100
        Height = 21
        DataField = 'F05'
        DataSource = ds3
        ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
        TabOrder = 2
      end
      object dbedt26: TDBEdit
        Left = 8
        Top = 144
        Width = 100
        Height = 21
        DataField = 'F06'
        DataSource = ds3
        ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
        TabOrder = 3
      end
      object dbedt27: TDBEdit
        Left = 8
        Top = 184
        Width = 100
        Height = 21
        DataField = 'F07'
        DataSource = ds3
        ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
        TabOrder = 4
      end
      object dbedt28: TDBEdit
        Left = 128
        Top = 24
        Width = 41
        Height = 21
        DataField = 'F09'
        DataSource = ds3
        ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
        TabOrder = 5
        OnChange = dbedt28Change
      end
      object dbedt30: TDBEdit
        Left = 128
        Top = 64
        Width = 166
        Height = 21
        Hint = #20027#34920#21333#21495#30340#23383#27573#21517
        DataField = 'F11'
        DataSource = ds3
        ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
        ParentShowHint = False
        ShowHint = True
        TabOrder = 6
      end
      object dbedt31: TDBEdit
        Left = 128
        Top = 104
        Width = 166
        Height = 21
        Hint = #23376#34920#21333#21495#30340#23383#27573#21517
        DataField = 'F12'
        DataSource = ds3
        ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
        ParentShowHint = False
        ShowHint = True
        TabOrder = 7
      end
      object dbedt34: TDBEdit
        Left = 128
        Top = 144
        Width = 166
        Height = 21
        DataField = 'F15'
        DataSource = ds3
        ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
        TabOrder = 8
      end
      object dbedt35: TDBEdit
        Left = 128
        Top = 184
        Width = 166
        Height = 21
        DataField = 'F16'
        DataSource = ds3
        ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
        TabOrder = 9
        OnDblClick = dbedt35DblClick
      end
      object dbedt36: TDBEdit
        Left = 309
        Top = 24
        Width = 99
        Height = 21
        DataField = 'F17'
        DataSource = ds3
        ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
        TabOrder = 10
        OnClick = dbedt36Click
      end
      object dbedt37: TDBEdit
        Left = 309
        Top = 64
        Width = 99
        Height = 21
        DataField = 'F18'
        DataSource = ds3
        ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
        TabOrder = 11
        OnClick = dbedt37Click
      end
      object dbedt38: TDBEdit
        Left = 309
        Top = 104
        Width = 99
        Height = 21
        DataField = 'F19'
        DataSource = ds3
        ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
        TabOrder = 12
      end
      object dbedt39: TDBEdit
        Left = 309
        Top = 144
        Width = 99
        Height = 21
        Hint = #22312#25171#24320#21333#25454#30340#31383#20307#30340' gridID'
        DataField = 'F20'
        DataSource = ds3
        ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
        ParentShowHint = False
        ShowHint = True
        TabOrder = 13
        OnClick = dbedt39Click
      end
      object dbedt40: TDBEdit
        Left = 309
        Top = 184
        Width = 99
        Height = 21
        DataField = 'F21'
        DataSource = ds3
        ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
        TabOrder = 14
      end
      object dbedt41: TDBEdit
        Left = 421
        Top = 24
        Width = 99
        Height = 21
        Hint = #23548#20837#30028#38754'ID'
        DataField = 'F22'
        DataSource = ds3
        ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
        ParentShowHint = False
        ShowHint = True
        TabOrder = 15
      end
      object dbedt42: TDBEdit
        Left = 421
        Top = 64
        Width = 99
        Height = 21
        Hint = #31243#24207#37324#27809#29992#21040
        DataField = 'F23'
        DataSource = ds3
        ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
        ParentShowHint = False
        ShowHint = True
        TabOrder = 16
      end
      object dbedt43: TDBEdit
        Left = 421
        Top = 104
        Width = 99
        Height = 21
        Hint = #31243#24207#37324#27809#29992#21040
        DataField = 'F24'
        DataSource = ds3
        ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
        ParentShowHint = False
        ShowHint = True
        TabOrder = 17
      end
      object dbedt44: TDBEdit
        Left = 421
        Top = 144
        Width = 99
        Height = 21
        DataField = 'F25'
        DataSource = ds3
        ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
        TabOrder = 18
      end
      object dbedt45: TDBEdit
        Left = 421
        Top = 184
        Width = 99
        Height = 21
        DataField = 'F26'
        DataSource = ds3
        ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
        TabOrder = 19
      end
      object dbedt46: TDBEdit
        Left = 533
        Top = 24
        Width = 99
        Height = 21
        DataField = 'F27'
        DataSource = ds3
        ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
        TabOrder = 20
      end
      object dbedt47: TDBEdit
        Left = 533
        Top = 64
        Width = 99
        Height = 21
        DataField = 'F28'
        DataSource = ds3
        ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
        TabOrder = 21
      end
      object dbedt48: TDBEdit
        Left = 533
        Top = 104
        Width = 99
        Height = 21
        DataField = 'F29'
        DataSource = ds3
        ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
        TabOrder = 22
      end
      object dbedt49: TDBEdit
        Left = 533
        Top = 144
        Width = 99
        Height = 21
        DataField = 'F30'
        DataSource = ds3
        ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
        TabOrder = 23
      end
      object dbedt50: TDBEdit
        Left = 533
        Top = 184
        Width = 99
        Height = 21
        DataField = 'F31'
        DataSource = ds3
        ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
        TabOrder = 24
      end
      object dbedt51: TDBEdit
        Left = 128
        Top = 224
        Width = 166
        Height = 21
        DataField = 'F32'
        DataSource = ds3
        ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
        TabOrder = 25
      end
      object dbedt52: TDBEdit
        Left = 309
        Top = 224
        Width = 99
        Height = 21
        DataField = 'F33'
        DataSource = ds3
        ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
        TabOrder = 26
      end
      object cbbCodePre: TComboBox
        Left = 168
        Top = 24
        Width = 129
        Height = 21
        ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
        ItemHeight = 0
        TabOrder = 27
        Text = 'cbbCodePre'
        OnClick = cbbCodePreClick
      end
      object DBEdit14: TDBEdit
        Left = 424
        Top = 232
        Width = 100
        Height = 21
        DataField = 'F34'
        DataSource = ds3
        ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
        TabOrder = 28
      end
      object DBEdit15: TDBEdit
        Left = 536
        Top = 232
        Width = 100
        Height = 21
        DataField = 'F35'
        DataSource = ds3
        ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
        TabOrder = 29
      end
    end
    object tsAnalyser: TTabSheet
      Caption = '       tsAnalyser t601    '
      ImageIndex = 3
      object lbl54: TLabel
        Left = 16
        Top = 24
        Width = 49
        Height = 13
        Caption = 'F01,formid'
        FocusControl = dbedt53
      end
      object lbl55: TLabel
        Left = 16
        Top = 64
        Width = 60
        Height = 13
        Caption = 'F02,Caption '
        FocusControl = dbedt54
      end
      object lbl56: TLabel
        Left = 16
        Top = 104
        Width = 63
        Height = 13
        Caption = 'F03,DbGridId'
        FocusControl = dbedt55
      end
      object lbl57: TLabel
        Left = 16
        Top = 144
        Width = 59
        Height = 13
        Caption = 'F04,FinderId'
        FocusControl = dbedt56
      end
      object lbl58: TLabel
        Left = 136
        Top = 24
        Width = 63
        Height = 13
        Caption = 'F05=t401.f01'
        FocusControl = dbedt57
      end
      object lbl59: TLabel
        Left = 136
        Top = 64
        Width = 70
        Height = 13
        Caption = 'F06,TopBoxId '
        FocusControl = dbedt58
      end
      object lbl60: TLabel
        Left = 136
        Top = 104
        Width = 69
        Height = 13
        Caption = 'F07,BtmBoxId '
        FocusControl = dbedt59
      end
      object lbl61: TLabel
        Left = 256
        Top = 24
        Width = 60
        Height = 13
        Caption = 'F09,DlgIdx,  '
        FocusControl = dbedt60
      end
      object lbl62: TLabel
        Left = 256
        Top = 64
        Width = 88
        Height = 13
        Caption = 'F10,SubSectionId '
        FocusControl = dbedt61
      end
      object lbl63: TLabel
        Left = 256
        Top = 104
        Width = 75
        Height = 13
        Caption = 'F11,DsFinderId '
        FocusControl = dbedt62
      end
      object lbl64: TLabel
        Left = 256
        Top = 144
        Width = 59
        Height = 13
        Caption = 'F12,Actions '
        FocusControl = dbedt63
      end
      object lbl65: TLabel
        Left = 360
        Top = 24
        Width = 118
        Height = 13
        Caption = 'F13,DblActIdx '#21452#20987#35760#24405
        FocusControl = dbedt64
      end
      object lbl66: TLabel
        Left = 360
        Top = 64
        Width = 43
        Height = 13
        Caption = 'F14,Tag '
        FocusControl = dbedt65
      end
      object lbl67: TLabel
        Left = 136
        Top = 232
        Width = 157
        Height = 13
        Caption = 'Y,mtdatasetID,t401.f02=t201.f01 '
      end
      object lbl68: TLabel
        Left = 16
        Top = 192
        Width = 124
        Height = 13
        Caption = 'Z,'#23384#20648#36807#31243#21442#25968',t401.f03'
      end
      object lbl23: TLabel
        Left = 16
        Top = 232
        Width = 107
        Height = 13
        Caption = 'T401_F01= T601_f05 '
        FocusControl = dbedt29
      end
      object lbl98: TLabel
        Left = 584
        Top = 248
        Width = 25
        Height = 13
        Caption = 'T401'
      end
      object dbedt53: TDBEdit
        Left = 16
        Top = 40
        Width = 100
        Height = 21
        DataField = 'F01'
        DataSource = ds5
        ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
        TabOrder = 0
      end
      object dbedt54: TDBEdit
        Left = 16
        Top = 80
        Width = 100
        Height = 21
        DataField = 'F02'
        DataSource = ds5
        ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
        TabOrder = 1
      end
      object dbedt55: TDBEdit
        Left = 16
        Top = 120
        Width = 100
        Height = 21
        DataField = 'F03'
        DataSource = ds5
        ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
        TabOrder = 2
        OnDblClick = dbedt55DblClick
      end
      object dbedt56: TDBEdit
        Left = 16
        Top = 160
        Width = 100
        Height = 21
        DataField = 'F04'
        DataSource = ds5
        ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
        TabOrder = 3
      end
      object dbedt57: TDBEdit
        Left = 136
        Top = 40
        Width = 100
        Height = 21
        DataField = 'F05'
        DataSource = ds5
        ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
        TabOrder = 4
        OnDblClick = dbedt57DblClick
      end
      object dbedt58: TDBEdit
        Left = 136
        Top = 80
        Width = 100
        Height = 21
        DataField = 'F06'
        DataSource = ds5
        ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
        TabOrder = 5
      end
      object dbedt59: TDBEdit
        Left = 136
        Top = 120
        Width = 100
        Height = 21
        DataField = 'F07'
        DataSource = ds5
        ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
        TabOrder = 6
        OnDblClick = dbedt59DblClick
      end
      object dbchk2: TDBCheckBox
        Left = 136
        Top = 160
        Width = 97
        Height = 17
        Caption = 'F08,IsOpen '
        DataField = 'F08'
        DataSource = ds5
        TabOrder = 7
        ValueChecked = 'True'
        ValueUnchecked = 'False'
      end
      object dbedt60: TDBEdit
        Left = 256
        Top = 40
        Width = 89
        Height = 21
        DataField = 'F09'
        DataSource = ds5
        ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
        TabOrder = 8
      end
      object dbedt61: TDBEdit
        Left = 256
        Top = 80
        Width = 89
        Height = 21
        DataField = 'F10'
        DataSource = ds5
        ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
        TabOrder = 9
      end
      object dbedt62: TDBEdit
        Left = 256
        Top = 120
        Width = 369
        Height = 21
        DataField = 'F11'
        DataSource = ds5
        ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
        TabOrder = 10
      end
      object dbedt63: TDBEdit
        Left = 256
        Top = 160
        Width = 161
        Height = 21
        DataField = 'F12'
        DataSource = ds5
        ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
        TabOrder = 11
      end
      object dbedt64: TDBEdit
        Left = 360
        Top = 40
        Width = 81
        Height = 21
        DataField = 'F13'
        DataSource = ds5
        ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
        TabOrder = 12
        OnChange = dbedt64Change
      end
      object dbedt65: TDBEdit
        Left = 360
        Top = 80
        Width = 265
        Height = 21
        DataField = 'F14'
        DataSource = ds5
        ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
        TabOrder = 13
      end
      object dbedt22: TDBEdit
        Left = 136
        Top = 248
        Width = 105
        Height = 21
        DataField = 'F02'
        DataSource = ds4
        ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
        TabOrder = 14
        OnClick = dbedt22Click
      end
      object dbedt23: TDBEdit
        Left = 16
        Top = 208
        Width = 609
        Height = 21
        DataField = 'F03'
        DataSource = ds4
        ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
        TabOrder = 15
      end
      object cbbactlstAnalyser: TComboBox
        Left = 416
        Top = 160
        Width = 209
        Height = 21
        ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
        ItemHeight = 13
        TabOrder = 16
        Text = ' '
        OnClick = cbbactlstAnalyserClick
      end
      object dbedt29: TDBEdit
        Left = 16
        Top = 248
        Width = 105
        Height = 21
        DataField = 'F01'
        DataSource = ds4
        ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
        TabOrder = 17
      end
      object cbbDBClick: TComboBox
        Left = 440
        Top = 40
        Width = 185
        Height = 21
        ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
        ItemHeight = 13
        TabOrder = 18
      end
      object dbnvgr1: TDBNavigator
        Left = 320
        Top = 248
        Width = 240
        Height = 25
        DataSource = ds4
        TabOrder = 19
      end
    end
    object tsTabEditor: TTabSheet
      Caption = ' tsTabEditor   t606'
      ImageIndex = 4
      object lbl24: TLabel
        Left = 24
        Top = 32
        Width = 87
        Height = 13
        Caption = 'F01 Id not identity '
        FocusControl = dbedt32
      end
      object lbl30: TLabel
        Left = 24
        Top = 72
        Width = 57
        Height = 13
        Caption = 'F02 Caption'
        FocusControl = dbedt33
      end
      object lbl33: TLabel
        Left = 24
        Top = 112
        Width = 69
        Height = 13
        Caption = 'F03 DataSetId'
        FocusControl = dbedt66
      end
      object lbl34: TLabel
        Left = 208
        Top = 32
        Width = 53
        Height = 13
        Caption = 'F04 BoxIds'
        FocusControl = dbedt67
      end
      object lbl69: TLabel
        Left = 208
        Top = 72
        Width = 49
        Height = 13
        Caption = 'F05 Width'
        FocusControl = dbedt68
      end
      object lbl70: TLabel
        Left = 208
        Top = 112
        Width = 52
        Height = 13
        Caption = 'F06 Height'
        FocusControl = dbedt69
      end
      object lbl71: TLabel
        Left = 352
        Top = 32
        Width = 61
        Height = 13
        Caption = 'F07 EditRitId'
        FocusControl = dbedt70
      end
      object dbedt32: TDBEdit
        Left = 24
        Top = 48
        Width = 100
        Height = 21
        DataField = 'F01'
        DataSource = ds6
        ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
        TabOrder = 0
      end
      object dbedt33: TDBEdit
        Left = 24
        Top = 88
        Width = 100
        Height = 21
        DataField = 'F02'
        DataSource = ds6
        ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
        TabOrder = 1
      end
      object dbedt66: TDBEdit
        Left = 24
        Top = 128
        Width = 100
        Height = 21
        DataField = 'F03'
        DataSource = ds6
        ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
        TabOrder = 2
        OnClick = dbedt66Click
      end
      object dbedt67: TDBEdit
        Left = 208
        Top = 48
        Width = 100
        Height = 21
        DataField = 'F04'
        DataSource = ds6
        ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
        TabOrder = 3
        OnDblClick = dbedt67DblClick
      end
      object dbedt68: TDBEdit
        Left = 208
        Top = 88
        Width = 100
        Height = 21
        DataField = 'F05'
        DataSource = ds6
        ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
        TabOrder = 4
      end
      object dbedt69: TDBEdit
        Left = 208
        Top = 128
        Width = 100
        Height = 21
        DataField = 'F06'
        DataSource = ds6
        ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
        TabOrder = 5
      end
      object dbedt70: TDBEdit
        Left = 352
        Top = 48
        Width = 100
        Height = 21
        DataField = 'F07'
        DataSource = ds6
        ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
        TabOrder = 6
      end
    end
    object tsT616: TTabSheet
      Caption = 'openEditor actlist id 8(T616)'
      ImageIndex = 5
      object lbl72: TLabel
        Left = 16
        Top = 24
        Width = 29
        Height = 26
        Caption = 'F01;id'#13#10
        FocusControl = dbedt71
      end
      object lbl73: TLabel
        Left = 16
        Top = 64
        Width = 56
        Height = 26
        Caption = 'F02;caption'#13#10
        FocusControl = dbedt72
      end
      object lbl74: TLabel
        Left = 16
        Top = 104
        Width = 51
        Height = 26
        Caption = 'F03 boxids'#13#10
        FocusControl = dbedt73
      end
      object lbl75: TLabel
        Left = 144
        Top = 24
        Width = 64
        Height = 26
        Caption = 'F04 datasetid'#13#10
        FocusControl = dbedt74
      end
      object lbl76: TLabel
        Left = 144
        Top = 104
        Width = 46
        Height = 26
        Caption = 'F06 width'#13#10
        FocusControl = dbedt75
      end
      object lbl77: TLabel
        Left = 144
        Top = 64
        Width = 50
        Height = 26
        Caption = 'F05 height'#13#10
        FocusControl = dbedt76
      end
      object lbl78: TLabel
        Left = 312
        Top = 24
        Width = 54
        Height = 26
        Caption = 'F07 cpyflds'#13#10
        FocusControl = dbedt77
      end
      object lbl79: TLabel
        Left = 312
        Top = 64
        Width = 61
        Height = 26
        Caption = 'F12 EditRitId'#13#10
        FocusControl = dbedt78
      end
      object lbl80: TLabel
        Left = 312
        Top = 104
        Width = 74
        Height = 26
        Caption = 'F13 DeleteRitId'#13#10
        FocusControl = dbedt79
      end
      object lbl81: TLabel
        Left = 440
        Top = 24
        Width = 64
        Height = 26
        Caption = 'F14 PrintRitId'#13#10
        FocusControl = dbedt80
      end
      object lbl97: TLabel
        Left = 16
        Top = 152
        Width = 58
        Height = 13
        Caption = 'F15 actions '
        FocusControl = dbedt96
      end
      object dbedt71: TDBEdit
        Left = 16
        Top = 40
        Width = 100
        Height = 21
        DataField = 'F01'
        DataSource = ds7
        ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
        TabOrder = 0
      end
      object dbedt72: TDBEdit
        Left = 16
        Top = 80
        Width = 100
        Height = 21
        DataField = 'F02'
        DataSource = ds7
        ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
        TabOrder = 1
      end
      object dbedt73: TDBEdit
        Left = 16
        Top = 120
        Width = 100
        Height = 21
        DataField = 'F03'
        DataSource = ds7
        ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
        TabOrder = 2
        OnDblClick = dbedt73DblClick
      end
      object dbedt74: TDBEdit
        Left = 144
        Top = 40
        Width = 134
        Height = 21
        DataField = 'F04'
        DataSource = ds7
        ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
        TabOrder = 3
        OnClick = dbedt74Click
      end
      object dbedt75: TDBEdit
        Left = 144
        Top = 120
        Width = 134
        Height = 21
        DataField = 'F06'
        DataSource = ds7
        ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
        TabOrder = 4
      end
      object dbedt76: TDBEdit
        Left = 144
        Top = 80
        Width = 134
        Height = 21
        DataField = 'F05'
        DataSource = ds7
        ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
        TabOrder = 5
      end
      object dbedt77: TDBEdit
        Left = 312
        Top = 40
        Width = 100
        Height = 21
        DataField = 'F07'
        DataSource = ds7
        ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
        TabOrder = 6
      end
      object dbedt78: TDBEdit
        Left = 312
        Top = 80
        Width = 100
        Height = 21
        DataField = 'F12'
        DataSource = ds7
        ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
        TabOrder = 7
      end
      object dbedt79: TDBEdit
        Left = 312
        Top = 120
        Width = 100
        Height = 21
        DataField = 'F13'
        DataSource = ds7
        ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
        TabOrder = 8
      end
      object dbedt80: TDBEdit
        Left = 440
        Top = 40
        Width = 105
        Height = 21
        DataField = 'F14'
        DataSource = ds7
        ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
        TabOrder = 9
      end
      object cbbOpenEditor: TComboBox
        Left = 120
        Top = 168
        Width = 161
        Height = 21
        ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
        ItemHeight = 0
        TabOrder = 10
        Text = 'cbbOpenEditor'
        OnClick = cbbOpenEditorClick
      end
      object dbedt96: TDBEdit
        Left = 16
        Top = 168
        Width = 105
        Height = 21
        DataField = 'F15'
        DataSource = ds7
        ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
        TabOrder = 11
      end
    end
    object ts_Pick_T603: TTabSheet
      Caption = '   ts_Pick_T603       '
      ImageIndex = 6
      object lbl82: TLabel
        Left = 24
        Top = 16
        Width = 49
        Height = 13
        Caption = 'F01 formid'
        FocusControl = dbedt81
      end
      object lbl83: TLabel
        Left = 24
        Top = 56
        Width = 57
        Height = 13
        Caption = 'F02 Catpion'
        FocusControl = dbedt82
      end
      object lbl84: TLabel
        Left = 24
        Top = 96
        Width = 63
        Height = 13
        Caption = 'F03 DbGridId'
        FocusControl = dbedt83
      end
      object lbl85: TLabel
        Left = 24
        Top = 136
        Width = 68
        Height = 13
        Caption = 'F04 MtParams'
        FocusControl = dbedt84
      end
      object lbl86: TLabel
        Left = 152
        Top = 16
        Width = 90
        Height = 13
        Caption = 'F05 FromKeyFlds   '
        FocusControl = dbedt85
      end
      object lbl87: TLabel
        Left = 152
        Top = 56
        Width = 71
        Height = 13
        Caption = 'F06 ToKeyFlds'
        FocusControl = dbedt86
      end
      object lbl88: TLabel
        Left = 152
        Top = 96
        Width = 81
        Height = 13
        Caption = 'F07 FromCpyFlds'
        FocusControl = dbedt87
      end
      object lbl89: TLabel
        Left = 152
        Top = 136
        Width = 71
        Height = 13
        Caption = 'F08 ToCpyFlds'
        FocusControl = dbedt88
      end
      object lbl90: TLabel
        Left = 424
        Top = 56
        Width = 56
        Height = 13
        Caption = 'F10 Actions'
        FocusControl = dbedt89
      end
      object lbl91: TLabel
        Left = 424
        Top = 136
        Width = 91
        Height = 13
        Caption = 'F12 WarePropRitId'
        FocusControl = dbedt90
      end
      object lbl92: TLabel
        Left = 720
        Top = 16
        Width = 101
        Height = 13
        Caption = 'F13 slPriceInRfsRitID'
        FocusControl = dbedt91
      end
      object lbl93: TLabel
        Left = 720
        Top = 56
        Width = 112
        Height = 13
        Caption = 'F14 slPriceOutRfsRitID '
        FocusControl = dbedt92
      end
      object lbl94: TLabel
        Left = 720
        Top = 96
        Width = 86
        Height = 13
        Caption = 'F15 phQuoteRitID'
        FocusControl = dbedt93
      end
      object lbl95: TLabel
        Left = 720
        Top = 136
        Width = 103
        Height = 13
        Caption = 'F16 ydWarepropRitID'
        FocusControl = dbedt94
      end
      object lbl96: TLabel
        Left = 720
        Top = 184
        Width = 91
        Height = 13
        Caption = 'F17 phOrderdlRitID'
        FocusControl = dbedt95
      end
      object dbedt81: TDBEdit
        Left = 24
        Top = 32
        Width = 100
        Height = 21
        DataField = 'F01'
        DataSource = ds8
        ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
        TabOrder = 0
      end
      object dbedt82: TDBEdit
        Left = 24
        Top = 72
        Width = 100
        Height = 21
        DataField = 'F02'
        DataSource = ds8
        ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
        TabOrder = 1
      end
      object dbedt83: TDBEdit
        Left = 24
        Top = 112
        Width = 100
        Height = 21
        DataField = 'F03'
        DataSource = ds8
        ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
        TabOrder = 2
        OnDblClick = dbedt83DblClick
      end
      object dbedt84: TDBEdit
        Left = 24
        Top = 152
        Width = 100
        Height = 21
        DataField = 'F04'
        DataSource = ds8
        ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
        TabOrder = 3
      end
      object dbedt85: TDBEdit
        Left = 152
        Top = 32
        Width = 265
        Height = 21
        DataField = 'F05'
        DataSource = ds8
        ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
        TabOrder = 4
      end
      object dbedt86: TDBEdit
        Left = 152
        Top = 72
        Width = 265
        Height = 21
        DataField = 'F06'
        DataSource = ds8
        ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
        TabOrder = 5
      end
      object dbedt87: TDBEdit
        Left = 152
        Top = 112
        Width = 265
        Height = 21
        DataField = 'F07'
        DataSource = ds8
        ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
        TabOrder = 6
      end
      object dbedt88: TDBEdit
        Left = 152
        Top = 152
        Width = 265
        Height = 21
        DataField = 'F08'
        DataSource = ds8
        ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
        TabOrder = 7
      end
      object dbchk3: TDBCheckBox
        Left = 424
        Top = 32
        Width = 97
        Height = 17
        Caption = 'F09 IsOpen'
        DataField = 'F09'
        DataSource = ds8
        TabOrder = 8
        ValueChecked = 'True'
        ValueUnchecked = 'False'
      end
      object dbedt89: TDBEdit
        Left = 424
        Top = 72
        Width = 137
        Height = 21
        DataField = 'F10'
        DataSource = ds8
        ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
        TabOrder = 9
      end
      object dbchk4: TDBCheckBox
        Left = 520
        Top = 32
        Width = 97
        Height = 17
        Caption = 'F11  IsRepeat'
        DataField = 'F11'
        DataSource = ds8
        TabOrder = 10
        ValueChecked = 'True'
        ValueUnchecked = 'False'
      end
      object dbedt90: TDBEdit
        Left = 424
        Top = 152
        Width = 289
        Height = 21
        DataField = 'F12'
        DataSource = ds8
        ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
        TabOrder = 11
      end
      object dbedt91: TDBEdit
        Left = 720
        Top = 32
        Width = 100
        Height = 21
        DataField = 'F13'
        DataSource = ds8
        ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
        TabOrder = 12
      end
      object dbedt92: TDBEdit
        Left = 720
        Top = 72
        Width = 100
        Height = 21
        DataField = 'F14'
        DataSource = ds8
        ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
        TabOrder = 13
      end
      object dbedt93: TDBEdit
        Left = 720
        Top = 112
        Width = 100
        Height = 21
        DataField = 'F15'
        DataSource = ds8
        ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
        TabOrder = 14
      end
      object dbedt94: TDBEdit
        Left = 720
        Top = 152
        Width = 100
        Height = 21
        DataField = 'F16'
        DataSource = ds8
        ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
        TabOrder = 15
      end
      object dbedt95: TDBEdit
        Left = 720
        Top = 200
        Width = 100
        Height = 21
        DataField = 'F17'
        DataSource = ds8
        ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
        TabOrder = 16
      end
      object cbbPickWindow: TComboBox
        Left = 560
        Top = 72
        Width = 153
        Height = 21
        ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
        ItemHeight = 0
        TabOrder = 17
        OnClick = cbbPickWindowClick
      end
      object dbnvgr2: TDBNavigator
        Left = 264
        Top = 224
        Width = 240
        Height = 25
        DataSource = ds8
        TabOrder = 18
      end
    end
    object TabSheet1: TTabSheet
      Caption = 'PickUniversal T623 '
      ImageIndex = 7
      object Label1: TLabel
        Left = 24
        Top = 32
        Width = 12
        Height = 13
        Caption = 'pk'
        FocusControl = DBEdit1
      end
      object Label2: TLabel
        Left = 24
        Top = 72
        Width = 54
        Height = 13
        Caption = 'f02 Catpion'
        FocusControl = DBEdit2
      end
      object Label3: TLabel
        Left = 24
        Top = 112
        Width = 78
        Height = 13
        Caption = 'f03 FromKeyFlds'
        FocusControl = DBEdit3
      end
      object Label4: TLabel
        Left = 24
        Top = 152
        Width = 71
        Height = 13
        Caption = 'f04  ToKeyFlds'
        FocusControl = DBEdit4
      end
      object Label5: TLabel
        Left = 152
        Top = 32
        Width = 78
        Height = 13
        Caption = 'f05 FromCpyFlds'
        FocusControl = DBEdit5
      end
      object Label6: TLabel
        Left = 152
        Top = 72
        Width = 68
        Height = 13
        Caption = 'f06 ToCpyFlds'
        FocusControl = DBEdit6
      end
      object Label7: TLabel
        Left = 152
        Top = 112
        Width = 215
        Height = 13
        Caption = 'f07 MtParams   parameters form Up  layer (bill)'
        FocusControl = DBEdit7
      end
      object Label8: TLabel
        Left = 408
        Top = 32
        Width = 53
        Height = 13
        Caption = 'f09 Actions'
        FocusControl = DBEdit8
      end
      object Label9: TLabel
        Left = 416
        Top = 104
        Width = 50
        Height = 13
        Caption = 'f11  BoxID'
        FocusControl = DBEdit9
      end
      object Label10: TLabel
        Left = 416
        Top = 144
        Width = 65
        Height = 13
        Caption = 'f12 DbGridIds'
        FocusControl = DBEdit10
      end
      object Label11: TLabel
        Left = 704
        Top = 48
        Width = 95
        Height = 13
        Caption = 'f13  DbGridCaptions'
        FocusControl = DBEdit11
      end
      object Label12: TLabel
        Left = 704
        Top = 88
        Width = 80
        Height = 13
        Caption = 'F14 mtDataSetId'
        FocusControl = DBEdit12
      end
      object Label13: TLabel
        Left = 704
        Top = 128
        Width = 70
        Height = 13
        Caption = 'F15 DLParams'
        FocusControl = DBEdit13
      end
      object DBEdit1: TDBEdit
        Left = 24
        Top = 48
        Width = 100
        Height = 21
        DataField = 'pk'
        DataSource = dsdsT623
        ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
        TabOrder = 0
      end
      object DBEdit2: TDBEdit
        Left = 24
        Top = 88
        Width = 100
        Height = 21
        DataField = 'f02'
        DataSource = dsdsT623
        ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
        TabOrder = 1
      end
      object DBEdit3: TDBEdit
        Left = 24
        Top = 128
        Width = 100
        Height = 21
        DataField = 'f03'
        DataSource = dsdsT623
        ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
        TabOrder = 2
      end
      object DBEdit4: TDBEdit
        Left = 24
        Top = 168
        Width = 100
        Height = 21
        DataField = 'f04'
        DataSource = dsdsT623
        ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
        TabOrder = 3
      end
      object DBEdit5: TDBEdit
        Left = 152
        Top = 48
        Width = 249
        Height = 21
        DataField = 'f05'
        DataSource = dsdsT623
        ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
        TabOrder = 4
      end
      object DBEdit6: TDBEdit
        Left = 152
        Top = 88
        Width = 249
        Height = 21
        DataField = 'f06'
        DataSource = dsdsT623
        ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
        TabOrder = 5
      end
      object DBEdit7: TDBEdit
        Left = 152
        Top = 128
        Width = 100
        Height = 21
        DataField = 'f07'
        DataSource = dsdsT623
        ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
        TabOrder = 6
      end
      object DBCheckBox1: TDBCheckBox
        Left = 152
        Top = 168
        Width = 97
        Height = 17
        Caption = 'f08 IsOpen'
        DataField = 'f08'
        DataSource = dsdsT623
        TabOrder = 7
        ValueChecked = 'True'
        ValueUnchecked = 'False'
      end
      object DBEdit8: TDBEdit
        Left = 408
        Top = 48
        Width = 100
        Height = 21
        DataField = 'f09'
        DataSource = dsdsT623
        ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
        TabOrder = 8
      end
      object DBCheckBox2: TDBCheckBox
        Left = 416
        Top = 80
        Width = 97
        Height = 17
        Caption = 'f10 IsRepeat'
        DataField = 'f10'
        DataSource = dsdsT623
        TabOrder = 9
        ValueChecked = 'True'
        ValueUnchecked = 'False'
      end
      object DBEdit9: TDBEdit
        Left = 416
        Top = 120
        Width = 100
        Height = 21
        DataField = 'f11'
        DataSource = dsdsT623
        ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
        TabOrder = 10
        OnDblClick = DBEdit9DblClick
      end
      object DBEdit10: TDBEdit
        Left = 416
        Top = 160
        Width = 100
        Height = 21
        DataField = 'f12'
        DataSource = dsdsT623
        ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
        TabOrder = 11
        OnDblClick = DBEdit10DblClick
      end
      object DBEdit11: TDBEdit
        Left = 704
        Top = 64
        Width = 100
        Height = 21
        DataField = 'f13'
        DataSource = dsdsT623
        ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
        TabOrder = 12
      end
      object DBEdit12: TDBEdit
        Left = 704
        Top = 104
        Width = 100
        Height = 21
        DataField = 'F14'
        DataSource = dsdsT623
        ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
        TabOrder = 13
        OnClick = DBEdit12Click
      end
      object cmbPickUniversal: TComboBox
        Left = 512
        Top = 48
        Width = 161
        Height = 21
        ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
        ItemHeight = 0
        TabOrder = 14
        Text = 'cmbPickUniversal'
        OnClick = cmbPickUniversalClick
      end
      object DBNavigator1: TDBNavigator
        Left = 104
        Top = 216
        Width = 240
        Height = 25
        DataSource = dsdsT623
        TabOrder = 15
      end
      object openT623: TButton
        Left = 32
        Top = 216
        Width = 75
        Height = 25
        Caption = 'openT623'
        TabOrder = 16
        OnClick = openT623Click
      end
      object DBEdit13: TDBEdit
        Left = 704
        Top = 144
        Width = 100
        Height = 21
        DataField = 'F15'
        DataSource = dsdsT623
        ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
        TabOrder = 17
      end
    end
    object ts1: TTabSheet
      Caption = 'TreeMgrT620'
      ImageIndex = 8
    end
  end
  object tlb1: TToolBar
    Left = 0
    Top = 0
    Width = 940
    Height = 33
    ButtonHeight = 23
    Caption = 'tlb1'
    TabOrder = 1
    object btnopen: TButton
      Left = 0
      Top = 2
      Width = 75
      Height = 23
      Caption = 'btnopen'
      TabOrder = 3
      OnClick = btnopenClick
    end
    object btnadd: TButton
      Left = 75
      Top = 2
      Width = 75
      Height = 23
      Caption = 'btnadd'
      TabOrder = 0
      OnClick = btnaddClick
    end
    object btnedit: TButton
      Left = 150
      Top = 2
      Width = 75
      Height = 23
      Caption = 'btnedit'
      TabOrder = 4
      OnClick = btneditClick
    end
    object btncancel: TButton
      Left = 225
      Top = 2
      Width = 75
      Height = 23
      Caption = 'btncancel'
      TabOrder = 1
      OnClick = btncancelClick
    end
    object btnDelete: TButton
      Left = 300
      Top = 2
      Width = 75
      Height = 23
      Caption = 'btnDelete'
      TabOrder = 5
      OnClick = btnDeleteClick
    end
    object btnsave: TButton
      Left = 375
      Top = 2
      Width = 75
      Height = 23
      Caption = 'btnsave'
      TabOrder = 2
      OnClick = btnsaveClick
    end
  end
  object edtFromID: TEdit
    Left = 652
    Top = 26
    Width = 121
    Height = 21
    ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
    TabOrder = 2
    Text = '1'
  end
  object dsTreeEdit: TADODataSet
    CommandText = 'select * from t611 where f01=:f01'#13#10
    Parameters = <>
    Left = 16
    Top = 40
    object dsTreeEditF01: TAutoIncField
      FieldName = 'F01'
      ReadOnly = True
    end
    object dsTreeEditF03: TIntegerField
      FieldName = 'F03'
    end
    object dsTreeEditF04: TIntegerField
      FieldName = 'F04'
    end
    object dsTreeEditF05: TStringField
      FieldName = 'F05'
      Size = 50
    end
    object dsTreeEditF02: TStringField
      FieldName = 'F02'
      Size = 50
    end
    object dsTreeEditF06: TStringField
      FieldName = 'F06'
      Size = 50
    end
    object dsTreeEditF07: TStringField
      FieldName = 'F07'
      Size = 50
    end
    object dsTreeEditF08: TStringField
      FieldName = 'F08'
      Size = 50
    end
    object dsTreeEditF09: TStringField
      FieldName = 'F09'
      Size = 50
    end
  end
  object ds2: TDataSource
    DataSet = dsTreeEdit
    Left = 16
    Top = 24
  end
  object dsTreeGrid: TADODataSet
    CommandText = 'select * from T612  where f01=:f01'
    Parameters = <>
    Left = 104
    Top = 48
  end
  object ds1: TDataSource
    DataSet = dsTreeGrid
    Left = 88
    Top = 32
  end
  object actlstTreeGrid: TActionList
    Images = dmFrm.ImageList1
    Left = 112
    Top = 32
    object actWarePropAction1: TAction
      Caption = #23646#24615
      ImageIndex = 28
    end
    object actEditorAction1: TAction
      Caption = #32534#36753
      ImageIndex = 21
    end
    object actDeleteAction1: TAction
      Caption = #21024#38500
      ImageIndex = 2
    end
    object actCaAction1: TAction
      Caption = #23545#24080
      ImageIndex = 1
    end
    object actCaDlAction1: TAction
      Caption = #26126#32454
      ImageIndex = 28
    end
    object actSortAction1: TAction
      Caption = #25490#24207
      ImageIndex = 15
    end
    object actClientPropAction1: TAction
      Caption = #23646#24615
      ImageIndex = 28
    end
    object actClientEmpAction1: TAction
      Caption = #25480#26435
      ImageIndex = 33
    end
    object actLocateAction1: TAction
      Caption = #23450#20301
      ImageIndex = 12
    end
    object actOriginalAction1: TAction
      Caption = #26399#21021
      ImageIndex = 4
    end
    object actFilterAction1: TAction
      Caption = #36807#28388
      ImageIndex = 19
    end
    object actClntOwnerAction1: TAction
      Caption = #31649#29702
      ImageIndex = 27
    end
    object actClntPubAction1: TAction
      Caption = #20849#20139
      ImageIndex = 28
    end
    object actUpdateImage: TAction
      Caption = #26356#26032#22270#29255
    end
  end
  object dsBill: TADODataSet
    ConnectionString = 
      'Provider=SQLOLEDB.1;Persist Security Info=False;User ID=sa;Initi' +
      'al Catalog=jingbeisys;Data Source=xts3'
    CommandText = 'select  * from T602    where  f01=:f01'
    Parameters = <
      item
        Name = 'f01'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 208
    Top = 40
  end
  object ds3: TDataSource
    DataSet = dsBill
    Left = 176
    Top = 40
  end
  object dsAnalyserT601: TADODataSet
    CommandText = 'select  top 1 *  from T601  where f01=:f01'#13#10
    Parameters = <
      item
        Name = 'f01'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 288
    Top = 48
    object dsAnalyserT601F01: TAutoIncField
      FieldName = 'F01'
      ReadOnly = True
    end
    object dsAnalyserT601F02: TStringField
      FieldName = 'F02'
      Size = 50
    end
    object dsAnalyserT601F03: TIntegerField
      FieldName = 'F03'
    end
    object dsAnalyserT601F04: TIntegerField
      FieldName = 'F04'
    end
    object dsAnalyserT601F05: TStringField
      FieldName = 'F05'
      Size = 50
    end
    object dsAnalyserT601F06: TStringField
      FieldName = 'F06'
      Size = 50
    end
    object dsAnalyserT601F07: TStringField
      FieldName = 'F07'
      Size = 50
    end
    object dsAnalyserT601F08: TBooleanField
      FieldName = 'F08'
    end
    object dsAnalyserT601F09: TIntegerField
      FieldName = 'F09'
    end
    object dsAnalyserT601F10: TIntegerField
      FieldName = 'F10'
    end
    object dsAnalyserT601F11: TIntegerField
      FieldName = 'F11'
    end
    object dsAnalyserT601F12: TStringField
      FieldName = 'F12'
      Size = 50
    end
    object dsAnalyserT601F13: TIntegerField
      FieldName = 'F13'
    end
    object dsAnalyserT601F14: TIntegerField
      FieldName = 'F14'
    end
  end
  object ds5: TDataSource
    DataSet = dsAnalyserT601
    Left = 288
    Top = 40
  end
  object dsT401: TADODataSet
    CommandText = 'select *from t401  where f01=:f01'
    Parameters = <
      item
        Name = 'f01'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 748
    Top = 13
    object dsT401F01: TAutoIncField
      FieldName = 'F01'
      ReadOnly = True
    end
    object dsT401F02: TIntegerField
      FieldName = 'F02'
    end
    object dsT401F03: TStringField
      FieldName = 'F03'
      Size = 500
    end
  end
  object ds4: TDataSource
    DataSet = dsT401
    Left = 776
    Top = 16
  end
  object actlstAnalyser: TActionList
    Images = dmFrm.ImageList1
    Left = 312
    Top = 32
    object actAction1: TAction
      Caption = #25171#21360
      ImageIndex = 13
    end
    object actAction2: TAction
      Caption = #21047#26032
      ImageIndex = 16
    end
    object actSortAction3: TAction
      Caption = #25490#24207
      ImageIndex = 15
    end
    object actAction4: TAction
      Caption = #23548#20986
      ImageIndex = 17
    end
    object actAction5: TAction
      Caption = #23548#20837
      ImageIndex = 21
    end
    object actAction6: TAction
      Caption = #36864#20986
      ImageIndex = 8
    end
    object actAction7: TAction
      Caption = #20998#27573
      ImageIndex = 14
    end
    object actAction8: TAction
      Caption = #26597#35810
      ImageIndex = 3
    end
    object actAction9: TAction
      Caption = #26597#25214
      ImageIndex = 31
    end
    object actWarePropAction10: TAction
      Caption = #23646#24615
      ImageIndex = 28
    end
    object actDeleteAction11: TAction
      Caption = #21024#38500
      ImageIndex = 2
    end
    object actPickWareAction12: TAction
      Caption = #23548#20837
      ImageIndex = 14
    end
    object actTabEditorAction13: TAction
      Caption = #32534#36753
      ImageIndex = 21
    end
    object actNewTabEditorAction14: TAction
      Caption = #26032#22686
      ImageIndex = 33
    end
    object actNewBillAction15: TAction
      Category = 'bill'
      Caption = #26032#22686
      ImageIndex = 7
    end
    object actEditBillAction16: TAction
      Category = 'bill'
      Caption = #20462#25913
      ImageIndex = 21
    end
    object actDeleteBillAction17: TAction
      Category = 'bill'
      Caption = #21024#38500
      ImageIndex = 2
    end
    object actChkBillAction18: TAction
      Category = 'bill'
      Caption = #23457#26680
      ImageIndex = 10
    end
    object actDeposeBillAction19: TAction
      Category = 'bill'
      Caption = #20316#24223
      ImageIndex = 11
    end
    object actCloseBillAction20: TAction
      Category = 'bill'
      Caption = #20851#38381
      ImageIndex = 22
    end
    object actVldBillAction21: TAction
      Category = 'bill'
      Caption = #30830#35748
      ImageIndex = 12
    end
    object actEditorAction22: TAction
      Caption = #32534#36753
      ImageIndex = 21
    end
    object actDetailAction23: TAction
      Category = 'bill'
      Caption = #26126#32454
      ImageIndex = 32
    end
    object actBillAction24: TAction
      Category = 'bill'
      Caption = #20973#35777
      ImageIndex = 1
    end
    object actCalcIncreaseAction25: TAction
      Caption = 'CalcIncreaseAction1'
    end
    object actFilterAction26: TAction
      Caption = #36807#28388
      ImageIndex = 19
    end
    object actInitdsFinderAction27: TAction
      Caption = 'InitdsFinderAction1'
    end
    object actPrint2Action28: TAction
      Caption = #25171#21360
      ImageIndex = 13
    end
    object actph1Action29: TAction
      Caption = 'ph1Action1'
    end
    object actph3Action30: TAction
      Caption = 'ph3Action1'
    end
    object actsl1Action31: TAction
      Caption = 'sl1Action1'
    end
    object actsl3Action32: TAction
      Caption = 'sl3Action1'
    end
    object actInvAction33: TAction
      Caption = #26356#26032
      ImageIndex = 10
    end
    object actWhInvbAction34: TAction
      Caption = #21021#22987
      ImageIndex = 26
    end
    object actArriveXAction35: TAction
      Caption = #21478#21040
      ImageIndex = 1
    end
    object actOrdAriXAction36: TAction
      Caption = #35814#24773
      ImageIndex = 28
    end
    object actBillAction37: TAction
      Caption = #21333#25454
      ImageIndex = 32
    end
    object actFirstAction38: TAction
      Caption = #39318#26465
      ImageIndex = 25
    end
    object actPriorAction39: TAction
      Caption = #19978#26465
      ImageIndex = 22
    end
    object actNextAction40: TAction
      Caption = #19979#26465
      ImageIndex = 24
    end
    object actLastAction41: TAction
      Caption = #23614#26465
      ImageIndex = 23
    end
    object actLocateAction42: TAction
      Caption = #23450#20301
      ImageIndex = 12
    end
    object actFilterAction43: TAction
      Caption = #36807#28388
      ImageIndex = 19
    end
    object actLocateAction44: TAction
      Caption = #23450#20301
      ImageIndex = 12
    end
    object actOrdCloseAction45: TAction
      Caption = #20851#38381
      ImageIndex = 10
    end
    object actOrdAriBilAction46: TAction
      Caption = #35814#24773
      Hint = #26597#38405#35813#20379#24212#21830#30340#25152#26377#26410#20851#38381#30340#35746#21333#21040#36135#24773#20917'...'
      ImageIndex = 1
    end
    object actCaAction47: TAction
      Caption = #23545#24080
      ImageIndex = 1
    end
    object actWhOutAction48: TAction
      Caption = #23457#26680
      ImageIndex = 10
    end
    object actHisAction49: TAction
      Caption = #21382#21490
      Hint = #26597#30475#21382#21490#34917#36135#21333'...'
      ImageIndex = 1
    end
    object actBankInoutAction50: TAction
      Caption = #26126#32454
      ImageIndex = 1
    end
    object actAction51: TAction
      Caption = #26126#32454
      ImageIndex = 32
    end
    object actWareInoutAction52: TAction
      Caption = #26126#32454
      ImageIndex = 1
    end
    object actOpenBillAction53: TAction
      Caption = #25171#24320
      ImageIndex = 0
    end
    object actProcAction54: TAction
      Caption = #24323#21333
      ImageIndex = 2
    end
    object actOutStpAction55: TAction
      Caption = #21462#28040
      ImageIndex = 4
    end
    object actDyRprtDtlAction56: TAction
      Caption = #35814#24773
      ImageIndex = 1
    end
    object actAlrdyBlAction57: TAction
      Caption = #20973#25454
      ImageIndex = 1
    end
    object actChkAction58: TAction
      Caption = #23457#26680
      ImageIndex = 10
    end
    object actDyRprtDtl2Action59: TAction
      Caption = #35814#32454
      ImageIndex = 1
    end
    object actIsInvoiceAction60: TAction
      Caption = #24320#31080
      ImageIndex = 10
    end
    object actItmInoutAction61: TAction
      Caption = 'actItmInoutAction61'
    end
    object actShldOutIOAction62: TAction
      Caption = 'actShldOutIOAction62'
    end
    object actwrprice63: TAction
      Caption = #36827#20215
      ImageIndex = 12
    end
    object actIsOutBillAction64: TAction
      Caption = #20986#21333
      ImageIndex = 33
    end
    object actInvoiceRecHintAction65: TAction
      Caption = #24310#26399
      ImageIndex = 21
    end
    object actInvoiceRecedAction1: TAction
      Caption = #25910#21040
      ImageIndex = 10
    end
    object actEmpSaleDlAction67: TAction
      Caption = #35814#24773
    end
    object actClientKp2Action68: TAction
      Caption = #21457#31080
      ImageIndex = 1
    end
    object actClientProfitAction69: TAction
      Caption = 'actClientProfitAction69'
    end
    object actDetailNewAction70: TAction
      Caption = #26032#22686
      ImageIndex = 21
    end
    object actDetailEdtAction71: TAction
      Caption = #32534#36753
      ImageIndex = 21
    end
    object actLinkmansAction72: TAction
      Caption = #32852#31995#20154
      ImageIndex = 27
    end
    object actActivitysAction73: TAction
      Caption = #27963#21160
      ImageIndex = 33
    end
    object actLinkmanNewAction74: TAction
      Caption = #22686#21152
      ImageIndex = 7
    end
    object actActivityNewAction75: TAction
      Caption = #22686#21152
      ImageIndex = 7
    end
    object actYdstockAction76: TAction
      Caption = #24322#22320
      ImageIndex = 18
    end
    object actQuotePriceAction77: TAction
      Caption = #20379#25253
      Hint = #21442#38405#20379#36135#25253#20215
      ImageIndex = 35
    end
    object actOrderReferAction78: TAction
      Caption = #35746#21442
      Hint = #22312#35746#21442#32771
      ImageIndex = 1
    end
    object actArriveReferAction79: TAction
      Caption = #36827#21442
      ImageIndex = 12
    end
    object actDemandAction80: TAction
      Caption = #38656#27714
      ImageIndex = 6
    end
    object actIsInvEditAction81: TAction
      Caption = #32534#36753
      ImageIndex = 21
    end
    object actStkinAndStkout: TAction
      Caption = #26576#31181#22120#20214#30340#20986#20837#24211#27719#20817
      ImageIndex = 32
    end
    object actInputInvoice83: TAction
      Caption = #21457#31080#24405#20837
    end
    object actPackPic84: TAction
      Caption = #23553#35013#22270#29255
    end
    object actBrandPic85: TAction
      Caption = #21697#29260#22270#29255
    end
    object actPriceOutRfs86: TAction
      Caption = 'actPriceOutRfs86'
    end
    object actNeedInvoiceDL: TAction
      Caption = #26410#24320#31080#26126#32454
    end
    object actHaveInvoiceDL: TAction
      Caption = #24050#24320#31080#26126#32454
    end
    object actInvoice: TAction
      Caption = #24320#31080
    end
  end
  object dsTabEditor: TADODataSet
    CommandText = 'select * from T606 where f01=:f01'
    Parameters = <>
    Left = 384
    Top = 56
    object dsTabEditorF01: TStringField
      FieldName = 'F01'
      Size = 50
    end
    object dsTabEditorF02: TStringField
      FieldName = 'F02'
      Size = 50
    end
    object dsTabEditorF03: TIntegerField
      FieldName = 'F03'
    end
    object dsTabEditorF04: TStringField
      FieldName = 'F04'
      Size = 50
    end
    object dsTabEditorF05: TIntegerField
      FieldName = 'F05'
    end
    object dsTabEditorF06: TIntegerField
      FieldName = 'F06'
    end
    object dsTabEditorF07: TStringField
      FieldName = 'F07'
      Size = 50
    end
  end
  object ds6: TDataSource
    DataSet = dsTabEditor
    Left = 384
    Top = 40
  end
  object dsOpenEditorT616: TADODataSet
    CommandText = 'select * from T616 where f01=:f01  '
    Parameters = <
      item
        Name = '=f01'
        Size = -1
        Value = Null
      end>
    Left = 552
    Top = 40
  end
  object ds7: TDataSource
    DataSet = dsOpenEditorT616
    Left = 528
    Top = 40
  end
  object dsPickT603: TADODataSet
    CommandText = 'select * from T603 where f01=:f01'#13#10
    Parameters = <
      item
        Name = 'f01'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 672
    Top = 48
    object dsPickT603F01: TAutoIncField
      FieldName = 'F01'
      ReadOnly = True
    end
    object dsPickT603F02: TStringField
      FieldName = 'F02'
      Size = 50
    end
    object dsPickT603F03: TIntegerField
      FieldName = 'F03'
    end
    object dsPickT603F04: TStringField
      FieldName = 'F04'
      Size = 100
    end
    object dsPickT603F09: TBooleanField
      FieldName = 'F09'
    end
    object dsPickT603F07: TStringField
      FieldName = 'F07'
      Size = 300
    end
    object dsPickT603F08: TStringField
      FieldName = 'F08'
      Size = 300
    end
    object dsPickT603F05: TStringField
      FieldName = 'F05'
      Size = 50
    end
    object dsPickT603F06: TStringField
      FieldName = 'F06'
      Size = 50
    end
    object dsPickT603F10: TStringField
      FieldName = 'F10'
      Size = 50
    end
    object dsPickT603F11: TBooleanField
      FieldName = 'F11'
    end
    object dsPickT603F12: TStringField
      FieldName = 'F12'
      Size = 50
    end
    object dsPickT603F13: TStringField
      FieldName = 'F13'
      Size = 50
    end
    object dsPickT603F14: TStringField
      FieldName = 'F14'
      Size = 50
    end
    object dsPickT603F15: TStringField
      FieldName = 'F15'
      Size = 50
    end
    object dsPickT603F16: TStringField
      FieldName = 'F16'
      Size = 50
    end
    object dsPickT603F17: TStringField
      FieldName = 'F17'
      Size = 50
    end
  end
  object ds8: TDataSource
    DataSet = dsPickT603
    Left = 656
    Top = 48
  end
  object actlstPickWindow: TActionList
    Images = dmFrm.ImageList1
    Left = 680
    Top = 48
    object actGetAction1: TAction
      Caption = #24341#20837
      ImageIndex = 12
    end
    object actSelectAction1: TAction
      Caption = #21453#36873
      ImageIndex = 26
    end
    object actCloseAction1: TAction
      Caption = #20851#38381
      ImageIndex = 8
    end
    object actFilterAction2: TAction
      Caption = #36807#28388
      ImageIndex = 19
    end
    object actLocateAction2: TAction
      Caption = #23450#20301
      ImageIndex = 3
    end
    object actSortAction2: TAction
      Caption = #25490#24207
      ImageIndex = 15
    end
    object actGetAction2: TAction
      Caption = #24341#20837
      ImageIndex = 12
    end
    object actMoveAction1: TAction
      Caption = #35843#35814
      ImageIndex = 21
    end
    object actYdWarePropAction1: TAction
      Caption = #24211#21442
      ImageIndex = 28
    end
    object actGetAction3: TAction
      Caption = #36873#20837
      ImageIndex = 12
    end
    object actQuoteAction1: TAction
      Caption = #20379#25253
      ImageIndex = 1
    end
    object actNewWareAction1: TAction
      Caption = #28155#21152
      ImageIndex = 7
    end
    object actOrderdlAction1: TAction
      Caption = #35746#21442
      ImageIndex = 14
    end
    object actPriceOutRfsAction1: TAction
      Caption = #21806#21442
      ImageIndex = 1
    end
    object actPriceInRfsAction1: TAction
      Caption = #36827#21442
      ImageIndex = 1
    end
    object actWarePropAction2: TAction
      Caption = #23646#24615
      ImageIndex = 28
    end
    object actPackPic2: TAction
      Caption = #23553#35013
    end
    object actBrandPic2: TAction
      Caption = #21697#29260
    end
    object ActInputInvoiceItem: TAction
      Caption = 'ActInputInvoiceItem'
    end
  end
  object actlstOpenEditor: TActionList
    Images = dmFrm.ImageList1
    Left = 576
    Top = 40
    object actAddAction: TAction
      Caption = #26032#22686
      ImageIndex = 7
    end
    object actCopyAction: TAction
      Caption = #22797#21046
      ImageIndex = 1
    end
    object actEditAction: TAction
      Caption = #20462#25913
      ImageIndex = 21
    end
    object actDeleteAction: TAction
      Caption = #21024#38500
      ImageIndex = 2
    end
    object actSaveAction: TAction
      Caption = #20445#23384
      ImageIndex = 9
    end
    object actCancelAction: TAction
      Caption = #25918#24323
      ImageIndex = 4
    end
    object actFirstAction: TAction
      Caption = #39318#24352
      ImageIndex = 25
    end
    object actPriorAction: TAction
      Caption = #19978#19968#24352
      ImageIndex = 22
    end
    object actNextAction: TAction
      Caption = #19979#19968#24352
      ImageIndex = 24
    end
    object actLastAction: TAction
      Caption = #26411#24352
      ImageIndex = 23
    end
    object actCloseAction: TAction
      Caption = #20851#38381
      ImageIndex = 8
    end
    object actPrintAction: TAction
      Caption = #25171#21360
      ImageIndex = 13
    end
    object actSetCaptionAction: TAction
      Caption = #26356#26032#26631#39064
      ImageIndex = 28
    end
    object actInputTaxAmt: TAction
      Caption = 'actInputTaxAmt13'#21457#31080#24212#25910#31246#37329
    end
  end
  object dsT623: TADODataSet
    ConnectionString = 
      'Provider=SQLOLEDB.1;Persist Security Info=False;User ID=sa;Initi' +
      'al Catalog=jingbeisys;Data Source=xts4'
    CommandText = 'select *  from t623  where pk=:pk'
    Parameters = <
      item
        Name = 'pk'
        Size = -1
        Value = Null
      end>
    Left = 776
    Top = 56
  end
  object dsdsT623: TDataSource
    DataSet = dsT623
    Left = 800
    Top = 56
  end
end
