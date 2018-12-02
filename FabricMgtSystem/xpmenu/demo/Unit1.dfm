object Form1: TForm1
  Left = 279
  Top = 342
  Width = 696
  Height = 480
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIForm
  Menu = MainMenu1
  OldCreateOrder = False
  PopupMenu = PopupMenu1
  PixelsPerInch = 96
  TextHeight = 13
  object CheckBox1: TCheckBox
    Left = 248
    Top = 96
    Width = 97
    Height = 17
    Caption = 'active'
    TabOrder = 0
    OnClick = CheckBox1Click
  end
  object CheckBox2: TCheckBox
    Left = 264
    Top = 136
    Width = 97
    Height = 17
    Caption = 'gradient'
    TabOrder = 1
    OnClick = CheckBox2Click
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 415
    Width = 688
    Height = 19
    Panels = <>
  end
  object ToolBar1: TToolBar
    Left = 0
    Top = 0
    Width = 688
    Height = 29
    ButtonHeight = 21
    ButtonWidth = 65
    Caption = 'ToolBar1'
    ShowCaptions = True
    TabOrder = 3
    object ToolButton1: TToolButton
      Left = 0
      Top = 2
      Caption = 'ToolButton1'
      ImageIndex = 0
    end
    object ToolButton2: TToolButton
      Left = 65
      Top = 2
      Caption = 'ToolButton2'
      ImageIndex = 1
    end
  end
  object ScrollBox1: TScrollBox
    Left = 280
    Top = 32
    Width = 185
    Height = 41
    TabOrder = 4
  end
  object Button1: TButton
    Left = 592
    Top = 296
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 5
    OnClick = Button1Click
  end
  object MainMenu1: TMainMenu
    Left = 112
    Top = 40
    object sd1: TMenuItem
      Caption = 'sd'
      object sdf1: TMenuItem
        Caption = 'sdf'
      end
      object s1: TMenuItem
        Caption = 's'
      end
      object df1: TMenuItem
        Caption = 'df'
      end
      object sdf2: TMenuItem
        Caption = 'sdf'
      end
      object sd2: TMenuItem
        Caption = 'sd'
      end
      object f1: TMenuItem
        Caption = 'f'
      end
    end
    object hg1: TMenuItem
      Caption = 'hg'
      object jk1: TMenuItem
        Caption = 'jk'
      end
      object j1: TMenuItem
        Caption = 'j'
      end
      object hj1: TMenuItem
        Caption = 'hj'
      end
      object jh1: TMenuItem
        Caption = ']jh'
      end
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 144
    Top = 40
    object ret1: TMenuItem
      Caption = 'ret'
    end
    object d1: TMenuItem
      Caption = 'd'
    end
    object fg1: TMenuItem
      Caption = 'fg'
    end
    object df2: TMenuItem
      Caption = 'df'
    end
    object g1: TMenuItem
      Caption = 'g'
    end
    object dfg1: TMenuItem
      Caption = 'dfg'
    end
  end
  object XPMenu1: TXPMenu
    DimLevel = 30
    GrayLevel = 10
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMenuText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Color = clBtnFace
    DrawMenuBar = False
    IconBackColor = clBtnFace
    MenuBarColor = clBtnFace
    SelectColor = clHighlight
    SelectBorderColor = clHighlight
    SelectFontColor = clMenuText
    DisabledColor = clInactiveCaption
    SeparatorColor = clBtnFace
    CheckedColor = clHighlight
    IconWidth = 24
    DrawSelect = True
    UseSystemColors = True
    UseDimColor = False
    OverrideOwnerDraw = False
    Gradient = False
    FlatMenu = False
    AutoDetect = False
    Active = False
    Left = 136
    Top = 88
  end
end
