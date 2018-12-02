object FrmCtrlConfig: TFrmCtrlConfig
  Left = 223
  Top = 236
  Width = 1170
  Height = 441
  Caption = #29992#25143#25511#38190#35774#32622
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object spl1: TSplitter
    Left = 121
    Top = 33
    Width = 8
    Height = 381
  end
  object tlb1: TToolBar
    Left = 0
    Top = 0
    Width = 1162
    Height = 33
    ButtonHeight = 21
    ButtonWidth = 67
    Caption = 'tlb1'
    ShowCaptions = True
    TabOrder = 0
    object btnALLeft: TToolButton
      Left = 0
      Top = 2
      Caption = #24038#23545#40784
      ImageIndex = 0
      OnClick = btnALLeftClick
    end
    object btnTbALRight: TToolButton
      Left = 67
      Top = 2
      Caption = #21491#23545#40784
      ImageIndex = 1
      OnClick = btnTbALRightClick
    end
    object btnTbALTop: TToolButton
      Left = 134
      Top = 2
      Caption = #27700#24179#23545#40784
      ImageIndex = 2
      OnClick = btnTbALTopClick
    end
    object btnTBVESpan: TToolButton
      Left = 201
      Top = 2
      Caption = #22402#30452#31561#38388#36317
      ImageIndex = 7
      OnClick = btnTBVESpanClick
    end
    object btnTbHEspan: TToolButton
      Left = 268
      Top = 2
      Caption = #27700#24179#31561#38388#36317
      ImageIndex = 8
      OnClick = btnTbHEspanClick
    end
    object btnTbMoveLeft: TToolButton
      Left = 335
      Top = 2
      Caption = #24038#31227
      ImageIndex = 3
      OnClick = btnTbMoveLeftClick
    end
    object btnTbMoveRight: TToolButton
      Left = 402
      Top = 2
      Caption = #21491#31227
      ImageIndex = 4
      OnClick = btnTbMoveRightClick
    end
    object btnTbMoveUP: TToolButton
      Left = 469
      Top = 2
      Caption = #19978#31227
      ImageIndex = 5
      OnClick = btnTbMoveUPClick
    end
    object btnTbMoveDown: TToolButton
      Left = 536
      Top = 2
      Caption = #19979#31227
      ImageIndex = 6
      OnClick = btnTbMoveDownClick
    end
    object lbl1: TLabel
      Left = 603
      Top = 2
      Width = 48
      Height = 21
      Caption = #31227#21160#27493#38271
    end
    object edMoveSpan: TEdit
      Left = 651
      Top = 2
      Width = 30
      Height = 21
      ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
      TabOrder = 0
      Text = '3'
      OnKeyPress = edMoveSpanKeyPress
    end
    object btnReflash: TToolButton
      Left = 681
      Top = 2
      Caption = #21047#26032
      ImageIndex = 8
      OnClick = btnReflashClick
    end
    object btnSave: TToolButton
      Left = 748
      Top = 2
      Caption = #20445#23384
      ImageIndex = 7
      OnClick = btnSaveClick
    end
  end
  object grpLeft: TGroupBox
    Left = 0
    Top = 33
    Width = 121
    Height = 381
    Align = alLeft
    Caption = #21487#35774#32622#30340#25511#38190
    TabOrder = 1
    object dbgrdGdCtrl: TDBGrid
      Left = 2
      Top = 15
      Width = 117
      Height = 364
      Align = alClient
      DataSource = dsSourceCtrl
      ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      OnMouseMove = dbgrdGdCtrlMouseMove
      Columns = <
        item
          Expanded = False
          FieldName = 'f09'
          Title.Caption = #23383#27573#20013#25991#21517
          Width = 110
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'f02'
          Title.Caption = #33521#25991#21517
          Width = 100
          Visible = True
        end>
    end
  end
  object grpGrpParent: TPanel
    Tag = 100
    Left = 129
    Top = 33
    Width = 1033
    Height = 381
    Align = alClient
    TabOrder = 2
    object imgtop: TImage
      Left = 1
      Top = 1
      Width = 1031
      Height = 379
      Align = alClient
      OnDragDrop = imgtopDragDrop
      OnDragOver = imgtopDragOver
      OnMouseDown = imgtopMouseDown
      OnMouseMove = imgtopMouseMove
      OnMouseUp = imgtopMouseUp
    end
  end
  object dsSet: TADODataSet
    Parameters = <>
    Left = 8
    Top = 233
  end
  object dsSourceCtrl: TDataSource
    DataSet = dsSet
    Left = 48
    Top = 233
  end
end
