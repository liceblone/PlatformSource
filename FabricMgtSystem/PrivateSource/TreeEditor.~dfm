object TreeEditorFrm: TTreeEditorFrm
  Left = 215
  Top = 264
  Width = 1034
  Height = 391
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = #23435#20307
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poDefault
  WindowState = wsMaximized
  OnActivate = FormActivate
  OnClose = FormClose
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 240
    Top = 44
    Height = 126
  end
  object Splitter2: TSplitter
    Left = 0
    Top = 170
    Width = 1026
    Height = 3
    Cursor = crVSplit
    Align = alBottom
    Visible = False
  end
  object TreeView1: TTreeView
    Left = 0
    Top = 44
    Width = 240
    Height = 126
    Align = alLeft
    HideSelection = False
    Images = dmFrm.ImageList1
    Indent = 19
    ReadOnly = True
    ShowRoot = False
    TabOrder = 0
    ToolTips = False
    OnChange = TreeView1Change
    OnChanging = TreeView1Changing
  end
  object ScrollBox1: TScrollBox
    Left = 243
    Top = 44
    Width = 783
    Height = 126
    Align = alClient
    Color = clBtnHighlight
    ParentColor = False
    TabOrder = 1
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 173
    Width = 1026
    Height = 191
    Align = alBottom
    DataSource = DataSource1
    ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    PopupMenu = dmFrm.DbGridPopupMenu1
    TabOrder = 2
    TitleFont.Charset = GB2312_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -13
    TitleFont.Name = #23435#20307
    TitleFont.Style = []
    Visible = False
    OnCellClick = DBGrid1CellClick
  end
  object ControlBar1: TControlBar
    Left = 0
    Top = 0
    Width = 1026
    Height = 44
    Align = alTop
    AutoSize = True
    TabOrder = 3
    object ToolBar1: TToolBar
      Left = 19
      Top = 2
      Width = 942
      Height = 36
      AutoSize = True
      ButtonHeight = 36
      ButtonWidth = 59
      Caption = 'ToolBar1'
      EdgeBorders = []
      Flat = True
      Images = dmFrm.ImageList1
      ShowCaptions = True
      TabOrder = 0
      Transparent = True
      OnDblClick = ToolBar1DblClick
      object BtnClearALL: TToolButton
        Left = 0
        Top = 0
        Caption = #28165#31354#36164#26009
        ImageIndex = 43
        OnClick = BtnClearALLClick
      end
      object btnCtrl: TToolButton
        Left = 59
        Top = 0
        Caption = #35774#32622#25511#38190
        ImageIndex = 45
        OnClick = btnCtrlClick
      end
      object PrtBtn: TToolButton
        Left = 118
        Top = 0
        Caption = #25171#21360
        ImageIndex = 13
        OnClick = PrtBtnClick
      end
      object PreBtn: TToolButton
        Left = 177
        Top = 0
        Caption = #34920#26684
        ImageIndex = 26
        Style = tbsCheck
        OnClick = PreBtnClick
      end
      object expBtn: TToolButton
        Left = 236
        Top = 0
        Caption = #20840#23637
        ImageIndex = 17
        OnClick = expBtnClick
      end
      object rfsBtn: TToolButton
        Left = 295
        Top = 0
        Caption = #21047#26032
        ImageIndex = 16
        OnClick = rfsBtnClick
      end
      object ToolButton1: TToolButton
        Left = 354
        Top = 0
        Hint = #25968#25454#20462#25913#21024#38500#35760#24405
        Caption = #26085#24535
        ImageIndex = 29
        ParentShowHint = False
        ShowHint = True
        OnClick = ToolButton1Click
      end
      object hlpBtn: TToolButton
        Left = 413
        Top = 0
        Caption = #24110#21161
        ImageIndex = 5
      end
      object ToolButton5: TToolButton
        Left = 472
        Top = 0
        Width = 8
        Caption = 'ToolButton5'
        ImageIndex = 4
        Style = tbsSeparator
      end
      object Addbtn: TToolButton
        Left = 480
        Top = 0
        Caption = #22686#21152
        ImageIndex = 7
        OnClick = AddbtnClick
      end
      object btnSubAdd: TToolButton
        Left = 539
        Top = 0
        Caption = #23376#32467#28857
        ImageIndex = 35
        OnClick = btnSubAddClick
      end
      object ChgBtn: TToolButton
        Left = 598
        Top = 0
        Caption = #20462#25913
        ImageIndex = 21
        OnClick = ChgBtnClick
      end
      object DelBtn: TToolButton
        Left = 657
        Top = 0
        Caption = #21024#38500
        ImageIndex = 2
        OnClick = DelBtnClick
      end
      object ToolButton9: TToolButton
        Left = 716
        Top = 0
        Width = 8
        Caption = 'ToolButton9'
        ImageIndex = 7
        Style = tbsSeparator
      end
      object CleBtn: TToolButton
        Left = 724
        Top = 0
        Caption = #25918#24323
        ImageIndex = 4
        OnClick = CleBtnClick
      end
      object SavBtn: TToolButton
        Left = 783
        Top = 0
        Caption = #20445#23384
        ImageIndex = 9
        OnClick = SavBtnClick
      end
      object ToolButton12: TToolButton
        Left = 842
        Top = 0
        Width = 8
        Caption = 'ToolButton12'
        ImageIndex = 9
        Style = tbsSeparator
      end
      object ExtBtn: TToolButton
        Left = 850
        Top = 0
        Caption = #36864#20986
        ImageIndex = 8
        OnClick = ExtBtnClick
      end
    end
  end
  object DataSource1: TDataSource
    DataSet = ADODataSet1
    Left = 260
    Top = 109
  end
  object ADODataSet1: TADODataSet
    Connection = dmFrm.ADOConnection1
    LockType = ltBatchOptimistic
    Parameters = <>
    Left = 168
    Top = 112
  end
end
