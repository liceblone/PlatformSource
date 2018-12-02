object MyPreview: TMyPreview
  Left = 411
  Top = 160
  Width = 981
  Height = 568
  Caption = 'MyPreview'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Scaled = False
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object QRPreview1: TQRPreview
    Left = 185
    Top = 29
    Width = 788
    Height = 512
    HorzScrollBar.Tracking = True
    VertScrollBar.Tracking = True
    Align = alClient
    TabOrder = 0
    PageNumber = 1
    Zoom = 100
  end
  object ToolBar1: TToolBar
    Left = 0
    Top = 0
    Width = 973
    Height = 29
    Caption = 'ToolBar1'
    TabOrder = 1
    object ToolButton1: TToolButton
      Left = 0
      Top = 2
      Caption = 'ToolButton1'
      ImageIndex = 0
    end
    object ToolButton2: TToolButton
      Left = 23
      Top = 2
      Caption = 'ToolButton2'
      ImageIndex = 1
    end
    object ToolButton3: TToolButton
      Left = 46
      Top = 2
      Caption = 'ToolButton3'
      ImageIndex = 2
    end
    object ToolButton4: TToolButton
      Left = 69
      Top = 2
      Caption = 'ToolButton4'
      ImageIndex = 3
    end
    object ToolButton5: TToolButton
      Left = 92
      Top = 2
      Caption = 'ToolButton5'
      ImageIndex = 4
    end
    object ToolButton6: TToolButton
      Left = 115
      Top = 2
      Caption = 'ToolButton6'
      ImageIndex = 5
    end
    object ToolButton7: TToolButton
      Left = 138
      Top = 2
      Caption = 'ToolButton7'
      ImageIndex = 6
    end
    object ToolButton8: TToolButton
      Left = 161
      Top = 2
      Caption = 'ToolButton8'
      ImageIndex = 7
    end
    object Button1: TButton
      Left = 184
      Top = 2
      Width = 75
      Height = 22
      Caption = 'Button1'
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 259
      Top = 2
      Width = 75
      Height = 22
      Caption = 'Button2'
      TabOrder = 1
      OnClick = Button2Click
    end
    object Button3: TButton
      Left = 334
      Top = 2
      Width = 75
      Height = 22
      Caption = 'Button3'
      TabOrder = 2
      OnClick = Button3Click
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 29
    Width = 97
    Height = 512
    Align = alLeft
    Caption = 'Panel1'
    TabOrder = 2
  end
  object Panel2: TPanel
    Left = 97
    Top = 29
    Width = 88
    Height = 512
    Align = alLeft
    Caption = 'Panel2'
    TabOrder = 3
  end
end
