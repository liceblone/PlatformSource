object FrmMainMenu: TFrmMainMenu
  Left = 181
  Top = 180
  Width = 999
  Height = 506
  Caption = 'FrmMainMenu'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  Menu = mmmain
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object ToolBar: TToolBar
    Left = 0
    Top = 41
    Width = 991
    Height = 36
    ButtonHeight = 36
    ButtonWidth = 43
    Caption = 'ToolBar'
    EdgeBorders = []
    Flat = True
    Images = dmFrm.ImageList1
    ShowCaptions = True
    TabOrder = 0
    OnDblClick = ToolBarDblClick
    object PrintBtn: TToolButton
      Left = 0
      Top = 0
      Action = actPrintAction
    end
    object SavBtn: TToolButton
      Left = 43
      Top = 0
      Action = actSaveAction
      AutoSize = True
    end
    object CelBtn: TToolButton
      Left = 78
      Top = 0
      Action = actCancelAction
      AutoSize = True
    end
    object btn2: TToolButton
      Left = 113
      Top = 0
      Width = 8
      Caption = 'btn2'
      ImageIndex = 2
      Style = tbsSeparator
    end
    object AddBtn: TToolButton
      Left = 121
      Top = 0
      Action = actAddAction
      AutoSize = True
    end
    object CpyBtn: TToolButton
      Left = 156
      Top = 0
      Action = actCopyAction
      AutoSize = True
    end
    object editBtn: TToolButton
      Left = 191
      Top = 0
      Action = actEditAction
      AutoSize = True
    end
    object DelBtn: TToolButton
      Left = 226
      Top = 0
      Action = actDeleteAction
      AutoSize = True
    end
    object btn3: TToolButton
      Left = 261
      Top = 0
      Width = 8
      Caption = 'btn3'
      ImageIndex = 5
      Style = tbsSeparator
    end
    object FirstBtn: TToolButton
      Left = 269
      Top = 0
      Action = actFirstAction
      AutoSize = True
    end
    object PriorBtn: TToolButton
      Left = 304
      Top = 0
      Action = actPriorAction
      AutoSize = True
    end
    object NextBtn: TToolButton
      Left = 351
      Top = 0
      Action = actNextAction
      AutoSize = True
    end
    object LastBtn: TToolButton
      Left = 398
      Top = 0
      Action = actLastAction
      AutoSize = True
    end
    object btn4: TToolButton
      Left = 433
      Top = 0
      Width = 8
      Caption = 'btn4'
      ImageIndex = 9
      Style = tbsSeparator
    end
    object TbtnReflash: TToolButton
      Left = 441
      Top = 0
      Caption = #21047#26032
      ImageIndex = 16
      OnClick = TbtnReflashClick
    end
    object Frm: TToolButton
      Left = 484
      Top = 0
      Caption = ' Forms '
      ImageIndex = 20
      OnClick = FrmClick
    end
    object ExtBtn: TToolButton
      Left = 527
      Top = 0
      Action = actCloseAction
      AutoSize = True
    end
    object btnSql: TToolButton
      Left = 562
      Top = 0
      Action = actSql
    end
    object ChkActive: TCheckBox
      Left = 605
      Top = 0
      Width = 97
      Height = 36
      Caption = 'ChkActive'
      TabOrder = 0
      OnClick = ChkActiveClick
    end
    object chkgradient: TCheckBox
      Left = 702
      Top = 0
      Width = 97
      Height = 36
      Caption = 'chkgradient'
      TabOrder = 1
      OnClick = chkgradientClick
    end
  end
  object pnlMain: TPanel
    Left = 0
    Top = 77
    Width = 991
    Height = 299
    Align = alClient
    TabOrder = 1
    object CoolBar1: TCoolBar
      Left = 1
      Top = 1
      Width = 989
      Height = 29
      AutoSize = True
      Bands = <
        item
          Control = ToolBar1
          ImageIndex = -1
          Width = 985
        end>
      Color = clMoneyGreen
      ParentColor = False
      Bitmap.Data = {
        360C0000424D360C000000000000360000002800000000040000010000000100
        180000000000000C0000120B0000120B00000000000000000000B0F8B8B0F8B8
        B0F8B8B0F8B8B0F8B8B0F8B8B0F8B8B0F8B8B0F8B8B0F8B8B0F8B8B0F8B8B0F8
        B8B0F8B8B0F8B8B0F8B8B0F8B8B0F8B8B0F8B8B0F8B8B0F8B8B0F8B8B0F8B8B0
        F8B8B0F8B8B1F8B8B1F8B8B0F8B8B0F8B9B0F9B9B0F9B9B0F8B8B0F8B8B1F8B9
        B1F8B9B0F8B8B1F8B8B0F8B8B1F8B9B1F8B9B1F8B9B1F8B8B1F8B9B1F8B9B1F8
        B9B1F9B9B1F8B9B1F8B9B1F8B9B1F8B9B2F8B9B2F8B9B2F8B9B2F8B9B1F8BAB1
        F8B9B2F8BAB2F8BAB1F8B9B2F8BAB2F8BAB2F8B9B2F8B9B2F8B9B2F8BAB2F8BA
        B2F8BAB2F8BAB2F8BAB2F8B9B2F8BAB2F8BAB2F8BAB3F8BAB2F8BAB2F8BBB2F8
        BBB3F8BAB3F9BBB3F8BAB3F8BAB3F9BBB3F8BAB3F8BBB3F8BBB3F8BBB3F8BBB3
        F9BBB3F8BBB3F8BBB4F9BBB4F8BBB4F8BBB4F8BBB4F8BBB4F8BBB4F8BBB4F8BB
        B4F8BBB4F9BBB4F9BBB4F8BCB4F8BBB4F8BBB4F9BCB4F8BCB4F8BCB4F9BCB4F9
        BCB4F9BCB5F8BCB5F8BCB5F8BCB5F9BCB5F9BCB5F8BCB5F9BCB5F9BCB5F8BCB5
        F8BDB5F8BCB5F8BCB5F8BDB5F9BDB5F9BCB5F9BCB5F9BDB5F8BDB5F8BDB6F9BD
        B6F9BDB6F8BDB5F9BDB5F8BDB5F8BEB5F8BEB6F9BEB6F8BEB6F8BDB6F9BEB6F9
        BEB7F9BDB6F9BEB7F8BDB7F8BDB6F9BEB7F8BEB7F8BEB7F9BEB7F9BEB7F8BFB7
        F9BEB7F8BFB8F8BFB8F9BFB7F9BEB8F8BFB8F8BFB8F8BFB8F9BFB8F9BFB8F9BF
        B8F8BFB7F8BFB7F9C0B8F9BFB8F9BFB8F9BFB8F9C0B8F8BFB9F9BFB9F9C0B9F9
        C0B8F9C0B9F8C0B9F9C0B9F9C0B8F9C0B9F9C0B9F9C0B9F9C0B9F9C0B9F9C0B9
        F8C1B9F8C0B9F9C0B9F9C0B9F8C1B9F9C1BAF8C1BAF8C1BAF9C1BAF9C1BAF9C1
        BAF9C1BAF9C1BAF9C1BAF9C2BBF9C2BBF9C2BBF9C2BBF9C1BAF9C1BBF9C2BBF9
        C2BAF9C2BBF9C2BBF9C2BBF9C2BBF9C2BBF8C2BBF9C2BBF9C2BBF9C2BCFAC3BC
        F9C2BCF9C3BBF9C3BBF9C3BCF9C3BCF9C3BCF9C2BCF9C2BCF9C3BDF9C3BCF9C3
        BCF9C3BCF9C3BDF9C3BCF9C3BDF9C3BDF9C3BDF9C4BDF9C4BDF9C4BDF9C3BDF9
        C3BEF9C4BDF9C4BEF9C4BEF9C4BEF9C5BDF9C4BDF9C4BEF9C5BEF9C5BEF9C5BE
        F9C5BEF9C5BEF9C4BFF9C4BFF9C5BEF9C5BFFAC5BFFAC5BEFAC5BFFAC5BEF9C5
        BEF9C5BFFAC5BFFAC5C0FAC6C0F9C6C0F9C6C0FAC6BFF9C6C0F9C6C0F9C6C0F9
        C6C0FAC6C0FAC7C0F9C6C0F9C6C1F9C7C1FAC7C0FAC6C0F9C7C0F9C7C1FAC6C0
        FAC7C0FAC7C0FAC7C1F9C7C1F9C7C2F9C8C2F9C7C2F9C7C1FAC8C2FAC8C2FAC8
        C2FAC8C2F9C8C2F9C8C2FAC8C3FAC8C3FAC8C2F9C8C2FAC8C2F9C9C2F9C9C2F9
        C8C3FAC8C3F9C9C3FAC9C3FAC9C3F9C9C3FAC9C3FAC9C3FAC9C3FAC9C3FAC9C4
        FAC9C3FAC9C3F9CAC3F9CAC4FAC9C4FACAC4FACAC4FACAC4FACBC4F9CAC4FACA
        C4FACAC4FACAC4FACAC5FACBC5FACAC5FACAC5FACBC5FACBC6FACBC6FACBC5FA
        CBC6FACCC6FACBC6FACCC6FACCC6FACCC6FACCC6FACCC6FACCC6FACCC6FACCC7
        FACCC6FACCC6FACCC7FACCC7FBCCC6FACDC6FACDC7FACDC7FACDC7FACDC8FBCD
        C8FBCDC8FACDC8FACEC7FBCDC7FBCDC7FBCDC7FACEC8FACEC8FACEC8FACEC8FA
        CEC8FACEC9FACEC9FACEC9FACEC9FACEC9FBCFC9FACFCAFACECAFACEC9FACFCA
        FACFC9FBCFC9FBCFC9FACFCAFACFCAFBCFCAFBCFCAFACFCAFACFCAFBD0CBFBD0
        CBFBD0CAFBD0CBFAD0CBFAD0CBFBD0CBFBD0CBFAD0CBFBD0CBFAD1CBFAD1CBFA
        D1CBFAD1CBFAD1CCFAD1CCFAD1CCFBD1CCFBD1CCFBD2CCFBD2CCFBD2CDFBD2CC
        FBD1CCFBD2CCFBD2CCFBD2CDFAD1CCFBD2CCFAD2CDFAD2CDFBD2CDFAD2CEFBD2
        CEFBD3CEFBD3CDFBD2CDFBD3CEFAD3CEFAD3CEFAD3CEFAD3CFFAD3CFFBD3CEFB
        D3CEFBD4CEFBD4CEFBD4CEFBD4CEFAD3CFFBD4CFFAD4CFFAD4CFFBD4CFFBD4CF
        FAD4D0FBD4D0FBD4D0FBD4D0FBD5D0FBD4D0FBD4D0FBD5D0FBD5D1FBD5D0FBD5
        D0FBD5D0FBD5D1FBD6D1FBD6D1FBD5D1FBD5D1FBD5D1FBD6D1FBD6D2FBD6D2FB
        D6D2FBD6D2FBD6D2FBD7D2FBD7D1FBD6D2FBD6D2FCD7D3FCD6D3FBD6D3FBD7D3
        FBD7D3FBD7D3FBD7D3FBD7D3FBD8D3FBD8D3FCD8D3FCD8D3FBD7D3FBD8D3FBD8
        D3FBD8D3FBD8D4FBD8D3FBD8D4FBD8D4FBD8D4FBD9D5FBD8D4FBD9D4FBD9D4FB
        D9D5FBD9D5FCD9D5FBDAD5FBDAD5FBD9D5FCDAD5FBDAD5FBD9D5FCD9D6FCDAD5
        FBDAD5FBDAD5FCDAD6FCDAD6FBDAD7FBDBD7FBDBD6FBDAD6FCDAD7FCDAD7FBDB
        D7FBDBD7FBDBD7FCDBD7FCDBD7FCDBD7FCDBD8FCDCD8FCDCD8FBDBD8FCDBD8FC
        DCD8FBDCD8FCDCD8FCDCD8FCDCD8FBDCD9FCDCD8FCDCD8FBDDD8FBDDD9FBDCD9
        FCDDD9FBDDD9FBDDD9FCDDDAFCDDD9FCDEDAFBDDDAFBDDD9FBDEDAFBDEDAFBDD
        DAFBDDDAFCDEDBFCDEDAFBDEDBFCDEDBFCDEDAFBDEDAFBDEDBFCDEDBFCDEDBFC
        DEDBFBDFDBFBDFDBFCDFDBFCDFDBFCDFDBFCDFDCFCDFDBFCE0DBFCE0DCFBDFDC
        FCDFDCFCE0DDFCE0DDFCE0DCFBE0DCFCE0DDFCE0DDFCE0DCFCE0DDFCE0DDFCE0
        DDFCE0DEFCE1DEFCE1DDFCE1DEFCE0DEFCE0DEFCE1DEFCE1DEFCE1DEFCE2DEFC
        E2DEFDE2DFFCE2DFFCE2DFFCE2DEFCE1DEFCE2DEFCE2DEFCE2DEFCE2DFFCE3DF
        FCE3DFFCE3E0FCE3E0FCE3DFFDE2E0FCE2E0FCE3E0FCE3E0FDE3E0FCE3E0FCE4
        E0FDE4E0FDE4E0FCE4E1FCE3E1FCE4E1FCE4E0FCE4E1FCE3E1FCE4E1FCE4E1FC
        E4E1FCE4E1FDE5E1FCE5E1FCE5E1FDE5E1FCE5E2FCE5E2FCE5E2FCE5E2FCE5E2
        FCE5E2FCE5E3FCE6E3FCE6E2FDE5E2FCE5E3FDE6E3FDE6E3FCE5E3FCE6E3FCE6
        E3FDE6E3FDE6E4FCE6E3FDE6E3FDE7E3FDE7E4FDE7E3FCE7E5FDE7E5FDE7E4FD
        E7E4FCE7E5FDE7E5FCE7E5FCE7E5FDE7E5FDE7E4FDE8E4FDE7E5FDE7E5FDE8E6
        FDE8E5FCE8E5FCE8E5FDE8E6FDE8E6FDE9E6FCE9E6FCE8E6FDE8E6FDE9E6FCE9
        E6FCE9E7FDE9E7FDE9E7FDE9E7FDE9E7FDE9E7FDE9E7FDE9E7FDEAE8FDEAE8FD
        EAE7FDEAE8FDE9E8FDE9E8FDE9E8FCEAE8FDEAE8FDEAE8FDEAE8FDEAE8FDEAE9
        FDEAE8FDEAE8FDEAE8FDEBE9FDEBE9FDEBE9FDEBE9FDEBE9FDEBE9FDEBE9FDEC
        E9FEECE9FEEBE9FDECE9FDECEAFDEBEAFDEBEAFEECEAFDECEAFDECEAFDECEAFD
        ECEAFDECEAFDECEAFDEDEAFDEDEAFDECEBFDEDEBFEEDEBFEEDEBFDEDEBFDEDEB
        FDEDEBFDEEECFDEEECFDEDEBFDEDECFEEEECFEEDECFDEDEBFDEEECFDEDECFDED
        ECFEEDECFEEEECFDEEECFEEFECFDEEECFDEEEDFDEEEDFDEEECFDEFECFDEFEDFD
        EEEDFDEFEEFEEEEDFDEEEDFDF0EEFEF0EDFEEFEEFEEFEEFEF0EEFEF0EEFDEFEE
        FEF0EEFDEFEEFDEFEEFDF0EEFEF0EEFEF0EEFEF0EEFEF0EFFEF0EEFEF1EFFDF0
        EFFDF0EFFDF0EFFEF1EFFEF1EFFDF0EFFDF0F0FEF1F0FEF1EFFEF1EFFEF1F0FE
        F1F0FEF1F0FDF1F0FEF2F0FEF2F0FEF2F0FEF1F1FDF2F0FDF2F0FDF2F1FEF2F0
        FDF2F0FEF2F0FEF2F1FEF2F1FEF2F1FEF3F1FEF2F1FEF2F1FEF3F1FEF2F1FEF3
        F1FEF3F1FEF3F2FEF3F2FEF3F2FEF3F2FEF3F2FEF3F2FEF3F2FEF3F2FEF3F2FE
        F3F2FDF4F3FEF3F2FEF3F2FEF3F2FEF4F2FEF4F3FEF4F3FEF4F3FEF4F3FEF4F3
        FEF4F3FEF4F4FEF4F4FEF4F3FEF5F4FEF5F4FDF5F4FDF5F4FEF5F3FEF5F3FEF5
        F3FEF5F4FEF5F4FEF5F4FFF5F4FEF5F4FEF5F4FEF5F4FEF6F4FEF6F4FEF6F4FE
        F6F5FEF6F5FEF6F4FEF6F4FEF6F5FFF6F5FEF6F5FEF7F5FEF7F5FEF6F5FEF6F6
        FEF7F5FEF7F5FEF7F6FEF6F6FEF6F6FEF7F6FEF6F6FEF6F6FEF7F6FEF6F6FEF7
        F6FFF7F6FFF7F7FEF8F6FEF7F7FEF7F7FEF7F7FFF8F7FEF7F7FFF8F7FFF8F7FE
        F7F7FEF8F7FEF8F7FEF8F7FEF8F7FEF8F7FEF8F8FEF8F8FFF8F7FFF8F7FFF8F7
        FFF8F8FEF8F8FEF8F7FEF8F8FEF8F8FEF9F8FFF9F8FFF9F8FEF9F9FEF9F8FEF9
        F8FEF9F8FEF9F9FEFAF8FFF9F8FEF9F8FEF9F8FFF9F8FFFAF9FFF9F9FFF9F9FE
        FAFAFEFAF9FEFAF9FEF9F9FEF9F9FEFAF9FFFAFAFEFAF9FEFAF9FEFAFAFFFAFA
        FFFBFAFEFBFAFEFBFAFFFAFAFEFAFBFFFBFBFFFAFAFEFAFAFEFBFAFEFBFAFFFB
        FAFFFBFAFFFBFAFEFBFAFEFBFBFFFBFBFFFBFAFFFBFBFEFBFAFFFBFAFFFBFBFE
        FBFBFFFCFBFEFCFCFFFCFCFFFCFBFFFCFBFFFBFCFFFCFBFFFCFBFFFCFCFEFCFB
        FFFCFBFFFCFBFFFCFCFFFCFCFEFCFCFFFCFCFFFDFCFFFDFCFFFCFCFFFDFCFEFC
        FDFEFCFDFEFCFCFFFDFDFFFCFDFFFDFDFFFDFDFFFDFDFFFDFCFEFDFCFEFDFDFF
        FDFDFFFDFCFFFDFDFFFDFDFFFDFDFFFDFDFFFDFEFFFDFDFFFDFDFFFDFEFFFDFD
        FFFEFEFFFEFEFFFDFEFFFDFEFFFEFDFFFDFDFEFDFDFEFEFDFFFEFDFFFEFEFFFE
        FEFFFEFEFFFEFEFFFEFEFFFEFEFFFFFEFFFFFEFFFEFEFFFEFEFFFFFEFFFFFEFF
        FEFEFFFEFFFFFFFEFFFFFEFFFFFFFFFEFFFFFEFFFFFFFFFFFFFFFFFFFEFFFFFF
        FFFFFFFFFFFEFFFFFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
      object ToolBar1: TToolBar
        Left = 9
        Top = 0
        Width = 972
        Height = 25
        Caption = 'ToolBar1'
        TabOrder = 0
        Transparent = True
      end
    end
  end
  object ToolBarMain: TToolBar
    Left = 0
    Top = 0
    Width = 991
    Height = 41
    ButtonHeight = 36
    ButtonWidth = 65
    Caption = 'ToolBarMain'
    Images = dmFrm.ImageList1
    ShowCaptions = True
    TabOrder = 2
    Wrapable = False
    object ToolButton1: TToolButton
      Left = 0
      Top = 2
      Caption = 'ToolButton1'
      ImageIndex = 0
    end
    object Edit1: TEdit
      Left = 65
      Top = 2
      Width = 121
      Height = 36
      PasswordChar = '*'
      TabOrder = 0
      Text = 'Edit1'
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 376
    Width = 991
    Height = 84
    Align = alBottom
    Caption = 'PnlBtm'
    TabOrder = 3
    object mmosql: TMemo
      Left = 1
      Top = 1
      Width = 989
      Height = 82
      Align = alClient
      Lines.Strings = (
        'mmosql')
      TabOrder = 0
    end
  end
  object ADODataSet1: TADODataSet
    Connection = dmFrm.ADOConnection1
    AfterEdit = ADODataSet1AfterEdit
    BeforePost = ADODataSet1BeforePost
    AfterPost = ADODataSet1AfterPost
    BeforeDelete = ADODataSet1BeforeDelete
    OnNewRecord = ADODataSet1NewRecord
    Parameters = <>
    Left = 72
    Top = 248
  end
  object DataSource1: TDataSource
    DataSet = ADODataSet1
    Left = 40
    Top = 245
  end
  object mmmain: TMainMenu
    Left = 104
    Top = 248
    object s1: TMenuItem
      Caption = 'sdffds'
      object ui1: TMenuItem
        Caption = 'ui'
      end
      object yu1: TMenuItem
        Caption = 'yu'
      end
    end
  end
  object ActionList1: TActionList
    Images = dmFrm.ImageList1
    Left = 8
    Top = 240
    object actAddAction: TAction
      Caption = #26032#22686
      ImageIndex = 7
      OnExecute = actAddActionExecute
    end
    object actCopyAction: TAction
      Caption = #22797#21046
      ImageIndex = 1
      OnExecute = actCopyActionExecute
    end
    object actEditAction: TAction
      Caption = #20462#25913
      ImageIndex = 21
      OnExecute = actEditActionExecute
    end
    object actDeleteAction: TAction
      Caption = #21024#38500
      ImageIndex = 2
      OnExecute = actDeleteActionExecute
    end
    object actSaveAction: TAction
      Caption = #20445#23384
      ImageIndex = 9
      OnExecute = actSaveActionExecute
    end
    object actCancelAction: TAction
      Caption = #25918#24323
      ImageIndex = 4
      OnExecute = actCancelActionExecute
    end
    object actFirstAction: TAction
      Caption = #39318#24352
      ImageIndex = 25
      OnExecute = actFirstActionExecute
    end
    object actPriorAction: TAction
      Caption = #19978#19968#24352
      ImageIndex = 22
      OnExecute = actPriorActionExecute
    end
    object actNextAction: TAction
      Caption = #19979#19968#24352
      ImageIndex = 24
      OnExecute = actNextActionExecute
    end
    object actLastAction: TAction
      Caption = #26411#24352
      ImageIndex = 23
      OnExecute = actLastActionExecute
    end
    object actCloseAction: TAction
      Caption = #20851#38381
      ImageIndex = 8
      OnExecute = actCloseActionExecute
    end
    object actPrintAction: TAction
      Caption = #25171#21360
      ImageIndex = 13
    end
    object actSetCaptionAction: TAction
      Caption = #26356#26032#26631#39064
      ImageIndex = 28
    end
    object actInputTaxAmt: TAction
      Caption = #31246#37329
      ImageIndex = 29
    end
    object SelectMenu: TAction
      Caption = 'SelectMenu'
      OnExecute = SelectMenuExecute
    end
    object actSql: TAction
      Caption = 'Sql'
      ImageIndex = 42
      OnExecute = actSqlExecute
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
    Left = 736
    Top = 41
  end
end
