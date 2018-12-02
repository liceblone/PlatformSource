object FrmTrigger: TFrmTrigger
  Left = 216
  Top = 278
  Width = 562
  Height = 343
  Caption = 'FrmTrigger'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object pgc1: TPageControl
    Left = 0
    Top = 32
    Width = 554
    Height = 284
    ActivePage = ts1
    Align = alBottom
    TabOrder = 0
    object ts1: TTabSheet
      Caption = 'after saveT207'
      object lbl1: TLabel
        Left = 16
        Top = 16
        Width = 22
        Height = 13
        Caption = 'frmid'
        FocusControl = dbedt1
      end
      object lbl2: TLabel
        Left = 16
        Top = 56
        Width = 48
        Height = 13
        Caption = 'Procname'
        FocusControl = dbedt2
      end
      object lbl3: TLabel
        Left = 16
        Top = 96
        Width = 45
        Height = 13
        Caption = 'sysPrama'
        FocusControl = dbedt3
      end
      object lbl4: TLabel
        Left = 16
        Top = 136
        Width = 52
        Height = 13
        Caption = 'UserPrama'
        FocusControl = dbedt4
      end
      object lbl5: TLabel
        Left = 16
        Top = 176
        Width = 31
        Height = 13
        Caption = 'errHint'
        FocusControl = dbedt5
      end
      object dbedt1: TDBEdit
        Left = 16
        Top = 32
        Width = 200
        Height = 21
        DataField = 'frmid'
        DataSource = dsdsT207
        TabOrder = 0
      end
      object dbedt2: TDBEdit
        Left = 16
        Top = 72
        Width = 200
        Height = 21
        DataField = 'Procname'
        DataSource = dsdsT207
        TabOrder = 1
      end
      object dbedt3: TDBEdit
        Left = 16
        Top = 112
        Width = 200
        Height = 21
        DataField = 'sysPrama'
        DataSource = dsdsT207
        TabOrder = 2
      end
      object dbedt4: TDBEdit
        Left = 16
        Top = 152
        Width = 200
        Height = 21
        DataField = 'UserPrama'
        DataSource = dsdsT207
        TabOrder = 3
      end
      object dbedt5: TDBEdit
        Left = 16
        Top = 192
        Width = 200
        Height = 21
        DataField = 'errHint'
        DataSource = dsdsT207
        TabOrder = 4
      end
      object dbnvgr1: TDBNavigator
        Left = 232
        Top = 120
        Width = 240
        Height = 25
        DataSource = dsdsT207
        TabOrder = 5
      end
      object btnOPenT207: TButton
        Left = 232
        Top = 160
        Width = 97
        Height = 25
        Caption = 'btnOPenT207'
        TabOrder = 6
        OnClick = btnOPenT207Click
      end
    end
  end
  object edtFrmID: TEdit
    Left = 48
    Top = 0
    Width = 121
    Height = 21
    TabOrder = 1
    Text = 'edtFrmID'
  end
  object dsT207: TADODataSet
    AfterInsert = dsT207AfterInsert
    CommandText = 'select *From T207  where frmid=:frmid'#13#10
    Parameters = <
      item
        Name = 'f01'
        Size = -1
        Value = Null
      end>
    Left = 8
    Top = 24
    object dsT207frmid: TStringField
      FieldName = 'frmid'
    end
    object dsT207Procname: TStringField
      FieldName = 'Procname'
      Size = 200
    end
    object dsT207sysPrama: TStringField
      FieldName = 'sysPrama'
      Size = 200
    end
    object dsT207UserPrama: TStringField
      FieldName = 'UserPrama'
      Size = 200
    end
    object dsT207errHint: TStringField
      FieldName = 'errHint'
      Size = 200
    end
  end
  object dsdsT207: TDataSource
    DataSet = dsT207
    Left = 65528
    Top = 24
  end
end
