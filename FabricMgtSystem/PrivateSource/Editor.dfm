object EditorFrm: TEditorFrm
  Left = 111
  Top = 239
  Width = 975
  Height = 434
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = 'EditorFrm'
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = #23435#20307
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnClose = FormClose
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 11
  object Splitter1: TSplitter
    Left = 0
    Top = 402
    Width = 967
    Height = 5
    Cursor = crVSplit
    Align = alBottom
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 41
    Width = 967
    Height = 360
    Align = alClient
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = #23435#20307
    Font.Style = []
    MultiLine = True
    ParentFont = False
    TabOrder = 0
  end
  object PnlItem: TPanel
    Left = 0
    Top = 401
    Width = 967
    Height = 1
    Align = alBottom
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
    TabOrder = 1
  end
  object CLBar: TControlBar
    Left = 0
    Top = 0
    Width = 967
    Height = 41
    Align = alTop
    TabOrder = 2
    object ToolBar1: TToolBar
      Left = 11
      Top = 2
      Width = 494
      Height = 48
      Align = alNone
      ButtonHeight = 36
      ButtonWidth = 46
      Caption = 'ToolBar1'
      EdgeBorders = []
      Flat = True
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = #23435#20307
      Font.Style = []
      Images = dmFrm.ImageList1
      ParentFont = False
      ShowCaptions = True
      TabOrder = 0
      OnDblClick = ToolBar1DblClick
      object FirstBtn: TToolButton
        Left = 0
        Top = 0
        Action = FirstAction
        AutoSize = True
      end
      object PriorBtn: TToolButton
        Left = 37
        Top = 0
        Action = PriorAction
        AutoSize = True
      end
      object NextBtn: TToolButton
        Left = 87
        Top = 0
        Action = NextAction
        AutoSize = True
      end
      object LastBtn: TToolButton
        Left = 137
        Top = 0
        Action = LastAction
        AutoSize = True
      end
      object ToolButton7: TToolButton
        Left = 174
        Top = 0
        Width = 8
        Caption = 'ToolButton7'
        ImageIndex = 5
        Style = tbsSeparator
      end
      object AddBtn: TToolButton
        Left = 182
        Top = 0
        Action = AddAction
        AutoSize = True
      end
      object CpyBtn: TToolButton
        Left = 219
        Top = 0
        Action = CopyAction
        AutoSize = True
      end
      object ChgBtn: TToolButton
        Left = 256
        Top = 0
        Action = EditAction
        AutoSize = True
      end
      object SavBtn: TToolButton
        Left = 293
        Top = 0
        Action = SaveAction
        AutoSize = True
        Enabled = False
      end
      object ToolButton3: TToolButton
        Left = 330
        Top = 0
        Width = 8
        Caption = 'ToolButton3'
        ImageIndex = 2
        Style = tbsSeparator
      end
      object CelBtn: TToolButton
        Left = 338
        Top = 0
        Action = CancelAction
        AutoSize = True
        Enabled = False
      end
      object ToolButton2: TToolButton
        Left = 375
        Top = 0
        Width = 8
        Caption = 'ToolButton2'
        ImageIndex = 9
        Style = tbsSeparator
      end
      object DelBtn: TToolButton
        Left = 383
        Top = 0
        Action = DeleteAction
        AutoSize = True
      end
      object PrintBtn: TToolButton
        Left = 420
        Top = 0
        Action = PrintAction
      end
      object ToolButton12: TToolButton
        Left = 466
        Top = 0
        Width = 8
        Caption = 'ToolButton12'
        ImageIndex = 9
        Style = tbsSeparator
      end
    end
    object ToolBar2: TToolBar
      Left = 520
      Top = 2
      Width = 425
      Height = 48
      Align = alNone
      ButtonHeight = 36
      ButtonWidth = 59
      Caption = 'ToolBar1'
      EdgeBorders = []
      Flat = True
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = #23435#20307
      Font.Style = []
      Images = dmFrm.ImageList1
      ParentFont = False
      ShowCaptions = True
      TabOrder = 1
      OnDblClick = ToolBar1DblClick
      object btnCtrl: TToolButton
        Left = 0
        Top = 0
        Caption = #35774#32622#25511#38190
        ImageIndex = 45
        OnClick = btnCtrlClick
      end
      object btnShowLog: TToolButton
        Left = 59
        Top = 0
        Hint = #25968#25454#20462#25913#21024#38500#35760#24405
        Caption = #26085#24535
        ImageIndex = 29
        ParentShowHint = False
        ShowHint = True
        OnClick = btnShowLogClick
      end
      object ToolButton9: TToolButton
        Left = 118
        Top = 0
        Action = ActReflash
        AutoSize = True
      end
      object ToolButton1: TToolButton
        Left = 155
        Top = 0
        Action = ActHelp
        Visible = False
      end
      object ExtBtn: TToolButton
        Left = 214
        Top = 0
        Action = CloseAction
      end
    end
  end
  object DataSource1: TDataSource
    DataSet = ADODataSet1
    OnDataChange = DataSource1DataChange
    Left = 128
    Top = 149
  end
  object ADODataSet1: TADODataSet
    Connection = dmFrm.ADOConnection1
    Parameters = <>
    Left = 232
    Top = 144
  end
  object ActionList1: TActionList
    Images = dmFrm.ImageList1
    Left = 472
    Top = 80
    object AddAction: TAction
      Caption = #26032#22686
      ImageIndex = 7
      OnExecute = AddActionExecute
    end
    object CopyAction: TAction
      Tag = 50
      Caption = #22797#21046
      ImageIndex = 1
      OnExecute = CopyActionExecute
    end
    object EditAction: TAction
      Tag = 200
      Caption = #20462#25913
      ImageIndex = 21
      Visible = False
      OnExecute = EditActionExecute
    end
    object DeleteAction: TAction
      Tag = 400
      Caption = #21024#38500
      ImageIndex = 2
      Visible = False
      OnExecute = DeleteActionExecute
    end
    object SaveAction: TAction
      Tag = 300
      Caption = #20445#23384
      ImageIndex = 9
      Visible = False
      OnExecute = SaveActionExecute
    end
    object CancelAction: TAction
      Tag = 350
      Caption = #25918#24323
      ImageIndex = 4
      OnExecute = CancelActionExecute
    end
    object FirstAction: TAction
      Tag = -1000
      Caption = #39318#24352
      ImageIndex = 25
      OnExecute = FirstActionExecute
    end
    object PriorAction: TAction
      Tag = -900
      Caption = #19978#19968#24352
      ImageIndex = 22
      OnExecute = PriorActionExecute
    end
    object NextAction: TAction
      Tag = -800
      Caption = #19979#19968#24352
      ImageIndex = 24
      OnExecute = NextActionExecute
    end
    object LastAction: TAction
      Tag = -700
      Caption = #26411#24352
      ImageIndex = 23
      OnExecute = LastActionExecute
    end
    object CloseAction: TAction
      Caption = #36864#20986
      ImageIndex = 8
      OnExecute = CloseActionExecute
    end
    object PrintAction: TAction
      Tag = -10000
      Caption = #25171#21360
      Hint = 'OneLine'
      ImageIndex = 13
      Visible = False
      OnExecute = PrintActionExecute
    end
    object ActReflash: TAction
      Caption = #21047#26032
      ImageIndex = 26
      OnExecute = ActReflashExecute
    end
    object ActHelp: TAction
      Caption = #24110#21161
      ImageIndex = 5
    end
    object ActAfterPost: TAction
      Caption = 'ActAfterPost'
    end
    object ActShowLog: TAction
      Caption = #26085#24535
      ImageIndex = 29
      OnExecute = ActShowLogExecute
    end
    object actlink: TAction
      Tag = 1000
      Caption = 'actLinkBill'
      ImageIndex = 32
      OnExecute = actlinkExecute
    end
    object ActCheck: TAction
      Tag = 500
      Caption = #23457#26680
      ImageIndex = 10
      OnExecute = ActCheckExecute
    end
    object ActUnCheck: TAction
      Tag = 600
      Caption = #24323#23457
      ImageIndex = 37
      OnExecute = ActUnCheckExecute
    end
    object ActSaveWithoutRefresh: TAction
      Tag = 300
      Caption = #20445#23384
      ImageIndex = 9
      Visible = False
      OnExecute = ActSaveWithoutRefreshExecute
    end
  end
end
