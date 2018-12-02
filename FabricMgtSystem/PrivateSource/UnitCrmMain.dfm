object FrmCrm: TFrmCrm
  Left = 302
  Top = 74
  Width = 958
  Height = 646
  Caption = 'FrmCrm'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  Visible = True
  WindowState = wsMaximized
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyUp = FormKeyUp
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object splTreeLeft: TSplitter
    Left = 185
    Top = 56
    Height = 563
  end
  object ctrlbr1: TControlBar
    Left = 0
    Top = 0
    Width = 950
    Height = 56
    Align = alTop
    AutoSize = True
    Color = clBtnFace
    ParentColor = False
    TabOrder = 0
    object toolbar: TToolBar
      Left = 11
      Top = 2
      Width = 574
      Height = 38
      AutoSize = True
      ButtonHeight = 36
      ButtonWidth = 55
      Caption = 'toolbar'
      Ctl3D = False
      Flat = True
      Images = dmFrm.ImageList1
      ShowCaptions = True
      TabOrder = 0
      object btnCtrl: TToolButton
        Left = 0
        Top = 0
        Caption = #35774#32622#25511#38190
        ImageIndex = 45
        OnClick = btnCtrlClick
      end
      object btnReflash: TToolButton
        Left = 55
        Top = 0
        Caption = #21047#26032
        ImageIndex = 16
        OnClick = btnReflashClick
      end
      object btnTreeVisiable: TToolButton
        Left = 110
        Top = 0
        Caption = #26641#25511
        Down = True
        ImageIndex = 6
        Style = tbsCheck
        OnClick = btnTreeVisiableClick
      end
      object btnQryScrollVisiable: TToolButton
        Left = 165
        Top = 0
        Caption = #26597#35810#26694
        Down = True
        ImageIndex = 17
        Style = tbsCheck
        OnClick = btnQryScrollVisiableClick
      end
      object btnSubVisiable: TToolButton
        Left = 220
        Top = 0
        Caption = #26126#32454
        Down = True
        ImageIndex = 4
        Style = tbsCheck
        OnClick = btnSubVisiableClick
      end
      object ToolButton2: TToolButton
        Left = 275
        Top = 0
        Action = Filter
      end
      object ToolButton1: TToolButton
        Left = 330
        Top = 0
        Action = ActHelp
      end
      object btnexit: TToolButton
        Left = 385
        Top = 0
        Caption = #36864#20986
        ImageIndex = 8
        OnClick = btnexitClick
      end
      object BtnSum: TToolButton
        Left = 440
        Top = 0
        Action = actSum
        Caption = #27719#24635
        Style = tbsCheck
        Visible = False
      end
    end
    object tlbMain: TToolBar
      Left = 598
      Top = 2
      Width = 346
      Height = 48
      AutoSize = True
      ButtonHeight = 36
      ButtonWidth = 65
      Caption = 'tlbMain'
      Ctl3D = False
      Flat = True
      Images = dmFrm.ImageList1
      ShowCaptions = True
      TabOrder = 1
    end
  end
  object PnlRight: TPanel
    Left = 188
    Top = 56
    Width = 762
    Height = 563
    Align = alClient
    Caption = 'PnlRight'
    TabOrder = 1
    object Splitter1: TSplitter
      Left = 1
      Top = 359
      Width = 760
      Height = 3
      Cursor = crVSplit
      Align = alBottom
    end
    object MtPnl: TPanel
      Left = 1
      Top = 1
      Width = 760
      Height = 80
      Align = alTop
      AutoSize = True
      ParentColor = True
      TabOrder = 0
      object MtScrollBox: TScrollBox
        Left = 1
        Top = 1
        Width = 758
        Height = 78
        Align = alClient
        AutoSize = True
        Color = clWhite
        Ctl3D = True
        ParentBackground = True
        ParentColor = False
        ParentCtl3D = False
        ParentShowHint = False
        ShowHint = False
        TabOrder = 0
        OnDblClick = MtScrollBoxDblClick
        DesignSize = (
          754
          74)
        object btnOpen: TSpeedButton
          Left = 539
          Top = 32
          Width = 59
          Height = 22
          Anchors = [akTop, akRight]
          Caption = #26597#35810
          Glyph.Data = {
            36030000424D3603000000000000360000002800000010000000100000000100
            18000000000000030000C40E0000C40E00000000000000000000F7BD8C4A637B
            BD9494F7BD8CF7BD8CF7BD8CF7BD8CF7BD8CF7BD8CF7BD8CF7BD8CF7BD8CF7BD
            8CAD7B73F7BD8CF7BD8C6B9CC6188CE74A7BA5C69494F7BD8CF7BD8CF7BD8CF7
            BD8CF7BD8CF7BD8CF7BD8CF7BD8CF7BD8CAD7B73AD7B73F7BD8C4AB5FF52B5FF
            218CEF4A7BA5C69494F7BD8CF7BD8CF7BD8CF7BD8CAD7B73AD7B73AD7B73AD7B
            73AD7B73AD7B73AD7B73F7BD8C52B5FF52B5FF1884E74A7BA5C69494F7BD8CF7
            BD8CF7BD8CF7BD8CF7BD8CF7BD8CF7BD8CAD7B73AD7B73F7BD8CF7BD8CF7BD8C
            52B5FF4AB5FF188CE74A7BA5BD9494F7BD8CF7BD8CF7BD8CF7BD8CF7BD8CF7BD
            8CAD7B73F7BD8CF7BD8CF7BD8CF7BD8CF7BD8C52B5FF4AB5FF2184DE5A6B73F7
            BD8CAD7B73C6A59CD6B5A5CEA59CF7BD8CF7BD8CF7BD8CF7BD8CF7BD8CF7BD8C
            F7BD8CF7BD8C52BDFFB5D6EFA5948CB59C8CF7E7CEFFFFD6FFFFD6FFFFD6E7DE
            BDCEADA5F7BD8CF7BD8CF7BD8CF7BD8CF7BD8CF7BD8CF7BD8CCEB5B5D6B5A5FF
            EFC6FFFFD6FFFFD6FFFFD6FFFFDEFFFFEFF7F7EFB58C8CF7BD8CF7BD8CF7BD8C
            F7BD8CF7BD8CF7BD8CC6948CF7DEB5F7D6A5FFF7CEFFFFD6FFFFDEFFFFEFFFFF
            F7FFFFFFDED6BDF7BD8CF7BD8CF7BD8CF7BD8CF7BD8CF7BD8CDEBDA5FFE7ADF7
            CE94FFF7CEFFFFDEFFFFE7FFFFF7FFFFF7FFFFEFF7EFD6C69C94F7BD8CF7BD8C
            F7BD8CF7BD8CF7BD8CE7C6ADFFDEADEFBD84F7E7B5FFFFD6FFFFDEFFFFE7FFFF
            E7FFFFDEF7F7D6C6AD9CF7BD8CF7BD8CF7BD8CF7BD8CF7BD8CDEBDADFFE7B5EF
            BD84F7CE94FFEFC6FFFFDEFFFFDEFFFFDEFFFFDEF7EFD6C6A59CF7BD8CF7BD8C
            F7BD8CF7BD8CF7BD8CC69C94FFEFC6FFEFC6F7D6A5F7CE9CF7E7B5FFF7CEFFF7
            D6FFFFD6E7DEBDF7BD8CF7BD8CF7BD8CF7BD8CF7BD8CF7BD8CF7BD8CDEC6ADFF
            FFFFFFF7EFF7CE94EFBD84F7CE9CFFE7B5FFF7C6BD9C8CF7BD8CF7BD8CF7BD8C
            F7BD8CF7BD8CF7BD8CF7BD8CF7BD8CD6BDBDF7EFD6FFEFC6FFE7ADFFE7B5F7DE
            B5CEAD9CF7BD8CF7BD8CF7BD8CF7BD8CF7BD8CF7BD8CF7BD8CF7BD8CF7BD8CF7
            BD8CCEAD94CEAD9CDEBDA5DEBDA5F7BD8CF7BD8CF7BD8CF7BD8C}
          OnClick = btnOpenClick
        end
        object Label1: TLabel
          Left = 70
          Top = 1
          Width = 3
          Height = 13
          Alignment = taRightJustify
        end
        object LblTitle: TLabel
          Left = 352
          Top = 4
          Width = 40
          Height = 19
          Caption = #26631#39064
          Font.Charset = GB2312_CHARSET
          Font.Color = clWindowText
          Font.Height = -19
          Font.Name = #26999#20307'_GB2312'
          Font.Style = [fsBold]
          ParentFont = False
        end
      end
    end
    object pnlMainGrid: TPanel
      Left = 1
      Top = 81
      Width = 760
      Height = 278
      Align = alClient
      TabOrder = 1
      object ScrollBoxDbCtrl: TScrollBox
        Left = 1
        Top = 139
        Width = 758
        Height = 138
        Align = alBottom
        AutoScroll = False
        AutoSize = True
        Color = clCream
        Ctl3D = False
        ParentColor = False
        ParentCtl3D = False
        TabOrder = 0
      end
      object pgcMainGrid: TPageControl
        Left = 1
        Top = 1
        Width = 758
        Height = 138
        Align = alClient
        TabOrder = 1
      end
    end
    object PnlItem: TPanel
      Left = 1
      Top = 362
      Width = 760
      Height = 200
      Align = alBottom
      Caption = 'PnlItem'
      TabOrder = 2
      object pgcSubInterface: TPageControl
        Left = 1
        Top = 1
        Width = 758
        Height = 198
        Align = alClient
        TabOrder = 0
        OnChange = pgcSubInterfaceChange
        OnDragDrop = pgcSubInterfaceDragDrop
        OnDragOver = pgcSubInterfaceDragOver
      end
    end
  end
  object PnLLeft: TPanel
    Left = 0
    Top = 56
    Width = 185
    Height = 563
    Align = alLeft
    Caption = 'PnLLeft'
    TabOrder = 2
    object pgcTree: TPageControl
      Left = 1
      Top = 1
      Width = 183
      Height = 520
      Align = alClient
      TabOrder = 0
      OnDragDrop = pgcTreeDragDrop
      OnDragOver = pgcTreeDragOver
    end
    object Panel1: TPanel
      Left = 1
      Top = 521
      Width = 183
      Height = 41
      Align = alBottom
      TabOrder = 1
      Visible = False
    end
  end
  object actlstCRM: TActionList
    Images = dmFrm.ImageList1
    Left = 272
    Top = 64
    object Action1: TAction
      Caption = 'Action1'
    end
    object actEditMain: TAction
      Caption = #32534#36753
      ImageIndex = 21
      OnExecute = actEditMainExecute
    end
    object DeleteAction1: TAction
      Caption = #21024#38500
    end
    object Filter: TAction
      Caption = #36807#28388
      ImageIndex = 19
      OnExecute = FilterExecute
    end
    object FavoriteM: TAction
      Caption = 'FavoriteM'
      ImageIndex = 23
      OnExecute = FavoriteMExecute
    end
    object FavoriteMgr: TAction
      Caption = 'FavoriteMgr'
      OnExecute = FavoriteMgrExecute
    end
    object FavoriteContentMgr: TAction
      Caption = 'FavoriteContentMgr'
      ImageIndex = 20
      OnExecute = FavoriteContentMgrExecute
    end
    object BatchUpdate: TAction
      Caption = #25209#37327#25913
      ImageIndex = 26
      OnExecute = BatchUpdateExecute
    end
    object ActHelp: TAction
      Caption = #24110#21161
      ImageIndex = 5
    end
    object ActLinkBill: TAction
      Caption = #20851#32852#21333#25454
      ImageIndex = 32
      OnExecute = ActLinkBillExecute
    end
    object ActExportExcel: TAction
      Caption = #23548#20986
      ImageIndex = 40
      OnExecute = ActExportExcelExecute
    end
    object ActProperty: TAction
      Caption = #26448#26009#23646#24615
      ImageIndex = 42
      OnExecute = ActPropertyExecute
    end
    object actSum: TAction
      Caption = 'actSum'
      ImageIndex = 41
      OnExecute = actSumExecute
    end
    object actprint: TAction
      Caption = #25171#21360
      ImageIndex = 13
      OnExecute = actprintExecute
    end
    object actChk: TAction
      Caption = 'actChk'
      ImageIndex = 39
      OnExecute = actChkExecute
    end
  end
  object XPMenu1: TXPMenu
    DimLevel = 30
    GrayLevel = 10
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMenuText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Color = clBtnFace
    DrawMenuBar = False
    IconBackColor = clBtnFace
    MenuBarColor = clBtnFace
    SelectColor = clHighlight
    SelectBorderColor = clHighlight
    SelectFontColor = clMenuText
    DisabledColor = clInactiveCaption
    SeparatorColor = clBtnFace
    CheckedColor = clHighlight
    IconWidth = 24
    DrawSelect = True
    UseSystemColors = True
    UseDimColor = False
    OverrideOwnerDraw = False
    Gradient = True
    FlatMenu = False
    AutoDetect = False
    Active = False
    Left = 302
    Top = 66
  end
end