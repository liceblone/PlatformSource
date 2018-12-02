unit UnitGetGridIDTreeID;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls,datamodule, DB, ADODB, StdCtrls, DBCtrls, Mask, ToolWin,
  ExtCtrls;

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
    dsGetTreeIDT507: TADODataSet;
    dsGetTreeIDT507F01: TIntegerField;
    dsGetTreeIDT507F02: TStringField;
    dsGetTreeIDT507F03: TStringField;
    dsGetTreeIDT507F04: TBooleanField;
    dsGetTreeIDT507F05: TStringField;
    dsGetTreeIDT507F06: TIntegerField;
    dsGetTreeIDT507F07: TIntegerField;
    dsGetTreeIDT507F08: TStringField;
    dsGetTreeIDT507F09: TStringField;
    dsGetTreeIDT507F10: TIntegerField;
    lbl21: TLabel;
    dbedt20: TDBEdit;
    ds3: TDataSource;
    lbl22: TLabel;
    dbedt21: TDBEdit;
    lbl23: TLabel;
    dbedt22: TDBEdit;
    dbchk10: TDBCheckBox;
    lbl24: TLabel;
    dbedt23: TDBEdit;
    lbl25: TLabel;
    dbedt24: TDBEdit;
    lbl26: TLabel;
    dbedt25: TDBEdit;
    lbl27: TLabel;
    dbedt26: TDBEdit;
    lbl28: TLabel;
    dbedt27: TDBEdit;
    lbl29: TLabel;
    dbedt28: TDBEdit;
    edtmtdatasetID: TEdit;
    lbl30: TLabel;
    cbbImageID: TComboBoxEx;
    edtgridID: TEdit;
    ts3: TTabSheet;
    dsT402: TADODataSet;
    dsT402F01: TIntegerField;
    dsT402F02: TStringField;
    dsT402F03: TStringField;
    dsT402F04: TStringField;
    dsT402F05: TStringField;
    lbl31: TLabel;
    dbedt29: TDBEdit;
    ds4: TDataSource;
    lbl32: TLabel;
    lbl33: TLabel;
    dbedt31: TDBEdit;
    lbl34: TLabel;
    dbedt32: TDBEdit;
    lbl35: TLabel;
    dbedt33: TDBEdit;
    ts4: TTabSheet;
    dsT202: TADODataSet;
    lbl36: TLabel;
    dbedt34: TDBEdit;
    ds6: TDataSource;
    lbl37: TLabel;
    dbedt35: TDBEdit;
    lbl38: TLabel;
    dbedt36: TDBEdit;
    lbl39: TLabel;
    dbchk11: TDBCheckBox;
    lbl40: TLabel;
    dbedt38: TDBEdit;
    dsT202F01: TAutoIncField;
    dsT202F02: TIntegerField;
    dsT202F03: TIntegerField;
    dsT202F04: TStringField;
    dsT202F05: TBooleanField;
    dsT202F06: TIntegerField;
    dsT202F07: TStringField;
    lbl41: TLabel;
    dbedt39: TDBEdit;
    lbl42: TLabel;
    dbcbb1: TDBComboBox;
    ts5: TTabSheet;
    dsT102: TADODataSet;
    dsT102F01: TAutoIncField;
    dsT102F02: TStringField;
    dsT102F03: TIntegerField;
    dsT102F04: TIntegerField;
    dsT102F05: TStringField;
    dsT102F06: TIntegerField;
    dsT102F07: TStringField;
    dsT102F08a: TIntegerField;
    dsT102F09: TStringField;
    dsT102F10: TStringField;
    dsT102F11: TStringField;
    dsT102F12: TBooleanField;
    dsT102F13: TBooleanField;
    dsT102F14: TIntegerField;
    dsT102F15: TStringField;
    dsT102F16: TStringField;
    dsT102F17: TStringField;
    dsT102F18: TStringField;
    dsT102F19: TStringField;
    lbl43: TLabel;
    dbedt37: TDBEdit;
    ds5: TDataSource;
    lbl44: TLabel;
    dbedt40: TDBEdit;
    lbl45: TLabel;
    dbedt41: TDBEdit;
    lbl46: TLabel;
    dbedt42: TDBEdit;
    lbl47: TLabel;
    dbedt43: TDBEdit;
    lbl48: TLabel;
    dbedt44: TDBEdit;
    lbl49: TLabel;
    dbedt45: TDBEdit;
    lbl50: TLabel;
    dbedt46: TDBEdit;
    lbl51: TLabel;
    dbedt47: TDBEdit;
    lbl52: TLabel;
    dbedt48: TDBEdit;
    lbl53: TLabel;
    dbedt49: TDBEdit;
    lbl54: TLabel;
    dbedt50: TDBEdit;
    dbchk12: TDBCheckBox;
    dbchk13: TDBCheckBox;
    lbl55: TLabel;
    dbedt51: TDBEdit;
    lbl56: TLabel;
    dbedt52: TDBEdit;
    lbl57: TLabel;
    dbedt53: TDBEdit;
    lbl58: TLabel;
    dbedt54: TDBEdit;
    lbl59: TLabel;
    dbedt55: TDBEdit;
    grp1: TGroupBox;
    lstFields: TListBox;
    ts6: TTabSheet;
    lbl60: TLabel;
    dsT204: TADODataSet;
    dsT204F01: TIntegerField;
    dsT204F02: TStringField;
    dsT204F05: TStringField;
    dsT204F06: TIntegerField;
    dsT204F09: TStringField;
    dsT204F10: TStringField;
    dsT204F11: TStringField;
    dsT204F12: TStringField;
    dsT204F13: TStringField;
    dsT204F14: TStringField;
    dsT204F15: TStringField;
    dsT204F17: TStringField;
    dsT204F18: TStringField;
    dsT204F19: TStringField;
    lbl61: TLabel;
    dbedt56: TDBEdit;
    ds7: TDataSource;
    lbl62: TLabel;
    dbedt57: TDBEdit;
    lbl63: TLabel;
    dbedt58: TDBEdit;
    lbl64: TLabel;
    dbedt59: TDBEdit;
    lbl65: TLabel;
    dbedt60: TDBEdit;
    lbl66: TLabel;
    dbedt61: TDBEdit;
    lbl67: TLabel;
    dbedt62: TDBEdit;
    lbl68: TLabel;
    dbedt63: TDBEdit;
    lbl69: TLabel;
    lbl70: TLabel;
    dbedt65: TDBEdit;
    lbl71: TLabel;
    dbedt66: TDBEdit;
    lbl72: TLabel;
    dbedt67: TDBEdit;
    lbl73: TLabel;
    dbedt68: TDBEdit;
    lbl74: TLabel;
    dbedt69: TDBEdit;
    ts7: TTabSheet;
    dsT203: TADODataSet;
    dsT203F01: TIntegerField;
    dsT203F02: TStringField;
    dsT203F03: TStringField;
    dsT203F04: TStringField;
    dsT203F05: TStringField;
    dsT203F06: TStringField;
    dsT203F07: TStringField;
    dsT203F08: TStringField;
    lbl75: TLabel;
    dbedt70: TDBEdit;
    ds8: TDataSource;
    lbl76: TLabel;
    dbedt71: TDBEdit;
    lbl77: TLabel;
    dbedt72: TDBEdit;
    lbl79: TLabel;
    dbedt74: TDBEdit;
    lbl80: TLabel;
    dbedt75: TDBEdit;
    lbl81: TLabel;
    dbedt76: TDBEdit;
    lbl82: TLabel;
    dbedt77: TDBEdit;
    lblfieldname: TLabel;
    lbl83: TLabel;
    dbedt78: TDBEdit;
    ts8: TTabSheet;
    dsT205: TADODataSet;
    dsT205F01: TIntegerField;
    dsT205F02: TStringField;
    dsT205F03: TStringField;
    dsT205F04: TStringField;
    dsT205F05: TStringField;
    dsT205F06: TStringField;
    lbl84: TLabel;
    dbedt79: TDBEdit;
    dsdsT205: TDataSource;
    lbl85: TLabel;
    dbedt80: TDBEdit;
    lbl87: TLabel;
    dbedt82: TDBEdit;
    lbl88: TLabel;
    dbedt83: TDBEdit;
    lbl89: TLabel;
    dbedt84: TDBEdit;
    btnT205: TButton;
    dbnvgr1: TDBNavigator;
    dbnvgr2: TDBNavigator;
    dbedt85: TDBEdit;
    dbedt86: TDBEdit;
    lstfieldtype: TListBox;
    lbl90: TLabel;
    lbl91: TLabel;
    dsT202F08: TStringField;
    dsT202F09: TStringField;
    lbl92: TLabel;
    dbedt87: TDBEdit;
    lbl93: TLabel;
    dbedt88: TDBEdit;
    dbnvgr3: TDBNavigator;
    lbl94: TLabel;
    lbl95: TLabel;
    dbedt89: TDBEdit;
    lbl96: TLabel;
    lbl97: TLabel;
    dsT201F16: TStringField;
    edtTreeView: TEdit;
    DBMemo1: TDBMemo;
    DBMemo2: TDBMemo;
    DBMemo3: TDBMemo;
    Label4: TLabel;
    DBMemo4: TDBMemo;
    Label5: TLabel;
    Label12: TLabel;
    DBComboBox1: TDBComboBox;
    dsT201f18: TStringField;
    dbmmoF02: TDBMemo;
    intgrfldT504F17: TIntegerField;
    Label1: TLabel;
    dbedt8: TDBEdit;
    procedure btnopenClick(Sender: TObject);
    procedure btnaddClick(Sender: TObject);
    procedure btncancelClick(Sender: TObject);
    procedure btndeleteClick(Sender: TObject);
    procedure btnsaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cbbImageIDClick(Sender: TObject);
    procedure dbedt24Change(Sender: TObject);
    procedure dbedt3Change(Sender: TObject);
    procedure GetExistFields(listbox:TlistBox;datasetID:string );
    procedure lstFieldsClick(Sender: TObject);
    procedure btnT205Click(Sender: TObject);
    procedure dbedt85Change(Sender: TObject);
    procedure dbedt89Exit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    dlgridid,mtdatasetid,treeviewid:string;

  end;

