object TreeGridFrm: TTreeGridFrm
  Left = 147
  Top = 166
  Width = 723
  Height = 416
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = #23435#20307
  Font.Style = []
  FormStyle = fsMDIChild
  KeyPreview = True
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poDefault
  Visible = True
  WindowState = wsMaximized
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 180
    Top = 54
    Height = 335
  end
  object Panel1: TPanel
    Left = 183
    Top = 54
    Width = 532
    Height = 335
    Align = alClient
    Alignment = taLeftJustify
    BevelOuter = bvNone
    TabOrder = 0
    object Panel2: TPanel
      Left = 0
      Top = 0
      Width = 532
      Height = 22
      Align = alTop
      Alignment = taLeftJustify
      BevelOuter = bvLowered
      TabOrder = 0
      object statLabel1: TLabel
        Left = 88
        Top = 8
        Width = 7
        Height = 13
        Caption = ' '
      end
      object lblPnl: TLabel
        Left = 8
        Top = 8
        Width = 14
        Height = 13
        Caption = '\\'
      end
    end
    object ControlBarSel: TControlBar
      Left = 0
      Top = 22
      Width = 532
      Height = 83
      Hint = #21452#20987#26174#31034#36807#28388#31383#20307#19982#26597#35810#31383#20307
      Align = alTop
      AutoDrag = False
      BevelOuter = bvNone
      BevelKind = bkSoft
      DragKind = dkDock
      TabOrder = 1
      Visible = False
    end
  end
  object ControlBar1: TControlBar
    Left = 0
    Top = 0
    Width = 715
    Height = 54
    Align = alTop
    AutoSize = True
    BevelInner = bvNone
    BevelKind = bkSoft
    Color = clBtnHighlight
    ParentColor = False
    TabOrder = 1
    OnDblClick = ControlBar1DblClick
    object myBar1: TToolBar
      Left = 542
      Top = 2
      Width = 169
      Height = 48
      AutoSize = True
      ButtonHeight = 36
      ButtonWidth = 35
      Caption = 'EditBar1'
      EdgeBorders = []
      Flat = True
      Images = dmFrm.ImageList1
      ShowCaptions = True
      TabOrder = 0
      Transparent = True
      OnDblClick = myBar1DblClick
    end
    object ToolBar2: TToolBar
      Left = 11
      Top = 2
      Width = 518
      Height = 36
      AutoSize = True
      ButtonHeight = 36
      ButtonWidth = 59
      Caption = 'ToolBar1'
      EdgeBorders = []
      Flat = True
      Images = dmFrm.ImageList1
      ShowCaptions = True
      TabOrder = 1
      Transparent = True
      object ToolButton2: TToolButton
        Left = 0
        Top = 0
        Action = ActClearALL
        Caption = #28165#31354#36164#26009
      end
      object refreshBtn: TToolButton
        Left = 59
        Top = 0
        AutoSize = True
        Caption = #21047#26032
        ImageIndex = 16
        OnClick = refreshBtnClick
      end
      object TreeBtn: TToolButton
        Left = 96
        Top = 0
        Caption = #26641#29366
        ImageIndex = 6
        Style = tbsCheck
        OnClick = TreeBtnClick
      end
      object expbtn: TToolButton
        Left = 155
        Top = 0
        Caption = #25910#23637
        ImageIndex = 17
        OnClick = expbtnClick
      end
      object ToolButtonQtyOrFilter: TToolButton
        Left = 214
        Top = 0
        Caption = #31579#36873#26694
        ImageIndex = 17
        Style = tbsCheck
        OnClick = ToolButtonQtyOrFilterClick
      end
      object ToolButton1: TToolButton
        Left = 273
        Top = 0
        Hint = #25968#25454#20462#25913#21024#38500#35760#24405
        Caption = #26085#24535
        ImageIndex = 29
        OnClick = ToolButton1Click
      end
      object upBtn: TToolButton
        Left = 332
        Top = 0
        Action = ActHelp
      end
      object ExtBtn: TToolButton
        Left = 391
        Top = 0
        Caption = #20851#38381
        ImageIndex = 8
        OnClick = ExtBtnClick
      end
    end
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 54
    Width = 180
    Height = 335
    Align = alLeft
    Caption = #26641
    TabOrder = 2
    object TreeView1: TTreeView
      Left = 2
      Top = 15
      Width = 176
      Height = 318
      Align = alClient
      BevelEdges = [beLeft, beTop]
      BevelInner = bvNone
      BevelKind = bkFlat
      BorderStyle = bsNone
      HideSelection = False
      Images = dmFrm.ImageList1
      Indent = 19
      ReadOnly = True
      ShowRoot = False
      TabOrder = 0
      OnChange = TreeView1Change
    end
  end
  object DataSource1: TDataSource
    DataSet = ADODataSet1
    Left = 272
    Top = 168
  end
  object ADODataSet1: TADODataSet
    Connection = dmFrm.ADOConnection1
    AfterScroll = ADODataSet1AfterScroll
    Parameters = <>
    Left = 248
    Top = 168
  end
  object ActionList1: TActionList
    Images = dmFrm.ImageList1
    Left = 456
    Top = 168
    object Action1: TAction
      Caption = 'Action1'
    end
    object EditorAction1: TAction
      Caption = #32534#36753
      ImageIndex = 21
      OnExecute = EditorAction1Execute
    end
    object DeleteAction1: TAction
      Caption = #21024#38500
      ImageIndex = 2
      OnExecute = DeleteAction1Execute
    end
    object SortAction1: TAction
      Caption = #25490#24207
      ImageIndex = 15
      OnExecute = SortAction1Execute
    end
    object LocateAction1: TAction
      Caption = #23450#20301
      ImageIndex = 12
      OnExecute = LocateAction1Execute
    end
    object FilterAction1: TAction
      Caption = #36807#28388
      ImageIndex = 19
      OnExecute = FilterAction1Execute
    end
    object ActHelp: TAction
      Caption = #24110#21161
      ImageIndex = 5
    end
    object ActClearALL: TAction
      Caption = #31354#38388
      ImageIndex = 43
      OnExecute = ActClearALLExecute
    end
    object actChk1: TAction
      Caption = 'actMergerUserMenuConfig'
      ImageIndex = 39
      OnExecute = actChk1Execute
    end
    object actExecProc: TAction
      Caption = #25191#34892
      ImageIndex = 10
      OnExecute = actExecProcExecute
    end
    object actBatchUpdate: TAction
      Caption = #25209#37327#25913
      ImageIndex = 26
      OnExecute = actBatchUpdateExecute
    end
  end
  object MainMenu1: TMainMenu
    Left = 223
    Top = 166
  end
end
