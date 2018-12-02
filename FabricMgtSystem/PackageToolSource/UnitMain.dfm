object FrmMain: TFrmMain
  Left = 838
  Top = 133
  Width = 1037
  Height = 619
  Anchors = [akLeft, akTop, akRight, akBottom]
  Caption = 'FrmMain'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  OnCreate = FormCreate
  DesignSize = (
    1029
    592)
  PixelsPerInch = 96
  TextHeight = 13
  object Label2: TLabel
    Left = 8
    Top = 0
    Width = 24
    Height = 13
    Caption = #29256#26412
  end
  object PageControl2: TPageControl
    Left = 0
    Top = 32
    Width = 1029
    Height = 560
    ActivePage = tsDettachFiles
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 0
    object tsTabCreateScript: TTabSheet
      Caption = #20135#29983#21319#32423#33050#26412
      DesignSize = (
        1021
        532)
      object PageControl1: TPageControl
        Left = 200
        Top = 0
        Width = 825
        Height = 537
        ActivePage = TabSheet4
        Anchors = [akLeft, akTop, akRight, akBottom]
        TabOrder = 0
        object TabSheet1: TTabSheet
          Caption = #23545#35937#33050#26412'  '
          DesignSize = (
            817
            509)
          object MmScript: TMemo
            Left = 0
            Top = 40
            Width = 817
            Height = 469
            Anchors = [akLeft, akTop, akRight, akBottom]
            ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
            ScrollBars = ssBoth
            TabOrder = 0
          end
          object BtnCreateProcScript: TButton
            Left = 0
            Top = 8
            Width = 113
            Height = 25
            Caption = 'BtnCreateProcScript'
            TabOrder = 1
            OnClick = BtnCreateProcScriptClick
          end
        end
        object TabSheet2: TTabSheet
          Caption = #26032#22686#23383#27573#33050#26412
          ImageIndex = 1
          DesignSize = (
            817
            509)
          object BtnLstFields: TButton
            Left = 16
            Top = 4
            Width = 75
            Height = 25
            Anchors = [akLeft]
            Caption = 'BtnLstFields'
            TabOrder = 0
            OnClick = BtnLstFieldsClick
          end
          object BtnFldsTablesScript: TButton
            Left = 96
            Top = 4
            Width = 129
            Height = 25
            Anchors = [akLeft]
            Caption = 'BtnFldsTablesScript'
            TabOrder = 1
            OnClick = BtnFldsTablesScriptClick
          end
          object GroupBox1: TGroupBox
            Left = 0
            Top = 32
            Width = 817
            Height = 457
            Anchors = [akLeft, akTop, akRight, akBottom]
            Caption = 'GroupBox1'
            TabOrder = 2
            object Splitter1: TSplitter
              Left = 621
              Top = 15
              Height = 440
              Align = alRight
            end
            object GridFlds: TDBGrid
              Left = 2
              Top = 15
              Width = 619
              Height = 440
              Align = alClient
              DataSource = DsFlds
              ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
              TabOrder = 0
              TitleFont.Charset = DEFAULT_CHARSET
              TitleFont.Color = clWindowText
              TitleFont.Height = -11
              TitleFont.Name = 'MS Sans Serif'
              TitleFont.Style = []
            end
            object MmTablesAndFields: TMemo
              Left = 624
              Top = 15
              Width = 191
              Height = 440
              Align = alRight
              ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
              ScrollBars = ssBoth
              TabOrder = 1
            end
          end
        end
        object TabSheet3: TTabSheet
          Caption = #21024#38500#30340#23383#27573
          ImageIndex = 2
          DesignSize = (
            817
            509)
          object mmDeletedFlds: TMemo
            Left = 8
            Top = 32
            Width = 809
            Height = 473
            Anchors = [akLeft, akTop, akRight, akBottom]
            ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
            Lines.Strings = (
              'select   * from T_DataUpdateLog order by Fcreatetime desc ')
            TabOrder = 0
          end
          object BtnAllDeletedFields: TButton
            Left = 176
            Top = 0
            Width = 145
            Height = 25
            Caption = 'BtnAllDeletedFields'
            TabOrder = 1
            OnClick = BtnAllDeletedFieldsClick
          end
        end
        object TabSheet7: TTabSheet
          Caption = #21333#21495
          ImageIndex = 3
          DesignSize = (
            817
            509)
          object MmSysID: TMemo
            Left = 0
            Top = 40
            Width = 809
            Height = 457
            Anchors = [akLeft, akTop, akRight, akBottom]
            ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
            Lines.Strings = (
              'MmSysID')
            ScrollBars = ssBoth
            TabOrder = 0
          end
          object BtnGetSysIDScript: TButton
            Left = 32
            Top = 8
            Width = 161
            Height = 25
            Caption = #21333#21495#35774#32622#33050#26412
            TabOrder = 1
            OnClick = BtnGetSysIDScriptClick
          end
        end
        object TabSheet4: TTabSheet
          Caption = #25480#26435#31383#20307
          ImageIndex = 4
          object MmAuthForms: TMemo
            Left = 0
            Top = 57
            Width = 817
            Height = 452
            Align = alClient
            Lines.Strings = (
              'MmAuthForms')
            TabOrder = 0
          end
          object Panel1: TPanel
            Left = 0
            Top = 0
            Width = 817
            Height = 57
            Align = alTop
            TabOrder = 1
            object BtnAuthForms: TButton
              Left = 24
              Top = 16
              Width = 75
              Height = 25
              Caption = #33050#26412
              TabOrder = 0
              OnClick = BtnAuthFormsClick
            end
          end
        end
      end
      object DBGridObj: TDBGrid
        Left = 0
        Top = 24
        Width = 193
        Height = 441
        Anchors = [akLeft, akTop, akBottom]
        DataSource = DataSource1
        ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
        ReadOnly = True
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
      end
      object BtnLstAllChgedObj: TButton
        Left = 0
        Top = 474
        Width = 193
        Height = 25
        Anchors = [akLeft, akBottom]
        Caption = 'BtnLstAllChgedObj'
        TabOrder = 2
        OnClick = BtnLstAllChgedObjClick
      end
      object BtnCreateFile: TButton
        Left = 0
        Top = 504
        Width = 193
        Height = 25
        Anchors = [akLeft, akBottom]
        Caption = 'BtnCreateFile'
        TabOrder = 3
        OnClick = BtnCreateFileClick
      end
    end
    object tsDettachFiles: TTabSheet
      Caption = #20998#31163#26412#22320#31995#32479#25968#25454#24211
      ImageIndex = 1
      object Label1: TLabel
        Left = 8
        Top = 96
        Width = 54
        Height = 13
        Caption = 'sys db path'
      end
      object Label3: TLabel
        Left = 16
        Top = 120
        Width = 45
        Height = 13
        Caption = 'password'
      end
      object Label5: TLabel
        Left = 32
        Top = 72
        Width = 38
        Height = 13
        Caption = 'user db '
      end
      object BtnDetattach: TButton
        Left = 144
        Top = 152
        Width = 121
        Height = 25
        Caption = 'Create Upgrade Package'
        TabOrder = 0
        OnClick = BtnDetattachClick
      end
      object edtSysDbPath: TEdit
        Left = 72
        Top = 96
        Width = 385
        Height = 21
        ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
        TabOrder = 1
        Text = 'E:\'#35199#26381#31649#29702#31995#32479'\BusiSuit\SysData'
      end
      object FlstPackage: TFileListBox
        Left = 352
        Top = 280
        Width = 193
        Height = 185
        ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
        ItemHeight = 16
        ParentShowHint = False
        ShowGlyphs = True
        ShowHint = False
        TabOrder = 2
      end
      object edtPassword: TEdit
        Left = 72
        Top = 120
        Width = 121
        Height = 21
        ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
        TabOrder = 3
        Text = '1'
      end
      object BtnAttach: TButton
        Left = 32
        Top = 360
        Width = 129
        Height = 25
        Caption = 'BtnAttach'
        TabOrder = 4
        Visible = False
        OnClick = BtnAttachClick
      end
      object chkCompress: TCheckBox
        Left = 72
        Top = 152
        Width = 65
        Height = 17
        Caption = #21387#32553
        TabOrder = 5
      end
      object BtnCompressExe: TButton
        Left = 120
        Top = 16
        Width = 153
        Height = 25
        Caption = 'BtnCompressExe'
        TabOrder = 6
        OnClick = BtnCompressExeClick
      end
      object edtUserDBPath: TEdit
        Left = 72
        Top = 72
        Width = 385
        Height = 21
        ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
        TabOrder = 7
        Text = 'E:\'#35199#26381#31649#29702#31995#32479'\BusiSuit\UserData'
      end
      object ChkBrandNewInstall: TCheckBox
        Left = 24
        Top = 20
        Width = 97
        Height = 17
        Caption = #20840#26032#23433#35013
        TabOrder = 8
      end
      object btnCreateWebErp: TButton
        Left = 280
        Top = 152
        Width = 121
        Height = 25
        Caption = 'btnCreateWebErp'
        TabOrder = 9
        OnClick = btnCreateWebErpClick
      end
    end
    object TabSheet6: TTabSheet
      Caption = #35299#21387#65292#21319#32423
      ImageIndex = 2
      object Label4: TLabel
        Left = 96
        Top = 29
        Width = 60
        Height = 13
        Caption = #23433#35013#30446#24405#65306
      end
      object edtInstallPath: TEdit
        Left = 160
        Top = 24
        Width = 401
        Height = 21
        ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
        TabOrder = 0
        Text = 'D:\'#40077#26031#31649#29702#31995#32479
      end
      object GroupBox2: TGroupBox
        Left = 360
        Top = 72
        Width = 201
        Height = 281
        Caption = #21319#32423
        TabOrder = 1
        object BtnBackUpUserConfig: TButton
          Left = 8
          Top = 56
          Width = 108
          Height = 25
          Caption = #22791#20221#29992#25143#35774#32622
          TabOrder = 0
        end
        object BtnUsersysDBDetattach: TButton
          Left = 8
          Top = 88
          Width = 108
          Height = 25
          Caption = #25335#36125#25991#20214
          TabOrder = 1
          OnClick = BtnUsersysDBDetattachClick
        end
        object BtnRenameDir: TButton
          Left = 136
          Top = 104
          Width = 97
          Height = 25
          Caption = 'BtnRenameDir'
          TabOrder = 2
          Visible = False
          OnClick = BtnRenameDirClick
        end
        object BtnCopyFile: TButton
          Left = 8
          Top = 120
          Width = 132
          Height = 25
          Caption = #35206#30422#25968#25454#24211
          TabOrder = 3
          OnClick = BtnCopyFileClick
        end
        object BtnAttachSYSDataBase: TButton
          Left = 8
          Top = 152
          Width = 132
          Height = 25
          Caption = #38468#21152#26032#29256#37197#32622#25968#25454
          TabOrder = 4
          OnClick = BtnAttachSYSDataBaseClick
        end
        object BtnAttachOldSys: TButton
          Left = 152
          Top = 160
          Width = 97
          Height = 25
          Caption = 'BtnAttachOldSys'
          TabOrder = 5
          Visible = False
          OnClick = BtnAttachOldSysClick
        end
        object BtnRunInitialScript: TButton
          Left = 8
          Top = 184
          Width = 129
          Height = 25
          Caption = #36816#34892#21021#22987#21270#33050#26412
          TabOrder = 6
          OnClick = BtnRunInitialScriptClick
        end
        object BtnRunScript: TButton
          Left = 8
          Top = 216
          Width = 132
          Height = 25
          Caption = #36816#34892#21319#32423#33050#26412
          TabOrder = 7
          OnClick = BtnRunScriptClick
        end
        object BtnRestoreSysConfig: TButton
          Left = 8
          Top = 248
          Width = 132
          Height = 25
          Caption = #24674#22797#29992#25143#37197#32622#20449#24687
          TabOrder = 8
          OnClick = BtnRestoreSysConfigClick
        end
        object BtnUnCompress: TButton
          Left = 8
          Top = 24
          Width = 84
          Height = 25
          Caption = #35299#21387#21319#32423#21253
          TabOrder = 9
          OnClick = BtnUnCompressClick
        end
      end
      object GroupBox3: TGroupBox
        Left = 0
        Top = 436
        Width = 1021
        Height = 96
        Align = alBottom
        Caption = #20840#26032#23433#35013
        TabOrder = 2
        object BtnCreateVirtual: TButton
          Left = 40
          Top = 32
          Width = 153
          Height = 25
          Caption = #24314#31435#29992#20110#26356#26032#30340#32593#31449
          TabOrder = 0
          OnClick = BtnCreateVirtualClick
        end
        object BtnAttachUserAndSysDataBase: TButton
          Left = 216
          Top = 32
          Width = 161
          Height = 25
          Caption = #38468#21152#31995#32479#21644#29992#25143#25968#25454#24211
          TabOrder = 1
          OnClick = BtnAttachUserAndSysDataBaseClick
        end
      end
    end
  end
  object edtVersion: TEdit
    Left = 48
    Top = 0
    Width = 121
    Height = 21
    ImeName = #19975#33021#20116#31508'EXE'#22806#25346#29256
    TabOrder = 1
    Text = '1.0.0.4'
  end
  object DsFlds: TDataSource
    DataSet = AdoDsFlds
    Left = 300
    Top = 32
  end
  object AdoDsFlds: TADODataSet
    Connection = dmfrm.SysConnection1
    Parameters = <>
    Left = 324
    Top = 32
  end
  object ADOObj: TADOQuery
    Connection = dmfrm.UserCnn
    Parameters = <>
    Left = 120
    Top = 256
  end
  object DataSource1: TDataSource
    DataSet = ADOObj
    Left = 88
    Top = 256
  end
  object VCLZip1: TVCLZip
    Left = 408
    Top = 16
  end
  object VCLUnZip1: TVCLUnZip
    Left = 464
    Top = 16
  end
end
