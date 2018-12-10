object FrmUpdateProperty: TFrmUpdateProperty
  Left = 295
  Top = 138
  Width = 881
  Height = 536
  Caption = #23646#24615#20462#25913
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object GrpLabel: TGroupBox
    Left = 0
    Top = 0
    Width = 225
    Height = 257
    Caption = 'GrpLabel'
    TabOrder = 0
    object lbl1: TLabel
      Left = 24
      Top = 80
      Width = 137
      Height = 13
      AutoSize = False
      Caption = 'caption'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      OnMouseDown = lbl1MouseDown
    end
    object lbl2: TLabel
      Left = 24
      Top = 128
      Width = 42
      Height = 13
      Caption = 'eCaption'
    end
    object edtCaption: TEdit
      Left = 24
      Top = 96
      Width = 121
      Height = 21
      ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
      TabOrder = 0
      Text = 'edtCaption'
      OnChange = edtCaptionChange
    end
    object btnRemove: TButton
      Left = 104
      Top = 176
      Width = 75
      Height = 25
      Caption = 'btnRemove'
      TabOrder = 1
      OnClick = btnRemoveClick
    end
    object btnUpdate: TButton
      Left = 32
      Top = 176
      Width = 75
      Height = 25
      Caption = 'btnUpdate'
      TabOrder = 2
      OnClick = btnUpdateClick
    end
    object edtECaption: TEdit
      Left = 24
      Top = 152
      Width = 121
      Height = 21
      TabOrder = 3
      Text = 'edtECaption'
    end
    object FontCombox: TfrFontComboBox
      Left = 27
      Top = 48
      Width = 150
      Height = 19
      MRURegKey = '\Software\FastReport\MRUFont'
      Text = 'FontCombox'
      DropDownCount = 12
      ItemHeight = 13
      TabOrder = 4
      OnChange = FontComboxChange
    end
  end
  object GrpCTRL: TGroupBox
    Left = 240
    Top = 0
    Width = 489
    Height = 401
    Caption = 'GrpCTRL'
    TabOrder = 1
    object Label1: TLabel
      Left = 8
      Top = 80
      Width = 37
      Height = 13
      Caption = 'onclick '
    end
    object Label2: TLabel
      Left = 0
      Top = 120
      Width = 49
      Height = 13
      Caption = 'ondbclick '
    end
    object Label3: TLabel
      Left = 16
      Top = 160
      Width = 31
      Height = 13
      Caption = 'onexit '
    end
    object rg1: TRadioGroup
      Left = 312
      Top = 18
      Width = 169
      Height = 369
      Caption = 'ComponnetType'
      DragCursor = crSizeAll
      DragKind = dkDock
      DragMode = dmAutomatic
      Items.Strings = (
        'TLabel=0  '
        'TFhlDbEdit =1 *'
        'TDBEdit =2'
        'TDBLookupListBox=3'
        'TDBRichEdit=4'
        'TFhlDbLookupComboBox =5*'
        'TDBMemo     =6*'
        'TDBCheckBox=7*'
        'TDBText  =8*'
        'TFhlDbDatePicker =9*'
        'TDBRadioGroup  =10*'
        'TDBListBox =11'
        'TDBComboBox  =12*       '
        'TDBImage =13'
        'TDBFile=14'
        'TdbBarCode=15'
        'TdbQrCode=16')
      TabOrder = 0
      OnClick = rg1Click
    end
    object Editclick: TEdit
      Left = 48
      Top = 72
      Width = 73
      Height = 21
      ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
      TabOrder = 1
      Text = '-1'
    end
    object cmbclick: TComboBox
      Left = 120
      Top = 72
      Width = 185
      Height = 21
      ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
      ItemHeight = 13
      TabOrder = 2
      OnClick = cmbclickClick
    end
    object Editdbclick: TEdit
      Left = 48
      Top = 112
      Width = 73
      Height = 21
      ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
      TabOrder = 3
      Text = '-1'
    end
    object cmbdbclick: TComboBox
      Left = 120
      Top = 112
      Width = 185
      Height = 21
      ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
      ItemHeight = 13
      TabOrder = 4
      OnClick = cmbdbclickClick
    end
    object cmbexit: TComboBox
      Left = 120
      Top = 152
      Width = 185
      Height = 21
      ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
      ItemHeight = 13
      TabOrder = 5
      OnClick = cmbexitClick
    end
    object Editexit: TEdit
      Left = 48
      Top = 152
      Width = 73
      Height = 21
      ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
      TabOrder = 6
      Text = '-1'
    end
    object ChkReadOnly: TCheckBox
      Left = 48
      Top = 184
      Width = 97
      Height = 33
      Caption = 'ChkReadOnly'
      TabOrder = 7
      OnClick = ChkReadOnlyClick
    end
    object edtUpdateAction: TButton
      Left = 32
      Top = 224
      Width = 89
      Height = 25
      Caption = 'edtUpdateAction'
      TabOrder = 8
      OnClick = edtUpdateActionClick
    end
    object BtnClearhint: TButton
      Left = 120
      Top = 224
      Width = 75
      Height = 25
      Caption = 'BtnClearhint'
      TabOrder = 9
      OnClick = BtnClearhintClick
    end
    object btnRemoveCtrl: TButton
      Left = 192
      Top = 224
      Width = 75
      Height = 25
      Caption = 'btnRemoveCtrl'
      TabOrder = 10
      OnClick = btnRemoveCtrlClick
    end
    object ColorBox1: TColorBox
      Left = 32
      Top = 280
      Width = 217
      Height = 22
      ItemHeight = 16
      TabOrder = 11
      OnChange = ColorBox1Change
    end
    object chkDLGridDatasource: TCheckBox
      Left = 192
      Top = 192
      Width = 113
      Height = 17
      Caption = 'DLGridDatasource'
      TabOrder = 12
      OnClick = chkDLGridDatasourceClick
    end
  end
  object FontDialog1: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Left = 44
    Top = 8
  end
  object pm1: TPopupMenu
    Left = 12
    Top = 8
    object F1: TMenuItem
      Caption = 'Font'
      OnClick = F1Click
    end
    object B1: TMenuItem
      Caption = 'BackColor'
      OnClick = B1Click
    end
    object P1: TMenuItem
      Caption = 'ParentBackColor'
      OnClick = P1Click
    end
    object a1: TMenuItem
      Caption = #20998#26512#30028#38754#24213#33394
      OnClick = a1Click
    end
  end
  object dlgColor1: TColorDialog
    Left = 68
    Top = 8
  end
end
