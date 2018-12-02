object FrmSendMsg: TFrmSendMsg
  Left = 299
  Top = 190
  Width = 676
  Height = 480
  Caption = #21457#36865#36890#30693
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox2: TGroupBox
    Left = 0
    Top = 0
    Width = 89
    Height = 453
    Align = alLeft
    Caption = #25509#25910#37096#38376
    TabOrder = 0
    object ChkLstDept: TCheckListBox
      Left = 2
      Top = 15
      Width = 85
      Height = 436
      Align = alClient
      ItemHeight = 13
      TabOrder = 0
    end
  end
  object GroupBox3: TGroupBox
    Left = 89
    Top = 0
    Width = 64
    Height = 453
    Align = alLeft
    Caption = #25509#25910#20154#21592
    TabOrder = 1
    object ChkLstEmp: TCheckListBox
      Left = 2
      Top = 15
      Width = 60
      Height = 436
      Align = alClient
      ItemHeight = 13
      TabOrder = 0
    end
  end
  object Panel1: TPanel
    Left = 153
    Top = 0
    Width = 515
    Height = 453
    Align = alClient
    Caption = 'Panel1'
    TabOrder = 2
    object Splitter1: TSplitter
      Left = 289
      Top = 1
      Width = 5
      Height = 335
      Align = alRight
    end
    object GroupBox1: TGroupBox
      Left = 1
      Top = 1
      Width = 288
      Height = 335
      Align = alClient
      Caption = #36890#30693#21457#36865#21382#21490#35760#24405'  ('#26368#36817'18'#26465#35760#24405')'
      TabOrder = 0
      object MMHistory: TMemo
        Left = 2
        Top = 15
        Width = 284
        Height = 318
        Align = alClient
        Lines.Strings = (
          'MMHistory')
        TabOrder = 0
      end
    end
    object GroupBox4: TGroupBox
      Left = 1
      Top = 336
      Width = 513
      Height = 116
      Align = alBottom
      Caption = #36890#30693#24405#20837#26694
      TabOrder = 1
      DesignSize = (
        513
        116)
      object BtnSend: TButton
        Left = 430
        Top = 90
        Width = 75
        Height = 25
        Anchors = [akRight, akBottom]
        Caption = #21457#36865
        TabOrder = 0
        OnClick = BtnSendClick
      end
      object MMContent: TMemo
        Left = 0
        Top = 32
        Width = 512
        Height = 57
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 1
      end
      object BtnClose: TButton
        Left = 350
        Top = 90
        Width = 75
        Height = 25
        Anchors = [akTop, akRight]
        Caption = #20851#38381
        TabOrder = 2
      end
      object BtnReceivedMsg: TButton
        Left = 430
        Top = 8
        Width = 75
        Height = 25
        Anchors = [akTop, akRight]
        Caption = #25509#25910#35760#24405
        TabOrder = 3
        OnClick = BtnReceivedMsgClick
      end
    end
    object grpReceivedMsg: TGroupBox
      Left = 294
      Top = 1
      Width = 220
      Height = 335
      Align = alRight
      Caption = #25509#25910#21040#36890#30693#35760#24405
      TabOrder = 2
      object mmReceivedMsg: TMemo
        Left = 2
        Top = 15
        Width = 216
        Height = 318
        Align = alClient
        Lines.Strings = (
          'mmReceivedMsg')
        TabOrder = 0
      end
    end
  end
  object QryHistory: TADOQuery
    Connection = dmFrm.ADOConnection1
    Parameters = <
      item
        Name = 'FCreateEmp'
        Size = -1
        Value = Null
      end>
    SQL.Strings = (
      'select top 18  msg.* ,emp.FempName'
      'from TMessage msg'
      'left join Temployee emp on emp.FempCode=msg.FCreateEmp'
      'where FCreateEmp=:FCreateEmp  '
      'order by FCreateTime desc')
    Left = 282
    Top = 65
  end
  object DsHistory: TDataSource
    DataSet = QryHistory
    Left = 314
    Top = 65
  end
  object DsContent: TDataSource
    DataSet = QryContent
    Left = 266
    Top = 328
  end
  object QryContent: TADOQuery
    Connection = dmFrm.ADOConnection1
    ParamCheck = False
    Parameters = <>
    SQL.Strings = (
      'select top 0 * from TMessage')
    Left = 298
    Top = 328
  end
  object Timer1: TTimer
    Interval = 10000
    OnTimer = Timer1Timer
    Left = 521
    Top = 225
  end
  object QryReceivedMsg: TADOQuery
    Connection = dmFrm.ADOConnection1
    Parameters = <>
    Left = 457
    Top = 73
  end
end
