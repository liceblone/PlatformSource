object FrmUserDefineReport: TFrmUserDefineReport
  Left = 285
  Top = 88
  Width = 910
  Height = 606
  Caption = 'FrmUserDefineReport'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poMainFormCenter
  WindowState = wsMaximized
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 201
    Top = 57
    Width = 8
    Height = 484
  end
  object PnlRight: TPanel
    Left = 209
    Top = 57
    Width = 693
    Height = 484
    Align = alClient
    Caption = 'PnlRight'
    TabOrder = 0
    object Splitter2: TSplitter
      Left = 1
      Top = 210
      Width = 691
      Height = 8
      Cursor = crVSplit
      Align = alTop
    end
    object Splitter3: TSplitter
      Left = 1
      Top = 292
      Width = 691
      Height = 10
      Cursor = crVSplit
      Align = alBottom
    end
    object GrpTop: TGroupBox
      Left = 1
      Top = 42
      Width = 691
      Height = 168
      Align = alTop
      Caption = #25253#34920#22836
      TabOrder = 0
      object imgtop: TImage
        Left = 2
        Top = 15
        Width = 687
        Height = 151
        Align = alClient
        OnDragDrop = imgtopDragDrop
        OnDragOver = imgtopDragOver
        OnMouseDown = imgtopMouseDown
        OnMouseMove = imgtopMouseMove
        OnMouseUp = imgtopMouseUp
      end
    end
    object grpBtm: TGroupBox
      Left = 1
      Top = 302
      Width = 691
      Height = 181
      Align = alBottom
      Caption = #25253#34920#23614
      TabOrder = 1
      OnDragDrop = grpBtmDragDrop
      OnDragOver = grpBtmDragOver
      object imgbtm: TImage
        Left = 2
        Top = 15
        Width = 687
        Height = 164
        Align = alClient
        OnDragDrop = imgbtmDragDrop
        OnDragOver = imgbtmDragOver
        OnMouseDown = imgbtmMouseDown
        OnMouseMove = imgbtmMouseMove
        OnMouseUp = imgbtmMouseUp
      end
    end
    object Panel1: TPanel
      Left = 1
      Top = 1
      Width = 691
      Height = 41
      Align = alTop
      Caption = 'Panel1'
      Ctl3D = False
      ParentCtl3D = False
      TabOrder = 2
      object edttitle: TEdit
        Left = 355
        Top = 10
        Width = 246
        Height = 19
        Ctl3D = False
        ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
        ParentCtl3D = False
        TabOrder = 0
      end
    end
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 57
    Width = 201
    Height = 484
    ActivePage = TabSheet3
    Align = alLeft
    TabOrder = 1
    object TabSheet1: TTabSheet
      Caption = #25968#25454#23383#27573
      object Splitter4: TSplitter
        Left = 0
        Top = 193
        Width = 193
        Height = 10
        Cursor = crVSplit
        Align = alTop
      end
      object LstMDatasetFields: TListBox
        Left = 0
        Top = 0
        Width = 193
        Height = 193
        Align = alTop
        ItemHeight = 13
        TabOrder = 0
        OnMouseMove = LstMDatasetFieldsMouseMove
      end
      object LstGridFields: TListBox
        Left = 0
        Top = 203
        Width = 193
        Height = 253
        Align = alClient
        ItemHeight = 13
        TabOrder = 1
        OnMouseMove = LstGridFieldsMouseMove
      end
    end
    object TabSheet2: TTabSheet
      Caption = #31995#32479#23383#27573
      ImageIndex = 1
      object lstSysFields: TListBox
        Left = 0
        Top = 0
        Width = 193
        Height = 641
        Align = alTop
        ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
        ItemHeight = 13
        TabOrder = 0
        OnMouseMove = lstSysFieldsMouseMove
      end
    end
    object TabSheet3: TTabSheet
      Caption = #28155#21152#25511#20214
      ImageIndex = 2
      object Label3: TLabel
        Left = 0
        Top = 264
        Width = 35
        Height = 13
        Caption = #27169#26495'ID'
        Visible = False
      end
      object Label2: TLabel
        Left = 8
        Top = 88
        Width = 36
        Height = 13
        Caption = #26631#31614#21517
        WordWrap = True
      end
      object GrpCtrlType: TRadioGroup
        Left = 8
        Top = 8
        Width = 73
        Height = 70
        Caption = #25511#38190#31867#22411
        DragCursor = crSizeAll
        DragKind = dkDock
        DragMode = dmAutomatic
        ItemIndex = 0
        Items.Strings = (
          #26631#31614'=0  ')
        TabOrder = 0
      end
      object BtnCreateCtrl: TButton
        Left = 48
        Top = 216
        Width = 129
        Height = 25
        Caption = #21019#24314#25511#38190
        TabOrder = 1
        OnClick = BtnCreateCtrlClick
      end
      object edtPrintID: TEdit
        Left = 48
        Top = 264
        Width = 81
        Height = 21
        ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
        TabOrder = 2
        Visible = False
      end
      object btnUseOldModule: TButton
        Left = 128
        Top = 264
        Width = 49
        Height = 25
        Caption = #24341#29992
        TabOrder = 3
        Visible = False
        OnClick = btnUseOldModuleClick
      end
      object RdoGrpPosition: TRadioGroup
        Left = 88
        Top = 8
        Width = 89
        Height = 70
        Caption = #20301#32622
        ItemIndex = 0
        Items.Strings = (
          #34920#22836'=0'
          #34920#23614'=1')
        TabOrder = 4
      end
      object MmlblCaption: TMemo
        Left = 48
        Top = 88
        Width = 129
        Height = 121
        ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
        Lines.Strings = (
          #26032#26631#31614)
        TabOrder = 5
      end
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 541
    Width = 902
    Height = 19
    Panels = <
      item
        Width = 50
      end
      item
        Width = 50
      end
      item
        Width = 50
      end
      item
        Width = 50
      end
      item
        Width = 50
      end>
  end
  object ToolBar1: TToolBar
    Left = 0
    Top = 0
    Width = 902
    Height = 57
    ButtonHeight = 36
    ButtonWidth = 67
    Caption = 'ToolBar1'
    Images = dmFrm.ImageList1
    ShowCaptions = True
    TabOrder = 3
    object ToolButton2: TToolButton
      Left = 0
      Top = 2
      Caption = #21047#26032#35774#32622
      ImageIndex = 26
      OnClick = ToolButton2Click
    end
    object ToolButton3: TToolButton
      Left = 67
      Top = 2
      Caption = #35774#32622#23383#20307
      ImageIndex = 16
      OnClick = ToolButton3Click
    end
    object ToolButton4: TToolButton
      Left = 134
      Top = 2
      Caption = #24038#23545#40784
      ImageIndex = 17
      OnClick = ToolButton4Click
    end
    object ToolButton5: TToolButton
      Left = 201
      Top = 2
      Caption = #21491#23545#40784
      ImageIndex = 23
      OnClick = ToolButton5Click
    end
    object ToolButton9: TToolButton
      Left = 268
      Top = 2
      Caption = #24038#31227
      ImageIndex = 22
      OnClick = ToolButton9Click
    end
    object ToolButton11: TToolButton
      Left = 335
      Top = 2
      Caption = #21491#31216
      ImageIndex = 24
      OnClick = ToolButton11Click
    end
    object ToolButton10: TToolButton
      Left = 402
      Top = 2
      Caption = #19978#31227
      ImageIndex = 33
      OnClick = ToolButton10Click
    end
    object ToolButton12: TToolButton
      Left = 469
      Top = 2
      Caption = #19979#31227
      ImageIndex = 15
      OnClick = ToolButton12Click
    end
    object ToolButton1: TToolButton
      Left = 536
      Top = 2
      Caption = #20445#23384#35774#32622
      ImageIndex = 9
      Wrap = True
      OnClick = ToolButton1Click
    end
    object Label1: TLabel
      Left = 0
      Top = 38
      Width = 48
      Height = 36
      Caption = #31227#21160#27493#38271
    end
    object edMoveSpan: TEdit
      Left = 48
      Top = 38
      Width = 19
      Height = 36
      ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
      TabOrder = 0
      Text = '5'
    end
    object ToolButton6: TToolButton
      Left = 67
      Top = 38
      Caption = #27700#24179#23545#40784
      ImageIndex = 14
      OnClick = ToolButton6Click
    end
    object ToolButton7: TToolButton
      Left = 134
      Top = 38
      Caption = #22402#30452#31561#38388#36317
      ImageIndex = 18
      OnClick = ToolButton7Click
    end
    object ToolButton8: TToolButton
      Left = 201
      Top = 38
      Caption = #27700#24179#31561#38388#36317
      ImageIndex = 21
      OnClick = ToolButton8Click
    end
    object TlbtnExpand: TToolButton
      Left = 268
      Top = 38
      Caption = #25193#22823
      ImageIndex = 32
      OnClick = TlbtnExpandClick
    end
    object Tlbtnsuoxiao: TToolButton
      Left = 335
      Top = 38
      Caption = #32553#23567
      ImageIndex = 29
      OnClick = TlbtnsuoxiaoClick
    end
    object tblSpantoSmall: TToolButton
      Left = 402
      Top = 38
      Caption = #32553#23567#38388#36317
      ImageIndex = 30
      OnClick = tblSpantoSmallClick
    end
    object tlbtnSpanTobig: TToolButton
      Left = 469
      Top = 38
      Caption = #25193#22823#38388#36317
      ImageIndex = 31
      OnClick = tlbtnSpanTobigClick
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 345
    Top = 248
    object N1: TMenuItem
      Caption = #35774#32622#38656#35201#25171#21360#30340#21015
    end
  end
  object FontDialog1: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Left = 824
    Top = 40
  end
  object MainMenu1: TMainMenu
    Left = 258
    Top = 122
    object j1: TMenuItem
      Caption = 'j'
    end
  end
end