var
  frmGetGridID: TfrmGetGridID;

implementation

{$R *.dfm}

procedure TfrmGetGridID.btnopenClick(Sender: TObject);
begin
    case pgc1.TabIndex of
    0:
        begin
             if self.dlgridid<>'' then
                fhlknl1.Ds_OpenDataSet(dsT504,self.dlgridid )    ;
             if self.edtgridID.text<>''   then
                fhlknl1.Ds_OpenDataSet(dsT504,self.edtgridID.Text  )
             else fhlknl1.Ds_OpenDataSet(dsT504,'0') ;
        end;
    1:   begin
            if self.mtdatasetid<>''
            then fhlknl1.Ds_OpenDataSet(dsT201,self.mtdatasetid )  ;

            if edtmtdatasetID.Text ='' then
               edtmtdatasetID.Text:='1';

              fhlknl1.Ds_OpenDataSet(dsT201, edtmtdatasetID.Text );
              GetExistFields(lstFields,edtmtdatasetID.Text);
              fhlknl1.Ds_OpenDataSet(dsT204, edtmtdatasetID.Text );    //befor post
              fhlknl1.Ds_OpenDataSet(dsT203, edtmtdatasetID.Text );    //befor delete


               fhlknl1.Ds_OpenDataSet(dsT402, edtmtdatasetID.Text  );


         end;
    2:   if self.treeviewid<>'' then
        fhlknl1.Ds_OpenDataSet(dsGetTreeIDT507,self.treeviewid  )
          else          fhlknl1.Ds_OpenDataSet(dsGetTreeIDT507,edtTreeView.Text   );

    3:   if self.edtmtdatasetID.Text <>'' then          fhlknl1.Ds_OpenDataSet(dsT402,edtmtdatasetID.Text   )         else          fhlknl1.Ds_OpenDataSet(dsT402,'628'  );


    end;

