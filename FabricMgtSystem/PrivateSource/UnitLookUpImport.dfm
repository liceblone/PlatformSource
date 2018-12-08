object FrmLoopUpImPortEx: TFrmLoopUpImPortEx
  Left = 433
  Top = 219
  Width = 629
  Height = 208
  ActiveControl = ScrollTop
  Caption = 'FrmLoopUpImPortEx'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object ScrollTop: TScrollBox
    Left = 0
    Top = 25
    Width = 621
    Height = 16
    Align = alTop
    BorderStyle = bsNone
    Color = clBtnHighlight
    ParentColor = False
    TabOrder = 0
    OnDblClick = ScrollTopDblClick
    DesignSize = (
      621
      16)
    object OpnDlDsBtn1: TSpeedButton
      Left = 487
      Top = 2
      Width = 52
      Height = 21
      Anchors = [akRight]
      Flat = True
      Glyph.Data = {
        CA010000424DCA01000000000000760000002800000026000000110000000100
        040000000000540100000000000000000000100000001000000018BA5A0042AE
        390039C7730029962100FFFFFF0018BE6300FFFFFF0000000000000000000000
        0000000000000000000000000000000000000000000000000000666633333333
        3333333333333333333333666600663311111111111111111111111111111133
        6600632255000000000000000000000000000551360063255504444444444400
        0000004440055555360032555555555555555555445555555455555513003255
        5555544444445555454544445455555513003255555554555554555545554554
        5455555513003255555554444444555545554444545555551300325555544455
        5554545545554554545555551300325555555444444445544555455454555555
        1300325555555545455455555545444454555555130032555555555445455555
        5554555554555555130032555554444444444455545544444455555513006325
        5555555545555555455545555555555536006322555555555555555555555555
        5555555536006633222222222222222222222222222225336600666633333333
        3333333333333333333333666600}
      Visible = False
      OnClick = OpnDlDsBtn1Click
    end
    object lblTitle: TLabel
      Left = 0
      Top = 0
      Width = 621
      Height = 16
      Align = alClient
      Alignment = taCenter
      Caption = #20154#20154#20154#20154
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = #26999#20307'_GB2312'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object TreeView1: TTreeView
    Left = 0
    Top = 41
    Width = 145
    Height = 140
    Align = alLeft
    BevelEdges = [beLeft, beTop]
    BevelInner = bvNone
    BevelKind = bkFlat
    BorderStyle = bsNone
    HideSelection = False
    Images = dmFrm.ImageList1
    Indent = 19
    ReadOnly = True
    ShowRoot = False
    TabOrder = 1
  end
  object pnlGd: TPanel
    Left = 145
    Top = 41
    Width = 476
    Height = 140
    Align = alClient
    Caption = 'pnlGd'
    TabOrder = 2
  end
  object CoolBar1: TCoolBar
    Left = 0
    Top = 0
    Width = 621
    Height = 25
    Bands = <
      item
        Control = ToolBar1
        ImageIndex = -1
        Width = 617
      end>
    Images = dmFrm.ImageList1
    object ToolBar1: TToolBar
      Left = 9
      Top = 0
      Width = 51
      Height = 25
      Align = alLeft
      AutoSize = True
      ButtonWidth = 51
      Caption = 'ToolBar1'
      EdgeBorders = []
      Flat = True
      Images = dmFrm.ImageList1
      List = True
      ShowCaptions = True
      TabOrder = 0
      object ToolButton1: TToolButton
        Left = 0
        Top = 0
        Caption = #23548#20837
        ImageIndex = 0
        Visible = False
      end
    end
  end
  object ActionList1: TActionList
    Images = dmFrm.ImageList1
    Left = 240
    Top = 120
    object ActClose: TAction
      Caption = 'ActClose'
      ImageIndex = 8
      OnExecute = ActCloseExecute
    end
    object ActFreeDeliveFee: TAction
      Caption = #20813#36153#36865#36135#27719#24635
    end
    object ActPick: TAction
      Caption = #23548#20837
      ImageIndex = 17
      OnExecute = ActPickExecute
    end
    object actPickALL: TAction
      Caption = #20840#36873
      ImageIndex = 28
      OnExecute = actPickALLExecute
    end
    object RefreshAction1: TAction
      Caption = 'RefreshAction1'
      ImageIndex = 16
      OnExecute = RefreshAction1Execute
    end
  end
  object mtDataSource1: TDataSource
    DataSet = mtDataSet1
    Left = 72
    Top = 49
  end
  object mtDataSet1: TADODataSet
    Connection = dmFrm.ADOConnection1
    LockType = ltBatchOptimistic
    CommandTimeout = 120
    Parameters = <>
    Left = 96
    Top = 48
  end
  object DlDataSource1: TDataSource
    DataSet = dlDataSet1
    Left = 288
    Top = 120
  end
  object dlDataSet1: TADODataSet
    Connection = dmFrm.ADOConnection1
    LockType = ltBatchOptimistic
    CommandTimeout = 120
    Parameters = <>
    Left = 328
    Top = 120
  end
  object TreeDataSet: TADODataSet
    Parameters = <>
    Left = 40
    Top = 120
  end
  object tmrQry: TTimer
    Enabled = False
    Interval = 10
    OnTimer = tmrQryTimer
    Left = 209
    Top = 120
  end
end
