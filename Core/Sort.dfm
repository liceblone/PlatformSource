object SortFrm: TSortFrm
  Left = 341
  Top = 160
  BorderStyle = bsDialog
  Caption = #25490#24207
  ClientHeight = 324
  ClientWidth = 377
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Label2: TLabel
    Left = 15
    Top = 8
    Width = 52
    Height = 13
    Caption = #24403#21069#39034#24207
  end
  object StringGrid1: TStringGrid
    Left = 9
    Top = 32
    Width = 269
    Height = 281
    Hint = #21452#20987#21487#25913#21464#24403#21069#20540
    ColCount = 2
    DefaultColWidth = 120
    DefaultRowHeight = 22
    RowCount = 1
    FixedRows = 0
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goColSizing, goRowMoving]
    TabOrder = 0
    OnDblClick = StringGrid1DblClick
    OnRowMoved = StringGrid1RowMoved
    OnSelectCell = StringGrid1SelectCell
    RowHeights = (
      23)
  end
  object upBtn: TButton
    Left = 288
    Top = 248
    Width = 75
    Height = 22
    Caption = #19978#31227'(&U)'
    Enabled = False
    TabOrder = 1
    OnClick = upBtnClick
  end
  object DownBtn: TButton
    Left = 288
    Top = 274
    Width = 75
    Height = 22
    Caption = #19979#31227'(&D)'
    Enabled = False
    TabOrder = 2
    OnClick = DownBtnClick
  end
  object Button1: TButton
    Left = 288
    Top = 32
    Width = 75
    Height = 22
    Caption = #30830#23450'(&Y)'
    Default = True
    ModalResult = 1
    TabOrder = 3
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 288
    Top = 57
    Width = 75
    Height = 22
    Cancel = True
    Caption = #21462#28040'(&C)'
    ModalResult = 2
    TabOrder = 4
  end
  object BtnSave: TButton
    Left = 288
    Top = 216
    Width = 75
    Height = 25
    Caption = #20445#23384#35774#32622
    TabOrder = 5
    OnClick = BtnSaveClick
  end
end
