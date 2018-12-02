object colPropFrm: TcolPropFrm
  Left = 351
  Top = 200
  BorderStyle = bsDialog
  ClientHeight = 382
  ClientWidth = 430
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 430
    Height = 345
    ActivePage = TabSheet1
    Align = alTop
    TabOrder = 0
    object TabSheet1: TTabSheet
      BorderWidth = 5
      Caption = #21015#23646#24615
      object Bevel1: TBevel
        Left = 0
        Top = 0
        Width = 412
        Height = 53
        Align = alTop
        Shape = bsBottomLine
      end
      object Label1: TLabel
        Left = 38
        Top = 19
        Width = 46
        Height = 13
        Caption = #36873#25321#21015':'
      end
      object Label5: TLabel
        Left = 216
        Top = 72
        Width = 39
        Height = 13
        Caption = #26631#39064#65306
      end
      object ComboBox1: TComboBox
        Left = 86
        Top = 16
        Width = 167
        Height = 19
        Style = csOwnerDrawFixed
        DropDownCount = 12
        ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
        ItemHeight = 13
        TabOrder = 0
        OnChange = ComboBox1Change
      end
      object GroupBox1: TGroupBox
        Left = 16
        Top = 110
        Width = 393
        Height = 76
        Caption = #21015#26631#39064
        TabOrder = 1
        object Label3: TLabel
          Left = 16
          Top = 21
          Width = 59
          Height = 13
          Caption = #32972#26223#39068#33394':'
        end
        object Label4: TLabel
          Left = 16
          Top = 47
          Width = 59
          Height = 13
          Caption = #23383#20307#39068#33394':'
        end
        object Label6: TLabel
          Left = 239
          Top = 46
          Width = 59
          Height = 13
          Caption = #23383#20307#22823#23567':'
        end
        object Label11: TLabel
          Left = 254
          Top = 16
          Width = 46
          Height = 13
          Caption = #21015#23485#24230':'
        end
        object titleBgColorBox1: TColorBox
          Left = 79
          Top = 16
          Width = 147
          Height = 22
          Style = [cbStandardColors, cbExtendedColors, cbSystemColors, cbPrettyNames]
          Ctl3D = True
          ItemHeight = 16
          ParentCtl3D = False
          TabOrder = 0
          OnChange = titleBgColorBox1Change
        end
        object titleFontColorBox1: TColorBox
          Left = 78
          Top = 42
          Width = 148
          Height = 22
          ItemHeight = 16
          TabOrder = 1
          OnChange = titleFontColorBox1Change
        end
        object titleFontSizeEdit1: TEdit
          Left = 304
          Top = 44
          Width = 80
          Height = 21
          ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
          TabOrder = 2
          OnChange = titleFontSizeEdit1Change
          OnKeyPress = widthEdit1KeyPress
        end
        object widthEdit1: TEdit
          Left = 304
          Top = 13
          Width = 81
          Height = 21
          ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
          TabOrder = 3
          OnChange = widthEdit1Change
          OnKeyPress = widthEdit1KeyPress
        end
      end
      object GroupBox2: TGroupBox
        Left = 16
        Top = 195
        Width = 393
        Height = 110
        Caption = #21015#20869#23481
        TabOrder = 2
        object Label2: TLabel
          Left = 16
          Top = 17
          Width = 59
          Height = 13
          Caption = #23545#40784#26041#24335':'
        end
        object Label7: TLabel
          Left = 15
          Top = 50
          Width = 59
          Height = 13
          Caption = #32972#26223#39068#33394':'
        end
        object Label8: TLabel
          Left = 15
          Top = 77
          Width = 59
          Height = 13
          Caption = #23383#20307#39068#33394':'
        end
        object Label9: TLabel
          Left = 231
          Top = 76
          Width = 59
          Height = 13
          Caption = #23383#20307#22823#23567':'
        end
        object Label10: TLabel
          Left = 260
          Top = 48
          Width = 39
          Height = 13
          Caption = #26684#24335#65306
        end
        object Label12: TLabel
          Left = 260
          Top = 20
          Width = 39
          Height = 13
          Caption = #27719#24635#65306
        end
        object bgColorBox1: TColorBox
          Left = 75
          Top = 45
          Width = 137
          Height = 22
          Style = [cbStandardColors, cbExtendedColors, cbSystemColors, cbPrettyNames]
          Ctl3D = True
          ItemHeight = 16
          ParentCtl3D = False
          TabOrder = 0
          OnChange = bgColorBox1Change
        end
        object fontColorBox1: TColorBox
          Left = 75
          Top = 72
          Width = 137
          Height = 22
          ItemHeight = 16
          TabOrder = 1
          OnChange = fontColorBox1Change
        end
        object RadioButton1: TRadioButton
          Left = 81
          Top = 16
          Width = 73
          Height = 17
          Caption = #24038#23545#40784
          Checked = True
          TabOrder = 2
          TabStop = True
          OnClick = RadioButton1Click
        end
        object RadioButton2: TRadioButton
          Tag = 1
          Left = 141
          Top = 16
          Width = 63
          Height = 17
          Caption = #23621#20013
          TabOrder = 3
          OnClick = RadioButton1Click
        end
        object RadioButton3: TRadioButton
          Tag = 2
          Left = 189
          Top = 16
          Width = 60
          Height = 17
          Caption = #21491#23545#40784
          TabOrder = 4
          OnClick = RadioButton1Click
        end
        object fontSizeEdit1: TEdit
          Left = 292
          Top = 73
          Width = 93
          Height = 21
          ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
          TabOrder = 5
          OnChange = fontSizeEdit1Change
          OnKeyPress = widthEdit1KeyPress
        end
        object ComDecimal: TComboBox
          Left = 292
          Top = 45
          Width = 93
          Height = 21
          ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
          ItemHeight = 13
          TabOrder = 6
          OnChange = ComDecimalChange
          Items.Strings = (
            '0.'
            '0.0'
            '0.00'
            '0.000'
            '0.0000'
            '0.00000'
            '0.000000'
            '0.0000000'
            '0.00000000'
            '0.000000000'
            '0.0000000000'
            '')
        end
        object ComBoGrpType: TComboBox
          Left = 292
          Top = 16
          Width = 93
          Height = 21
          ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
          ItemHeight = 13
          TabOrder = 7
          OnChange = ComBoGrpTypeChange
          Items.Strings = (
            #19981#35745#31639
            #27719#24635
            #24179#22343#20540
            #39318#34892#20540
            #26411#34892#20540
            #26368#22823#20540
            #26368#23567#20540)
        end
      end
      object CheckBox1: TCheckBox
        Left = 263
        Top = 17
        Width = 97
        Height = 17
        Caption = #20165#26174#31034#21487#35270#21015
        Checked = True
        State = cbChecked
        TabOrder = 3
        OnClick = CheckBox1Click
      end
      object GroupBox3: TGroupBox
        Left = 16
        Top = 56
        Width = 185
        Height = 49
        Caption = #21487#35270#24615
        TabOrder = 4
        object visRadioBtn2: TRadioButton
          Left = 94
          Top = 16
          Width = 75
          Height = 17
          Caption = #19981#21487#35265
          TabOrder = 0
          OnClick = visRadioBtn1Click
        end
        object visRadioBtn1: TRadioButton
          Left = 22
          Top = 16
          Width = 75
          Height = 17
          Caption = #21487#35265
          TabOrder = 1
          OnClick = visRadioBtn1Click
        end
      end
      object edtTitleCaption: TEdit
        Left = 256
        Top = 69
        Width = 147
        Height = 21
        ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
        TabOrder = 5
        OnChange = edtTitleCaptionChange
      end
    end
  end
  object Button1: TButton
    Left = 230
    Top = 353
    Width = 75
    Height = 21
    Caption = #30830#23450'(&Y)'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object Button2: TButton
    Left = 315
    Top = 354
    Width = 75
    Height = 20
    Cancel = True
    Caption = #21462#28040
    ModalResult = 2
    TabOrder = 2
  end
end
