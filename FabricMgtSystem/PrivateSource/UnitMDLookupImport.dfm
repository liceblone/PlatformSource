object FrmMDLookupImport: TFrmMDLookupImport
  Left = 324
  Top = 70
  Width = 917
  Height = 524
  Caption = 'FrmMDLookupImport'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object ScrollTop: TScrollBox
    Left = 0
    Top = 0
    Width = 909
    Height = 121
    Align = alTop
    BorderStyle = bsNone
    Color = clBtnHighlight
    ParentColor = False
    TabOrder = 0
    OnDblClick = ScrollTopDblClick
    DesignSize = (
      909
      121)
    object Label3: TLabel
      Left = 0
      Top = 41
      Width = 909
      Height = 4
      Align = alTop
      Alignment = taRightJustify
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -4
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object OpnDlDsBtn1: TSpeedButton
      Left = 791
      Top = 59
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
      OnClick = OpnDlDsBtn1Click
    end
    object lblTitle: TLabel
      Left = 0
      Top = 0
      Width = 909
      Height = 16
      Align = alTop
      Alignment = taCenter
      Caption = #20154
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = #26999#20307'_GB2312'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object CoolBar1: TCoolBar
      Left = 0
      Top = 16
      Width = 909
      Height = 25
      Bands = <
        item
          Control = ToolBar1
          ImageIndex = -1
          Width = 905
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
  end
  object TreeView1: TTreeView
    Left = 0
    Top = 306
    Width = 145
    Height = 134
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
    Top = 306
    Width = 764
    Height = 134
    Align = alClient
    Caption = 'pnlGd'
    TabOrder = 2
  end
  object scrlbxMiddle: TScrollBox
    Left = 0
    Top = 121
    Width = 909
    Height = 185
    Align = alTop
    Color = clBtnHighlight
    Ctl3D = False
    ParentColor = False
    ParentCtl3D = False
    TabOrder = 3
  end
  object scrlbx1: TScrollBox
    Left = 0
    Top = 440
    Width = 909
    Height = 41
    Align = alBottom
    Color = clBtnHighlight
    Ctl3D = False
    ParentColor = False
    ParentCtl3D = False
    TabOrder = 4
    DesignSize = (
      907
      39)
    object btnOk: TBitBtn
      Left = 776
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = #30830#23450
      TabOrder = 0
      OnClick = btnOkClick
    end
  end
  object pbIteration: TProgressBar
    Left = 0
    Top = 481
    Width = 909
    Height = 16
    Align = alBottom
    TabOrder = 5
    Visible = False
  end
  object ActionList1: TActionList
    Images = dmFrm.ImageList1
    Left = 216
    Top = 288
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
    object actMainAndDL: TAction
      Caption = 'actMainAndDL'
      ImageIndex = 34
      OnExecute = actMainAndDLExecute
    end
    object actSelected: TAction
      Caption = 'actSelected'
      ImageIndex = 33
      OnExecute = actSelectedExecute
    end
  end
  object mtDataSource1: TDataSource
    DataSet = mtDataSet1
    Left = 208
    Top = 57
  end
  object mtDataSet1: TADODataSet
    Connection = dmFrm.ADOConnection1
    LockType = ltBatchOptimistic
    CommandTimeout = 120
    Parameters = <>
    Left = 240
    Top = 56
  end
  object DlDataSource1: TDataSource
    DataSet = dlDataSet1
    Left = 248
    Top = 288
  end
  object dlDataSet1: TADODataSet
    Connection = dmFrm.ADOConnection1
    LockType = ltBatchOptimistic
    CommandTimeout = 120
    Parameters = <>
    Left = 280
    Top = 288
  end
  object TreeDataSet: TADODataSet
    Parameters = <>
    Left = 56
    Top = 312
  end
  object dsMain: TDataSource
    DataSet = dsDataSetMain
    Left = 208
    Top = 120
  end
  object dsDataSetMain: TADODataSet
    Connection = dmFrm.ADOConnection1
    AfterScroll = dsDataSetMainAfterScroll
    Parameters = <>
    Left = 264
    Top = 120
  end
end
