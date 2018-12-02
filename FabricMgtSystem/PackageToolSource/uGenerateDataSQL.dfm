object FrmGenerateDataSQL: TFrmGenerateDataSQL
  Left = 599
  Top = 229
  Width = 870
  Height = 500
  Caption = 'FrmGenerateDataSQL'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object MmTables: TMemo
    Left = 0
    Top = 105
    Width = 185
    Height = 368
    Align = alLeft
    Lines.Strings = (
      'MmTables')
    TabOrder = 0
  end
  object MmSQLScript: TMemo
    Left = 185
    Top = 105
    Width = 677
    Height = 368
    Align = alClient
    Lines.Strings = (
      'MmSQLScript')
    TabOrder = 1
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 862
    Height = 105
    Align = alTop
    Caption = 'GroupBox1'
    TabOrder = 2
    object btnGetSQL: TButton
      Left = 24
      Top = 32
      Width = 75
      Height = 25
      Caption = 'btnGetSQL'
      TabOrder = 0
      OnClick = btnGetSQLClick
    end
  end
  object ADOQuery1: TADOQuery
    Parameters = <>
    Left = 120
    Top = 56
  end
end
