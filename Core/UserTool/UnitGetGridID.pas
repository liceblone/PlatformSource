unit UnitGetGridID;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls,datamodule, DB, ADODB, StdCtrls, DBCtrls, Mask, ToolWin;

type
  TfrmGetGridID = class(TForm)
    pgc1: TPageControl;
    ts1: TTabSheet;
    ts2: TTabSheet;
    dsT201: TADODataSet;
    dsT504: TADODataSet;
    dsT504F01: TAutoIncField;
    dsT504F02: TStringField;
    dsT504F03: TIntegerField;
    dsT504F04: TBooleanField;
    dsT504F05: TBooleanField;
    dsT504F06: TStringField;
    dsT504F07: TIntegerField;
    dsT504F08: TBooleanField;
    dsT504F09: TBooleanField;
    dsT504F10: TBooleanField;
    dsT504F11: TBooleanField;
    dsT504F12: TBooleanField;
    dsT504F13: TBooleanField;
    dsT201F01: TAutoIncField;
    dsT201F02: TStringField;
    dsT201F03: TStringField;
    dsT201F04: TIntegerField;
    dsT201F05: TIntegerField;
    dsT201F06: TStringField;
    dsT201F07: TStringField;
    dsT201F08: TBooleanField;
    dsT201F09: TIntegerField;
    dsT201F10: TIntegerField;
    dsT201F11: TIntegerField;
    dsT201F12: TIntegerField;
    dsT201F13: TStringField;
    dsT201F14: TIntegerField;
    dsT201F15: TIntegerField;
    lbl6: TLabel;
    dbedt6: TDBEdit;
    ds1: TDataSource;
    lbl7: TLabel;
    dbedt7: TDBEdit;
    lbl8: TLabel;
    dbedt8: TDBEdit;
    lbl9: TLabel;
    dbedt9: TDBEdit;
    lbl10: TLabel;
    dbedt10: TDBEdit;
    lbl11: TLabel;
    dbedt11: TDBEdit;
    lbl12: TLabel;
    dbedt12: TDBEdit;
    dbchk9: TDBCheckBox;
    lbl13: TLabel;
    dbedt13: TDBEdit;
    lbl14: TLabel;
    dbedt14: TDBEdit;
    lbl15: TLabel;
    dbedt15: TDBEdit;
    lbl16: TLabel;
    dbedt16: TDBEdit;
    lbl17: TLabel;
    dbedt17: TDBEdit;
    lbl18: TLabel;
    dbedt18: TDBEdit;
    lbl19: TLabel;
    dbedt19: TDBEdit;
    lbl1: TLabel;
    dbedt1: TDBEdit;
    ds2: TDataSource;
    lbl2: TLabel;
    dbedt2: TDBEdit;
    lbl3: TLabel;
    dbedt3: TDBEdit;
    dbchk1: TDBCheckBox;
    dbchk2: TDBCheckBox;
    lbl4: TLabel;
    dbedt4: TDBEdit;
    lbl5: TLabel;
    dbedt5: TDBEdit;
    dbchk3: TDBCheckBox;
    dbchk4: TDBCheckBox;
    dbchk5: TDBCheckBox;
    dbchk6: TDBCheckBox;
    dbchk7: TDBCheckBox;
    dbchk8: TDBCheckBox;
    tlb1: TToolBar;
    btnopen: TToolButton;
    btnadd: TButton;
    btncancel: TButton;
    btndelete: TButton;
    btnsave: TButton;
    lbl20: TLabel;
    tsGetTreeViewID: TTabSheet;
    procedure btnopenClick(Sender: TObject);
    procedure btnaddClick(Sender: TObject);
    procedure btncancelClick(Sender: TObject);
    procedure btndeleteClick(Sender: TObject);
    procedure btnsaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    dlgridid,mtdatasetid:string;
    constructor create(owner:Twincontrol;dlgridid:string);//override;
  end;

var
  frmGetGridID: TfrmGetGridID;

implementation

{$R *.dfm}

procedure TfrmGetGridID.btnopenClick(Sender: TObject);
begin
    case pgc1.TabIndex of
    0:   dsT504.Open ;
    1:   dsT201.Open ;
    end;

end;

procedure TfrmGetGridID.btnaddClick(Sender: TObject);
begin
self.btnopenClick (sender);
    case pgc1.TabIndex of
    0:   dsT504.Append ;
    1:   dsT201.Append ;
    end;

end;

procedure TfrmGetGridID.btncancelClick(Sender: TObject);
begin
    case pgc1.TabIndex of
    0:   dsT504.Append ;
    1:   dsT201.Append ;
    end;
end;

procedure TfrmGetGridID.btndeleteClick(Sender: TObject);
begin
    case pgc1.TabIndex of
    0:   dsT504.Delete  ;
    1:   dsT201.Delete ;
    end;
end;

procedure TfrmGetGridID.btnsaveClick(Sender: TObject);
begin
    case pgc1.TabIndex of
    0:   dsT504.Post   ;
    1:   begin
              dsT201.Post  ;
              dbedt3.Text :=dbedt6.Text ;

         end;
    end;

end;

procedure TfrmGetGridID.FormCreate(Sender: TObject);
begin
 dsT504.Connection :=FhlKnl1.Connection ;
 dsT201.Connection :=FhlKnl1.Connection ;

 dsT504.CommandText :=   'select * from T504 where f01='+self.dlgridid ;
 dsT504.Open ;
 self.mtdatasetid :=dsT504.Fieldbyname ('f03').asstring;
 dsT201.CommandText :='select * from t201 where f01='+quotedstr(self.mtdatasetid );
//    dlgridid,mtdatasetid:string;

end;

constructor TfrmGetGridID.create(owner: Twincontrol; dlgridid:string);
begin
  inherited create(owner);
  self.dlgridid :=dlgridid;


end;

end.
