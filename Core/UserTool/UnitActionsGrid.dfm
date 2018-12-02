object FrmActions: TFrmActions
  Left = 319
  Top = 127
  Width = 666
  Height = 576
  AutoSize = True
  Caption = 'FrmActions'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 193
    Top = 0
    Height = 549
  end
  object PnlLeft: TPanel
    Left = 0
    Top = 0
    Width = 193
    Height = 549
    Align = alLeft
    Caption = 'PnlLeft'
    TabOrder = 0
    Visible = False
    object CombSelectMolde: TListBox
      Left = 1
      Top = 1
      Width = 191
      Height = 547
      Align = alClient
      ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
      ItemHeight = 13
      TabOrder = 0
      OnClick = CombSelectMoldeClick
    end
  end
  object pnlRight: TPanel
    Left = 196
    Top = 0
    Width = 462
    Height = 549
    Align = alClient
    Caption = 'pnlRight'
    TabOrder = 1
    object F: TPageControl
      Left = 1
      Top = 1
      Width = 352
      Height = 547
      ActivePage = ts1
      Align = alLeft
      TabOrder = 0
      object ts1: TTabSheet
        Caption = 'Frm'
        object ActionGrid: TStringGrid
          Left = 0
          Top = 0
          Width = 344
          Height = 519
          Align = alClient
          ColCount = 6
          DefaultColWidth = 90
          RowCount = 1
          FixedRows = 0
          TabOrder = 0
          OnClick = ActionGridClick
        end
      end
      object TabSheet1: TTabSheet
        Caption = 'ImageList'
        ImageIndex = 1
        object TreeView1: TTreeView
          Left = 16
          Top = 24
          Width = 257
          Height = 441
          Images = dmFrm.ImageList1
          Indent = 19
          TabOrder = 0
          OnChange = TreeView1Change
          OnDblClick = TreeView1DblClick
        end
      end
    end
    object btnCancel: TButton
      Left = 375
      Top = 464
      Width = 75
      Height = 25
      Caption = #21462#28040'(&C)'
      ModalResult = 2
      TabOrder = 1
    end
    object btnConfirm: TButton
      Left = 374
      Top = 424
      Width = 75
      Height = 25
      Caption = #30830#23450'(&Y)'
      ModalResult = 1
      TabOrder = 2
    end
  end
end
