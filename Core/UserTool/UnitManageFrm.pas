unit UnitManageFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, StdCtrls, ToolWin, ComCtrls,FhlKnl,datamodule, Mask,
  DBCtrls,UnitGetGridIDTreeID,TreeGrid, ActnList, ExtCtrls,Trigger,
  QuickRpt;

type
  TFrmManageFrm = class(TForm)
    pgc1: TPageControl;
    tlb1: TToolBar;
    btnadd: TButton;
    btncancel: TButton;
    btnsave: TButton;
    dsTreeEdit: TADODataSet;
    btnopen: TButton;
    dsTreeEditF01: TAutoIncField;
    dsTreeEditF03: TIntegerField;
    dsTreeEditF04: TIntegerField;
    dsTreeEditF05: TStringField;
    dsTreeEditF02: TStringField;
    dsTreeEditF06: TStringField;
    dsTreeEditF07: TStringField;
    dsTreeEditF08: TStringField;
    dsTreeEditF09: TStringField;
    tsTreeEdit: TTabSheet;
    ds2: TDataSource;
    lbl1: TLabel;
    dbedt1: TDBEdit;
    lbl2: TLabel;
    dbedt2: TDBEdit;
    lbl3: TLabel;
    dbedt3: TDBEdit;
    lbl4: TLabel;
    dbedt4: TDBEdit;
    lbl5: TLabel;
    dbedt5: TDBEdit;
    lbl6: TLabel;
    dbedt6: TDBEdit;
    lbl7: TLabel;
    dbedt7: TDBEdit;
    lbl8: TLabel;
    dbedt8: TDBEdit;
    lbl9: TLabel;
    dbedt9: TDBEdit;
    tsTreeGrid: TTabSheet;
    dsTreeGrid: TADODataSet;
    ds1: TDataSource;
    lbl10: TLabel;
    dbedt10: TDBEdit;
    lbl11: TLabel;
    dbedt11: TDBEdit;
    lbl12: TLabel;
    dbedt12: TDBEdit;
    lbl13: TLabel;
    dbedt13: TDBEdit;
    lbl14: TLabel;
    dbedt14: TDBEdit;
    lbl15: TLabel;
    dbedt15: TDBEdit;
    dbchk1: TDBCheckBox;
    lbl16: TLabel;
    dbedt16: TDBEdit;
    lbl17: TLabel;
    dbedt17: TDBEdit;
    lbl18: TLabel;
    dbedt18: TDBEdit;
    lbl19: TLabel;
    dbedt19: TDBEdit;
    lbl20: TLabel;
    dbedt20: TDBEdit;
    cbbTreeGridActions: TComboBox;
    actlstTreeGrid: TActionList;
    actWarePropAction1: TAction;
    actEditorAction1: TAction;
    actDeleteAction1: TAction;
    actCaAction1: TAction;
    actCaDlAction1: TAction;
    actSortAction1: TAction;
    actClientPropAction1: TAction;
    actClientEmpAction1: TAction;
    actLocateAction1: TAction;
    actOriginalAction1: TAction;
    actFilterAction1: TAction;
    actClntOwnerAction1: TAction;
    actClntPubAction1: TAction;
    edtFromID: TEdit;
    lbl21: TLabel;
    tsTsBill: TTabSheet;
    tsAnalyser: TTabSheet;
    dsBill: TADODataSet;
    lbl22: TLabel;
    dbedt21: TDBEdit;
    ds3: TDataSource;
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
    lbl31: TLabel;
    dbedt30: TDBEdit;
    lbl32: TLabel;
    dbedt31: TDBEdit;
    lbl35: TLabel;
    dbedt34: TDBEdit;
    lbl36: TLabel;
    dbedt35: TDBEdit;
    lbl37: TLabel;
    dbedt36: TDBEdit;
    lbl38: TLabel;
    dbedt37: TDBEdit;
    lbl39: TLabel;
    dbedt38: TDBEdit;
    lbl40: TLabel;
    dbedt39: TDBEdit;
    lbl41: TLabel;
    dbedt40: TDBEdit;
    lbl42: TLabel;
    dbedt41: TDBEdit;
    lbl43: TLabel;
    dbedt42: TDBEdit;
    lbl44: TLabel;
    dbedt43: TDBEdit;
    lbl45: TLabel;
    dbedt44: TDBEdit;
    lbl46: TLabel;
    dbedt45: TDBEdit;
    lbl47: TLabel;
    dbedt46: TDBEdit;
    lbl48: TLabel;
    dbedt47: TDBEdit;
    lbl49: TLabel;
    dbedt48: TDBEdit;
    lbl50: TLabel;
    dbedt49: TDBEdit;
    lbl51: TLabel;
    dbedt50: TDBEdit;
    lbl52: TLabel;
    dbedt51: TDBEdit;
    lbl53: TLabel;
    dbedt52: TDBEdit;
    dsAnalyserT601: TADODataSet;
    dsAnalyserT601F01: TAutoIncField;
    dsAnalyserT601F02: TStringField;
    dsAnalyserT601F03: TIntegerField;
    dsAnalyserT601F04: TIntegerField;
    dsAnalyserT601F05: TStringField;
    dsAnalyserT601F06: TStringField;
    dsAnalyserT601F07: TStringField;
    dsAnalyserT601F08: TBooleanField;
    dsAnalyserT601F09: TIntegerField;
    dsAnalyserT601F10: TIntegerField;
    dsAnalyserT601F11: TIntegerField;
    dsAnalyserT601F12: TStringField;
    dsAnalyserT601F13: TIntegerField;
    dsAnalyserT601F14: TIntegerField;
    lbl54: TLabel;
    dbedt53: TDBEdit;
    ds5: TDataSource;
    lbl55: TLabel;
    dbedt54: TDBEdit;
    lbl56: TLabel;
    dbedt55: TDBEdit;
    lbl57: TLabel;
    dbedt56: TDBEdit;
    lbl58: TLabel;
    dbedt57: TDBEdit;
    lbl59: TLabel;
    dbedt58: TDBEdit;
    lbl60: TLabel;
    dbedt59: TDBEdit;
    dbchk2: TDBCheckBox;
    lbl61: TLabel;
    dbedt60: TDBEdit;
    lbl62: TLabel;
    dbedt61: TDBEdit;
    lbl63: TLabel;
    dbedt62: TDBEdit;
    lbl64: TLabel;
    dbedt63: TDBEdit;
    lbl65: TLabel;
    dbedt64: TDBEdit;
    lbl66: TLabel;
    dbedt65: TDBEdit;
    lbl67: TLabel;
    lbl68: TLabel;
    dsT401: TADODataSet;
    dsT401F01: TAutoIncField;
    dsT401F02: TIntegerField;
    dsT401F03: TStringField;
    dbedt22: TDBEdit;
    ds4: TDataSource;
    dbedt23: TDBEdit;
    actlstAnalyser: TActionList;
    actAction1: TAction;
    actAction2: TAction;
    actSortAction3: TAction;
    actAction4: TAction;
    actAction5: TAction;
    actAction6: TAction;
    actAction7: TAction;
    actAction8: TAction;
    actAction9: TAction;
    actWarePropAction10: TAction;
    actDeleteAction11: TAction;
    actPickWareAction12: TAction;
    actTabEditorAction13: TAction;
    actNewTabEditorAction14: TAction;
    actNewBillAction15: TAction;
    actEditBillAction16: TAction;
    actDeleteBillAction17: TAction;
    actChkBillAction18: TAction;
    actDeposeBillAction19: TAction;
    actCloseBillAction20: TAction;
    actVldBillAction21: TAction;
    actEditorAction22: TAction;
    actDetailAction23: TAction;
    actBillAction24: TAction;
    actCalcIncreaseAction25: TAction;
    actFilterAction26: TAction;
    actInitdsFinderAction27: TAction;
    actPrint2Action28: TAction;
    actph1Action29: TAction;
    actph3Action30: TAction;
    actsl1Action31: TAction;
    actsl3Action32: TAction;
    actInvAction33: TAction;
    actWhInvbAction34: TAction;
    actArriveXAction35: TAction;
    actOrdAriXAction36: TAction;
    actBillAction37: TAction;
    actFirstAction38: TAction;
    actPriorAction39: TAction;
    actNextAction40: TAction;
    actLastAction41: TAction;
    actLocateAction42: TAction;
    actFilterAction43: TAction;
    actLocateAction44: TAction;
    actOrdCloseAction45: TAction;
    actOrdAriBilAction46: TAction;
    actCaAction47: TAction;
    actWhOutAction48: TAction;
    actHisAction49: TAction;
    actBankInoutAction50: TAction;
    actAction51: TAction;
    actWareInoutAction52: TAction;
    actOpenBillAction53: TAction;
    actProcAction54: TAction;
    actOutStpAction55: TAction;
    actDyRprtDtlAction56: TAction;
    actAlrdyBlAction57: TAction;
    actChkAction58: TAction;
    actDyRprtDtl2Action59: TAction;
    actIsInvoiceAction60: TAction;
    actItmInoutAction61: TAction;
    actShldOutIOAction62: TAction;
    actwrprice63: TAction;
    actIsOutBillAction64: TAction;
    actInvoiceRecHintAction65: TAction;
    actInvoiceRecedAction1: TAction;
    actEmpSaleDlAction67: TAction;
    actClientKp2Action68: TAction;
    actClientProfitAction69: TAction;
    actDetailNewAction70: TAction;
    actDetailEdtAction71: TAction;
    actLinkmansAction72: TAction;
    actActivitysAction73: TAction;
    actLinkmanNewAction74: TAction;
    actActivityNewAction75: TAction;
    actYdstockAction76: TAction;
    actQuotePriceAction77: TAction;
    actOrderReferAction78: TAction;
    actArriveReferAction79: TAction;
    actDemandAction80: TAction;
    actIsInvEditAction81: TAction;
    actStkinAndStkout: TAction;
    cbbactlstAnalyser: TComboBox;
    lbl23: TLabel;
    dbedt29: TDBEdit;
    btnedit: TButton;
    cbbDBClick: TComboBox;
    cbbCodePre: TComboBox;
    tsTabEditor: TTabSheet;
    dsTabEditor: TADODataSet;
    dsTabEditorF01: TStringField;
    dsTabEditorF02: TStringField;
    dsTabEditorF03: TIntegerField;
    dsTabEditorF04: TStringField;
    dsTabEditorF05: TIntegerField;
    dsTabEditorF06: TIntegerField;
    dsTabEditorF07: TStringField;
    lbl24: TLabel;
    dbedt32: TDBEdit;
    ds6: TDataSource;
    lbl30: TLabel;
    dbedt33: TDBEdit;
    lbl33: TLabel;
    dbedt66: TDBEdit;
    lbl34: TLabel;
    dbedt67: TDBEdit;
    lbl69: TLabel;
    dbedt68: TDBEdit;
    lbl70: TLabel;
    dbedt69: TDBEdit;
    lbl71: TLabel;
    dbedt70: TDBEdit;
    btnDelete: TButton;
    tsT616: TTabSheet;
    dsOpenEditorT616: TADODataSet;
    lbl72: TLabel;
    dbedt71: TDBEdit;
    ds7: TDataSource;
    lbl73: TLabel;
    dbedt72: TDBEdit;
    lbl74: TLabel;
    dbedt73: TDBEdit;
    lbl75: TLabel;
    dbedt74: TDBEdit;
    lbl76: TLabel;
    dbedt75: TDBEdit;
    lbl77: TLabel;
    dbedt76: TDBEdit;
    lbl78: TLabel;
    dbedt77: TDBEdit;
    lbl79: TLabel;
    dbedt78: TDBEdit;
    lbl80: TLabel;
    dbedt79: TDBEdit;
    lbl81: TLabel;
    dbedt80: TDBEdit;
    actUpdateImage: TAction;
    ts_Pick_T603: TTabSheet;
    dsPickT603: TADODataSet;
    dsPickT603F01: TAutoIncField;
    dsPickT603F02: TStringField;
    dsPickT603F03: TIntegerField;
    dsPickT603F04: TStringField;
    dsPickT603F09: TBooleanField;
    dsPickT603F07: TStringField;
    dsPickT603F08: TStringField;
    dsPickT603F05: TStringField;
    dsPickT603F06: TStringField;
    dsPickT603F10: TStringField;
    dsPickT603F11: TBooleanField;
    dsPickT603F12: TStringField;
    dsPickT603F13: TStringField;
    dsPickT603F14: TStringField;
    dsPickT603F15: TStringField;
    dsPickT603F16: TStringField;
    dsPickT603F17: TStringField;
    lbl82: TLabel;
    dbedt81: TDBEdit;
    ds8: TDataSource;
    lbl83: TLabel;
    dbedt82: TDBEdit;
    lbl84: TLabel;
    dbedt83: TDBEdit;
    lbl85: TLabel;
    dbedt84: TDBEdit;
    lbl86: TLabel;
    dbedt85: TDBEdit;
    lbl87: TLabel;
    dbedt86: TDBEdit;
    lbl88: TLabel;
    dbedt87: TDBEdit;
    lbl89: TLabel;
    dbedt88: TDBEdit;
    dbchk3: TDBCheckBox;
    lbl90: TLabel;
    dbedt89: TDBEdit;
    dbchk4: TDBCheckBox;
    lbl91: TLabel;
    dbedt90: TDBEdit;
    lbl92: TLabel;
    dbedt91: TDBEdit;
    lbl93: TLabel;
    dbedt92: TDBEdit;
    lbl94: TLabel;
    dbedt93: TDBEdit;
    lbl95: TLabel;
    dbedt94: TDBEdit;
    lbl96: TLabel;
    dbedt95: TDBEdit;
    actlstPickWindow: TActionList;
    actGetAction1: TAction;
    actSelectAction1: TAction;
    actCloseAction1: TAction;
    actFilterAction2: TAction;
    actLocateAction2: TAction;
    actSortAction2: TAction;
    actGetAction2: TAction;
    actMoveAction1: TAction;
    actYdWarePropAction1: TAction;
    actGetAction3: TAction;
    actQuoteAction1: TAction;
    actNewWareAction1: TAction;
    actOrderdlAction1: TAction;
    actPriceOutRfsAction1: TAction;
    actPriceInRfsAction1: TAction;
    actWarePropAction2: TAction;
    cbbPickWindow: TComboBox;
    cbbOpenEditor: TComboBox;
    lbl97: TLabel;
    dbedt96: TDBEdit;
    actlstOpenEditor: TActionList;
    actAddAction: TAction;
    actCopyAction: TAction;
    actEditAction: TAction;
    actDeleteAction: TAction;
    actSaveAction: TAction;
    actCancelAction: TAction;
    actFirstAction: TAction;
    actPriorAction: TAction;
    actNextAction: TAction;
    actLastAction: TAction;
    actCloseAction: TAction;
    actPrintAction: TAction;
    actSetCaptionAction: TAction;
    actInputTaxAmt: TAction;
    actPackPic84: TAction;
    actBrandPic85: TAction;
    actInputInvoice83: TAction;
    actPackPic2: TAction;
    actBrandPic2: TAction;
    actPriceOutRfs86: TAction;
    TabSheet1: TTabSheet;
    dsT623: TADODataSet;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    dsdsT623: TDataSource;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    Label3: TLabel;
    DBEdit3: TDBEdit;
    Label4: TLabel;
    DBEdit4: TDBEdit;
    Label5: TLabel;
    DBEdit5: TDBEdit;
    Label6: TLabel;
    DBEdit6: TDBEdit;
    Label7: TLabel;
    DBEdit7: TDBEdit;
    DBCheckBox1: TDBCheckBox;
    Label8: TLabel;
    DBEdit8: TDBEdit;
    DBCheckBox2: TDBCheckBox;
    Label9: TLabel;
    DBEdit9: TDBEdit;
    Label10: TLabel;
    DBEdit10: TDBEdit;
    Label11: TLabel;
    DBEdit11: TDBEdit;
    Label12: TLabel;
    DBEdit12: TDBEdit;
    cmbPickUniversal: TComboBox;
    Label14: TLabel;
    DBEdit14: TDBEdit;
    Label15: TLabel;
    DBEdit15: TDBEdit;
    DBNavigator1: TDBNavigator;
    openT623: TButton;
    Label13: TLabel;
    DBEdit13: TDBEdit;
    ActInputInvoiceItem: TAction;
    actNeedInvoiceDL: TAction;
    actHaveInvoiceDL: TAction;
    actInvoice: TAction;
    dbnvgr1: TDBNavigator;
    lbl98: TLabel;
    dbnvgr2: TDBNavigator;
    ts1: TTabSheet;
    procedure FormCreate(Sender: TObject);
    procedure btnopenClick(Sender: TObject);
    procedure btnaddClick(Sender: TObject);
    procedure btncancelClick(Sender: TObject);
    procedure btnsaveClick(Sender: TObject);

    function getMaxT616f01:string;
    function getboxid:string;
    function getgridid:string;
    function GetT606PK:string ;
    procedure dbedt3DblClick(Sender: TObject);
    procedure dbedt12DblClick(Sender: TObject);
    procedure dbedt20DblClick(Sender: TObject);
    procedure cbbTreeGridActionsClick(Sender: TObject);
    procedure cbbactlstAnalyserClick(Sender: TObject);
    procedure dbedt55DblClick(Sender: TObject);
    procedure dbedt57DblClick(Sender: TObject);
    procedure dbedt22Click(Sender: TObject);
    procedure btneditClick(Sender: TObject);
    procedure dbedt59DblClick(Sender: TObject);
    procedure dbedt64Change(Sender: TObject);
    procedure dbedt35DblClick(Sender: TObject);
    procedure dbedt36Click(Sender: TObject);
    procedure dbedt39Click(Sender: TObject);
    procedure cbbCodePreClick(Sender: TObject);
    procedure dbedt28Change(Sender: TObject);
    procedure dbedt67DblClick(Sender: TObject);
    procedure dbedt66Click(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure dbedt73DblClick(Sender: TObject);
    procedure dbedt74Click(Sender: TObject);
    procedure dbedt83DblClick(Sender: TObject);
    procedure cbbPickWindowClick(Sender: TObject);
    procedure dbedt96DblClick(Sender: TObject);
    procedure dbedt37Click(Sender: TObject);
    procedure cbbOpenEditorClick(Sender: TObject);
    procedure cmbPickUniversalClick(Sender: TObject);
    procedure DBEdit9DblClick(Sender: TObject);
    procedure openT623Click(Sender: TObject);
    procedure DBEdit10DblClick(Sender: TObject);
    procedure DBEdit12Click(Sender: TObject);
    procedure dbedt21DblClick(Sender: TObject);

  private
    ModelID: integer  ;

    { Private declarations }


  public
    constructor create(owner: Twincontrol; PModelID: integer);
  end;

var
  FrmManageFrm: TFrmManageFrm;

implementation
           uses UnitFrmAnalyserEx;
{$R *.dfm}

{ TFrmManageFrm }

constructor TFrmManageFrm.create(owner: Twincontrol; PModelID: integer);
begin
   ModelID:=PModelID;
   inherited create(owner);
end;

procedure TFrmManageFrm.FormCreate(Sender: TObject);
var
  table :string;
  i:integer;

  var
  analyserFrm: TAnalyseEx;

begin
self.Caption :=self.Caption+fhlknl1.Connection.DefaultDatabase ;



case ModelId of

0:  begin
         tsTsBill.Enabled :=true;
         dsBill.Connection := fhlknl1.Connection;

         //对应的pickwindows
                  ts_Pick_T603.Enabled :=true;
         dsPickT603.Connection := fhlknl1.Connection ;
    end;
1:  begin
          tsTreeEdit.Enabled :=true;
          dsTreeEdit.Connection :=fhlknl1.Connection;

         
    end;
2:  begin
          pgc1.TabIndex:=1;
          tsTreeGrid.Enabled :=true;
          dsTreeGrid.Connection :=fhlknl1.Connection;
          table:='T612';
    end;
3:   begin
          pgc1.TabIndex:=4;
         dsTabEditor.Connection :=fhlknl1.Connection;
          table:='T606';
    end;
4:  begin
         table:='T611';
    end;
5:  begin
         table:='T611';
    end;
6:  begin
         table:='T611';
    end;
7:  begin
         tsAnalyser.Enabled :=true;
         dsT401.Connection :=fhlknl1.Connection ;
         dsAnalyserT601.Connection :=fhlknl1.Connection ;

         table:='T601';
    end;
8:  begin
         tsT616.Enabled :=true;
         dsOpenEditorT616.Connection := fhlknl1.Connection ;

         table:='T616';
    end;
9:  begin
          
         table:='T611';
    end;
10:  begin
         table:='T611';
    end;
11:  begin
         table:='T611';
    end;
12:  begin
         table:='T611';
    end;
21:begin
         ts_Pick_T603.Enabled :=true;
         dsPickT603.Connection := fhlknl1.Connection ;
    end;


end;


dsT623.Connection := fhlknl1.Connection ;

for i:=0 to   actlstTreeGrid.ActionCount -1 do
begin
    cbbTreeGridActions.Items.Add  ( actlstTreeGrid.Actions [i].Name+':'+Taction(actlstTreeGrid.Actions [i]).Caption +' :'+inttostr(i) );
end;


  analyserFrm:=TAnalyseEx.Create (nil);
for i:=0 to   analyserFrm.ActionList1.ActionCount -1 do
begin
    cbbactlstAnalyser.Items.Add(analyserFrm.ActionList1.Actions [i].Name +':' +Taction(analyserFrm.ActionList1.Actions [i]).Caption +' :'+inttostr(i) )   ;
end;
freeandnil( analyserFrm);

    cbbDBClick.Items.Assign(cbbactlstAnalyser.Items) ;

    {

    cbbCodePre.Clear;
    for    i:=0 to dmfrm.FreeQuery1.RecordCount - 1 do
    begin
        cbbCodePre.Items.Add(dmfrm.FreeQuery1.fieldbyname('tblid').AsString +'='+dmfrm.FreeQuery1.fieldbyname('pre').AsString +'- '+dmfrm.FreeQuery1.fieldbyname('xlen').AsString );
        dmfrm.FreeQuery1.Next;
    end;
    }
 



    for i:=0 to  actlstOpenEditor.ActionCount -1 do
    begin
        cbbOpenEditor.Items.Add(actlstOpenEditor.Actions [i].Name +':' +Taction(actlstOpenEditor.Actions [i]).Caption +' :'+inttostr(i) )   ;
    end;
end;


procedure TFrmManageFrm.btnopenClick(Sender: TObject);
begin

case ModelId of

0:  begin
         //table:='T611';                 
          if edtFromID.Text <>'' then
       fhlknl1.Ds_OpenDataSet(dsBill,edtFromID.Text )
       else
       fhlknl1.Ds_OpenDataSet(dsBill,'1' );

       //打开对应的pickwindows
        if dsBill.FieldByName('f22').AsString <>'' then
           fhlknl1.Ds_OpenDataSet(dsPickT603,dsBill.FieldByName('f22').AsString )
        else
        begin
           if edtFromID.Text <>'' then
               fhlknl1.Ds_OpenDataSet(dsPickT603,edtFromID.Text )
           else
              fhlknl1.Ds_OpenDataSet(dsPickT603,'1')    ;
        end;

    end;
1:  begin
        if edtFromID.Text <>'' then
          fhlknl1.Ds_OpenDataSet(dsTreeEdit,edtFromID.Text )
        else
         fhlknl1.Ds_OpenDataSet(dsTreeEdit,'1' )
    end;
2:  begin
          if edtFromID.Text <>'' then
              fhlknl1.Ds_OpenDataSet(dsTreeGrid,edtFromID.Text )
          else
              fhlknl1.Ds_OpenDataSet(dsTreeGrid,'1' )
         //table:='T611';
    end;
3:   begin
          if edtFromID.Text <>'' then
            fhlknl1.Ds_OpenDataSet(dsTabEditor,edtFromID.Text )
          else
            fhlknl1.Ds_OpenDataSet(dsTabEditor,'1' );

        // table:='T611';
    end;
4:  begin
         //table:='T611';
    end;
5:  begin
         //table:='T611';
    end;
6:  begin
         //table:='T611';
    end;
7:  begin

         if edtFromID.Text <>'' then
             fhlknl1.Ds_OpenDataSet(dsAnalyserT601,edtFromID.Text )
         else
             fhlknl1.Ds_OpenDataSet(dsAnalyserT601,'1' );

         if dsAnalyserT601.fieldbyname('f05').AsString <>'' then
             fhlknl1.Ds_OpenDataSet(dsT401,dsAnalyserT601.fieldbyname('f05').AsString  )
         else
             fhlknl1.Ds_OpenDataSet(dsT401,'1');

    end;
8:  begin
         if edtFromID.Text <>'' then
             fhlknl1.Ds_OpenDataSet(dsOpenEditorT616,edtFromID.Text )
         else
            fhlknl1.Ds_OpenDataSet(dsOpenEditorT616,'1')    ;

        // table:='T611';
    end;
9:  begin
         //table:='T611';
    end;
10:  begin
         //table:='T611';
    end;
11:  begin
        // table:='T611';
    end;
12:  begin
        // table:='T611';
    end;
21: begin


           if edtFromID.Text <>'' then
               fhlknl1.Ds_OpenDataSet(dsPickT603,edtFromID.Text )
           else
              fhlknl1.Ds_OpenDataSet(dsPickT603,'1')    ;
  
    end;


end;


end;

procedure TFrmManageFrm.btnaddClick(Sender: TObject);
var mtblid,mkeyfld,fkeyfld,topboxid,btmboxid, qtyfld:string;
var DiscardInterFace:boolean;
begin
DiscardInterFace:=false;
btnopen.Click ;

case ModelId of

0:  begin
          if MessageBox(0, '生成弃单界面？', '', MB_YESNO + MB_ICONQUESTION) = 
            IDYES then
          begin
              DiscardInterFace:=true;
              mtblid :=dsBill.fieldbyname ('f09').AsString ;
              mkeyfld:=dsBill.fieldbyname ('f11').AsString ;
              fkeyfld:=dsBill.fieldbyname ('f12').AsString ;
              topboxid:=dsBill.fieldbyname ('f15').AsString ;
              btmboxid:=dsBill.fieldbyname ('f16').AsString ;
              qtyfld:=dsBill.fieldbyname ('f25').AsString ;
          end;

          if  dsBill.Active then
          dsBill.Append ;

          dsBill.FieldByName('f05').Value := 'clWindowText';
          dsBill.FieldByName('f06').Value := 15;
          dsBill.FieldByName('f07').Value := '楷体_GB2312';

          dsBill.FieldByName('f15').Value :=getboxid            ;
          dsBill.FieldByName('f17').Value :=getGridID            ;
          dsBill.FieldByName('f20').Value :=getGridID   ;

          if DiscardInterFace then
          begin
              dsBill.fieldbyname ('f09').AsString:= mtblid ;
              dsBill.fieldbyname ('f11').AsString:=mkeyfld ;
              dsBill.fieldbyname ('f12').AsString:= fkeyfld;
              dsBill.fieldbyname ('f15').AsString:=topboxid ;
              dsBill.fieldbyname ('f16').AsString :=btmboxid;
              dsBill.fieldbyname ('f25').AsString :=qtyfld;
          end;
    end;
1:  begin
          if  dsTreeEdit.Active then
          dsTreeEdit.Append ;
          dbedt6.Text :='Code';
          dbedt7.Text :='Name';
          dbedt2.Text :=getboxid            ;

          dsTreeEdit.FieldByName('F04').AsString := getGridID;
    end;
2:  begin
          if  dsTreeGrid.Active then
          begin
          dsTreeGrid.Append ;
          dsTreeGrid.FieldByName ('f04').Value := getGridID      ;
          dsTreeGrid.FieldByName ('f11').Value :=true;
          end;
    end;
3:   begin
          if dsTabEditor.Active then
          dsTabEditor.Append ;
          dsTabEditor.FieldByName('f01').Value :=GetT606PK;
    end;
4:  begin

    end;
5:  begin

    end;
6:  begin

    end;
7:  begin

          if    dsAnalyserT601.Active then
          dsAnalyserT601.Append ;

           if dsT401.Active then
          dsT401.Append;

          dsAnalyserT601.FieldByName ('f03').Value  := getGridID      ;
          dsAnalyserT601.FieldByName ('f07').Value  :=-1          ;
          dsAnalyserT601.FieldByName ('f06').Value  :=getboxid              ;
          dsAnalyserT601.FieldByName ('F13').Value  :=-1            ;
          
    end;
8:  begin
         if     dsOpenEditorT616.Active then
         begin


              dsOpenEditorT616.Append      ;
              dsOpenEditorT616.FieldByName('F05').AsInteger :=360;
              dsOpenEditorT616.FieldByName('F06').AsInteger :=660;
              dsOpenEditorT616.FieldByName('f15').AsInteger :=-1;
           //   dbedt71.Text:=getMaxT616f01;
         end
         else
              showmessage('先打开数据集')  ;

    end;
9:  begin

    end;
10:  begin

    end;
11:  begin

    end;
12:  begin

    end;
21 :begin

         if     dsPickT603.Active then
         begin
              dsPickT603.Append      ;
              dsPickT603.FieldByName ('f03').Value := getGridID      ;
         end
         else
              showmessage('先打开数据集')  ;
    end;
end;

end;


procedure TFrmManageFrm.btncancelClick(Sender: TObject);
begin



case ModelId of

0:  begin
          dmFrm.GetQry_Sys('delete t502 where f02='+dbedt34.Text  ,false   );        //label
          dmFrm.GetQry_Sys('delete t503 where f02='+dbedt34.Text  ,false    );        //crol
          dmFrm.GetQry_Sys('delete t504 where f01='+dbedt36.Text   ,false    );    // Fcfg_dbgrid  dataset
          dmFrm.GetQry_Sys('delete t505 where f02='+dbedt36.Text   ,false    );    //grid col
          dsBill.Cancel  ;
    end;
1:  begin
          dmFrm.GetQry_Sys('delete t502 where f02='+dbedt2.Text  ,false   );        //label
          dmFrm.GetQry_Sys('delete t503 where f02='+dbedt2.Text  ,false    );        //crol
          dmFrm.GetQry_Sys('delete t504 where f01='+dbedt3.Text   ,false    );    // Fcfg_dbgrid  dataset
          dmFrm.GetQry_Sys('delete t505 where f02='+dbedt3.Text   ,false    );    //grid col
          dsTreeEdit.Cancel  ;
    end;
2:  begin

          dmFrm.GetQry_Sys('delete t504 where f01='+dbedt12.Text   ,false    );    // Fcfg_dbgrid  dataset
          dmFrm.GetQry_Sys('delete t505 where f02='+dbedt12.Text   ,false    );    //grid col
          dsTreeGrid.Cancel   ;

    end;
3:   begin
        if dbedt67.Text <>'' then
           dmFrm.GetQry_Sys('delete t504 where f01='+dbedt67.Text   ,false    );
         dsTabEditor.Cancel;
    end;
4:  begin

    end;
5:  begin

    end;
6:  begin

    end;
7:  begin
          if dbedt58.Text<>'' then
          begin
              dmFrm.GetQry_Sys('delete t502 where f02='+dbedt58.Text  ,false   );        //label
              dmFrm.GetQry_Sys('delete t503 where f02='+dbedt58.Text  ,false    );        //crol
          end;
          if dbedt59.Text<>'' then
          begin
              dmFrm.GetQry_Sys('delete t502 where f02='+dbedt59.Text  ,false   );        //label
              dmFrm.GetQry_Sys('delete t503 where f02='+dbedt59.Text  ,false    );        //crol
          end;
          if dbedt55.Text<>'' then
          begin
              dmFrm.GetQry_Sys('delete t504 where f01='+dbedt55.Text   ,false    );    // Fcfg_dbgrid  dataset
              dmFrm.GetQry_Sys('delete t505 where f02='+dbedt55.Text   ,false    );    //grid col
          end;
          if dbedt29.Text<>'' then
          dmFrm.GetQry_Sys('delete T401 where f01='+dbedt29.Text   ,false    );    //T401
          if   dbedt22.Text<>'' then 
          dmFrm.GetQry_Sys('delete T201 where f01='+dbedt22.Text   ,false    );    //T201
          dsAnalyserT601.Cancel;
          dsT401.Cancel;
    end;
8:  begin
         dsOpenEditorT616.Cancel;
    end;
9:  begin

    end;
10:  begin

    end;
11:  begin

    end;
12:  begin

    end;

21:  begin
              dsPickT603.Cancel       ;
          if dbedt83.Text<>'' then
          begin
              dmFrm.GetQry_Sys('delete t504 where f01='+dbedt83.Text   ,false    );    // Fcfg_dbgrid  dataset
              dmFrm.GetQry_Sys('delete t505 where f02='+dbedt83.Text   ,false    );    //grid col
          end;

    end;
end;

end;

procedure TFrmManageFrm.btnsaveClick(Sender: TObject);
begin
//    BTNEDIT.Click;
    try

          case ModelId of

          0:  begin
                    if dsbill.State  in [dsEdit	,dsInsert ]    then
                      dsbill.Post
                     else
                     MessageBox(0, '请先按编辑或追加?', '', MB_OK + MB_ICONQUESTION);
              end;
          1:  begin
                    if dsTreeEdit.State  in [dsEdit	,dsInsert ]    then
                      dsTreeEdit.Post
                     else
                     MessageBox(0, '请先按编辑或追加?', '', MB_OK + MB_ICONQUESTION);


              end;
          2:  begin
                    if dsTreeGrid.State  in [dsEdit	,dsInsert ]    then
                     dsTreeGrid.Post
                     else
                     MessageBox(0, '请先按编辑或追加?', '', MB_OK + MB_ICONQUESTION);

                   
              end;
          3:   begin
                    if dsTabEditor.State  in [dsEdit	,dsInsert ]    then
                     dsTabEditor.Post
                     else
                     MessageBox(0, '请先按编辑或追加?', '', MB_OK + MB_ICONQUESTION);

              end;
          4:  begin

              end;
          5:  begin

              end;
          6:  begin

              end;
          7:  begin


                    if dsAnalyserT601.State  in [dsEdit	,dsInsert ]    then
                    begin
                    if dsT401.FieldByName('f01').AsString <>'' then
                    dsAnalyserT601.FieldByName('f05').Value := dsT401.FieldByName('f01').Value;
                    dsAnalyserT601.Post;
                    end
                    else
                     MessageBox(0, '请先按编辑或追加?', '', MB_OK + MB_ICONQUESTION);



              end;
          8:  begin
                    if dsOpenEditorT616.State  in [dsEdit	,dsInsert ]    then
                     dsOpenEditorT616.Post
                     else
                     MessageBox(0, '请先按编辑或追加?', '', MB_OK + MB_ICONQUESTION);


              end;
          9:  begin

              end;
          10:  begin

              end;
          11:  begin

              end;
          12:  begin

              end;
          21:  begin
                    if dsPickT603.State  in [dsEdit	,dsInsert ]    then
                       dsPickT603.Post 
                     else
                     MessageBox(0, '请先按编辑或追加?', '', MB_OK + MB_ICONQUESTION);

              end;

              
          end;
          showmessage('save success' );
    except
           on err:exception do
           showmessage(err.Message );
    end;

end;

function TFrmManageFrm.getboxid: string;
var maxboxid:integer;
begin
    dmFrm.GetQry_Sys('select max(boxid)as maxboxid from V501  ');        //label
    maxboxid:=  dmFrm.qryFree_Sys.FieldByName('maxboxid').AsInteger  ;
    result:=   inttostr(maxboxid+1);
end;

function TFrmManageFrm.getgridid: string;
var maxGridid:integer;
begin
maxGridid:=0;
 //   FhlKnl1.FreeQuery.CanModify :=true;
    dmFrm.GetQry_Sys('select * from t504 order by f01 desc ');        //grid procedure ,sql ,dataset
    maxGridid:=  dmFrm.qryFree_Sys.FieldByName('f01').AsInteger  ;
    dmFrm.qryFree_Sys.Append ;
    dmFrm.qryFree_Sys.FieldByName('f02').Value:=' 新界面';
    dmFrm.qryFree_Sys.Post ;
    maxGridid:=  dmFrm.qryFree_Sys.FieldByName('f01').AsInteger  ;



    dmFrm.GetQry_Sys('select * from t505 order by f01 desc ');        //grid col
    dmFrm.qryFree_Sys.Append ;
    dmFrm.qryFree_Sys.FieldByName('f02').Value :=  maxGridid;    //gridid
    dmFrm.qryFree_Sys.FieldByName('f03').Value:=4415;
    dmFrm.qryFree_Sys.FieldByName('f09').Value:='clBtnFace';
    dmFrm.qryFree_Sys.FieldByName('f13').Value:=0;
    dmFrm.qryFree_Sys.FieldByName('f14').Value:='备注';
    dmFrm.qryFree_Sys.FieldByName('f15').Value:='clBtnFace';
    dmFrm.qryFree_Sys.FieldByName('f19').Value:='clblack';
    dmFrm.qryFree_Sys.FieldByName('f22').Value:='clblack';

    dmFrm.qryFree_Sys.Post ;

    result:=   inttostr(maxGridid);
end;

procedure TFrmManageFrm.dbedt3DblClick(Sender: TObject);
var   frmGetGridID: TfrmGetGridID;
begin
  frmGetGridID:= TfrmGetGridID.Create (nil );
  frmGetGridID.edtGridId.Text :=tdbedit(sender).Text ;

  frmGetGridID.ShowModal;

end;

procedure TFrmManageFrm.dbedt12DblClick(Sender: TObject);
var   frmGetGridID: TfrmGetGridID;
begin
  frmGetGridID:= TfrmGetGridID.Create (nil );
  frmGetGridID.edtGridId.Text :=tdbedit(sender).Text ;

  frmGetGridID.ShowModal;

end;

procedure TFrmManageFrm.dbedt20DblClick(Sender: TObject);
var   frmGetGridID: TfrmGetGridID;
begin
  frmGetGridID:= TfrmGetGridID.Create (nil);
  frmGetGridID.treeviewid  :=Tdbedit(sender).Text;
  frmGetGridID.ShowModal;

end;

procedure TFrmManageFrm.cbbTreeGridActionsClick(Sender: TObject);
begin
if  dbedt14.Text ='' then
    dbedt14.Text :=inttostr(cbbTreeGridActions.Itemindex )
else
     dbedt14.Text :=dbedt14.Text+','+inttostr(cbbTreeGridActions.Itemindex )
end;

procedure TFrmManageFrm.cbbactlstAnalyserClick(Sender: TObject);
begin
dsAnalyserT601.Edit;
dsT401.Edit;

if  dbedt63.Text ='' then
    dsAnalyserT601.FieldByName ('f12').Value  :=inttostr(cbbactlstAnalyser.Itemindex )
else
    dsAnalyserT601.FieldByName ('f12').Value :=    dsAnalyserT601.FieldByName ('f12').Value +','+inttostr(cbbactlstAnalyser.Itemindex )

end;

procedure TFrmManageFrm.dbedt55DblClick(Sender: TObject);
var   frmGetGridID: TfrmGetGridID;
begin
  frmGetGridID:= TfrmGetGridID.Create (nil);
  frmGetGridID.edtgridID.Text   :=tdbedit(sender).Text ;
  frmGetGridID.ShowModal;
end;

procedure TFrmManageFrm.dbedt57DblClick(Sender: TObject);
var   frmGetGridID: TfrmGetGridID;
begin
  frmGetGridID:= TfrmGetGridID.Create (nil);
  frmGetGridID.edtmtdatasetID.Text :=Tdbedit(sender).Text ;
  frmGetGridID.ShowModal;
end;
procedure TFrmManageFrm.dbedt22Click(Sender: TObject);
var   frmGetGridID: TfrmGetGridID;
begin
  frmGetGridID:= TfrmGetGridID.Create (nil);
  if tdbedit(sender).Text<>''   then
  frmGetGridID.edtmtdatasetID.Text   :=tdbedit(sender).Text ;
  frmGetGridID.ShowModal;

end;

procedure TFrmManageFrm.btneditClick(Sender: TObject);
begin

case ModelId of

0:  begin
          if  dsBill.Active then
          dsBill.edit ;
    end;
1:  begin
          if  dsTreeEdit.Active then
          dsTreeEdit.edit ;

    end;
2:  begin
          if  dsTreeGrid.Active then
          dsTreeGrid.edit ;


    end;
3:   begin
         if dsTabEditor.Active then
         dsTabEditor.Edit ;
    end;
4:  begin

    end;
5:  begin

    end;
6:  begin

    end;
7:  begin

          if    dsAnalyserT601.Active then
          dsAnalyserT601.edit ;

           if dsT401.Active then
          dsT401.edit;

    end;
8:  begin
        if dsOpenEditorT616.Active then
        dsOpenEditorT616.Edit ;
    end;
9:  begin

    end;
10:  begin

    end;
11:  begin

    end;
12:  begin

    end;
21:  begin
        if dsPickT603.Active then
        dsPickT603.Edit ;
    end;
end;

end;

procedure TFrmManageFrm.dbedt59DblClick(Sender: TObject);
begin
if MessageBox(0, '需要BTMBoxID?', '', MB_YESNO + MB_ICONQUESTION) = IDYES then
begin
if  dsAnalyserT601.State in  [dsEdit	,dsInsert ]  then
     dsAnalyserT601.FieldByName ('f07').Value :=getboxid
else
    showmessage('先按编辑');     
end;

         
end;

procedure TFrmManageFrm.dbedt64Change(Sender: TObject);
begin
    cbbDBClick.Itemindex:=  dsAnalyserT601.fieldbyname('F13').AsInteger -1;
end;

procedure TFrmManageFrm.dbedt35DblClick(Sender: TObject);
begin
          dsBill.FieldByName('f16').Value :=getboxid            ;
end;

procedure TFrmManageFrm.dbedt36Click(Sender: TObject);
var   frmGetGridID: TfrmGetGridID;
begin
  frmGetGridID:= TfrmGetGridID.Create (nil);
  if tdbedit(sender).Text<>''   then
  frmGetGridID.edtgridID.Text    :=tdbedit(sender).Text ;
  frmGetGridID.ShowModal;

end;


procedure TFrmManageFrm.dbedt39Click(Sender: TObject);
var   frmGetGridID: TfrmGetGridID;
begin
  frmGetGridID:= TfrmGetGridID.Create (nil);
  if tdbedit(sender).Text<>''   then
  frmGetGridID.edtgridID.Text    :=tdbedit(sender).Text ;
  frmGetGridID.ShowModal;

end;

procedure TFrmManageFrm.cbbCodePreClick(Sender: TObject);
begin
     dsBill.FieldByName('f09').Value :=cbbCodePre.items.names [  cbbCodePre.ItemIndex ];
end;

procedure TFrmManageFrm.dbedt28Change(Sender: TObject);
var i:integer;
begin
for i :=0 to    cbbCodePre.Items.Count -1 do
begin

    if    dsBill.FieldByName('f09').AsString = cbbCodePre.Items.Names [i] then
    begin
        cbbCodePre.ItemIndex :=cbbCodePre.ItemIndex +1;
        exit;
    end;
    cbbCodePre.ItemIndex :=cbbCodePre.ItemIndex +1;

end;



end;

procedure TFrmManageFrm.dbedt67DblClick(Sender: TObject);
begin
  //       if MessageBox(0, '需要BTMBoxID?', '', MB_YESNO + MB_ICONQUESTION) = IDYES then
      begin
           dsTabEditor.FieldByName ('f04').Value :=getboxid            ;
      end;

end;

procedure TFrmManageFrm.dbedt66Click(Sender: TObject);
var   frmGetGridID: TfrmGetGridID;
begin
  frmGetGridID:= TfrmGetGridID.Create (nil);
  if tdbedit(sender).Text<>''   then
  frmGetGridID.edtmtdatasetID.Text   :=tdbedit(sender).Text ;
  frmGetGridID.ShowModal;

end;

procedure TFrmManageFrm.btnDeleteClick(Sender: TObject);
begin
    try

          case ModelId of

          0:  begin

              end;
          1:  begin

              end;
          2:  begin
                  if MessageBox(0, 'delete?', '', MB_YESNO + MB_ICONQUESTION) = IDYES then
                  begin
                       dsTreeGrid.Delete;
                  end;
              end;
          3:   begin
                  if MessageBox(0, 'delete?', '', MB_YESNO + MB_ICONQUESTION) = IDYES then
                  begin
                       dsTabEditor.Delete;
                  end;


                  
              end;
          4:  begin

              end;
          5:  begin

              end;
          6:  begin

              end;
          7:  begin

              end;
          8:  begin
                  if MessageBox(0, 'delete?', '', MB_YESNO + MB_ICONQUESTION) = IDYES then
                  begin
                       dsOpenEditorT616.Delete;
                  end;
                 
              end;
          9:  begin

              end;
          10:  begin

              end;
          11:  begin

              end;
          12:  begin

              end;
          21:  begin
                  if MessageBox(0, 'delete?', '', MB_YESNO + MB_ICONQUESTION) = IDYES then
                  begin
                       dsPickT603.Delete;
                  end;
              end;

          end;
          self.Caption :='del success' ;
    except
           on err:exception do
           showmessage(err.Message );
    end;

end;

procedure TFrmManageFrm.dbedt73DblClick(Sender: TObject);
begin
    {if MessageBox(0, '需要BoxID?', '', MB_YESNO + MB_ICONQUESTION) = IDYES then
    begin
         if dsOpenEditorT616.FieldByName ('f03').AsString ='' then
         dsOpenEditorT616.FieldByName ('f03').Value :=getboxid            ;
    end
    else
    begin

         if Sender is Tdbedit then
      FhlUser.ShowModalTreeGridFrm('34', Tdbedit(sender).Text,true ).ShowModal ;

    end;
    }
   dmfrm.actGetMaxBoxId.OnExecute (sender) ;

end;

procedure TFrmManageFrm.dbedt74Click(Sender: TObject);
var   frmGetGridID: TfrmGetGridID;
begin
  frmGetGridID:= TfrmGetGridID.Create (nil);
  if tdbedit(sender).Text<>''   then
  frmGetGridID.edtmtdatasetID.Text   :=tdbedit(sender).Text ;
  frmGetGridID.ShowModal;

end;

function TFrmManageFrm.getMaxT616f01: string;
begin
    dmFrm.GetQry_Sys('select max(convert(int,f01)) as maxpk From t616 where f01<>'+quotedstr('ph_ArriveX'));        //label

    result:= inttostr( dmFrm.qryFree_Sys.FieldByName('maxpk').AsInteger +1 );
end;

procedure TFrmManageFrm.dbedt83DblClick(Sender: TObject);
var   frmGetGridID: TfrmGetGridID;
begin
      frmGetGridID:= TfrmGetGridID.Create (nil);
      frmGetGridID.edtgridID.Text   :=tdbedit(sender).Text ;
      frmGetGridID.ShowModal;
end;

procedure TFrmManageFrm.cbbPickWindowClick(Sender: TObject);
begin


if  dsPickT603.FieldByName('f10').AsString  ='' then
    dsPickT603.FieldByName ('f10').AsString  :=inttostr(cbbPickWindow.Itemindex )
else
    dsPickT603.FieldByName ('f10').AsString  :=    dsPickT603.FieldByName ('f10').AsString  +','+inttostr(cbbPickWindow.Itemindex )

end;

procedure TFrmManageFrm.dbedt96DblClick(Sender: TObject);
var   frmGetGridID: TfrmGetGridID;
begin
  if   dsBill.FieldByName('f34').Value='' then
  begin
        if MessageBox(0, '生成弃单界面？', '', MB_YESNO + MB_ICONQUESTION) = IDYES then
        begin

                  if dsbill.State in [dsedit,dsinsert]        then
                  begin
                      dsBill.FieldByName('f34').Value :=getGridID     ;
                      frmGetGridID:= TfrmGetGridID.Create (nil);
                      if tdbedit(sender).Text<>''   then
                      frmGetGridID.edtgridID.Text    :=tdbedit(sender).Text ;
                      frmGetGridID.ShowModal;
                  end
                  else
                      showmessage('请先按编辑');
        end;

  end
  else
  begin
      frmGetGridID:= TfrmGetGridID.Create (nil);
      if tdbedit(sender).Text<>''   then
      frmGetGridID.edtgridID.Text    :=tdbedit(sender).Text ;
      frmGetGridID.ShowModal;
  end;      

end;
procedure TFrmManageFrm.dbedt37Click(Sender: TObject);
var   frmGetGridID: TfrmGetGridID;
begin
  frmGetGridID:= TfrmGetGridID.Create (nil);
  if tdbedit(sender).Text<>''   then
  frmGetGridID.edtmtdatasetID.Text   :=tdbedit(sender).Text ;
  frmGetGridID.ShowModal;

end;

procedure TFrmManageFrm.cbbOpenEditorClick(Sender: TObject);
begin
    dsOpenEditorT616.Edit ;
    if  dbedt96.Text ='' then
        dsOpenEditorT616.FieldByName ('f15').AsString  :=inttostr(cbbOpenEditor.Itemindex )
    else
        dsOpenEditorT616.FieldByName ('f15').AsString  :=    dsOpenEditorT616.FieldByName ('f15').AsString +','+inttostr(cbbOpenEditor.Itemindex );
    dsOpenEditorT616.Post ;
end;

function TFrmManageFrm.GetT606PK: string;
begin
    dmFrm.GetQry_Sys('select max(convert(int,f01)) as f01 From t606 where isnumeric(f01)=1');        //label

    result:= inttostr( dmFrm.qryFree_Sys.FieldByName('f01').AsInteger +1 );

end;

procedure TFrmManageFrm.cmbPickUniversalClick(Sender: TObject);
begin
if  dsT623.FieldByName('f09').AsString  ='' then
    dsT623.FieldByName ('f09').AsString  :=inttostr(Tcombobox(Sender).Itemindex )
else
    dsT623.FieldByName ('f09').AsString  :=    dsT623.FieldByName ('f09').AsString  +','+inttostr(Tcombobox(Sender).Itemindex )

end;

procedure TFrmManageFrm.DBEdit9DblClick(Sender: TObject);
begin

           dsT623.FieldByName ('f11').Value :=getboxid            ;


end;

procedure TFrmManageFrm.openT623Click(Sender: TObject);
begin
if dsBill.FieldByName('F35').AsString <>'' then
      fhlknl1.Ds_OpenDataSet(dsT623 ,dsBill.FieldByName('F35').AsString )
else
   fhlknl1.Ds_OpenDataSet(dsT623 ,'1' );
end;

procedure TFrmManageFrm.DBEdit10DblClick(Sender: TObject);
var   frmGetGridID: TfrmGetGridID;
begin
  frmGetGridID:= TfrmGetGridID.Create (nil);
  frmGetGridID.edtgridID.Text   :=tdbedit(sender).Text ;
  frmGetGridID.ShowModal;
end;

procedure TFrmManageFrm.DBEdit12Click(Sender: TObject);
var   frmGetGridID: TfrmGetGridID;
begin
  frmGetGridID:= TfrmGetGridID.Create (nil);
  if tdbedit(sender).Text<>''   then
  frmGetGridID.edtmtdatasetID.Text   :=tdbedit(sender).Text ;
  frmGetGridID.ShowModal;

end;

procedure TFrmManageFrm.dbedt21DblClick(Sender: TObject);
var FrmTrigger:TFrmTrigger;
begin
      FrmTrigger:=TFrmTrigger.Create (nil);
      FrmTrigger.edtFrmID.Text :=  Tdbedit(Sender).Text ;
      FrmTrigger.ShowModal ;
end;

end.
