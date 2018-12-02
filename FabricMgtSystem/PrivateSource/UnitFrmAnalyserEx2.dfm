object AnalyseEx2: TAnalyseEx2
  Left = 890
  Top = 207
  Width = 870
  Height = 500
  Caption = 'AnalyseEx2'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 0
    Top = 153
    Width = 862
    Height = 3
    Cursor = crVSplit
    Align = alTop
  end
  object BtmPanel1: TPanel
    Left = 0
    Top = 445
    Width = 862
    Height = 28
    Align = alBottom
    BevelOuter = bvNone
    Color = clWhite
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 0
    object Label1: TLabel
      Left = 0
      Top = 0
      Width = 862
      Height = 28
      Align = alClient
      Alignment = taRightJustify
      Color = clCream
      ParentColor = False
      Layout = tlCenter
    end
  end
  object TopPanel1: TPanel
    Left = 0
    Top = 41
    Width = 862
    Height = 112
    Align = alTop
    BevelOuter = bvLowered
    Color = clWhite
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 1
    DesignSize = (
      862
      112)
    object statLabel1: TLabel
      Left = 739
      Top = 88
      Width = 85
      Height = 13
      Alignment = taRightJustify
      Anchors = [akRight, akBottom]
      AutoSize = False
      Caption = '0/0'
      Transparent = True
    end
    object OpnDlDsBtn1: TSpeedButton
      Left = 760
      Top = 36
      Width = 54
      Height = 22
      Anchors = [akTop, akRight]
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
    object LblTitle: TLabel
      Left = 352
      Top = 4
      Width = 42
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
  object ControlBar1: TControlBar
    Left = 0
    Top = 0
    Width = 862
    Height = 41
    Align = alTop
    Color = clWhite
    ParentColor = False
    TabOrder = 2
    object ToolBar2: TToolBar
      Left = 11
      Top = 2
      Width = 214
      Height = 36
      AutoSize = True
      ButtonHeight = 36
      ButtonWidth = 43
      Caption = 'ToolBar1'
      Color = clWhite
      Ctl3D = False
      EdgeBorders = []
      Flat = True
      Images = dmFrm.ImageList1
      ParentColor = False
      ShowCaptions = True
      TabOrder = 0
      Transparent = True
      object TLBtnShowQry: TToolButton
        Left = 0
        Top = 0
        Caption = #26597#35810#26694
        Down = True
        ImageIndex = 3
        Style = tbsCheck
      end
      object ToolButton1: TToolButton
        Left = 43
        Top = 0
        Caption = #21047#26032
        ImageIndex = 16
      end
      object ToolButton2: TToolButton
        Left = 86
        Top = 0
        Action = CloseAction1
      end
    end
    object ToolBar1: TToolBar
      Left = 238
      Top = 2
      Width = 524
      Height = 48
      ButtonHeight = 35
      ButtonWidth = 33
      Caption = 'ToolBar1'
      EdgeBorders = []
      Flat = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = [fsBold]
      Images = dmFrm.ImageList1
      ParentFont = False
      ShowCaptions = True
      TabOrder = 1
      Transparent = True
    end
  end
  object PgGrids: TPageControl
    Left = 0
    Top = 156
    Width = 862
    Height = 289
    Align = alClient
    Style = tsFlatButtons
    TabOrder = 3
  end
  object mtADODataSet1: TADODataSet
    Connection = dmFrm.ADOConnection1
    CommandTimeout = 120
    Parameters = <>
    Left = 280
    Top = 56
    object mtADODataSet1IntegerField111: TIntegerField
      FieldKind = fkCalculated
      FieldName = '111'
      Calculated = True
    end
  end
  object mtDataSource1: TDataSource
    DataSet = mtADODataSet1
    Left = 344
    Top = 56
  end
  object ActionList1: TActionList
    Images = dmFrm.ImageList1
    Left = 352
    Top = 224
    object PrintAction1: TAction
      Caption = #25171#21360
      Enabled = False
      ImageIndex = 13
    end
    object RefreshAction1: TAction
      Caption = #21047#26032
      Enabled = False
      ImageIndex = 16
    end
    object CloseAction1: TAction
      Caption = #20851#38381
      ImageIndex = 8
    end
    object HelpAction1: TAction
      Caption = #24110#21161
      ImageIndex = 5
    end
    object ActOriBill: TAction
      Caption = #21407#21333#25454
      ImageIndex = 32
      OnExecute = ActOriBillExecute
    end
  end
end
