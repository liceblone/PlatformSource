object DirSelectorFrm: TDirSelectorFrm
  Left = 447
  Top = 222
  BorderStyle = bsDialog
  Caption = #30446#24405#36873#25321#22120
  ClientHeight = 319
  ClientWidth = 320
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poDefault
  PixelsPerInch = 96
  TextHeight = 12
  object Label1: TLabel
    Left = 8
    Top = 11
    Width = 210
    Height = 12
    Caption = '\\Fhl\e$\mywork\projects\pub\fhlpkg'
  end
  object DirectoryListBox1: TDirectoryListBox
    Left = 8
    Top = 31
    Width = 218
    Height = 274
    DirLabel = Label1
    ItemHeight = 16
    TabOrder = 0
  end
  object Button1: TButton
    Left = 236
    Top = 32
    Width = 75
    Height = 21
    Caption = #30830#23450
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object Button2: TButton
    Left = 236
    Top = 64
    Width = 75
    Height = 21
    Caption = #21462#28040
    ModalResult = 2
    TabOrder = 2
  end
end