end;

procedure TfrmGetGridID.btnaddClick(Sender: TObject);
begin
self.btnopenClick (sender);
    case pgc1.TabIndex of
    0:   dsT504.Append ;
    1:   BEGIN
          dsT201.Append ;
          dbedt10.Text :='1';
          dbchk9.Checked :=TRUE;
          dbedt13.Text :='-1';
          dbedt14.Text :='-1';
          dbedt15.Text :='-1';
          dbedt16.Text :='-1';
         END;
    2:   begin
             dsGetTreeIDT507.Append ;
             dsGetTreeIDT507.FieldByName('f05').AsString :='全部';
             dsGetTreeIDT507.FieldByName('f06').AsString :='6';
             dsGetTreeIDT507.FieldByName('f10').AsString :='200';

         end;
    4:   dsT202.Append ;
    5:   dsT102.Append ;

    6:       begin
            dsT204.append;
            dsT204.FieldByName ('f01').Value := edtmtdatasetID.Text;
            end;
     7:begin
          dsT203.Append ;
          dsT203.FieldByName ('f01').Value := edtmtdatasetID.Text;

      end;

    end;

end;

procedure TfrmGetGridID.btncancelClick(Sender: TObject);
begin
    case pgc1.TabIndex of
    0:   dsT504.Cancel;
    1:   dsT201.Cancel ;
    2:   dsGetTreeIDT507.Cancel;

    6:dsT204.Cancel;
    7:dsT203.Cancel;
    end;
end;

procedure TfrmGetGridID.btndeleteClick(Sender: TObject);
begin

if MessageBox(0, '确定删除?', '', MB_YESNO + MB_ICONQUESTION) = IDYES then
begin
        case pgc1.TabIndex of
    0:   dsT504.Delete  ;
    1:   dsT201.Delete ;
    2:    dsGetTreeIDT507.delete;

    4:  dsT202.Delete;
    6:dsT204.delete;
    7:dsT203.Delete ;
    end;
end;


end;

