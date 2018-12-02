object FrmSerialNos: TFrmSerialNos
  Left = 192
  Top = 103
  Width = 741
  Height = 466
  Caption = 'FrmSerialNos'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object ToolBar1: TToolBar
    Left = 0
    Top = 0
    Width = 733
    Height = 49
    ButtonHeight = 36
    ButtonWidth = 43
    Caption = 'ToolBar1'
    Images = dmFrm.ImageList1
    ShowCaptions = True
    TabOrder = 0
    object ToolButton8: TToolButton
      Left = 0
      Top = 2
      Width = 17
      Caption = 'ToolButton8'
      ImageIndex = 9
      Style = tbsSeparator
    end
    object ToolButton1: TToolButton
      Left = 17
      Top = 2
      Action = FirstAction1
    end
    object ToolButton2: TToolButton
      Left = 60
      Top = 2
      Action = PriorAction1
    end
    object ToolButton3: TToolButton
      Left = 103
      Top = 2
      Action = NextAction1
    end
    object ToolButton4: TToolButton
      Left = 146
      Top = 2
      Action = LastAction1
    end
    object ToolButton10: TToolButton
      Left = 189
      Top = 2
      Width = 8
      Caption = 'ToolButton10'
      ImageIndex = 10
      Style = tbsSeparator
    end
    object TlBtnChk: TToolButton
      Left = 197
      Top = 2
      Action = CheckAction1
    end
    object ToolButton7: TToolButton
      Left = 240
      Top = 2
      Width = 8
      Caption = 'ToolButton7'
      ImageIndex = 6
      Style = tbsSeparator
    end
    object ToolButton5: TToolButton
      Left = 248
      Top = 2
      Action = CloseAction1
    end
    object ToolButton9: TToolButton
      Left = 291
      Top = 2
      Width = 8
      Caption = 'ToolButton9'
      ImageIndex = 9
      Style = tbsSeparator
    end
    object ToolButton11: TToolButton
      Left = 299
      Top = 2
      Width = 8
      Caption = 'ToolButton11'
      ImageIndex = 10
      Style = tbsSeparator
    end
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 129
    Width = 733
    Height = 310
    ActivePage = TabSerial
    Align = alClient
    TabOrder = 1
    object TabSerial: TTabSheet
      Caption = #26465#24418#30721#24405#20837
      object Splitter1: TSplitter
        Left = 417
        Top = 0
        Width = 8
        Height = 282
        Align = alRight
      end
      object GrpCandidate: TGroupBox
        Left = 0
        Top = 0
        Width = 417
        Height = 282
        Align = alClient
        TabOrder = 0
        object GridCandidate: TDBGrid
          Left = 2
          Top = 15
          Width = 413
          Height = 265
          Align = alClient
          DataSource = DsSourceCandidate
          PopupMenu = dmFrm.DbGridPopupMenu1
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          OnDblClick = GridCandidateDblClick
        end
      end
      object GrpHaveOut: TGroupBox
        Left = 425
        Top = 0
        Width = 300
        Height = 282
        Align = alRight
        TabOrder = 1
        object PnlSerialno: TPanel
          Left = 2
          Top = 15
          Width = 296
          Height = 66
          Align = alTop
          Caption = ' '
          TabOrder = 0
          object Label1: TLabel
            Left = 16
            Top = 8
            Width = 39
            Height = 13
            Caption = #26465#24418#30721':'
          end
          object statLabel1: TLabel
            Left = 1
            Top = 52
            Width = 294
            Height = 13
            Align = alBottom
            Caption = '/'
          end
          object EdtSerialNo: TEdit
            Left = 16
            Top = 28
            Width = 161
            Height = 21
            Color = clHighlightText
            MaxLength = 13
            TabOrder = 0
            OnChange = EdtSerialNoChange
          end
          object BtnAdd: TButton
            Left = 192
            Top = 24
            Width = 49
            Height = 25
            Caption = #21152#20837
            TabOrder = 1
            OnClick = BtnAddClick
          end
          object BtnDelete: TButton
            Left = 240
            Top = 24
            Width = 41
            Height = 25
            Caption = #21024#38500
            TabOrder = 2
            OnClick = BtnDeleteClick
          end
        end
        object Panel2: TPanel
          Left = 2
          Top = 146
          Width = 296
          Height = 134
          Align = alClient
          TabOrder = 1
          object GridSerialNOs: TDBGrid
            Left = 1
            Top = 1
            Width = 294
            Height = 132
            Align = alClient
            DataSource = DsSourceSerialNo
            PopupMenu = dmFrm.DbGridPopupMenu1
            TabOrder = 0
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = []
            OnDblClick = GridSerialNOsDblClick
          end
        end
        object PnlOutQty: TPanel
          Left = 2
          Top = 81
          Width = 296
          Height = 65
          Align = alTop
          Caption = 'PnlOutQty'
          TabOrder = 2
          object Label2: TLabel
            Left = 16
            Top = 8
            Width = 60
            Height = 13
            Caption = #25351#23450#20986#24211#25968
          end
          object EdtQty: TEdit
            Left = 16
            Top = 24
            Width = 161
            Height = 21
            TabOrder = 0
            Text = '0'
          end
          object BtnUpdateOutQty: TButton
            Left = 200
            Top = 24
            Width = 57
            Height = 25
            Caption = #26356#26032
            TabOrder = 1
            OnClick = BtnUpdateOutQtyClick
          end
        end
      end
    end
  end
  object ScrollTop: TScrollBox
    Left = 0
    Top = 49
    Width = 733
    Height = 80
    Align = alTop
    BorderStyle = bsNone
    Color = clInactiveBorder
    Ctl3D = True
    ParentColor = False
    ParentCtl3D = False
    TabOrder = 2
    OnDblClick = ScrollTopDblClick
    DesignSize = (
      733
      80)
    object Label3: TLabel
      Left = 0
      Top = 0
      Width = 733
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
    object LblState: TLabel
      Left = 681
      Top = 32
      Width = 24
      Height = 13
      Anchors = [akTop, akRight]
      Caption = #29366#24577
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      Visible = False
    end
  end
  object MtDataSource1: TDataSource
    DataSet = MtDataSet1
    Left = 200
    Top = 105
  end
  object MtDataSet1: TADODataSet
    Connection = dmFrm.ADOConnection1
    LockType = ltBatchOptimistic
    AfterOpen = MtDataSet1AfterOpen
    CommandText = 'sp_MachOutWriteSerialNO'
    CommandType = cmdStoredProc
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = 0
      end
      item
        Name = '@F_WhCode'
        Attributes = [paNullable]
        DataType = ftString
        Size = 50
        Value = #39#39
      end
      item
        Name = '@sEmpid'
        Attributes = [paNullable]
        DataType = ftString
        Size = 50
        Value = #39#39
      end
      item
        Name = '@filters'
        Attributes = [paNullable]
        DataType = ftString
        Size = 50
        Value = #20840#37096
      end>
    Left = 216
    Top = 105
    object MtDataSet1F_MchApplyID: TIntegerField
      FieldName = 'F_MchApplyID'
    end
    object MtDataSet1F_Whcode: TStringField
      FieldName = 'F_Whcode'
    end
    object MtDataSet1F_ChkTime: TDateTimeField
      FieldName = 'F_ChkTime'
    end
    object MtDataSet1F_OutMan: TStringField
      FieldName = 'F_OutMan'
      Size = 30
    end
    object MtDataSet1F_OutDate: TDateTimeField
      FieldName = 'F_OutDate'
    end
    object MtDataSet1F_BillTime: TDateTimeField
      FieldName = 'F_BillTime'
    end
    object MtDataSet1F_WhName: TStringField
      FieldName = 'F_WhName'
    end
    object MtDataSet1F_FlagName: TStringField
      FieldName = 'F_FlagName'
      ReadOnly = True
      Size = 2
    end
  end
  object DsSourceCandidate: TDataSource
    DataSet = AdoDsCandidate
    OnDataChange = DsSourceCandidateDataChange
    Left = 28
    Top = 336
  end
  object AdoDsCandidate: TADODataSet
    Connection = dmFrm.ADOConnection1
    Parameters = <>
    Left = 60
    Top = 336
  end
  object DsSourceSerialNo: TDataSource
    DataSet = AdoDsSerialNO
    Left = 413
    Top = 345
  end
  object AdoDsSerialNO: TADODataSet
    Connection = dmFrm.ADOConnection1
    AfterScroll = AdoDsSerialNOAfterScroll
    Parameters = <>
    Left = 437
    Top = 345
  end
  object ActionList1: TActionList
    Images = dmFrm.ImageList1
    Left = 368
    Top = 16
    object NewAction1: TAction
      Caption = #26032#22686
      ImageIndex = 7
    end
    object CopyAction: TAction
      Caption = #22797#21046
      ImageIndex = 1
    end
    object EditAction: TAction
      Caption = #20462#25913
      ImageIndex = 21
    end
    object DeleteAction: TAction
      Caption = #21024#38500
      ImageIndex = 2
    end
    object SaveAction1: TAction
      Caption = #20445#23384
      ImageIndex = 9
    end
    object CancelAction1: TAction
      Caption = #25918#24323
      ImageIndex = 4
    end
    object FirstAction1: TAction
      Caption = #39318#24352
      ImageIndex = 25
      OnExecute = FirstAction1Execute
    end
    object PriorAction1: TAction
      Caption = #19978#19968#24352
      ImageIndex = 22
      OnExecute = PriorAction1Execute
    end
    object NextAction1: TAction
      Caption = #19979#19968#24352
      ImageIndex = 24
      OnExecute = NextAction1Execute
    end
    object LastAction1: TAction
      Caption = #26411#24352
      ImageIndex = 23
      OnExecute = LastAction1Execute
    end
    object CloseAction1: TAction
      Caption = #20851#38381
      ImageIndex = 8
      OnExecute = CloseAction1Execute
    end
    object PrintAction1: TAction
      Caption = #25171#21360
      ImageIndex = 13
    end
    object SetCaptionAction: TAction
      Caption = #26356#26032#26631#39064
      ImageIndex = 28
    end
    object actInputTaxAmt: TAction
      Caption = #31246#37329
      ImageIndex = 29
    end
    object CheckAction1: TAction
      Caption = #23457#26680
      Hint = #23457#26680
      ImageIndex = 10
      OnExecute = CheckAction1Execute
    end
  end
end
