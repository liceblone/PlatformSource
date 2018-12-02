object TreeMgrFrm: TTreeMgrFrm
  Left = 151
  Top = 209
  Width = 700
  Height = 402
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = #23435#20307
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poDefault
  Visible = True
  WindowState = wsMaximized
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 177
    Top = 54
    Height = 321
  end
  object Panel2: TPanel
    Left = 180
    Top = 54
    Width = 512
    Height = 321
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object ScrollBox1: TScrollBox
      Left = 0
      Top = 22
      Width = 512
      Height = 299
      Align = alClient
      Color = clCream
      Ctl3D = False
      ParentColor = False
      ParentCtl3D = False
      TabOrder = 2
    end
    object DBGrid1: TDBGrid
      Left = 0
      Top = 22
      Width = 512
      Height = 299
      Align = alClient
      Ctl3D = False
      DataSource = DataSource1
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
      ParentCtl3D = False
      PopupMenu = dmFrm.DbGridPopupMenu1
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -13
      TitleFont.Name = #23435#20307
      TitleFont.Style = []
    end
    object Panel1: TPanel
      Left = 0
      Top = 0
      Width = 512
      Height = 22
      Align = alTop
      Alignment = taLeftJustify
      BevelOuter = bvLowered
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 54
    Width = 177
    Height = 321
    Align = alLeft
    Caption = #26641
    TabOrder = 1
    object TreeView1: TTreeView
      Left = 2
      Top = 15
      Width = 173
      Height = 304
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
  object ControlBar1: TControlBar
    Left = 0
    Top = 0
    Width = 692
    Height = 54
    Align = alTop
    AutoSize = True
    BevelInner = bvNone
    BevelKind = bkSoft
    TabOrder = 2
    object myBar1: TToolBar
      Left = 201
      Top = 2
      Width = 487
      Height = 48
      AutoSize = True
      ButtonHeight = 36
      ButtonWidth = 33
      Caption = 'myBar1'
      EdgeBorders = []
      Flat = True
      Images = dmFrm.ImageList1
      ShowCaptions = True
      TabOrder = 0
      Visible = False
      Wrapable = False
      OnDblClick = myBar1DblClick
    end
    object ToolBar1: TToolBar
      Left = 11
      Top = 2
      Width = 177
      Height = 36
      AutoSize = True
      ButtonHeight = 36
      ButtonWidth = 33
      Caption = 'ToolBar1'
      EdgeBorders = []
      Flat = True
      Images = dmFrm.ImageList1
      ShowCaptions = True
      TabOrder = 1
      object printBtn: TToolButton
        Left = 0
        Top = 0
        AutoSize = True
        Caption = #25171#21360
        ImageIndex = 13
      end
      object refreshbtn: TToolButton
        Left = 37
        Top = 0
        AutoSize = True
        Caption = #21047#26032
        ImageIndex = 16
      end
      object ToolButton2: TToolButton
        Left = 74
        Top = 0
        Caption = #21521#19978
        ImageIndex = 20
        OnClick = ToolButton2Click
      end
      object TreeBtn: TToolButton
        Left = 107
        Top = 0
        Caption = #26641#25511
        Down = True
        ImageIndex = 6
        Style = tbsCheck
        OnClick = TreeBtnClick
      end
      object exitBtn: TToolButton
        Left = 140
        Top = 0
        Caption = #36864#20986
        ImageIndex = 8
        OnClick = exitBtnClick
      end
    end
  end
  object DataSource1: TDataSource
    DataSet = ADODataSet1
    Left = 344
    Top = 144
  end
  object ADODataSet1: TADODataSet
    Connection = dmFrm.ADOConnection1
    LockType = ltBatchOptimistic
    Parameters = <>
    Left = 424
    Top = 152
  end
  object ActionList1: TActionList
    Images = dmFrm.ImageList1
    Left = 376
    Top = 240
    object AddAction1: TAction
      Caption = #28155#21152
      ImageIndex = 7
    end
    object EditAction1: TAction
      Tag = 2
      Caption = #32534#36753
      ImageIndex = 21
    end
    object SaveAction1: TAction
      Caption = #20445#23384
      ImageIndex = 9
      OnExecute = SaveAction1Execute
    end
    object UserPropAction1: TAction
      Caption = #23646#24615
      ImageIndex = 28
    end
    object GroupPropAction1: TAction
      Caption = #23646#24615
      ImageIndex = 28
    end
    object UsersAction1: TAction
      Caption = #25104#21592
      ImageIndex = 27
      OnExecute = UsersAction1Execute
    end
    object uGroupAction1: TAction
      Caption = #38582#23646
      ImageIndex = 6
      OnExecute = uGroupAction1Execute
    end
    object RightAction1: TAction
      Caption = #26435#38480
      ImageIndex = 10
      OnExecute = RightAction1Execute
    end
    object rGroupAction1: TAction
      Caption = #25480#26435
      ImageIndex = 12
      OnExecute = rGroupAction1Execute
    end
    object actDeleteAction9: TAction
      Caption = #21024#38500
      ImageIndex = 2
      OnExecute = actDeleteAction9Execute
    end
    object LoginAction1: TAction
      Caption = #30331#38470
      ImageIndex = 35
      OnExecute = LoginAction1Execute
    end
    object PwAction1: TAction
      Caption = #23494#30721
      ImageIndex = 10
    end
    object uBankAction1: TAction
      Caption = #24080#25143
      ImageIndex = 21
      OnExecute = uBankAction1Execute
    end
    object BakAction1: TAction
      Caption = #22791#20221
      ImageIndex = 9
      OnExecute = BakAction1Execute
    end
    object CarryAction1: TAction
      Caption = #32467#36716
      ImageIndex = 17
    end
    object EmpClientAction1: TAction
      Caption = #23458#25143
      ImageIndex = 33
      OnExecute = EmpClientAction1Execute
    end
    object BosEmpAction16: TAction
      Caption = #19979#23646
      ImageIndex = 27
      OnExecute = BosEmpAction16Execute
    end
    object MacPermit17: TAction
      Caption = #25480#26435
      ImageIndex = 12
      OnExecute = MacPermit17Execute
    end
    object act1: TAction
      Caption = 'act1'
    end
    object actsys: TAction
      Caption = 'sys'#25480#26435
      ImageIndex = 12
      OnExecute = actsysExecute
    end
    object actTabEdit20: TAction
      Caption = #32534#36753
      ImageIndex = 21
    end
    object actAdd21: TAction
      Caption = #22686#21152
      ImageIndex = 7
    end
    object actGroup22: TAction
      Caption = 'sys'#38582#23646
      ImageIndex = 6
      OnExecute = actGroup22Execute
    end
    object actlogin: TAction
      Caption = #30331#24405#28857
      ImageIndex = 35
      OnExecute = actloginExecute
    end
    object actFilter: TAction
      Caption = #36807#28388
      ImageIndex = 19
      OnExecute = actFilterExecute
    end
    object actADD25: TAction
      Caption = #22686#21152
      ImageIndex = 7
      OnExecute = actADD25Execute
    end
    object ActAddEmp26: TAction
      Caption = #28155#21152
      ImageIndex = 27
      OnExecute = ActAddEmp26Execute
    end
    object ActClearDefaultWin27: TAction
      Caption = #28165#40664#35748#31383#20307
      ImageIndex = 11
      OnExecute = ActClearDefaultWin27Execute
    end
  end
  object NodeDataSet1: TADODataSet
    Parameters = <>
    Left = 72
    Top = 144
  end
end
