object TabEditorFrm: TTabEditorFrm
  Left = 297
  Top = 208
  BorderStyle = bsDialog
  ClientHeight = 220
  ClientWidth = 394
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = #23435#20307
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnDblClick = FormDblClick
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  DesignSize = (
    394
    220)
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 394
    Height = 192
    Align = alTop
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 0
  end
  object Button1: TButton
    Left = 301
    Top = 197
    Width = 75
    Height = 20
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = #21462#28040
    ModalResult = 2
    TabOrder = 2
  end
  object savBtn: TButton
    Left = 217
    Top = 197
    Width = 75
    Height = 21
    Anchors = [akRight, akBottom]
    Caption = #30830#23450
    ModalResult = 1
    TabOrder = 1
  end
  object CheckBox1: TCheckBox
    Left = 8
    Top = 200
    Width = 134
    Height = 17
    Anchors = [akLeft, akBottom]
    Caption = #23384#30424#21518#32487#32493#28155#21152
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
    TabOrder = 3
  end
  object DataSource1: TDataSource
    DataSet = ADODataSet1
    Left = 193
    Top = 157
  end
  object ADODataSet1: TADODataSet
    Connection = dmFrm.ADOConnection1
    Parameters = <>
    Left = 224
    Top = 160
  end
end