procedure TfrmGetGridID.btnsaveClick(Sender: TObject);
begin
    case pgc1.TabIndex of
    0:   dsT504.Post   ;
    1:   begin
              dsT201.Post  ;
              if  dsT504.State in [dsedit ,dsinsert ] then
              dsT504.Fieldbyname('f03').Value :=  dbedt6.Text ;

         end;
    2:   begin
              dsGetTreeIDT507.Post ;
         end;

    4:begin
            dsT202.Post;
      end;
     5: dsT102.post;
     6:dsT204.Post ;
     7:dsT203.Post ;
    end;

end;

procedure TfrmGetGridID.FormCreate(Sender: TObject);
var i:integer;
begin
 dsT504.Connection :=FhlKnl1.Connection ;
 dsT201.Connection :=FhlKnl1.Connection ;
 dsGetTreeIDT507.Connection:=FhlKnl1.Connection ;
 dsT402.Connection :=FhlKnl1.Connection ;
 dsT202.Connection :=FhlKnl1.Connection ;
 dsT102.Connection :=FhlKnl1.Connection ;
 dsT204.Connection :=FhlKnl1.Connection ;
 dsT203.Connection :=FhlKnl1.Connection ;
 dsT205.Connection :=FhlKnl1.Connection ;

 if self.dlgridid<>'' then
 begin
    if dsT504.Active then
    dsT504.Close;
        dsT504.Parameters[0].Value :=self.dlgridid ;
    dsT504.Open ;
 end;
 if  self.mtdatasetid <>'' then
 begin
     self.mtdatasetid :=dsT504.Fieldbyname ('f03').asstring;
     fhlknl1.Ds_OpenDataSet (dsT201,self.mtdatasetid )

 end;

 if self.treeviewid<>''  then
 begin
       fhlknl1.Ds_OpenDataSet (dsGetTreeIDT507,self.treeviewid )  ;
 end;




for i:=0 to dmFrm.ImageList1.Count -1 do
begin
    cbbImageID.ItemsEx.Add ;
    cbbImageID.ItemsEx.Items [i].ImageIndex  :=i;
end;

end;



procedure TfrmGetGridID.cbbImageIDClick(Sender: TObject);
begin
dbedt24.text:=inttostr   (Tcomboboxex(   Sender).ItemIndex );
end;

procedure TfrmGetGridID.dbedt24Change(Sender: TObject);
begin
//dbedit24.text=inttostr   (Tcomboboxex(   Sender).ItemIndex );
if Tdbedit(sender).text<>'' then
cbbimageID.ItemIndex:=strtoint(Tdbedit(sender).text);
end;

procedure TfrmGetGridID.dbedt3Change(Sender: TObject);
begin
    edtmtdatasetID.Text :=  dbedt3.Text ;
end;

procedure TfrmGetGridID.GetExistFields(listbox: TlistBox;
  datasetID: string);
  var i:integer;
begin
    dmFrm.GetQry_Sys('select * from T202 where f02='+datasetID);        //label

    listbox.Clear;
    if not dmFrm.qryFree_Sys.IsEmpty then
          for i:=0 to dmFrm.qryFree_Sys.RecordCount -1 do
          begin
              listbox.Items.Add(dmFrm.qryFree_Sys.Fieldbyname('f03').AsString +'='+dmFrm.qryFree_Sys.Fieldbyname('f07').AsString );
              dmFrm.qryFree_Sys.Next ;
          end;
end;

procedure TfrmGetGridID.lstFieldsClick(Sender: TObject);
begin

if edtmtdatasetID.Text <>'' then
    fhlknl1.Ds_OpenDataSet(dsT202, edtmtdatasetID.text  +','+lstFields.Items.Names [lstFields.ItemIndex ]  )    ;

if lstFields.ItemIndex >-1 then
 fhlknl1.Ds_OpenDataSet(dsT102, lstFields.Items.Names [lstFields.ItemIndex ]  )    ;

 end;

procedure TfrmGetGridID.btnT205Click(Sender: TObject);
begin
fhlknl1.Ds_OpenDataSet(dsT205,edtmtdatasetID.Text ) ;

end;

procedure TfrmGetGridID.dbedt85Change(Sender: TObject);
begin
if    dbedt85.Text <>'' then
lstfieldtype.ItemIndex :=strtoint(dbedt85.Text );
end;

procedure TfrmGetGridID.dbedt89Exit(Sender: TObject);
begin

if   dsT201.State in [dsinsert ,dsedit] then
    if  dsT201.FieldByName('F03').AsString='' then
    if dsT201.FieldByName('F04').AsString='0' then
       dsT201.FieldByName('F03').AsString :='select * from '+dsT201.FieldByName('F16').AsString
    else
       dsT201.FieldByName('F03').AsString :=dsT201.FieldByName('F16').AsString;


end;

end.
