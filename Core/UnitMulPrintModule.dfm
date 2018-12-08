object FrmMulModulePrint: TFrmMulModulePrint
  Left = 396
  Top = 181
  Width = 464
  Height = 440
  Caption = #36873#25321#25171#21360#27169#26495
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDblClick = FormDblClick
  DesignSize = (
    456
    413)
  PixelsPerInch = 96
  TextHeight = 13
  object StrGridPrintModule: TStringGrid
    Left = 18
    Top = 8
    Width = 319
    Height = 265
    Hint = #21452#20987#21487#25913#21464#24403#21069#20540
    Anchors = [akLeft, akTop, akRight, akBottom]
    ColCount = 2
    Ctl3D = True
    DefaultColWidth = 120
    DefaultRowHeight = 22
    RowCount = 1
    FixedRows = 0
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goColSizing]
    ParentCtl3D = False
    ScrollBars = ssVertical
    TabOrder = 0
    OnClick = StrGridPrintModuleClick
    RowHeights = (
      23)
  end
  object BtnPreview: TButton
    Left = 351
    Top = 8
    Width = 96
    Height = 26
    Anchors = [akTop, akRight]
    Caption = #25171#21360#39044#35272'(&P)'
    Default = True
    TabOrder = 1
    OnClick = BtnPreviewClick
  end
  object Button2: TButton
    Left = 351
    Top = 38
    Width = 96
    Height = 24
    Anchors = [akTop, akRight]
    Cancel = True
    Caption = #21462#28040'(&C)'
    ModalResult = 2
    TabOrder = 2
  end
  object btnprint: TButton
    Left = 351
    Top = 155
    Width = 97
    Height = 26
    Anchors = [akTop, akRight]
    Caption = #36830#32493#25171#21360
    TabOrder = 3
    Visible = False
    OnClick = btnprintClick
  end
  object btnPrintOne: TButton
    Left = 351
    Top = 184
    Width = 97
    Height = 26
    Anchors = [akTop, akRight]
    Caption = #25171#21360
    TabOrder = 4
    Visible = False
    OnClick = btnPrintOneClick
  end
  object BtnDelete: TButton
    Left = 351
    Top = 65
    Width = 97
    Height = 26
    Anchors = [akTop, akRight]
    Caption = #21024#38500#27169#26495
    TabOrder = 5
    OnClick = BtnDeleteClick
  end
  object BtnPageSize: TButton
    Left = 351
    Top = 125
    Width = 97
    Height = 26
    Anchors = [akTop, akRight]
    Caption = #20445#23384#25171#21360#35774#32622
    TabOrder = 6
    OnClick = BtnPageSizeClick
  end
  object GroupBox1: TGroupBox
    Left = 16
    Top = 280
    Width = 321
    Height = 129
    Anchors = [akLeft, akRight, akBottom]
    Caption = #25171#21360#35774#32622
    TabOrder = 7
    object plPageSize: TPanel
      Left = 2
      Top = 16
      Width = 317
      Height = 111
      Align = alBottom
      TabOrder = 0
      object lblheight: TLabel
        Left = 272
        Top = 29
        Width = 12
        Height = 13
        Caption = #39640
      end
      object lblwidth: TLabel
        Left = 272
        Top = 7
        Width = 12
        Height = 13
        Caption = #23485
      end
      object Label3: TLabel
        Left = 98
        Top = 5
        Width = 42
        Height = 13
        Caption = #24038#36793#36317'  '
      end
      object Label4: TLabel
        Left = 185
        Top = 5
        Width = 42
        Height = 13
        Caption = #21491#36793#36317'  '
      end
      object Label5: TLabel
        Left = 98
        Top = 31
        Width = 42
        Height = 13
        Caption = #19978#36793#36317'  '
      end
      object Label6: TLabel
        Left = 185
        Top = 31
        Width = 42
        Height = 13
        Caption = #19979#36793#36317'  '
      end
      object lblTitle: TLabel
        Left = 8
        Top = 56
        Width = 96
        Height = 24
        Caption = #25260#22836#23383#20307
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -24
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object btnFont: TButton
        Left = 8
        Top = 16
        Width = 89
        Height = 25
        Caption = #36873#25321#25260#22836#23383#20307
        TabOrder = 0
        OnClick = btnFontClick
      end
      object edtLeftMargin: TDBEdit
        Left = 142
        Top = 0
        Width = 41
        Height = 21
        DataField = 'FLeftMargin'
        DataSource = DataSource1
        ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
        TabOrder = 1
      end
      object edtRightMargin: TDBEdit
        Left = 228
        Top = 0
        Width = 41
        Height = 21
        DataField = 'FRightMargin'
        DataSource = DataSource1
        ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
        TabOrder = 2
      end
      object edtTopMargin: TDBEdit
        Left = 142
        Top = 24
        Width = 41
        Height = 21
        DataField = 'FTopMargin'
        DataSource = DataSource1
        ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
        TabOrder = 3
      end
      object edtBtmMargin: TDBEdit
        Left = 228
        Top = 24
        Width = 41
        Height = 21
        DataField = 'FBtmMargin'
        DataSource = DataSource1
        ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
        TabOrder = 4
      end
      object edtWidth: TDBEdit
        Left = 285
        Top = 0
        Width = 34
        Height = 21
        DataField = 'FRptWidth'
        DataSource = DataSource1
        ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
        TabOrder = 5
      end
      object edtHeight: TDBEdit
        Left = 285
        Top = 24
        Width = 33
        Height = 21
        DataField = 'FRptHeight'
        DataSource = DataSource1
        ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
        TabOrder = 6
      end
      object RdgpOrientation: TDBCheckBox
        Left = 235
        Top = 56
        Width = 73
        Height = 17
        Caption = #32437#21521#25171#21360
        DataField = 'FIsPortrait'
        DataSource = DataSource1
        TabOrder = 7
        ValueChecked = 'True'
        ValueUnchecked = 'False'
      end
      object ChkDrawGrid: TDBCheckBox
        Left = 147
        Top = 56
        Width = 49
        Height = 17
        Caption = #36793#26694
        DataField = 'FHasVline'
        DataSource = DataSource1
        TabOrder = 8
        ValueChecked = 'True'
        ValueUnchecked = 'False'
      end
      object dbChkLabelTemplate: TDBCheckBox
        Left = 147
        Top = 80
        Width = 78
        Height = 17
        Caption = #26631#31614#27169#26495
        DataField = 'FLabelTemplate'
        DataSource = DataSource1
        ReadOnly = True
        TabOrder = 9
        ValueChecked = 'True'
        ValueUnchecked = 'False'
      end
    end
  end
  object BtnDefineRptModel: TButton
    Left = 351
    Top = 95
    Width = 97
    Height = 26
    Anchors = [akTop, akRight]
    Caption = #23450#20041#25171#21360#27169#26495
    TabOrder = 8
    OnClick = BtnDefineRptModelClick
  end
  object BtnPrevior: TButton
    Left = 351
    Top = 271
    Width = 96
    Height = 24
    Anchors = [akTop, akRight]
    Cancel = True
    Caption = #19978#19968#24352
    TabOrder = 9
    Visible = False
    OnClick = BtnPreviorClick
  end
  object BtnNext: TButton
    Left = 351
    Top = 298
    Width = 96
    Height = 24
    Anchors = [akTop, akRight]
    Cancel = True
    Caption = #19979#19968#24352
    TabOrder = 10
    Visible = False
    OnClick = BtnNextClick
  end
  object btnExit: TButton
    Left = 351
    Top = 336
    Width = 97
    Height = 26
    Anchors = [akTop, akRight]
    Caption = #36864#20986
    TabOrder = 11
    OnClick = btnExitClick
  end
  object DatasetReport: TADODataSet
    Parameters = <>
    Left = 384
    Top = 368
  end
  object FontDialog1: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Left = 360
    Top = 368
  end
  object DataSource1: TDataSource
    DataSet = DatasetReport
    Left = 416
    Top = 368
  end
  object frReport1: TfrReport
    InitialZoom = pzDefault
    PreviewButtons = [pbZoom, pbLoad, pbSave, pbPrint, pbFind, pbHelp, pbExit]
    RebuildPrinter = False
    Left = 328
    Top = 368
    ReportForm = {19000000}
  end
end
