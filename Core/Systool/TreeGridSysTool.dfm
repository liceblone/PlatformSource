object TreeGridFrmSystool: TTreeGridFrmSystool
  Left = 580
  Top = 353
  Width = 820
  Height = 381
  Caption = 'x'
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
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 180
    Top = 54
    Height = 300
  end
  object Panel1: TPanel
    Left = 183
    Top = 54
    Width = 629
    Height = 300
    Align = alClient
    Alignment = taLeftJustify
    BevelOuter = bvNone
    TabOrder = 0
    object Panel2: TPanel
      Left = 0
      Top = 0
      Width = 629
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
    object DBGrid1: TDBGrid
      Left = 0
      Top = 105
      Width = 629
      Height = 195
      Align = alClient
      DataSource = DataSource1
      ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
      PopupMenu = dmFrm.DbGridPopupMenu1
      TabOrder = 1
      TitleFont.Charset = GB2312_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -13
      TitleFont.Name = #23435#20307
      TitleFont.Style = []
      OnCellClick = DBGrid1CellClick
      OnMouseMove = DBGrid1MouseMove
    end
    object ControlBarSel: TControlBar
      Left = 0
      Top = 22
      Width = 629
      Height = 83
      Hint = #21452#20987#26174#31034#36807#28388#31383#20307#19982#26597#35810#31383#20307
      Align = alTop
      AutoDrag = False
      BevelOuter = bvNone
      BevelKind = bkSoft
      DragKind = dkDock
      TabOrder = 2
      Visible = False
    end
  end
  object ControlBar1: TControlBar
    Left = 0
    Top = 0
    Width = 812
    Height = 54
    Align = alTop
    AutoSize = True
    BevelInner = bvNone
    BevelKind = bkSoft
    TabOrder = 1
    OnDblClick = ControlBar1DblClick
    object myBar1: TToolBar
      Left = 390
      Top = 2
      Width = 415
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
      OnDblClick = myBar1DblClick
    end
    object ToolBar2: TToolBar
      Left = 11
      Top = 2
      Width = 366
      Height = 36
      AutoSize = True
      ButtonHeight = 36
      ButtonWidth = 46
      Caption = 'ToolBar1'
      EdgeBorders = []
      Flat = True
      Images = dmFrm.ImageList1
      ShowCaptions = True
      TabOrder = 1
      object setBtn: TToolButton
        Left = 0
        Top = 0
        Caption = #35774#32622
        ImageIndex = 14
      end
      object prtBtn: TToolButton
        Left = 46
        Top = 0
        AutoSize = True
        Caption = #25171#21360
        ImageIndex = 13
        OnClick = prtBtnClick
      end
      object TreeBtn: TToolButton
        Left = 83
        Top = 0
        Caption = #26641#25511
        Down = True
        ImageIndex = 6
        Style = tbsCheck
        OnClick = TreeBtnClick
      end
      object expbtn: TToolButton
        Left = 129
        Top = 0
        Caption = #25910#23637
        ImageIndex = 17
        OnClick = expbtnClick
      end
      object upBtn: TToolButton
        Left = 175
        Top = 0
        Caption = #21521#19978
        ImageIndex = 20
        OnClick = upBtnClick
      end
      object ToolButtonQtyOrFilter: TToolButton
        Left = 221
        Top = 0
        Caption = #31579#36873#26694
        ImageIndex = 17
        Style = tbsCheck
        OnClick = ToolButtonQtyOrFilterClick
      end
      object refreshBtn: TToolButton
        Left = 267
        Top = 0
        AutoSize = True
        Caption = #21047#26032
        ImageIndex = 16
        OnClick = refreshBtnClick
      end
      object ExtBtn: TToolButton
        Left = 304
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
    Height = 300
    Align = alLeft
    Caption = #26641
    TabOrder = 2
    object TreeView1: TTreeView
      Left = 2
      Top = 15
      Width = 176
      Height = 283
      Align = alClient
      BevelEdges = [beLeft, beTop]
      BevelInner = bvNone
      BevelKind = bkFlat
      BorderStyle = bsNone
      Color = clSkyBlue
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
    object WarePropAction1: TAction
      Caption = #23646#24615
      ImageIndex = 28
    end
    object EditorAction1: TAction
      Caption = #32534#36753
      ImageIndex = 21
      OnExecute = EditorAction1Execute
    end
    object act1: TAction
      Caption = 'act1'
    end
    object act2: TAction
      Caption = 'act2'
    end
    object act3: TAction
      Caption = 'act3'
    end
    object act4: TAction
      Caption = 'act4'
    end
    object act5: TAction
      Caption = 'act5'
    end
    object act6: TAction
      Caption = 'act6'
    end
    object actChk1: TAction
      Caption = 'actChk1'
      ImageIndex = 39
      OnExecute = actChk1Execute
    end
  end
  object MainMenu1: TMainMenu
    Left = 223
    Top = 166
  end
end
