object FrmDemo: TFrmDemo
  Left = 548
  Top = 152
  Width = 696
  Height = 480
  Caption = #28436#31034
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poDefault
  Scaled = False
  Visible = True
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object imgMain: TImage
    Left = 0
    Top = 0
    Width = 688
    Height = 450
    Align = alClient
    AutoSize = True
    PopupMenu = pmDemo
    Stretch = True
  end
  object pgc: TPageControl
    Left = 0
    Top = 0
    Width = 688
    Height = 450
    Align = alClient
    PopupMenu = pmDemo
    TabOrder = 0
    OnChange = pgcChange
  end
  object pmDemo: TPopupMenu
    Left = 32
    Top = 72
    object save: TMenuItem
      Caption = #20445#23384
      OnClick = saveClick
    end
    object GetPic: TMenuItem
      Caption = #32534#36753#29366#24577
      OnClick = GetPicClick
    end
    object PriView: TMenuItem
      Caption = #39044#35272#25928#26524
      OnClick = PriViewClick
    end
    object addPage: TMenuItem
      Caption = #22686#21152#39029#38754
      OnClick = addPageClick
    end
  end
  object dlgOpenPicDemo: TOpenPictureDialog
    Left = 72
    Top = 72
  end
end
