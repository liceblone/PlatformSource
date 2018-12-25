object mainFrm: TmainFrm
  Left = 580
  Top = 165
  Width = 700
  Height = 400
  Caption = #26700#38754
  Color = 16761220
  DefaultMonitor = dmMainForm
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = #23435#20307
  Font.Style = []
  FormStyle = fsMDIForm
  KeyPreview = True
  Menu = MainMenu1
  OldCreateOrder = False
  WindowState = wsMaximized
  OnActivate = FormActivate
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 16
  object Splitter1: TSplitter
    Left = 185
    Top = 0
    Width = 10
    Height = 335
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 335
    Width = 692
    Height = 19
    Panels = <
      item
        Width = 200
      end
      item
        Width = 150
      end
      item
        Width = 200
      end
      item
        Width = 100
      end>
  end
  object gpTree: TGroupBox
    Left = 0
    Top = 0
    Width = 185
    Height = 335
    Align = alLeft
    Caption = #26641#29366#23548#33322
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    object TreeViewMenu: TTreeView
      Left = 2
      Top = 15
      Width = 181
      Height = 318
      Align = alClient
      Images = dmFrm.ImageList1
      Indent = 19
      ReadOnly = True
      TabOrder = 0
      OnDblClick = TreeViewMenuDblClick
    end
  end
  object MainMenu1: TMainMenu
    Images = dmFrm.ImageList1
    Left = 144
    Top = 64
    object WindowMenu: TMenuItem
      Caption = #31383#21475'(&W)'
      GroupIndex = 10
      OnClick = WindowMenuClick
      object MenuShowTree: TMenuItem
        Caption = #26641#29366#23548#33322
        Checked = True
        OnClick = MenuShowTreeClick
      end
      object ExchangeBtn: TMenuItem
        Action = DesktopFrm.WindowSwitch1
      end
      object N1: TMenuItem
        Action = DesktopFrm.WindowClose1
      end
      object CloseAllBtn: TMenuItem
        Action = DesktopFrm.WindowCloseAll1
      end
      object N37: TMenuItem
        Caption = '-'
      end
      object N2: TMenuItem
        Action = DesktopFrm.WindowCascade1
      end
      object N4: TMenuItem
        Action = DesktopFrm.WindowTileHorizontal1
      end
      object N5: TMenuItem
        Action = DesktopFrm.WindowTileVertical1
      end
      object N6: TMenuItem
        Action = DesktopFrm.WindowMinimizeAll1
      end
      object MaxAllBtn: TMenuItem
        Action = DesktopFrm.WindowMaxmizeAll1
      end
    end
    object TlMenu: TMenuItem
      Caption = #20854#23427'(&O)'
      GroupIndex = 10
      Hint = 'tytty'
      object bgBtn: TMenuItem
        Caption = #26700#38754#22270#20687
        object DefbgBtn: TMenuItem
          Caption = #20351#29992#40664#35748#26700#38754
          RadioItem = True
          OnClick = DefbgBtnClick
        end
        object WinBgBtn: TMenuItem
          Caption = #20351#29992'Windows'#26700#38754
          RadioItem = True
          OnClick = WinBgBtnClick
        end
        object MybgBtn: TMenuItem
          Caption = #33258#23450#20041#26700#38754'...'
          RadioItem = True
          OnClick = MybgBtnClick
        end
        object N7: TMenuItem
          Caption = #19981#20351#29992#32972#26223#22270#29255
          RadioItem = True
          OnClick = N7Click
        end
      end
      object NReflashMainMenu: TMenuItem
        Caption = #21047#26032#33756#21333
        Hint = 'tytutututyuu'
        OnClick = NReflashMainMenuClick
      end
      object NMetaData: TMenuItem
        Caption = #25968#25454#23383#20856
        OnClick = NMetaDataClick
      end
      object NClearBUserData: TMenuItem
        Caption = #28165#31354#19994#21153#25968#25454
        OnClick = NClearBUserDataClick
      end
      object NUpdateCacheFiles: TMenuItem
        Caption = #26356#26032#32531#23384
      end
      object N9: TMenuItem
        Caption = '-'
      end
      object menuRefreshCfgData: TMenuItem
        Caption = #21047#26032#37197#32622#20449#24687
        GroupIndex = 10
        OnClick = menuRefreshCfgDataClick
      end
    end
    object H1: TMenuItem
      Caption = #24110#21161'(&H)'
      GroupIndex = 10
      object N3: TMenuItem
        Caption = #20851#20110'...'
        OnClick = N3Click
      end
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 232
    Top = 64
    object N8: TMenuItem
      Caption = #22842
    end
    object p1: TMenuItem
      Caption = 'p'
    end
    object io1: TMenuItem
      Caption = 'io'
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
    Left = 272
    Top = 64
  end
  object dsMainMenu: TADODataSet
    Connection = dmFrm.ADOConnection1
    LockType = ltBatchOptimistic
    Parameters = <>
    Left = 56
    Top = 88
  end
end
