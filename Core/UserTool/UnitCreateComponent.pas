unit UnitCreateComponent;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, ADODB, Grids, DBGrids, ExtCtrls,FhlKnl,
  ComCtrls, Mask,UnitUpdateProerty,datamodule, Menus,UPublicCtrl,StrUtils,
  DBCtrls,UnitGetGridIDTreeID, ToolWin, CheckLst;

type TcontrolEx=class(Tcontrol)
end;


type
  TfrmCreateComponent = class(TForm)
    pgcM: TPageControl;
    ts1: TTabSheet;
    ts2: TTabSheet;
    rg1: TRadioGroup;
    grpGrpParent: TGroupBox;
    grp2: TGroupBox;
    btnCreateComponent: TButton;
    btnSavetoDataBase: TButton;
    btnDisplayExistsFields: TButton;
    mm1: TMainMenu;
    r1: TMenuItem;
    grp1: TGroupBox;
    btnshowAllNeedFields: TButton;
    edt1: TEdit;
    lbl2: TLabel;
    lstExistFields: TListBox;
    btnCreatedFields: TButton;
    pgc2: TPageControl;
    ts4: TTabSheet;
    ts5: TTabSheet;
    lbl3: TLabel;
    grp3: TGroupBox;
    lbl4: TLabel;
    lbl5: TLabel;
    grp4: TGroupBox;
    lbl7: TLabel;
    lbl8: TLabel;
    lbl9: TLabel;
    lbl10: TLabel;
    lbl11: TLabel;
    lbl12: TLabel;
    lbl14: TLabel;
    lbl15: TLabel;
    lbl16: TLabel;
    lbl17: TLabel;
    grp5: TGroupBox;
    lbl18: TLabel;
    lbl19: TLabel;
    lbl20: TLabel;
    lbl21: TLabel;
    lbl22: TLabel;
    qryT202: TADOQuery;
    dsT202: TDataSource;
    dbchkChecked: TDBCheckBox;
    dblkcbbFType: TDBLookupComboBox;
    dbedtFsize: TDBEdit;
    dbedtCaption: TDBEdit;
    dbedtPICKLIST: TDBEdit;
    dbchk1: TDBCheckBox;
    dbedt1: TDBEdit;
    dbedt2: TDBEdit;
    dbedt3: TDBEdit;
    dbedt4: TDBEdit;
    qryT102: TADOQuery;
    dsT102: TDataSource;
    btnAddT202: TButton;
    btnSaveT202: TButton;
    dbedtT202FieldID: TDBEdit;
    lbl13: TLabel;
    dbedt6: TDBEdit;
    lbl23: TLabel;
    btnAddT102: TButton;
    btnSaveT102: TButton;
    dbedtFieldName: TDBEdit;
    dbtxt2: TDBText;
    lbl24: TLabel;
    dblkcbbKind: TDBLookupComboBox;
    dbcbb1: TDBComboBox;
    dbcbb2: TDBComboBox;
    dbtxt1: TDBText;
    lbl25: TLabel;
    qryT201: TADOQuery;
    dsT201: TDataSource;
    dbcbb3: TDBComboBox;
    dbcbb4: TDBComboBox;
    dbedt9: TDBEdit;
    dbedt10: TDBEdit;
    btn7: TButton;
    btn8: TButton;
    btn12: TButton;
    btn13: TButton;
    btn14: TButton;
    qryGrid: TADOQuery;
    dsGrid: TDataSource;
    ifdGridF2: TIntegerField;
    ifdGridF3: TIntegerField;
    ifdGridF4: TIntegerField;
    qryGridF05: TBooleanField;
    qryGridF06: TBooleanField;
    qryGridF07: TBooleanField;
    qryGridF08: TBooleanField;
    qryGridF09: TStringField;
    qryGridF10: TBooleanField;
    qryGridF11: TStringField;
    ifdGridF12: TIntegerField;
    qryGridF13: TStringField;
    qryGridF14: TStringField;
    qryGridF15: TStringField;
    qryGridF16: TStringField;
    qryGridF17: TStringField;
    ifdGridF18: TIntegerField;
    qryGridF19: TStringField;
    qryGridF20: TStringField;
    ifdGridF21: TIntegerField;
    qryGridF22: TStringField;
    ifdGridF23: TIntegerField;
    ifdGridF24: TIntegerField;
    ts3: TTabSheet;
    lbl26: TLabel;
    lbl27: TLabel;
    lbl29: TLabel;
    lbl30: TLabel;
    dbgrd1: TDBGrid;
    grp6: TGroupBox;
    btn_saveAddCol: TButton;
    btnCol1: TButton;
    dbedt11: TDBEdit;
    dbchk2: TDBCheckBox;
    dbedt14: TDBEdit;
    dbchk3: TDBCheckBox;
    dbedt15: TDBEdit;
    lbl31: TLabel;
    dbedt16: TDBEdit;
    lbl32: TLabel;
    dbedtAlignment: TDBEdit;
    lbl33: TLabel;
    dbedt18: TDBEdit;
    lbl34: TLabel;
    dbedt19: TDBEdit;
    lbl35: TLabel;
    dbedt20: TDBEdit;
    lbl36: TLabel;
    dbedt21: TDBEdit;
    lbl37: TLabel;
    dbedt22: TDBEdit;
    lbl38: TLabel;
    dbedt23: TDBEdit;
    lbl39: TLabel;
    dbedt24: TDBEdit;
    lbl40: TLabel;
    dbedt25: TDBEdit;
    lbl41: TLabel;
    dbedt26: TDBEdit;
    lbl42: TLabel;
    dbedt27: TDBEdit;
    dbchkReadOnly: TDBCheckBox;
    dbchk5: TDBCheckBox;
    dbchk6: TDBCheckBox;
    dbedt28: TDBEdit;
    lbl43: TLabel;
    btncancel: TButton;
    btncolAdd: TButton;
    btnOpenDsGridExistCol: TButton;
    dbedt12: TDBEdit;
    btnedit: TButton;
    grpGrpParent_Btm: TGroupBox;
    ControlConfig: TMenuItem;
    LoadControl: TMenuItem;
    grp_FieldNeedToConfig: TGroupBox;
    lstFields: TListBox;
    pm_DelControl: TPopupMenu;
    del_control: TMenuItem;
    btnUpdate: TButton;
    lbl44: TLabel;
    lbl45: TLabel;
    EdtProc_Parameter: TEdit;
    btnProcParameter: TButton;
    grp7: TGroupBox;
    btnGridDelete: TButton;
    lbl46: TLabel;
    edtMtDataSetID: TEdit;
    btnT202Del: TButton;
    btnOpenT102: TButton;
    Label1: TLabel;
    edtFieldID: TEdit;
    lbl47: TLabel;
    dbedt29: TDBEdit;
    btnOpen: TButton;
    btnNext: TButton;
    btnPrior: TButton;
    lbl48: TLabel;
    edtT202FldName: TDBEdit;
    lbl49: TLabel;
    dbedt31: TDBEdit;
    ts6: TTabSheet;
    dsT607: TADODataSet;
    lbl50: TLabel;
    dbedt32: TDBEdit;
    dsST607: TDataSource;
    lbl51: TLabel;
    dbedt33: TDBEdit;
    lbl52: TLabel;
    dbedt34: TDBEdit;
    lbl53: TLabel;
    dbedt35: TDBEdit;
    lbl54: TLabel;
    dbedt36: TDBEdit;
    dbchk7: TDBCheckBox;
    lbl55: TLabel;
    dbedt37: TDBEdit;
    lbl56: TLabel;
    dbedt38: TDBEdit;
    lbl57: TLabel;
    dbedt39: TDBEdit;
    lbl58: TLabel;
    dbedt40: TDBEdit;
    lbl59: TLabel;
    dbedt41: TDBEdit;
    dbnvgr1: TDBNavigator;
    btnOpenT607: TButton;
    lbl60: TLabel;
    lbl61: TLabel;
    dbedt43: TDBEdit;
    lbl62: TLabel;
    dbcbb5: TDBComboBox;
    lbl63: TLabel;
    dbedt42: TDBEdit;
    lbl64: TLabel;
    dbedt44: TDBEdit;
    ts7: TTabSheet;
    dsT610: TADODataSet;
    lbl65: TLabel;
    dbedt45: TDBEdit;
    dsds610: TDataSource;
    lbl66: TLabel;
    dbedt46: TDBEdit;
    lbl67: TLabel;
    dbedt47: TDBEdit;
    lbl68: TLabel;
    dbedt48: TDBEdit;
    lbl69: TLabel;
    dbedt49: TDBEdit;
    lbl70: TLabel;
    dbedt50: TDBEdit;
    lbl71: TLabel;
    dbedt51: TDBEdit;
    lbl72: TLabel;
    dbedt52: TDBEdit;
    dbchk8: TDBCheckBox;
    dbchk9: TDBCheckBox;
    dbnvgr2: TDBNavigator;
    btnT610: TButton;
    lbl1: TLabel;
    lbl73: TLabel;
    dbedt53: TDBEdit;
    dsdsGetOneFieldInfo: TDataSource;
    lbl74: TLabel;
    dbedt54: TDBEdit;
    edtTable: TEdit;
    lbl75: TLabel;
    spGetOneFieldInfo: TADOStoredProc;
    spGetOneFieldInfoname: TWideStringField;
    spGetOneFieldInfolength: TSmallintField;
    spGetOneFieldInfoTypename: TWideStringField;
    ts8: TTabSheet;
    dbgrdFieldInfo: TDBGrid;
    pgc3: TPageControl;
    ts9: TTabSheet;
    ts10: TTabSheet;
    lblFieldName: TLabel;
    edtFieldname: TEdit;
    btn9GetFieldName: TButton;
    lstGridFieldsName: TListBox;
    lbl76: TLabel;
    edtTableID: TEdit;
    btnQAddField: TButton;
    btnCreateCtrl: TButton;
    lbledtLintCnt: TLabeledEdit;
    lbledtPosX: TLabeledEdit;
    lbledtPosy: TLabeledEdit;
    lbledtgap: TLabeledEdit;
    Refresh: TMenuItem;
    lbledtCtrlGap: TLabeledEdit;
    lbledtGapY: TLabeledEdit;
    btnCreateFields: TButton;
    lbledtFontSize: TLabeledEdit;
    dbchk10: TDBCheckBox;
    ts11: TTabSheet;
    btnDeleteT102: TButton;
    chkNewTool: TCheckBox;
    ToolBar1: TToolBar;
    tbALLeft: TToolButton;
    TbALRight: TToolButton;
    TbALTop: TToolButton;
    TbMoveLeft: TToolButton;
    TbMoveRight: TToolButton;
    TbMoveUP: TToolButton;
    TbMoveDown: TToolButton;
    edMoveSpan: TEdit;
    Label2: TLabel;
    TBVESpan: TToolButton;
    TbHEspan: TToolButton;
    BtnBatchQuote: TButton;
    Label3: TLabel;
    DBEdit1: TDBEdit;
    qryGridfieldEName: TStringField;
    DBLookupComboBox1: TDBLookupComboBox;
    EdtTBoxID: TEdit;
    Label4: TLabel;
    EdtBBoxID: TEdit;
    N1: TMenuItem;
    N2: TMenuItem;
    lstGridCols: TListBox;
    btnShowGirdCols: TButton;
    btnBatchCreateCols: TButton;
    lstGridField: TListBox;
    EditColTable: TEdit;
    BtnCreateColByTable: TButton;
    Lable1: TMenuItem;
    BtnDecWidth: TButton;
    BtnIncWidth: TButton;
    lable2: TMenuItem;
    Enable1: TMenuItem;
    TabSheet1: TTabSheet;
    Memo1: TMemo;
    BtnExec: TButton;
    MemFlds: TMemo;
    GridFildNames: TLabel;
    EdtFlds: TEdit;
    BtnCreateColByU8Table: TButton;
    BtnCreateaCols: TButton;
    BtnBatchCreatePRTFields: TButton;
    edtDataSetID: TEdit;
    qryGridF27: TStringField;
    Label5: TLabel;
    DBEdit2: TDBEdit;
    Label6: TLabel;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    DBEdit6: TDBEdit;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    lstParaFields: TCheckListBox;
    ChkSearchFields: TCheckBox;
    DBNavigator1: TDBNavigator;
    DBMemo1: TDBMemo;
    qryGridF28: TIntegerField;
    DBEdit7: TDBEdit;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    DBComboBox1: TDBComboBox;
    DBEdit8: TDBEdit;
    BtnIncTopGrpHeight: TToolButton;
    btnExpHGap: TToolButton;
    BtnDecHGap: TToolButton;
    imgtop: TImage;
    DBText1: TDBText;
    qryGridf01: TIntegerField;
    btnCreateCol: TButton;
    MClearDbClick: TMenuItem;
    chkUserMode: TCheckBox;
    edtGridID: TEdit;
    strngfldGridF50: TStringField;
    lbl6: TLabel;
    dbedt5: TDBEdit;
    Splitter1: TSplitter;
    DBEdit9: TDBEdit;
    Label13: TLabel;

    procedure btnCreateComponentClick(Sender: TObject);
    //=============2006-5-7 停用
    {procedure MouseMove_EX(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure MouseDown_Ex (Sender: TObject;  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure MouseUP_Ex (Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer); }

    procedure ControlDragOver(Sender, Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
    procedure ControlDragDrop(Sender, Source: TObject; X, Y: Integer);

    procedure DblClick_Ex(Sender: TObject) ;
    procedure    Click_Ex(Sender: TObject) ;

    procedure btnSavetoDataBaseClick(Sender: TObject);
    procedure btnshowAllNeedFieldsClick(Sender: TObject);
    procedure btnDisplayExistsFieldsClick(Sender: TObject);
    procedure lstFieldsMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure r1Click(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure btnCreatedFieldsClick(Sender: TObject);
    procedure btnAddT202Click(Sender: TObject);
    procedure btnSaveT202Click(Sender: TObject);
    procedure ShowT102Value(fieldName:string;TableID:string='');

    procedure ShowExistsFieldsValue(fieldName:string); 
    procedure lstParaFieldsClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dsT102DataChange(Sender: TObject; Field: TField);
    procedure btnSaveT102Click(Sender: TObject);
    procedure btnAddT102Click(Sender: TObject);
    procedure btn7Click(Sender: TObject);
    procedure btn8Click(Sender: TObject);
    procedure dblkcbbKindClick(Sender: TObject);
    procedure btn12Click(Sender: TObject);
    procedure btn13Click(Sender: TObject);
    procedure btn14Click(Sender: TObject);
    procedure lstExistFieldsClick(Sender: TObject);
    procedure btn_saveAddColClick(Sender: TObject);
    procedure btnCol1Click(Sender: TObject);
    procedure btnOpenDsGridExistColClick(Sender: TObject);
    procedure dblkcbbFTypeClick(Sender: TObject);
    procedure btncolAddClick(Sender: TObject);
    procedure btncancelClick(Sender: TObject);
    procedure dbedt12Exit(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btneditClick(Sender: TObject);
    procedure LoadControlClick(Sender: TObject);
    procedure edt1Change(Sender: TObject);
    procedure btnUpdateClick(Sender: TObject);
    procedure btnProcParameterClick(Sender: TObject);
    procedure btn9GetFieldNameClick(Sender: TObject);
    procedure dbedt12DragOver(Sender, Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
    procedure dbedt12DragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure lstGridFieldMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure btnGridDeleteClick(Sender: TObject);
    procedure getfieldID(fieldname:string;fieldlist:Tlistbox;Returnfieldname:string;Clear:boolean=true);
    procedure lstGridFieldDblClick(Sender: TObject);
    procedure lstParaFieldsMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure lstExistFieldsDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure lstExistFieldsDragOver(Sender, Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
    procedure lstExistFieldsDblClick(Sender: TObject);
    procedure btnT202DelClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btnOpenT102Click(Sender: TObject);
    procedure btnOpenClick(Sender: TObject);
    procedure btnNextClick(Sender: TObject);
    procedure btnPriorClick(Sender: TObject);
    procedure dbedt11DblClick(Sender: TObject);
    procedure btnOpenT607Click(Sender: TObject);
    procedure dbedt34DblClick(Sender: TObject);
    procedure qryT102AfterOpen(DataSet: TDataSet);
    procedure btnT610Click(Sender: TObject);
    procedure grpGrpParentDragOver(Sender, Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
    procedure grpGrpParentDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure lstFieldsClick(Sender: TObject);
    procedure edtTableDblClick(Sender: TObject);
    procedure edtTableExit(Sender: TObject);
    procedure btnQAddFieldClick(Sender: TObject);
    procedure btnCreateCtrlClick(Sender: TObject);
    procedure edtMtDataSetIDDblClick(Sender: TObject);
    procedure btnCreateFieldsClick(Sender: TObject);
    procedure btnShowGirdColsClick(Sender: TObject);
    procedure btnBatchCreateColsClick(Sender: TObject);
    procedure lstGridColsClick(Sender: TObject);
    procedure btnDeleteT102Click(Sender: TObject);
    procedure lstFieldsDblClick(Sender: TObject);
    procedure dbedt12DblClick(Sender: TObject);
    procedure lstParaFieldsDblClick(Sender: TObject);
    procedure tbALLeftClick(Sender: TObject);
    procedure TbALRightClick(Sender: TObject);
    procedure TbALTopClick(Sender: TObject);
    procedure TbMoveLeftClick(Sender: TObject);
    procedure TbMoveRightClick(Sender: TObject);
    procedure TbMoveUPClick(Sender: TObject);
    procedure TbMoveDownClick(Sender: TObject);
    procedure TBVESpanClick(Sender: TObject);
    procedure TbHEspanClick(Sender: TObject);
    procedure BtnBatchQuoteClick(Sender: TObject);
    procedure dbchkReadOnlyClick(Sender: TObject);
    procedure grpGrpParent_BtmDragOver(Sender, Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
    procedure grpGrpParent_BtmDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure N2Click(Sender: TObject);
    procedure BtnCreateColByTableClick(Sender: TObject);
    procedure Lable1Click(Sender: TObject);
    procedure BtnDecWidthClick(Sender: TObject);
    procedure BtnIncWidthClick(Sender: TObject);
    procedure lable2Click(Sender: TObject);
    procedure Enable1Click(Sender: TObject);
    procedure BtnCreateColByU8TableClick(Sender: TObject);
    procedure BtnCreateaColsClick(Sender: TObject);
    procedure BtnBatchCreatePRTFieldsClick(Sender: TObject);
    procedure lstGridFieldMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure BtnIncTopGrpHeightClick(Sender: TObject);
    procedure btnExpHGapClick(Sender: TObject);
    procedure BtnDecHGapClick(Sender: TObject);
    procedure imgtopMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure imgtopMouseMove(Sender: TObject; Shift: TShiftState; X,Y: Integer);
    procedure imgtopMouseUp(Sender: TObject; Button: TMouseButton;   Shift: TShiftState; X, Y: Integer);
    procedure chyMouseUp(Sender: TObject;    Button: TMouseButton;   Shift: TShiftState; X, Y: Integer);
    procedure chyMouseDown(Sender: TObject;    Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure imgtopDragOver(Sender, Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
    procedure imgtopDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure edtGridIDDblClick(Sender: TObject);
    procedure dbedtFieldNameChange(Sender: TObject);
    procedure edtFieldIDDblClick(Sender: TObject);
    procedure btnCreateColClick(Sender: TObject);
    procedure dbedtFieldNameDblClick(Sender: TObject);
    procedure MClearDbClickClick(Sender: TObject);
    procedure chkUserModeClick(Sender: TObject);
    procedure RefreshClick(Sender: TObject);
  private
    function  GetCtrlTypeIndex(sender:Tobject):string;
    procedure CreateControlObj(contralClass:TcontrolClass;parent:Twincontrol);
    procedure SavePorpertyToDataBase(sender:Tlabel_Mtn);  overload;
    procedure SavePorpertyToDataBase(sender :TEdit_Mtn) ;overload;
    procedure SavePorpertyToDataBase(sender :TDbRadioGroup);overload;
    procedure getfieldTolist(desList:Tstrings;sql:string;connectionstring:string);   overload;
    procedure getfieldTolist(desList:Tstrings;sql:string;connection:TADOConnection);   overload;
    function  isinteger(value:string):boolean;

    procedure ExecSql(sql:string;Return:boolean;SysDataBase:boolean);

    function StrExistsInLst(Str:string;Lst:Tstrings):boolean;
    function GetFieldECaption(FieldName:string):string;
    function GetFieldType(FieldName:string):string;
    function GetFieldLength(FieldName:string):string;
    { Private declarations }
  public
    { Public declarations }
    drawing:boolean;
    oldx,oldy,newx,newy:integer;
    fstpt:Tpoint;

    TopOrBtm   :  boolean; //标志现在指向的位置，  true =top  false=btm
    TOPBoxId:string;
    BtmBOXID:string;
    DlGridId:string;
    mtDataSetId:string;
    mtDataSource1:TdataSource;
    mtDataSet1:TadodataSet;
    DLDataSet1:TadodataSet;
    DLGrid:TDbGrid;
    ModelType       :TFormType;     //使用哪个模板
    fbilldict       :TBillDict;     //billfrm 数据字典
    fAnalyserDict   :TAnalyserDict;
    fTabGridDict    :TTabGridDict    ;
    fTreeEditorDict :TTreeEditorDict;
    FTreeGridDict   :TTreeGridDict;
    FEditorDict     :TEditorDict;
    FTTabeditorDict :TTabEditorDict;
    FTLookupDict    :TLookupDict  ;
    FTBilOpnDlgDict :  TBilOpnDlgDict     ;
    FTPickDict:TPickDict;
    FormId:integer;
private
   FCollector:Tstrings;    
end;

var
   frmCreateComponent: TfrmCreateComponent;
   index :integer;
   Px,Py:integer;//鼠标右击坐标
   ColIndex:integer;
   CurrentCol: Tcolumn;
implementation
uses Editor;
  
{$R *.dfm}
procedure TfrmCreateComponent.CreateControlObj(contralClass: TcontrolClass;parent:Twincontrol);
var acontrolObj:Tcontrol;
var temp:Tcontrol;
begin
    if contralClass.ClassName <> 'TLabel'  then
    begin
        temp:= contralClass.Create(nil);
        //acontrolObj :=TEdit.Create(nil);
        acontrolObj :=Tedit_Mtn.Create(nil);
        acontrolObj.Parent:=parent;
        TEdit(acontrolObj).Text := temp.ClassName;
        TEdit(acontrolObj).Tag:= strtoint(GetCtrlTypeIndex(temp));           //typeID
        acontrolObj.Name:=contralClass.ClassName+inttostr(index) ;
        acontrolObj.Width :=120;
        acontrolObj.ShowHint :=true;
        //TEdit(acontrolObj).OnDblClick := DblClick_Ex;
        TEdit(acontrolObj).onDragDrop:=ControlDragDrop;
        TEdit(acontrolObj).onDragOver:=ControlDragOver;
        TEdit(acontrolObj).OnDblClick := DblClick_Ex;
        TEdit(acontrolObj).OnClick := Click_Ex;
        temp.Free;
    end
    else
    begin
        acontrolObj :=Tlabel_Mtn.Create(nil);
        acontrolObj.Parent:=parent;
        TLabel(acontrolObj).Font.Style := TLabel(acontrolObj).Font.Style+ [fsBold ]	;
        TLabel(acontrolObj).Color :=StringToColor('clCream');
        acontrolObj.Name:=contralClass.ClassName+inttostr(index) ;
        TcontrolEx(acontrolObj).OnDblClick := DblClick_Ex;
        TcontrolEx(acontrolObj).OnClick := Click_Ex;  
        acontrolObj.Hint :='0'  // 对应记录的pk f01
    end;

    inc(index);            
end;

procedure TfrmCreateComponent.DblClick_Ex(Sender: TObject);
var FrmUpdateProperty: TFrmUpdateProperty;
begin
    FrmUpdateProperty:=TFrmUpdateProperty.Create (self);
    FrmUpdateProperty.Acontrol := Tcontrol(Sender);
    if Sender is tlabel then
    begin
        FrmUpdateProperty.edtCaption.Text :=  (Sender as Tlabel_Mtn).Caption ;
        FrmUpdateProperty.edtECaption.Text :=  (Sender as Tlabel_Mtn).ECaption ;
        (FrmUpdateProperty.Acontrol as Tlabel).Color :=(Sender as Tlabel).Color ;
        FrmUpdateProperty.lbl1.Font:=(Sender as Tlabel).Font ;
    end;
    FrmUpdateProperty.rg1.ItemIndex :=  Tcontrol(Sender).Tag ;
    FrmUpdateProperty.Show ;
end;

procedure TfrmCreateComponent.btnCreateComponentClick(Sender: TObject);
const ControlClassArray:array[0..13] of
TcontrolClass=(Tlabel,TFhlDbEdit,TDbedit,TDblookuplistbox,
      TDbRichEdit,TFhlDbLookupComboBox,TDbMemo,
      TDbCheckBox, TDbText  , TFhlDbDatePicker,
      TDbRadioGroup ,TDBListBox,TDbComboBox ,Tdbimage  )  ;
var i:integer;
begin
    for i:=0 to grpGrpParent.controlcount-1 do
    begin
        if (grpGrpParent.controls[i] is Tlabel)    or
       (grpGrpParent.controls[i] is TFhlDbEdit)   or
       (grpGrpParent.controls[i] is TDbEdit)   or
       (grpGrpParent.controls[i] is TDblookuplistbox)   or
       (grpGrpParent.controls[i] is TDbRichEdit)   or
       (grpGrpParent.controls[i] is TFhlDbLookupComboBox)   or
       (grpGrpParent.controls[i] is TDbMemo)   or
       (grpGrpParent.controls[i] is TDbCheckBox)   or
       (grpGrpParent.controls[i] is TDbText)   or
       (grpGrpParent.controls[i] is TFhlDbDatePicker)   or
       (grpGrpParent.controls[i] is TDbRadioGroup)   or
       (grpGrpParent.controls[i] is TDBListBox)   or
       (grpGrpParent.controls[i] is TDbComboBox)   or
       (grpGrpParent.controls[i] is Tdbimage)        then
    end;
    
    if rg1.itemindex>-1 then
    CreateControlObj(controlClassArray[rg1.itemindex],grpGrpParent);
end;





procedure TfrmCreateComponent.btnSavetoDataBaseClick(Sender: TObject);
var i:integer;
var grpbox:Tgroupbox;

var Lst:Tstringlist;
begin
Lst:=Tstringlist.Create ;

if self.TopOrBtm  then
   grpbox:=grpGrpParent
else
   grpbox:=grpGrpParent_Btm;

try dmFrm.ADOConnection1.BeginTrans   ;
    for i:=0 to grpbox.controlcount-1 do
    begin
           if (grpbox.controls[i] is TEdit) then
           begin
              Lst.CommaText :=   (grpbox.controls[i] as TEdit).Hint;
              if  isinteger( Lst[0] )then  //if  the hint is fieldID  then continue else break. fieldID is integer
              SavePorpertyToDataBase(grpbox.controls[i] as TEdit_Mtn)
              else
              break
           end;
           if (grpbox.controls[i] is TDbRadioGroup) then
           begin
              if  isinteger(  (grpbox.controls[i] as TDbRadioGroup).Hint )then  //if  the hint is fieldID  then continue else break. fieldID is integer
              SavePorpertyToDataBase(grpbox.controls[i] as TDbRadioGroup)
              else
              break
           end;
           if  (grpbox.controls[i] is Tlabel) then
           SavePorpertyToDataBase ( grpbox.controls[i] as Tlabel_Mtn );
    end;

    dmFrm.ADOConnection1.CommitTrans ;
     self.Caption := self.Caption +'控键  保存成功';
except
    dmFrm.ADOConnection1.RollbackTrans ;
end;
end;

procedure TfrmCreateComponent.SavePorpertyToDataBase(sender: Tlabel_Mtn);
var qry:Tadoquery;
sql:string;
BOXID:string;
begin

    if sender.Color =stringtocolor('clblack') then exit;

    if topORBtm then
    BOXID:=self.TOPBoxId
    else
    BOXID:=self.BtmBOXID ;

    qry:=Tadoquery.Create (nil);
    qry.Connection :=FhlKnl1.Connection;
    if BOXID='' then
    begin
        showmessage('BOXID 为空');
        exit;
    end;

    sql:='select *from t503 where f02 ='+quotedstr(BOXID )+' and f03='+quotedstr(Tlabel(sender).Caption  );
    qry.SQL.Clear ;
    qry.SQL.Add(sql);
    qry.Open;
    if not qry.IsEmpty then
      qry.Edit
    else
     qry.Append;

     qry.FieldByName('f02').Value:= BoxId;
     qry.FieldByName('f03').Value:= sender.Caption ;
     qry.FieldByName('f04').Value:= sender.Left;
     qry.FieldByName('f05').Value:= sender.top  ;

     qry.FieldByName('f06').Value:=ColorToString ( sender.color);
     qry.FieldByName('f07').Value:= sender.Transparent  ;
     qry.FieldByName('f08').Value:= sender.Font.Name ;
     qry.FieldByName('f09').Value:= sender.Font.Size ;
     qry.FieldByName('f10').Value:= colortostring(sender.Font.Color );

     if   fsBold in    sender.Font.Style then
          qry.FieldByName('f11').Value:= 1
     else
          qry.FieldByName('f11').Value:= 0;

     if   fsUnderline in    sender.Font.Style then
          qry.FieldByName('f12').Value:=  1
     else
          qry.FieldByName('f12').Value:=0;

     qry.FieldByName('f13').Value:= '';
     qry.FieldByName('f50').Value:= sender.ECaption ;
     qry.FieldByName('f300').Value:=sender.isUserMode ;

    try
          qry.Post ;
         qry.Free;
    except
        on err:exception do
        begin
            showmessage(err.Message );
            qry.Free;
        end;
    end;

end;
procedure TfrmCreateComponent.SavePorpertyToDataBase( sender: TDbRadioGroup);   // SavePorpertyToDataBase
var qry:Tadoquery;
var sql,BOXID:string;
begin

      if topORBtm then
      BOXID:=self.TOPBoxId
      else
      BOXID:=self.BtmBOXID ;

      qry:=Tadoquery.Create (nil);
      qry.Connection :=FhlKnl1.Connection;
      sql:='select * from T502  where f02='+BOXID+' and f03='+sender.Hint ;
      qry.SQL.Clear ;
      qry.SQL.Add(sql);
      qry.Open ;

      if not qry.IsEmpty then
          qry.Edit
      else
          qry.Append;

     qry.FieldByName('f02').Value:= BoxId;
     qry.FieldByName('f03').Value:= sender.Hint;     // f12   CtrlTypeId        1:  TFhlDbEdit       5:  TFhlDbLookupComboBox        6:  TDbMemo       7:  TDbCheckBox        8:  TDbText      9:  TFhlDbDatePicker             12: TDbComboBox
     qry.FieldByName('f04').Value:= sender.Left;
     qry.FieldByName('f05').Value:= sender.top  ;

     qry.FieldByName('f06').Value:= sender.Width;
     qry.FieldByName('f07').Value:= sender.Height  ;
     qry.FieldByName('f08').Value:= ColorToString(sender.Color);
     qry.FieldByName('f09').Value:= sender.ReadOnly ;
     qry.FieldByName('f10').Value:= 0;                      // F10 AS PwChar,

     qry.FieldByName('f11').Value:= '';                     // f11 Hint
     qry.FieldByName('f12').Value:= inttostr(sender.tag)  ; // f12 CtrlTypeId        1:  TFhlDbEdit       5:  TFhlDbLookupComboBox        6:  TDbMemo       7:  TDbCheckBox        8:  TDbText      9:  TFhlDbDatePicker        10: TDbRadioGroup        12: TDbComboBox;
     qry.FieldByName('f13').Value:= 1;                      // f13  这模块没用到   功能尚不清楚
     qry.FieldByName('f14').Value:= sender.Font.Name ;
     qry.FieldByName('f15').Value:= sender.Font.Size;

     qry.FieldByName('f16').Value:= ColorToString(sender.Font.Color  );
     qry.FieldByName('f17').Value:= sender.TabOrder;                     // f17   OrderIndex
     qry.FieldByName('f18').Value:= -1 ;                     // c.F18 AS ClickId,
     qry.FieldByName('f19').Value:= -1;                      // c.F19 AS DblClickId,
     qry.FieldByName('f20').Value:= -1;                      // c.F20 AS ExitId,

     qry.FieldByName('f21').Value:= '';                      //  c.F21 AS LoginId,


try
    qry.Post;
    qry.Free ;
except
    on err:exception do
    begin
    showmessage(err.Message );
    qry.Free ;
    end;
end;

end;



procedure TfrmCreateComponent.SavePorpertyToDataBase(sender: TEdit_Mtn);   //SavePorpertyToDataBase
var qry:Tadoquery;
var sql,BOXID:string;

var actlist:Tstringlist;
begin
if sender.Color =stringtocolor('clblack')then exit;

      actlist:=Tstringlist.Create ;
      if length(sender.Hint)=4 then
          sender.Hint :=sender.Hint+',-1,-1,-1'
      else
          actlist.CommaText :=sender.Hint ;

      if topORBtm then
      BOXID:=self.TOPBoxId
      else
      BOXID:=self.BtmBOXID ;

      qry:=Tadoquery.Create (nil);
      qry.Connection :=FhlKnl1.Connection;
      sql:='select * from T502  where f02='+quotedstr(BOXID)+' and f03='+actlist[0] ;
      qry.SQL.Clear ;
      qry.SQL.Add(sql);
      qry.Open ;

      if not qry.IsEmpty then
          qry.Edit
      else
          qry.Append;

     qry.FieldByName('f02').Value:= BoxId;
     qry.FieldByName('f03').Value:= actlist[0]      ;              //sender.Hint;   //fieldID
     qry.FieldByName('f04').Value:= sender.Left;
     qry.FieldByName('f05').Value:= sender.top  ;

     qry.FieldByName('f06').Value:= sender.Width;
     qry.FieldByName('f07').Value:= sender.Height  ;
     qry.FieldByName('f08').Value:= ColorToString(sender.Color);
     qry.FieldByName('f09').Value:= sender.ReadOnly ;
     qry.FieldByName('f10').Value:= 0;                      // F10 AS PwChar,

     qry.FieldByName('f11').Value:= '';                     // f11 Hint
     qry.FieldByName('f12').Value:= inttostr(sender.tag)  ; // f12 CtrlTypeId        1:  TFhlDbEdit       5:  TFhlDbLookupComboBox        6:  TDbMemo       7:  TDbCheckBox        8:  TDbText      9:  TFhlDbDatePicker        10: TDbRadioGroup        12: TDbComboBox;
     qry.FieldByName('f13').Value:= 1;                      // f13  这模块没用到   功能尚不清楚
     qry.FieldByName('f14').Value:= sender.Font.Name ;
     qry.FieldByName('f15').Value:= sender.Font.Size;

     qry.FieldByName('f16').Value:=ColorToString(sender.Font.Color  );
     qry.FieldByName('f17').Value:= sender.TabOrder;                     // f17   OrderIndex

     qry.FieldByName('f18').Value:= actlist[1] ;                     // c.F18 AS ClickId,
     qry.FieldByName('f19').Value:= actlist[2];                      // c.F19 AS DblClickId,
     qry.FieldByName('f20').Value:= actlist[3];                      // c.F20 AS ExitId,

     qry.FieldByName('f21').Value:= '';                      //  c.F21 AS LoginId,



     qry.FieldByName('f300').Value:=sender.isUserMode ;


 {   sql:='insert into  T502 (f02,f03,f04,f05,f06,f07,f08,f09,f10,f11,f12,f13,f14,f15,f16,f17,f18,f19,f20,f21) values (';

    sql:=sql+ quotedstr(BoxId)+ ',';
    sql:=sql+ quotedstr(sender.Text )+ ',';     //fieldID
    sql:=sql+ inttostr(sender.Left  )+ ',';
    sql:=sql+ inttostr(sender.top  )+ ',';
    sql:=sql+ inttostr(sender.Width   )+ ',';
    sql:=sql+ inttostr(sender.Height    )+ ',';
    sql:=sql+ quotedstr(colortostring(sender.Color    ))+ ',';
    if sender.ReadOnly then
      sql:=sql+  '1 ,'
    else
      sql:=sql+  '0 ,'  ;

    sql:=sql+  '0 ,';      //  c.F10 AS PwChar,
    sql:=sql+  'null  ,';  //f11 Hint
    sql:=sql+ inttostr(sender.tag)+ '  ,';     // f12   CtrlTypeId        1:  TFhlDbEdit       5:  TFhlDbLookupComboBox        6:  TDbMemo       7:  TDbCheckBox        8:  TDbText      9:  TFhlDbDatePicker        10: TDbRadioGroup        12: TDbComboBox

    sql:=sql+  '1  ,';                            // f13    这模块没用到   功能尚不清楚
    sql:=sql+ quotedstr(sender.Font.Name )+  ',';   //f14  FontName
    sql:=sql+ inttostr(sender.Font.Size )+  ',';      //f15 FontSize
    sql:=sql+ quotedstr(colortostring(sender.Font.Color  ))+  ',';     //f16 Fontcolor
    sql:=sql+ inttostr((sender.Tag  ))+  ',';                // f17   OrderIndex                                                      // f17 OrderIndex
    sql:=sql+   '-1 ,';                                              //c.F18 AS ClickId,

    sql:=sql+   '-1 ,';     //c.F19 AS DblClickId,
    sql:=sql+   '-1 ,';       //    	c.F20 AS ExitId,
    sql:=sql+   quotedstr('')+')';      //  c.F21 AS LoginId,


    }

try
    qry.Post;
    qry.Free ;
except
    on err:exception do
    begin
    showmessage(err.Message );
    qry.Free ;
    end;
end;

end;
procedure TfrmCreateComponent.btnshowAllNeedFieldsClick(Sender: TObject);
//var CommandText,tmpstr:string;
var i:integer;
begin
   //connectionstring :='Provider=SQLOLEDB.1;Persist Security Info=False;User ID=sa;Initial Catalog=wzjb03a;Data Source=localhost;Use Procedure for Prepare=1;Auto Translate=True;Packet Size=4096;Workstation ID=XTS1;Use Encryption for Data=False;Tag with column collation when possible=False';
    edtMtDataSetID.Text := inttostr(mtDataSet1.Tag)    ;
    self.Caption :=self.Caption +' '+mtDataSet1.CommandText ;
   if   assigned(mtDataSet1) and  ( mtDataSet1.CommandText<>'') then
   begin
      getfieldTolist(lstParaFields.Items, mtDataSet1.CommandText, mtDataSet1.Connection );
      for i:=0 to    lstParaFields.Count -1 do
      begin
      lstParaFields.Checked  [i]:=true;
      end;
      edt1.Text :=  mtDataSet1.CommandText ;
      EdtProc_Parameter.text:=fAnalyserDict.mtOpenParamFlds;
      edtMtDataSetID.Text := inttostr(mtDataSet1.Tag)    ;
      mtdatasetid:=edtMtDataSetID.Text;
   end
   else
      MessageBox(0, ' mtDataSet1 为nil', '', MB_OK + MB_ICONQUESTION);



      self.Caption :='sys: '+fhlknl1.Connection.DefaultDatabase +'    user:'+fhlknl1.UserConnection.DefaultDatabase
end;

procedure TfrmCreateComponent.getfieldTolist(desList:Tstrings;sql:string;connectionstring:string);
var qry:Tadoquery;
i:integer;
begin
qry := Tadoquery.Create(nil);
try
      qry.ConnectionString:= connectionstring;
      qry.SQL.add(sql);
      qry.Open ;
      desList.Clear;

      for i:=0 to qry.FieldCount -1 do
      begin
          desList.Add(qry.Fields[i].FieldName )   ;
      end;
finally
  qry.Free;
end;

end;

procedure TfrmCreateComponent.getfieldTolist(desList: Tstrings;
  sql: string; connection: TADOConnection);
var qry:Tadodataset;
      i:integer;
begin
    qry := Tadodataset.Create(nil);
    try
          qry.Connection:= connection;
          if pos('(',mtDataSet1.CommandText)>-1 then
          begin
           qry.Prepared :=true;
           qry.Parameters.AddParameter ;
           qry.Parameters[0].Value :='0';
          end;



          qry.CommandText :=sql; 
          if uppercase( leftstr(trim(sql),6))<>uppercase('select') then
          begin
             qry.CommandType :=  cmdStoredProc;
             qry.Parameters.Refresh ;
          end;

          for i:=0 to qry.Parameters.Count -1 do
          begin
              if  ((qry.Parameters[i].DataType  =ftDate )or  (qry.Parameters[i].DataType  =ftTime )or (qry.Parameters[i].DataType  = ftDateTime ))then
                 qry.Parameters[i].Value :='2001-1-1'
              else
                 qry.Parameters[i].Value :='0' ;

          end;

          qry.Open ;
          desList.Clear;

          for i:=0 to qry.FieldCount -1 do
          begin
              desList.Add(qry.Fields[i].FieldName )   ;

          end;

    finally
      qry.Free;
    end;
end;
procedure TfrmCreateComponent.btnDisplayExistsFieldsClick(Sender: TObject);
var sql:string;
qry:Tadoquery;
values,valLst:string;
i:integer;
begin
grp_FieldNeedToConfig.Visible :=true;

lstFields.Clear;
lstExistFields.Clear ;

if  mtDataSetId<>'' then
begin

        if edtMtDataSetID.Text ='' then
            sql:='select fieldID,datasetId,name,label from V201_getCtrlField where datasetId='+mtDataSetId       +' order by F200'
        else
            sql:='select fieldID,datasetId,name,label from V201_getCtrlField where datasetId='+edtMtDataSetID.Text +' order by F200'   ;

            qry:=Tadoquery.Create (nil);
        try
            qry.Connection :=FhlKnl1.Connection;
            qry.SQL.Clear ;
            qry.SQL.Add(sql);
            qry.open ;

            lstFields.Clear;
            lstExistFields.Clear ;
            if not qry.IsEmpty then
            begin
                  while not qry.Eof do
                  begin
                        values:= qry.FieldByName('name').AsString +'='+qry.FieldByName('fieldID').AsString  +','+ qry.FieldByName('label').AsString ;
                        valLst:= qry.FieldByName('fieldID').AsString  +'='+qry.FieldByName('name').AsString  ;  //+ qry.FieldByName('label').AsString+','+
                        lstFields.items.Add(valLst) ;
                        lstExistFields.items.Add(values) ;
                        qry.Next;
                  end;
            end
            else
                   self.Caption :=self.caption +'还没有建立字段!';

        finally
          qry.Free;
        end;
end
else
begin    //TreeEdit 没有参数
        lstGridField.Clear ;
        for i :=0 to mtDataSet1.FieldCount -1 do
        begin
              values:=mtDataSet1.Fields [i].fieldName ;// qry.FieldByName('name').AsString +'='+qry.FieldByName('fieldID').AsString  +','+ qry.FieldByName('label').AsString ;
              lstGridField.items.Add(values) ;
         end;



end;

end;

procedure TfrmCreateComponent.lstFieldsMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
if shift= [ssLeft] then
lstFields.BeginDrag(true);
end;



procedure TfrmCreateComponent.r1Click(Sender: TObject);
begin
rg1.Show;
end;

procedure TfrmCreateComponent.FormHide(Sender: TObject);
begin
rg1.Hide;
end;

procedure TfrmCreateComponent.btnCreatedFieldsClick(Sender: TObject);
begin
btnDisplayExistsFields.Click;
end;

procedure TfrmCreateComponent.btnAddT202Click(Sender: TObject);
var i:integer;
begin
  i :=lstExistFields.Items.IndexOfName( self.qryT102.fieldbyname('F02').AsString ) ;

 if i>-1 then
 begin
   ShowMessage('field already exits');
  // Exit;
 end;

{qryT202.SQL.Clear ;
qryT202.SQL.Add('select top 1 *From t102');
showmessage(qryT202.ConnectionString); 
qryT202.Close;
qryT202.Open;
}
qryT202.Close;
qryT202.Open;
qryT202.Append ;

if   edtMtDataSetID.Text ='' then
    dbedt6.Text :=mtDataSetId
else
    dbedt6.Text :=edtMtDataSetID.Text;

dbcbb2.Text :='sEmpty';
end;

procedure TfrmCreateComponent.btnSaveT202Click(Sender: TObject);
var i:integer;
    bExists:boolean;
begin
try
  bExists:=false;
  if   qryT202.State in [dsEdit, dsInsert] then
  begin
  // if fieldname already exists then it's not nesscery to add
  //
    for i:=0 to lstExistFields.Count -1 do
    begin
       if edtT202FldName.Text<>'' then
       if  lstExistFields.Items.ValueFromIndex[i]= edtT202FldName.Text  then
        bExists:=true;
    end;
    if not bExists then
    begin
      qryT202.Post;
      self.Caption :=self.caption +'字段与datasetid追加成功';
      btnCreatedFields.Click;
    end
    else
       if   qryT202.State in [dsEdit] then
            qryT202.Post
       else
            showmessage(edtT202FldName.Text +' already exists');
  end
  else
      showmessage('先按编辑');
except
   on err:exception do
   showmessage(err.Message );
end;



end;

procedure TfrmCreateComponent.ShowT102Value(fieldName:string;TableID:string='');


begin






     {}


end;

procedure TfrmCreateComponent.lstParaFieldsClick(Sender: TObject);
var sql:string ;
begin


  edtFieldname.Text :=   lstParaFields.Items [lstParaFields.itemindex];
  getfieldID( edtFieldname.Text ,lstFields,'f02');        //返回英文字段名

   // ShowT102Value(lstParaFields.Items [lstParaFields.itemindex],edtTable.Text );

      qryT102.Close;
      qryT102.SQL.Clear;

   if edtTableID.Text <>'' then
       sql:='select *From t102 where F03='+quotedstr(trim(edtTableID.Text ))  +' and  f02='+quotedstr(lstParaFields.Items [lstParaFields.itemindex])
    else
       sql:='select *From t102 where f02='+quotedstr(lstParaFields.Items [lstParaFields.itemindex]);

      qryT102.SQL.Add(sql);
      qryT102.Open ;

     {
   if edtTable.Text <>'' then
   begin
       if not spGetOneFieldInfo.Active then
       begin

           spGetOneFieldInfo.Close;
           spGetOneFieldInfo.Parameters[1].Value :=edtTable.Text;
           spGetOneFieldInfo.open  ;
       end
       else
       begin
            if not dbgrdFieldInfo.DataSource.DataSet.IsEmpty then 
            dbgrdFieldInfo.DataSource.DataSet.RecNo:=lstParaFields.itemindex+1 ;
       end;
   end;      }

end;

procedure TfrmCreateComponent.FormCreate(Sender: TObject);
var sql:string;
var FTypeDs,FKindDs:TdataSource;
var FQry,FKindQry,FFLDIDQry:Tadoquery;
begin
self.FCollector :=Tstringlist.Create ;

qryT102.Connection :=fhlknl1.Connection;
qryT202.Connection :=fhlknl1.Connection;
dsT607.Connection :=fhlknl1.Connection;
dsT610.Connection:=fhlknl1.Connection;
qryT201.Connection:=fhlknl1.Connection;
qryGrid.Connection:=fhlknl1.Connection;




self.Caption := fhlknl1.Connection.DefaultDatabase ;


// con1.DefaultDatabase:=fhlknl1.Connection.DefaultDatabase  ;
  FTypeDs := TdataSource.Create(self);
  FKindDs := TdataSource.Create(self);
//  FFLDIDDs:= TdataSource.Create(self);

      FQry:=Tadoquery.Create(self);
  FKindQry:=Tadoquery.Create(self);
 FFLDIDQry:=Tadoquery.Create(self);


      FQry.Connection       :=fhlknl1.Connection;
      FKindQry.Connection   :=fhlknl1.Connection;
      FFLDIDQry.Connection  :=fhlknl1.Connection;
      spGetOneFieldInfo.Connection :=fhlknl1.UserConnection ;

      
      sql:='select *   from  TFieldType order  by Findex ';
      FQry.SQL.Add(sql);
      FQry.Open ;

      FTypeDs.DataSet:=FQry;
      if not FQry.IsEmpty then
      begin
            dblkcbbFtype.ListSource:=FTypeDs;
            dblkcbbFtype.ListField :='FTypeNameEx';
            dblkcbbFtype.KeyField :='FIndex';
      end;
     //----------------------------------
      sql:= 'select *from TfieldKind';
      FKindQry.SQL.Add(sql);
      FKindQry.Open ;
      FKindDs.DataSet :=FKindQry  ;
      if not FKindQry.IsEmpty then
      begin
            dblkcbbKind.ListSource:=FKindDs;
            dblkcbbKind.ListField :='FkindName';
            dblkcbbKind.KeyField :='FKind';
      end;
    {  //------------------ //dblkcbbFLDID
      sql:= 'select f01,f02,f09 From t102';
      FFLDIDQry.SQL.Add(sql);
      FFLDIDQry.Open ;

      FFLDIDDs.DataSet :=FFLDIDQry  ;
      if not FFLDIDQry.IsEmpty then
      begin
            dblkcbbFLDID.ListSource:=FFLDIDDs;
            dblkcbbFLDID.ListField :='f02';
            dblkcbbFLDID.KeyField :='f01';
          //  dbedt18.Text :=dblkcbbFLDID.ListSource.DataSet.FieldValues ['f09'];
      end;
      }

end;

procedure TfrmCreateComponent.dsT102DataChange(Sender: TObject;
  Field: TField);
var  sql:string;
begin
 sql:='SELECT *  FROM T202  where f03='+quotedstr(dbtxt2.Caption )+' and f02='+quotedstr(edtMtDataSetID.Text  );
 qryT202.SQL.Clear ;
 qryT202.SQL.add(sql);
 qryT202.Close;
 qryT202.Open ;


 sql:=' select *From T201 where f01='+ quotedstr( dbedt1.Text) ;
 qryT201.SQL.Clear ;
 qryT201.SQL.Add(sql);
 qryT201.Close;
 qryT201.Open;
end;

procedure TfrmCreateComponent.btnSaveT102Click(Sender: TObject);
begin


try
   qryT102.Post;
   self.Caption :=self.caption +'字段追加成功';



   btnAddT202.Click;
   
         if ((qryT102.FieldByName('f04').AsString  ='0') and (qryT102.FieldByName('f05').AsString  ='')) then
    qryT202.FieldByName('f04').AsString :='sEmpty';
   if ((qryT102.FieldByName('f04').AsString  ='1' ) or (qryT102.FieldByName('f04').AsString  ='2' ) ) then
     qryT202.FieldByName('f04').AsString :='sToday';

   dbedtT202FieldID.Text :=dbtxt2.Caption ;
   edtT202FldName.Text  :=  dbedtFieldName.Text ;
except
   on err:exception do
   showmessage(err.Message );
end;
end;

procedure TfrmCreateComponent.btnAddT102Click(Sender: TObject);
var fieldCaption,fieldsize :string ;
var  fieldtypeid:string;
begin
     if not qryT102.Active then exit;

     if dbedtcaption.Text ='' then
        if lstParaFields.itemindex>-1 then
           fieldCaption:= GetFieldECaption(lstParaFields.Items [lstParaFields.itemindex])
       else
      fieldCaption:= dbedtcaption.Text ;





      if  qryT102.fieldbyname('f04').AsString   ='' then
      begin
        if lstParaFields.itemindex>-1 then
           fieldtypeid:= self.GetFieldType( lstParaFields.Items [lstParaFields.itemindex] )
      end
      else
            fieldtypeid:= qryT102.fieldbyname('f04').AsString    ;

      if  fieldtypeid   ='0'then
        if lstParaFields.itemindex>-1 then
        fieldsize:=self.GetFieldLength(  lstParaFields.Items [lstParaFields.itemindex] )
      else
      fieldsize:=   dbedtFsize.Text ;

      qryT102.Open;
      qryT102.Append;

      if edtTableID.Text ='' then
      begin
            qryT102.fieldbyname('f09').AsString  :=fieldCaption;
            if lstParaFields.itemindex>-1 then
            dbedtFieldName.Text :=lstParaFields.Items [lstParaFields.itemindex]      ;
            dbedtFsize.Text :='0';
                     qryT102.fieldbyname('f04').AsString:=fieldtypeid  ;
              qryT102.fieldbyname('f06').AsString:=fieldsize  ;
       end
       else
       begin
                   if lstParaFields.itemindex>-1 then
            dbedtFieldName.Text :=lstParaFields.Items [lstParaFields.itemindex]      ;
            qryT102.fieldbyname('f09').AsString  :=fieldCaption;
            dbedtFsize.Text := fieldsize;
              qryT102.fieldbyname('f04').AsString:=fieldtypeid  ;
              qryT102.fieldbyname('f06').AsString:=fieldsize  ;

       end;

end;

procedure TfrmCreateComponent.btn7Click(Sender: TObject);
begin
qryT202.Cancel;
end;

procedure TfrmCreateComponent.btn8Click(Sender: TObject);
begin
qryT102.Cancel;
end;

procedure TfrmCreateComponent.dblkcbbKindClick(Sender: TObject);
begin
if  dblkcbbKind.KeyValue ='l' then
 pgc2.TabIndex :=1;

end;

procedure TfrmCreateComponent.btn12Click(Sender: TObject);
begin

qryT201.Open ;
qryT201.Append;
end;

procedure TfrmCreateComponent.btn13Click(Sender: TObject);
begin
qryT201.Cancel;
end;

procedure TfrmCreateComponent.btn14Click(Sender: TObject);
begin



try
   qryT201.Post;

   if  qryT102.State in [dsinsert ,dsedit] then
 qryT102.FieldByName ('f14').AsString  :=dbtxt1.Caption  ;
   showmessage('追加成功');


except
   on err:exception do
   showmessage(err.Message );
end;


end;

procedure TfrmCreateComponent.ShowExistsFieldsValue(fieldName: string);
var sql:string;
begin
    qryT102.SQL.Clear;

    sql:=     'select distinct f.* FROM DBO.T202 D';
    sql:= sql+'     INNER JOIN DBO.T102 F ON D.F03 = F.F01 ';
    sql:= sql+' LEFT OUTER JOIN DBO.T201 DS ON DS.F01 = F.F14 ' ;
    sql:= sql+' where  f.f02='+quotedstr(fieldname) ;

    if not  ChkSearchFields.Checked then
    sql:= sql+'  and  d.f02='+ quotedstr(SELF.mtDataSetId   ) ;

    qryT102.SQL.Add(sql);
    qryT102.Close;
    qryT102.Open ;
end;

procedure TfrmCreateComponent.lstExistFieldsClick(Sender: TObject);
begin
if  lstExistFields.itemindex>=0 then
   ShowExistsFieldsValue( lstExistFields.Items.names[lstExistFields.itemindex])  ;

end;

function TfrmCreateComponent.GetCtrlTypeIndex(sender: Tobject): string;
var i:integer;
begin

for i:= 0 to  rg1.Items.Count -1  do
begin
    if (trim(sender.ClassName ))=(trim( rg1.Items.Names [i])) then
    break;
end;
if  1>rg1.Items.Count -1 then
showmessage('error')
else 
result:=inttostr(i);
end;


procedure TfrmCreateComponent.btn_saveAddColClick(Sender: TObject);
//var sql:string ;
begin
try
    qryGrid.Post;

    self.Caption :=self.caption + '栅位建立成功';
except
     on err:exception   do
     showmessage(err.Message)
end;
end;

procedure TfrmCreateComponent.btnCol1Click(Sender: TObject);
begin

   dbgrd1.Columns[colindex].Font.Style :=dbgrd1.Columns[colindex].Font.Style +[fsBold	];
   CurrentCol:= dbgrd1.Columns[colindex];

if colIndex<dbgrd1.Columns.Count -1 then
   inc(colIndex)
else
   colIndex:=0;

end;

procedure TfrmCreateComponent.btnOpenDsGridExistColClick(Sender: TObject);
var sql:string;
var i:integer;
begin
       qryGrid.SQL.Clear;
    if edtGridID.Text ='' then
    begin

        sql:='select *From T505 where f02='+quotedstr(dlgridId)+' order by f23 ';
  
    end
    else
    begin
           sql:='select *From T505 where f02='+quotedstr( edtGridID.Text)+' order by f23 ';
    end;
        qryGrid.SQL.Add(sql);
        qryGrid.Close;
        qryGrid.Open;
         edtGridID.Text :=self.DlGridId ;


   //qryGrid.DataSource.DataSet.DisableControls ;

   for i:=0 to   qryGrid.RecordCount -1 do
    begin
          MemFlds.Lines.Add(  DBLookupComboBox1.Text );
          qryGrid.Next ;
    end;
   qryGrid.First ;

end;

procedure TfrmCreateComponent.dblkcbbFTypeClick(Sender: TObject);
begin

if edtTableID.Text ='' then
    if trim( dblkcbbFType.text )= 'cftString: 0' then
    begin

        if (    pos( 'NOTE', uppercase(dbedtFieldName.Text) ) >0)   or (    pos( 'NAME', uppercase(dbedtFieldName.Text))>0)   then
        dbedtFsize.Text :='150'
        else    if      pos( 'CODE',uppercase(dbedtFieldName.Text) )>0 then
        dbedtFsize.Text :='30'
        else
        dbedtFsize.Text :='50'
    end
    else
        dbedtFsize.Text :='0'
end;

procedure TfrmCreateComponent.btncolAddClick(Sender: TObject);
begin
  qryGrid.Open;
  if not (qryGrid.State in [dsinsert]) then
  qryGrid.Append ;
  dbedt11.Text :=self.DlGridId ;
  dbedt28.Text :='70';
  
  dbedt14.Text :='clWhite';
  dbedt16.Text :='0';
  dbedtAlignment.Text :='0';
  dbedt19.Text :='clBtnface' ;
  dbedt21.Text :='宋体';
  dbedt22.Text :='10';
  dbedt23.Text :='clWindowText';
  dbedt24.Text :='宋体';
  dbedt25.Text :='10';
  dbedt26.Text :='clWindowText';





end;

procedure TfrmCreateComponent.btncancelClick(Sender: TObject);
begin
qryGrid.Cancel;
end;

procedure TfrmCreateComponent.dbedt12Exit(Sender: TObject);
begin
    dbedt18.Text :=  dbedtCaption.Text ;
end;

procedure TfrmCreateComponent.FormDestroy(Sender: TObject);
begin
FCollector.Free ;
qryGrid.Close;
qryT102.Close;
qryT201.Close;
qryT202.Close;
end;

function TfrmCreateComponent.isinteger(value: string): boolean;
begin
try
    strtoint(value);
    result:=true;
except
    result:=false;
end;

end;

procedure TfrmCreateComponent.btneditClick(Sender: TObject);
begin
if   qryGrid.Active then
  qryGrid.Edit;
end;



procedure TfrmCreateComponent.LoadControlClick(Sender: TObject);
begin

if self.TOPBoxId<>'' then
       EdtTBoxID.Text  :=TOPBoxId
else
      TOPBoxId:=EdtTBoxID.Text;

  if MessageBox(0, 'LoadControl?', '', MB_YESNO + MB_ICONQUESTION) = IDYES then
   begin
        if TopBoxId<>'' then      //top or buttom      create label and dbcontrol
        begin

              FhlKnl1.q_SetLabel_mtn (EdtTBoxID.Text ,grpGrpParent,self.FCollector );
              FhlKnl1.q_SetDbCtrl_mtn(EdtTBoxID.Text ,grpGrpParent,dmFrm.UserDbCtrlActLst,FCollector);

            //  grpGrpParent.Height :=200;// grpGrpParent.Height +5;
        end;    {}
        if BtmBoxId<>'' then
        begin
              FhlKnl1.q_SetLabel_mtn (self.BtmBOXID  ,grpGrpParent_Btm,self.FCollector );
              FhlKnl1.q_SetDbCtrl_mtn(self.BtmBOXID ,grpGrpParent_Btm,dmFrm.UserDbCtrlActLst,FCollector);
               {}
            //  grpGrpParent_Btm.Height :=  grpGrpParent_Btm.Height +5;
        end;
   end;
end;


procedure TfrmCreateComponent.ControlDragDrop(Sender, Source: TObject; X,
  Y: Integer);
begin
     if   (Sender as tedit).Hint  ='' then
          (Sender as tedit).Hint  :=Tlistbox (Source).Items.Names [Tlistbox (Source).ItemIndex] +',-1,-1,-1'
     else
          (Sender as tedit).Hint  :=Tlistbox (Source).Items.Names [Tlistbox (Source).ItemIndex] +rightstr( trim( (Sender as tedit).Hint),length(trim((Sender as tedit).Hint))-4);

     (Sender as tedit).text  :=Tlistbox (Source).Items.Values [leftstr((Sender as tedit).Hint ,4) ];//[Tlistbox (Source).ItemIndex] ;

end;

procedure TfrmCreateComponent.ControlDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin

if  Source is tlistbox then
Accept:=true;
end;



procedure TfrmCreateComponent.edt1Change(Sender: TObject);
begin
btnUpdate.Enabled :=true;
end;

procedure TfrmCreateComponent.btnUpdateClick(Sender: TObject);
var sql:string;
begin
if   ( edt1.text<>'') and    (  mtDataSetId<>'' ) then
begin
    sql:='update t201 set f03='+quotedstr(edt1.text )+'  where f01= '+ mtDataSetId ;
    self.ExecSql(sql,false,true);
end;

end;
procedure TfrmCreateComponent.btnProcParameterClick(Sender: TObject);
var sql:string;
begin
if   ( EdtProc_Parameter.text<>'') and    (  fAnalyserDict.mtDataSetId<>'' ) then
begin
    sql:='update t401 set f03='+quotedstr(EdtProc_Parameter.text )+'  where f01= '+ fAnalyserDict.LinkT401Pk  ;
    self.ExecSql(sql,false,true);
end;
end;
procedure TfrmCreateComponent.ExecSql(sql: string; Return,
  SysDataBase: boolean);
  var qry:Tadoquery;
begin
          qry:=Tadoquery.Create (nil);
      if    SysDataBase  then
          qry.Connection :=fhlknl1.Connection
      else
          qry.Connection :=fhlknl1.UserConnection ;

      qry.SQL.Add(sql);
      try
          if   not Return then
            qry.ExecSQL
          else
            qry.Open ;
          showmessage('OK' );
      except
            on err:exception do
            begin
                qry.free;
                showmessage(err.Message );
            end;
      end;

      qry.free;
end;



procedure TfrmCreateComponent.btn9GetFieldNameClick(Sender: TObject);
begin

    getfieldID(edtFieldname.Text ,lstGridField,'f09');
end;

procedure TfrmCreateComponent.getfieldID(fieldname:string;fieldlist:Tlistbox;Returnfieldname:string;Clear:boolean=true);
var qryLstField:Tadoquery;
i:integer;
sql:string;
begin
      qryLstField:=Tadoquery.Create(nil);
      qryLstField.Connection:=fhlknl1.Connection;;

      sql:='select distinct top 3  f01,'+Returnfieldname+' ,f09 from t102 where f02 ='+quotedstr(fieldname) +' order  by f01 desc ';

      qryLstField.sql.Add(sql);
      qryLstField.Open ;
      if  Clear then
      fieldlist.Clear;

      if  not qryLstField.IsEmpty then
            for i:=0 to qryLstField.Recordset.RecordCount -1 do
            begin
                 fieldlist.Items.Add(qryLstField.fieldbyname('f01').AsString +'='+qryLstField.fieldbyname(Returnfieldname).AsString) ;//+' '+qryLstField.fieldbyname('f09').AsString);
                 qryLstField.Next;
            end
      else
          self.Caption :=self.Caption +'没有该字段';

          qryLstField.Free;
      end;



procedure TfrmCreateComponent.dbedt12DragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin

self.ControlDragOver(Sender, Source, X,
  Y, State, Accept)
end;

procedure TfrmCreateComponent.dbedt12DragDrop(Sender, Source: TObject; X,
  Y: Integer);
  var temp:string;
  i:integer;
  fieldTypes:Tstrings;
begin

//Tlistbox (Source).Items.Names [Tlistbox (Source).ItemIndex]


//dbedt12.Text := trim(  ( Source as Tlistbox).Items.Names [( Source as Tlistbox).ItemIndex ]);
i:=   Tlistbox (Source).ItemIndex      ;

if i<>-1 then
begin
    temp:= Tlistbox (Source).Items.Names [Tlistbox (Source).ItemIndex] ;
    dbedt12.Text := temp;
    dbedt18.Text :=   ( Source as Tlistbox).Items.Values   [dbedt12.Text ] ;

    if qryGrid.FindField ('f50')<>nil then
       qryGrid.FieldByName ('f50').Value   := qryT102.FieldByName ('f02').Value ;//

    fieldTypes:=Tstringlist.Create ;
    fieldTypes.CommaText :='4,5,10,12';
    if   fieldTypes.IndexOf ( qryT102.FieldByName('f04').AsString)>-1 then
    dbedtAlignment.Text  :='2';

end;

end;

procedure TfrmCreateComponent.lstGridFieldMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
if shift= [ssLeft] then
lstGridField.BeginDrag(true);
end;

procedure TfrmCreateComponent.btnGridDeleteClick(Sender: TObject);
//var sql:string;
begin
if MessageBox(0, '删除记录?', '', MB_YESNO + MB_ICONQUESTION) = IDYES then
begin
     if   qryGrid.Active and  (not qryGrid.IsEmpty )then
     begin
        qryGrid.delete;

      end;
end;
end;





procedure TfrmCreateComponent.lstGridFieldDblClick(Sender: TObject);
begin
//    getfieldID(lstGridField.Items [lstGridField.itemindex],         lstFields,'f02');


lstFields.items.Add(lstGridField.Items [lstGridField.itemindex]);
end;

procedure TfrmCreateComponent.lstParaFieldsMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
if shift= [ssLeft] then
TlistBox(Sender).BeginDrag(true);
end;

procedure TfrmCreateComponent.lstExistFieldsDragDrop(Sender,
  Source: TObject; X, Y: Integer);
begin
     //

if MessageBox(0, '确定可用?', '', MB_YESNO + MB_ICONQUESTION) = IDYES then
begin
      try
          Tlistbox(sender).Items.Add(Tlistbox(source).Items[Tlistbox(source).Itemindex]);
          qryT202.Append;
          qryT202.FieldByName('f02' ).Value :=edtMtDataSetID.Text   ;
          qryT202.FieldByName('f03' ).Value :=dbtxt2.Caption ;
          qryT202.Post;
      except
           on err : exception  do
          showmessage(err.Message);
      end;
end;


{}


end;

procedure TfrmCreateComponent.lstExistFieldsDragOver(Sender,
  Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
begin

if Source is tlistbox then
accept:=true;

end;

procedure TfrmCreateComponent.lstExistFieldsDblClick(Sender: TObject);
begin
if MessageBox(0, '删除已经建立的字段?', '删除字段与mtdatasetID 的关联.', MB_YESNO + MB_ICONQUESTION) = IDYES then
begin
    if not qryT202.IsEmpty then
    qryT202.Delete; 
end  ;


end;

procedure TfrmCreateComponent.btnT202DelClick(Sender: TObject);
begin
if qryt202.Active  and (not qryt202.IsEmpty )then

 if MessageBox(0, '要删除?', '', MB_YESNO + MB_ICONQUESTION) = IDYES then
   begin
    qryT202.Delete ;

    btnCreatedFields.Click;
   end     ;



end;

procedure TfrmCreateComponent.FormActivate(Sender: TObject);
var sql,tmpsql:string;
var i:integer;
begin
//ModelFrmBill,ModelFrmTreeEditor,ModelFrmTreeGrid,ModelFrmAnalyser,ModelFrmTabEditor,ModelFrmTreeMgr,ModelTabGrid //模板类型

case  self.ModelType  of
      ModelFrmBill:
                  begin

                       if DLGridid='' then
                       DLGridid:= fbilldict.dlGridId    ;

                       if    mtDataSetId='' then
                             if self.mtDataSet1.Name ='dlDataSet1' then
                             begin
                                 fhlknl1.Kl_GetQuery2('select * from T504 where  f01='+  DLGridid )   ;
                                 self.mtDataSetId :=fhlknl1.FreeQuery.FieldByName('F03').asString;      //get dldatasetid
                             end
                             else
                                 self.mtDataSetId := fbilldict.mtDataSetId ;

                     //  mtDataSetId :=fbilldict.mtDataSetId  ;
                     if   TOPBoxId='' then
                     begin
                       TOPBoxId:=fbilldict.TopBoxId ;
                       BtmBOXID:=fbilldict.BtmBoxId ;
                    end;   

                  end;
      ModelFrmAnalyser:
                  begin
                       mtDataSetId := fAnalyserDict.mtDataSetId ;
                       TOPBoxId:=fAnalyserDict.TopBoxId ;
                       BtmBOXID:=fAnalyserDict.BtmBoxId ;
                       DLGridid:= fAnalyserDict.DbGridId ;
                  end;
      ModelTabGrid:
                  begin
                       if fTabGridDict.DbGridId <>''then
                       begin
                       DLGridid:= fTabGridDict.DbGridId ;
                       if      DLGridid<>'' then
                       begin
                          fhlknl1.Kl_GetQuery2('select * from T504 where  f01='+  DLGridid )   ;
                         self.mtDataSetId :=fhlknl1.FreeQuery.FieldByName('F03').asString;
                       end;
                       end;
                 end;
      ModelFrmTreeEditor:
                  begin
                       DLGridid:= fTreeEditorDict.DbGridId ;
                       self.TopBoxId :=fTreeEditorDict.BoxId ;
                       if      DLGridid<>'' then
                       begin
                          fhlknl1.Kl_GetQuery2('select * from T504 where  f01='+  DLGridid )   ;
                         self.mtDataSetId :=fhlknl1.FreeQuery.FieldByName('F03').asString;
                       end;
                  end;
      ModelFrmTreeGrid:
            begin

                     DLGridid:= self.FTreeGridDict.DbGridId  ;
                     fhlknl1.Kl_GetQuery2('select * from T504 where  f01='+  DLGridid )   ;
                     self.mtDataSetId :=fhlknl1.FreeQuery.FieldByName('F03').asString;

//                 self.TopBoxId :=FTreeGridDict.BoxId ;
            end;
     Modeleditor:
            begin
                topORBtm:=true;
                 self.mtDataSetId :=FEditorDict.DataSetId ;
                 self.TOPBoxId :=FEditorDict.BoxIds ;

            end;
     ModelFrmTabEditor:
            begin
                topORBtm:=true;
                if   self.FTTabeditorDict.DataSetId <>'' then
                self.mtDataSetId :=self.FTTabeditorDict.DataSetId ;
                self.TOPBoxId:=  self.FTTabeditorDict.BoxIds ;

            end;
   ModelLookup:
            begin
                topORBtm:=true;
                self.DlGridId :=self.FTLookupDict.DbGridId ;
                fhlknl1.Kl_GetQuery2('select * from T504 where  f01='+  DLGridid )   ;
                self.mtDataSetId :=fhlknl1.FreeQuery.FieldByName('F03').asString;
            end;
  ModelFrmYdWareProp :
            begin
                   //异地


            end;
  ModelPickDict:
            begin
                self.DlGridId :=self.FTPickDict.DbGridId ;

                 fhlknl1.Kl_GetQuery2('select * from T504 where  f01='+  DLGridid )   ;
                 self.mtDataSetId :=fhlknl1.FreeQuery.FieldByName('F03').asString;
            end;
ModelBilOpnDlgDict:
            begin
                 DLGridid:= inttostr(self.FTBilOpnDlgDict.DbGridId  ) ;
                 fhlknl1.Kl_GetQuery2('select * from T504 where  f01='+  DLGridid )   ;
                 self.mtDataSetId :=fhlknl1.FreeQuery.FieldByName('F03').asString;

                 fhlknl1.Kl_GetQuery2('select * from t201 where  f01='+  self.mtDataSetId )   ;
                 sql:=  fhlknl1.FreeQuery.FieldByName('F03').asString;

               if   not assigned(mtDataSet1)  then
               begin
                  edt1.Text :=  sql;
                  edtMtDataSetID.Text := SELF.mtDataSetId      ;
               end
            end;
          

end;

if lstGridField.Items.Count =0 then
if assigned(DLDataSet1) then
    if self.DLDataSet1.FieldCount >0 then         //fillgridcol
    begin
     for i:=0 to    self.DLDataSet1.FieldCount -1 do
     begin
              edtFieldname.Text :=DLDataSet1.Fields[i].FieldName ;
              getfieldID(edtFieldname.Text ,lstGridField,'f09',false);
     end;
     if    self.DlGridId <>''  then
     tmpsql:=' select T1.f03,T1.f14 ,T2.f02   '
              +' from T505 T1 '
              +' join T102 T2 on T1.f03=t2.f01 '
              +'  where T1.f02= '+ self.DlGridId;
              fhlknl1.Kl_GetQuery2(tmpsql);
       if not fhlknl1.FreeQuery.IsEmpty then
       for i:=0 to    fhlknl1.FreeQuery.RecordCount -1 do
       begin
             lstGridFieldsName.Items.Add(fhlknl1.FreeQuery.Fields[0].AsString +'  '+fhlknl1.FreeQuery.Fields[1].AsString +' '+fhlknl1.FreeQuery.Fields[2].asstring);
             fhlknl1.FreeQuery.Next ;
       end;


    end;


rg1.Hide;
end;

procedure TfrmCreateComponent.btnOpenT102Click(Sender: TObject);
begin
qryT102.Open;

if edtFieldID.Text <>'' then
begin
qryT102.Filter :='f01='+edtFieldID.Text ;
qryT102.Filtered :=false;
qryT102.Filtered:=true;
end;

end;

procedure TfrmCreateComponent.btnOpenClick(Sender: TObject);
begin
  if edtMtDataSetID.Text <>'' then
  begin
      qryT202.SQL.Clear ;
      qryT202.SQL.Add('select * from t202 where f02='+quotedstr(edtMtDataSetID.Text))  ;
      qryT202.Open ;
      edtFieldID.Text :=  qryT202.fieldbyname('f03').AsString ;
      btnOpenT102.Click;
  end;
end;

procedure TfrmCreateComponent.btnNextClick(Sender: TObject);
begin
      qryT202.Next;
      edtFieldID.Text :=  qryT202.fieldbyname('f03').AsString ;
      btnOpenT102.Click;
end;

procedure TfrmCreateComponent.btnPriorClick(Sender: TObject);
begin
      qryT202.Prior ;
     edtFieldID.Text :=  qryT202.fieldbyname('f03').AsString ;
      btnOpenT102.Click;
end;

procedure TfrmCreateComponent.dbedt11DblClick(Sender: TObject);
var   frmGetGridID: TfrmGetGridID;
begin
 frmGetGridID:= TfrmGetGridID.Create (nil);
 frmGetGridID.edtgridID.Text   :=tdbedit(sender).Text ;
 frmGetGridID.ShowModal;
end;

procedure TfrmCreateComponent.btnOpenT607Click(Sender: TObject);
begin
if edtFieldID.Text   <>'' then
fhlknl1.Ds_OpenDataSet(dsT607,edtFieldID.Text );
end;

procedure TfrmCreateComponent.dbedt34DblClick(Sender: TObject);
var   frmGetGridID: TfrmGetGridID;
begin
 frmGetGridID:= TfrmGetGridID.Create (nil);
 frmGetGridID.edtgridID.Text   :=tdbedit(sender).Text ;
 frmGetGridID.ShowModal;
end;

procedure TfrmCreateComponent.qryT102AfterOpen(DataSet: TDataSet);
begin
edtFieldID.Text :=dataset.fieldbyname('f01').AsString ;
end;

procedure TfrmCreateComponent.btnT610Click(Sender: TObject);
begin
if edtFieldID.Text   <>'' then
fhlknl1.Ds_OpenDataSet(dsT610,edtFieldID.Text );
end;

procedure TfrmCreateComponent.grpGrpParentDragOver(Sender, Source: TObject;
  X, Y: Integer; State: TDragState; var Accept: Boolean);
begin
if  Source is tlistbox then
Accept:=true;
end;

procedure TfrmCreateComponent.grpGrpParentDragDrop(Sender, Source: TObject;
  X, Y: Integer);
  var lbl:Tlabel;
  var CTRL:Tedit_Mtn;
  var FieldType:integer;
  var FieldKind :string;
  var picklist:string;
name:string;
begin
      if    Source is   tlistbox then
      begin

            lbl:=Tlabel_Mtn.Create(grpGrpParent);
            lbl.Parent :=grpGrpParent;
            lbl.Left :=x;
            lbl.Top :=y;
            name:=Tlistbox (Source).Items.Names [Tlistbox (Source).ItemIndex];
            lbl.Caption :=self.qryT102.FieldValues ['f09'];
            lbl.OnDblClick := DblClick_Ex;
            lbl.Visible :=true;
            lbl.Hint :='0'         ;
            lbl.Font.Name :='宋体';
            lbl.Font.Size:=10;

            CTRL:=Tedit_Mtn.Create (grpGrpParent);
            CTRL.Parent :=grpGrpParent;
            CTRL.Left :=x+lbl.Width +10;
            CTRL.Top :=y-3;
            CTRL.ShowHint :=true;
            CTRL.Hint := name+',-1,-1,-1';
            CTRL.Text := Tlistbox (Source).Items.Values  [name];
            CTRL.Visible :=true;

            CTRL.OnDblClick := DblClick_Ex;
            FieldType:=qryT102.FieldValues ['f04'];
            FieldKind:=qryT102.Fieldbyname ('f05').AsString ;
            picklist:=qryT102.Fieldbyname ('F11').AsString ;

            //1:  TFhlDbEdit       5:  TFhlDbLookupComboBox        6:  TDbMemo       7:  TDbCheckBox        8:  TDbText      9:  TFhlDbDatePicker        10: TDbRadioGroup        12: TDbComboBox;  13 TDbImage
//             0 :cftString  1 :cftDate  2 :cftDateTime  3 :cftBoolean  4 :cftFloat  5 :cftCurrency  6 :cftMemo  7 :cftBlob  8 :cftBytes  9 :cftAutoInc  10:cftInteger  11:cftImage  12:cftLargeint
            case FieldType of
            0:begin
                   if  trim(FieldKind)='l' then
                     CTRL.Tag :=5;

                    if picklist<>'' then
                    begin
                      CTRL.Tag:=12;
                    end
                    else
                     CTRL.Tag :=1;
              end;
            4,5,10:        CTRL.Tag :=1;
            1,2  :         CTRL.Tag :=9;
            3:             CTRL.Tag :=7;
            6:             CTRL.Tag :=6;
            7 :            CTRL.Tag :=13;
            end;

      end;
end;

procedure TfrmCreateComponent.lstFieldsClick(Sender: TObject);
//var a:integer;
begin
//   a:=  lstExistFields.Items.IndexOfName()
lstExistFields.ItemIndex :=   lstExistFields.Items.IndexOfName(  lstFields.Items.Values  [lstFields.Items.Names [lstFields.ItemIndex]]) ;
lstExistFields.OnClick (lstExistFields);
end;

procedure TfrmCreateComponent.edtTableDblClick(Sender: TObject);
begin
if (Tedit(Sender).Text <>'' ) and (leftstr(Tedit(Sender).Text ,1)='T') then
begin

  fhlknl1.Kl_GetQuery2 ('select * from T101 where f02='+quotedstr(Tedit(Sender).Text ));
  if not fhlknl1.FreeQuery.IsEmpty then
  begin
       fhlknl1.FreeQuery.First ;
       edtTableID.Text :=fhlknl1.FreeQuery.fieldbyname('f01').AsString ;

  end;
end;

end;
procedure TfrmCreateComponent.edtTableExit(Sender: TObject);
begin
if (Tedit(Sender).Text <>'' ) and (leftstr(Tedit(Sender).Text ,1)='T') then
begin

  fhlknl1.Kl_GetQuery2 ('select * from T101 where f02='+quotedstr(Tedit(Sender).Text ));
  if not fhlknl1.FreeQuery.IsEmpty then
  begin
       fhlknl1.FreeQuery.First ;
       edtTableID.Text :=fhlknl1.FreeQuery.fieldbyname('f01').AsString ;
  end
  else
      edtTableID.Text:='';
end;

end;

procedure TfrmCreateComponent.btnQAddFieldClick(Sender: TObject);

var I:integer;
sql:string;
var NewToolDB:String;
begin
//btnshowAllNeedFields.Click ;
//btnCreatedFields.Click ;

if   (edtTable.Text ='' ) or (lstExistFields.Items.Count <>0) then
begin
MessageBox(0, '错误!', '', MB_OK + MB_ICONQUESTION);
exit;
end;

    if   chkNewTool.Checked  then  NewToolDB:=logininfo.SysDBToolName +'.dbo.';
    for i:=0 to lstParaFields.Items.Count -1 do
    begin
        lstParaFields.ItemIndex :=i;

          edtFieldname.Text :=   lstParaFields.Items [lstParaFields.itemindex];


          qryT102.Close;
          qryT102.SQL.Clear;

          if edtTableID.Text <>'' then
          sql:='select *From t102 where F03='+quotedstr(trim(edtTableID.Text ))  +' and  f02='+quotedstr(lstParaFields.Items [lstParaFields.itemindex])
          else
          sql:='select *From t102 where f02='+quotedstr(lstParaFields.Items [lstParaFields.itemindex]);

          qryT102.SQL.Add(sql);
          qryT102.Open ;

          btnAddT102.Click;
          btnSaveT102.Click;
          btnSaveT202.Click ;
    end;
end;

procedure TfrmCreateComponent.btnCreateCtrlClick(Sender: TObject);
  var lbl:array of Tlabel;
  var CTRL:array of Tedit_Mtn;
  var FieldType:integer;
  var FieldKind :string;
  var picklist:string;
name:string;

  var cntpL,i,x,y  ,po :integer;
begin
  //btnshowAllNeedFields.Click;
  //btnCreatedFields.Click;


  self.RefreshClick(sender) ;          //clear

  cntpL:=strtoint(lbledtLintCnt.Text );
  y:=strtoint(lbledtPosy.Text );
  x:=strtoint(lbledtPosx.Text );


  setlength(lbl,lstFields.Count);
  setlength(CTRL,lstFields.Count);

for i:=0 to  lstFields.Count -1 do
begin

            if ((i mod cntpL)=0  )and (i>0)then
            begin
             y:=y+strtoint(lbledtGapY.Text );
            end;
            ShowExistsFieldsValue( lstExistFields.Items.names[i])  ;
            lstFields.ItemIndex := i;
            lstFields.OnClick (lstFields);


            lbl[i]:=Tlabel_Mtn.Create(grpGrpParent);
            lbl[i].Parent :=grpGrpParent;
            name:=lstFields.Items.Names [lstFields.ItemIndex];
            po:=pos('|',trim(self.qryT102.FieldValues ['f09'])) ;
            lbl[i].Caption:=rightstr(trim(self.qryT102.FieldValues ['f09']) , length(trim(self.qryT102.FieldValues ['f09']))-po );
           // lbl[i].Caption :=trim(self.qryT102.FieldValues ['f09']);
            lbl[i].Font.Name :='宋体';
            lbl[i].Font.Size :=10;
            lbl[i].OnDblClick := DblClick_Ex;
            lbl[i].Visible :=true;
            lbl[i].Hint :='0'         ;
            lbl[i].Font.Size:=strtoint(lbledtFontSize.text );
            lbl[i].Width :=lbl[i].Width ;
            if i>=cntpL then
            lbl[i].Left :=lbl[i-cntpL].Left+ (  lbl[i-cntpL].width   -lbl[i].width  )
            else
            lbl[i].Left :=x;

            lbl[i].Top :=y;

            CTRL[i]:=Tedit_Mtn.Create (grpGrpParent);
            CTRL[i].Parent :=grpGrpParent;
            CTRL[i].Left :=lbl[i].left +lbl[i].width+strtoint(lbledtCtrlGap.Text );
            CTRL[i].Top :=y-3;
            CTRL[i].ShowHint :=true;
            CTRL[i].Hint := name+',-1,-1,-1';
            CTRL[i].Text := lstFields.Items.Values  [name];
            CTRL[i].Visible :=true;

            CTRL[i].OnDblClick := DblClick_Ex;
            FieldType:=qryT102.FieldValues ['f04'];
            FieldKind:=qryT102.Fieldbyname ('f05').AsString ;
            picklist:=qryT102.Fieldbyname ('F11').AsString ;

            //1:  TFhlDbEdit       5:  TFhlDbLookupComboBox        6:  TDbMemo       7:  TDbCheckBox        8:  TDbText      9:  TFhlDbDatePicker        10: TDbRadioGroup        12: TDbComboBox;  13 TDbImage
//             0 :cftString  1 :cftDate  2 :cftDateTime  3 :cftBoolean  4 :cftFloat  5 :cftCurrency  6 :cftMemo  7 :cftBlob  8 :cftBytes  9 :cftAutoInc  10:cftInteger  11:cftImage  12:cftLargeint
            case FieldType of
            0:begin
                   if  trim(FieldKind)='l' then
                     CTRL[i].Tag :=5
                   else
                   begin
                        if picklist<>'' then
                        begin
                          CTRL[i].Tag:=12;
                        end
                        else
                         CTRL[i].Tag :=1;
                    end;
              end;
            4,5,10:        CTRL[i].Tag :=1;
            1,2  :         CTRL[i].Tag :=9;
            3:             CTRL[i].Tag :=7;
            6:             CTRL[i].Tag :=6;
            7 :            CTRL[i].Tag :=13;
            end;


                 x:=CTRL[i].Left +CTRL[i].Width +strtoint(lbledtgap.Text ) ;
      end;
end;



procedure TfrmCreateComponent.edtMtDataSetIDDblClick(Sender: TObject);
var   frmGetGridID: TfrmGetGridID;
begin
  frmGetGridID:= TfrmGetGridID.Create (nil);
  if tedit(sender).Text<>''   then
  frmGetGridID.edtmtdatasetID.Text   :=tedit(sender).Text ;
  frmGetGridID.ShowModal;
end;
procedure TfrmCreateComponent.btnCreateFieldsClick(Sender: TObject);
var I:integer;
sql,  FieldCname,FieldTypeID ,FieldEname ,fieldlength ,DefaultValueInSys :string;

nullable,Isunique:boolean;

HaveNotNull,HaveDefault:string;

begin
        HaveNotNull:='-1';
        HaveDefault:='-1';

  //      btnshowAllNeedFields.Click ;
   //     btnCreatedFields.Click ;

        if   (edtTable.Text ='' ) then
        begin
        MessageBox(0, '错误!', '', MB_OK + MB_ICONQUESTION);
        exit;
        end;
        qryT102.Open;

        if MessageBox(0, '确定删除所有字段吗？', '', MB_YESNO +
          MB_ICONQUESTION) = IDYES then
        begin
              //delete all fields
              sql:=  '   delete T102 where f01 in (select f03 from t202 where f02='+ edtMtDataSetID.Text +')' ;
              if edtMtDataSetID.Text <>'' then
              begin
              fhlknl1.Kl_GetQuery2(sql,false );
              fhlknl1.Kl_GetQuery2('delete t202 where f02='+ edtMtDataSetID.Text,false );
              end;

        end
        else
        begin
             exit;
        end;

          if MessageBox(0, '确定建立所有字段吗？', '', MB_YESNO +MB_ICONQUESTION) = IDno then exit;

        fhlknl1.Kl_GetQuery2('select * from '  +logininfo.SysDBPubName+'.dbo.V_BatchCreateFields  '
                              +' where TableEname='+quotedstr(trim(edtTable.Text ))   +' and FieldEname<>'+quotedstr('F_ID')+'  order by OrderID '       );


        for i:=0 to fhlknl1.FreeQuery.RecordCount-1 do
        begin
            if fhlknl1.FreeQuery.fieldbyname ('FisLookUpFld').AsBoolean then
            continue;

            FieldEname  := fhlknl1.FreeQuery.fieldbyname ('FieldEname').AsString ;

            if lstParaFields.Items.IndexOf ( FieldEname)<0then
            continue;
            if not lstParaFields.Checked [ lstParaFields.Items.IndexOf ( FieldEname)] then
            continue;

           // if not StrExistsInLst(FieldEname,self.lstParaFields.Items ) then continue;

            FieldCname  := fhlknl1.FreeQuery.fieldbyname ('FieldCname').AsString   ;
            FieldTypeID := fhlknl1.FreeQuery.fieldbyname ('FieldTypeID').AsString   ;
            fieldlength := fhlknl1.FreeQuery.fieldbyname ('fieldlength').AsString   ;
            DefaultValueInSys:= fhlknl1.FreeQuery.fieldbyname ('DefaultValueInSys').AsString   ;
            nullable:= fhlknl1.FreeQuery.fieldbyname ('nullable').AsBoolean    ;
            Isunique:= fhlknl1.FreeQuery.fieldbyname ('Isunique').AsBoolean    ;

            qryT102.Append ;
            qryT102.FieldByName('f02').AsString :=   trim(FieldEname )  ;
            qryT102.FieldByName('f04').AsString :=   trim(FieldTypeID )  ;
            qryT102.FieldByName('f09').AsString :=   trim(FieldCname )    ;
            if  fieldlength<>'' then
            qryT102.FieldByName('f06').AsString :=fieldlength;

            
            btnSaveT102.Click;

            if FieldEname<>'F_ID' then
            qryT202.FieldByName('f05').AsBoolean :=not nullable;
            qryT202.FieldByName('f04').AsString  :=DefaultValueInSys;
            qryT202.FieldByName('f10').AsBoolean   :=Isunique;

            if nullable  then
            begin
                  HaveNotNull:='4';
            end;

            if  (DefaultValueInSys<>'' ) then
            begin
                 HaveDefault:='2';
            end;

            btnSaveT202.Click ;
            fhlknl1.FreeQuery.Next ;
        end;

          fhlknl1.Kl_GetQuery2 ('update  T201 set F09 ='+HaveNotNull+' , F10='+HaveDefault+' where F03='+quotedstr(self.mtDataSetId ) ,false);

end;

procedure TfrmCreateComponent.btnShowGirdColsClick(Sender: TObject);
var i:integer;
begin
    lstGridCols.Clear;

    if self.DLGrid<>nil then
    begin
         for i:=0 to self.DLGrid.Columns.Count -1 do
         begin
             lstGridCols.Items.Add(self.DLGrid.Columns[i].FieldName );
         end;
         EdtFlds.Text :=lstGridCols.items.CommaText;
    end;
end;

procedure TfrmCreateComponent.btnBatchCreateColsClick(Sender: TObject);
var sql:string;
begin
//    sql:='select * from T505   where F02=   '+quotedstr(self.DlGridId)
    sql:='delete T505   where F02=   '+quotedstr(self.DlGridId);
    fhlknl1.Kl_GetQuery2(sql,false);


      sql:='insert into T505    '
      +'select                 '
      +'distinct '+quotedstr(self.DlGridId)+', Fldid , 70,0,0,1,1,'+quotedstr('clWhite')+' ,0,null,10,0,rtrim(ltrim(label)),   '
      +quotedstr('clBtnface')+',null,'+quotedstr('宋体')+',10,'
      +quotedstr('clWindowText')+','
      +quotedstr('宋体')+',10,'
      +quotedstr('clWindowText')+',null,null,getdate() ,0,0'
      +'  from V201 where datasetid='  +quotedstr(self.mtDataSetId )     ;
      
      fhlknl1.Kl_GetQuery2(sql,false);



end;

procedure TfrmCreateComponent.lstGridColsClick(Sender: TObject);
begin
edtFieldname.Text :=lstGridCols.Items[lstGridCols.ItemIndex ];
btn9GetFieldNameClick(Sender );

end;

procedure TfrmCreateComponent.btnDeleteT102Click(Sender: TObject);
begin
if MessageBox(0, '确定删除字段吗？', '', MB_YESNO + MB_ICONQUESTION) = IDYES
  then
begin
      if MessageBox(0, '确定吗？', '', MB_YESNO + MB_ICONQUESTION) =
        IDYES then
      begin
           qryT102.Delete; 
      end;
end;

end;

procedure TfrmCreateComponent.lstFieldsDblClick(Sender: TObject);
begin
     lstFields.Items.Delete(lstFields.ItemIndex ); 
end;

procedure TfrmCreateComponent.dbedt12DblClick(Sender: TObject);
var frmeditor:Tform;
begin
   if Sender is Tdbedit then
    frmeditor:=FhlUser.ShowEditorFrmSystool('64', Tdbedit(sender).Text );
    frmeditor.Showmodal          ;
        if   Tdbedit(sender).Field.DataSet.State in [dsinsert,dsedit] then
        if   not TEditorFrm(frmeditor).ADODataSet1.IsEmpty then
        Tdbedit(sender).Text :=TEditorFrm(frmeditor).ADODataSet1.FieldByName('F01').AsString ;

    freeandnil(frmeditor);
end;

procedure TfrmCreateComponent.lstParaFieldsDblClick(Sender: TObject);
begin
qryT202.Insert;
qryT202.fieldbyname('F02').AsString:=edtMtDataSetID.Text;
    qryT202.fieldbyname('F03').AsString:=edtFieldID.Text ;

    if Tchecklistbox( Sender).Items[ Tchecklistbox( Sender).ItemIndex ]='F_ID' then
    qryT202.fieldbyname('F04').AsString:='sGUID';

    if Tchecklistbox( Sender).Items[ Tchecklistbox( Sender).ItemIndex ]='FCreateEmp' then
    qryT202.fieldbyname('F04').AsString:='sEmpid';

    if Tchecklistbox( Sender).Items[ Tchecklistbox( Sender).ItemIndex ]='FCreateTime' then
    qryT202.fieldbyname('F04').AsString:='snow';
    qryT202.Post;
    btnCreatedFields.Click;
   //lstParaFields.DeleteSelected ;
end;

procedure TfrmCreateComponent.Click_Ex(Sender: TObject);
begin
    if ( Sender is tlabel) then
    begin
         ( Sender as tlabel).Cursor  :=crsizeall;
         ( Sender as tlabel).Alignment  :=taRightJustify;
         ( Sender as tlabel).Font.Style := ( Sender as tlabel).Font.Style   +[fsBold];
    end;

    if ( Sender is Tedit_Mtn) then
    begin
        ( Sender as Tedit_Mtn).Ctl3D :=true;
        ( Sender as Tedit_Mtn).Cursor  :=crsizeall;
    end;
end;

procedure TfrmCreateComponent.tbALLeftClick(Sender: TObject);
var i:integer;
var firstLeft:integer;
begin
    if     self.FCollector.Count>1 then
    begin

          firstLeft :=tcontrol( self.FCollector.Objects [0]).Left ;
          for i:=0 to self.FCollector.Count -1 do
          begin

             tcontrol(self.FCollector.Objects [i]).Left :=  firstLeft;
          end;
    end;
end;

procedure TfrmCreateComponent.TbALRightClick(Sender: TObject);
var i:integer;
var firstleft,firstwidth:integer;
begin
    if     self.FCollector.Count>1 then
    begin
          firstleft := tcontrol( self.FCollector.Objects [0]).Left;
          firstwidth:= tcontrol( self.FCollector.Objects [0]).width;

          for i:=0 to self.FCollector.Count -1 do
          begin
            if ( tcontrol( self.FCollector.Objects [i]) is Tlabel_Mtn)  then
               ( tcontrol( self.FCollector.Objects [i]) as tlabel).Font.Style := ( tcontrol( self.FCollector.Objects [i]) as tlabel).Font.Style   -[fsBold];
          end;
          for i:=0 to self.FCollector.Count -1 do
          begin 
            tcontrol( self.FCollector.Objects [i]).Left :=  firstleft+(firstwidth- tcontrol( self.FCollector.Objects [i]).width);

            if ( tcontrol( self.FCollector.Objects [i]) is Tlabel_Mtn)  then
               ( tcontrol( self.FCollector.Objects [i]) as tlabel).Font.Style := ( tcontrol( self.FCollector.Objects [i]) as tlabel).Font.Style   +[fsBold];
          end;
    end;
end;

procedure TfrmCreateComponent.TbALTopClick(Sender: TObject);
var i:integer;
var firstTop:integer;
begin
    if     self.FCollector.Count>1 then
    begin
          firstTop :=tcontrol( self.FCollector.Objects [0]).Top ;
          for i:=0 to self.FCollector.Count -1 do
          begin
             tcontrol( self.FCollector.Objects [i]).Top  :=  firstTop;
          end;
    end;
end;
procedure TfrmCreateComponent.TbMoveLeftClick(Sender: TObject);
var i:integer;
begin
    if     self.FCollector.Count>1 then
    begin
          for i:=0 to self.FCollector.Count -1 do
          begin
             tcontrol( self.FCollector.Objects [i]).Left :=   tcontrol(self.FCollector.Objects [i]).Left -strtoint(edMoveSpan.Text );
          end;
    end
    else
    begin
        for i:=0 to  grpGrpParent.ControlCount  -1 do
        begin
            (grpGrpParent.Controls[i] as Tcontrol).Left:=(grpGrpParent.Controls[i] as Tcontrol).Left-strtoint(edMoveSpan.Text );

        end;
    end;
end;

procedure TfrmCreateComponent.TbMoveRightClick(Sender: TObject);
var i:integer;
begin
    if     self.FCollector.Count>1 then
    begin
          for i:=0 to self.FCollector.Count -1 do
          begin
             tcontrol( self.FCollector.Objects [i]).left :=   tcontrol( self.FCollector.Objects [i]).left +strtoint(edMoveSpan.Text );
          end;
    end
    else
    begin
        for i:=0 to  grpGrpParent.ControlCount  -1 do
        begin
            (grpGrpParent.Controls[i] as Tcontrol).Left :=(grpGrpParent.Controls[i] as Tcontrol).Left+strtoint(edMoveSpan.Text );
        end;
    end;
end;

procedure TfrmCreateComponent.TbMoveUPClick(Sender: TObject);
var i:integer;
begin
    if     self.FCollector.Count>1 then
    begin
          for i:=0 to self.FCollector.Count -1 do
          begin
             tcontrol( self.FCollector.Objects [i]).Top  :=   tcontrol( self.FCollector.Objects [i]).Top  -strtoint(edMoveSpan.Text );
          end;
    end
    else
    begin
        for i:=0 to  grpGrpParent.ControlCount  -1 do
        begin
            (grpGrpParent.Controls[i] as Tcontrol).Top  :=(grpGrpParent.Controls[i] as Tcontrol).Top -strtoint(edMoveSpan.Text );
        end;
    end;
end;

procedure TfrmCreateComponent.TbMoveDownClick(Sender: TObject);
var i:integer;
begin
    if     self.FCollector.Count>1 then
    begin
          for i:=0 to self.FCollector.Count -1 do
          begin
             tcontrol( self.FCollector.Objects [i]).Top  :=   tcontrol( self.FCollector.Objects [i]).Top  +strtoint(edMoveSpan.Text );
          end;
    end
    else
    begin
        for i:=0 to  grpGrpParent.ControlCount  -1 do
        begin
            (grpGrpParent.Controls[i] as Tcontrol).Top  :=(grpGrpParent.Controls[i] as Tcontrol).Top +strtoint(edMoveSpan.Text );
        end;
    end;
end;


procedure TfrmCreateComponent.TBVESpanClick(Sender: TObject);
var i:integer;
var MinTop,MaxTop,SumHeight,Vspan:integer;
//var MinControl:TControl;
begin
    if     self.FCollector.Count>1 then
    begin
          MinTop:=tcontrol( self.FCollector.Objects [0]).Top ;
          MaxTop:=tcontrol( self.FCollector.Objects [0]).Top ;
          SumHeight:=0;
          for i:=0 to self.FCollector.Count -1 do
          begin
             if  MinTop> tcontrol( self.FCollector.Objects [i]).Top then
             begin
                 MinTop:=tcontrol( self.FCollector.Objects [i]).Top ;
             end;
             if  MaxTop< tcontrol( self.FCollector.Objects [i]).Top then
                 MaxTop:=tcontrol( self.FCollector.Objects [i]).Top ;
             if    i<>self.FCollector.Count-1 then
             SumHeight:=   SumHeight+tcontrol( self.FCollector.Objects [i]).Height ;

          end;
          Vspan:=( (MaxTop -MinTop)-SumHeight) div (self.FCollector.Count-1);



          for i:=0 to self.FCollector.Count -1 do
          begin
               if i=0 then
                  tcontrol( self.FCollector.Objects [i]).Top:=  MinTop
               else
                  tcontrol( self.FCollector.Objects [i]).Top:= Vspan+  tcontrol( self.FCollector.Objects [i-1]).top +tcontrol( self.FCollector.Objects [i-1]).height ;
          end;
    end;
end;

procedure TfrmCreateComponent.TbHEspanClick(Sender: TObject);
var i:integer;
var Minleft,Maxleft,SumWidth,Vspan:integer;
//var MinControl:TControl;
begin
    if     self.FCollector.Count>1 then
    begin
          Minleft:=tcontrol( self.FCollector.Objects [0]).left ;
          Maxleft:=tcontrol( self.FCollector.Objects [0]).left ;
          SumWidth:=0;

          for i:=0 to self.FCollector.Count -1 do
          begin
             if  Minleft> tcontrol( self.FCollector.Objects [i]).left then
             begin
                 Minleft:=tcontrol( self.FCollector.Objects [i]).left ;
             end;
             if  Maxleft< tcontrol( self.FCollector.Objects [i]).left then
                 Maxleft:=tcontrol( self.FCollector.Objects [i]).left ;
             if    i<>self.FCollector.Count-1 then
             SumWidth:=   SumWidth+tcontrol( self.FCollector.Objects [i]).width ;

          end;
          Vspan:=( (MaxLeft -MinLeft)-SumWidth) div (self.FCollector.Count-1);



          for i:=0 to self.FCollector.Count -1 do
          begin
               if i=0 then
                  tcontrol( self.FCollector.Objects [i]).left:=  Minleft
               else
                  tcontrol( self.FCollector.Objects [i]).left:= Vspan+  tcontrol( self.FCollector.Objects [i-1]).left +tcontrol( self.FCollector.Objects [i-1]).width ;
          end;
    end;
end;

procedure TfrmCreateComponent.BtnBatchQuoteClick(Sender: TObject);
var I:integer;
sql,  FieldCname,FieldTypeID ,FieldEname ,fieldlength ,DefaultValueInSys :string;

nullable,Isunique:boolean;

HaveNotNull,HaveDefault:string;


quoteFieldName,fldID:string;
begin
edtFieldID.Text :='1';
btnAddT102.Click ;

        HaveNotNull:='-1';
        HaveDefault:='-1';

  //      btnshowAllNeedFields.Click ;
   //     btnCreatedFields.Click ;

        if   (edtTable.Text ='' ) then
        begin
        MessageBox(0, '错误!', '', MB_OK + MB_ICONQUESTION);
        exit;
        end;
        qryT102.Open;

        if MessageBox(0, '确定删除所有字段吗？', '', MB_YESNO +
          MB_ICONQUESTION) = IDYES then
        begin
              //delete all fields
              sql:=  '   delete T102 where f01 in (select f03 from t202 where f02='+ edtMtDataSetID.Text +')' ;
              if edtMtDataSetID.Text <>'' then
              begin
              fhlknl1.Kl_GetQuery2(sql,false );
              fhlknl1.Kl_GetQuery2('delete t202 where f02='+ edtMtDataSetID.Text,false );
              end;

        end
        else
        begin
             exit;
        end;

          if MessageBox(0, '确定引用所有字段吗？', '', MB_YESNO +MB_ICONQUESTION) = IDno then exit;

          for i:=0 to lstParaFields.Items.Count -1 do
          begin
               quoteFieldName:=lstParaFields.Items [i];
                sql:='select top  1 f01, b.f02,b.f200 '
                    +' From V_BatchCreateFields A '
                    +' join T102                B on A.FieldEname =B.f02  and A.FieldCName=B.f09 and '
                    +'                              A.FieldtypeID=B.f04  and A.fieldlength=B.f06 '
                    +' where A.TAbleEname='+quotedstr(edtTable.Text) +' and A.fieldEname='+quotedstr(quoteFieldName)
                    +' order by F200 desc '  ;

                fhlknl1.Kl_GetQuery2(sql );
                fldID:=    fhlknl1.FreeQuery.Fieldbyname('f01').asstring;

                 qryT202.Append ;
                qryT202.FieldByName('F02').AsString   :=edtMtDataSetID.Text ;
                qryT202.FieldByName('F03').AsString   :=fldID;

                btnSaveT202.Click ;
                fhlknl1.Kl_GetQuery2('update T102 set F23=Isnull(F23,1)+1 where f01=' +fldID,false);


                 
                 btnAddT102.Click ;
                  if MessageBox(0, 'go on ？', '', MB_YESNO +MB_ICONQUESTION) = IDno then exit;
          end;

end    ;


procedure TfrmCreateComponent.dbchkReadOnlyClick(Sender: TObject);
begin
if   qryGrid.State in [dsinsert,dsedit] then
begin
    if dbchkReadOnly.Checked then
      dbedt14.Text  :='clCream'
      else
       dbedt14.Text  :='clwhite';
end;
end;

function TfrmCreateComponent.StrExistsInLst(Str: string;
  Lst: Tstrings): boolean;
var i:integer;
begin
     for i:=0 to Lst.Count -1 do
     begin
         if trim(Str) =  trim(Lst[i]) then
         begin
             result:=true;
             break;
         end;
     end;
end;

procedure TfrmCreateComponent.grpGrpParent_BtmDragOver(Sender,
  Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
begin
    if  Source is tlistbox then
Accept:=true;
end;

procedure TfrmCreateComponent.grpGrpParent_BtmDragDrop(Sender,
  Source: TObject; X, Y: Integer);

  var lbl:Tlabel;
  var CTRL:Tedit_Mtn;
  var FieldType:integer;
  var FieldKind :string;
  var picklist:string;
name:string;
begin
      if    Source is   tlistbox then
      begin

            lbl:=Tlabel_Mtn.Create(grpGrpParent_Btm);
            lbl.Parent :=grpGrpParent_Btm;
            lbl.Left :=x;
            lbl.Top :=y;
            name:=Tlistbox (Source).Items.Names [Tlistbox (Source).ItemIndex];
            lbl.Caption :=self.qryT102.FieldValues ['f09'];
            lbl.OnDblClick := DblClick_Ex;
            lbl.Visible :=true;
            lbl.Hint :='0'         ;
            lbl.Font.Name :='宋体';
            lbl.Font.Size:=10;

            CTRL:=Tedit_Mtn.Create (grpGrpParent_Btm);
            CTRL.Parent :=grpGrpParent_Btm;
            CTRL.Left :=x+lbl.Width +10;
            CTRL.Top :=y-3;
            CTRL.ShowHint :=true;
            CTRL.Hint := name+',-1,-1,-1';
            CTRL.Text := Tlistbox (Source).Items.Values  [name];
            CTRL.Visible :=true;

            CTRL.OnDblClick := DblClick_Ex;
            FieldType:=qryT102.FieldValues ['f04'];
            FieldKind:=qryT102.Fieldbyname ('f05').AsString ;
            picklist:=qryT102.Fieldbyname ('F11').AsString ;

            //1:  TFhlDbEdit       5:  TFhlDbLookupComboBox        6:  TDbMemo       7:  TDbCheckBox        8:  TDbText      9:  TFhlDbDatePicker        10: TDbRadioGroup        12: TDbComboBox;  13 TDbImage
//             0 :cftString  1 :cftDate  2 :cftDateTime  3 :cftBoolean  4 :cftFloat  5 :cftCurrency  6 :cftMemo  7 :cftBlob  8 :cftBytes  9 :cftAutoInc  10:cftInteger  11:cftImage  12:cftLargeint
            case FieldType of
            0:begin
                   if  trim(FieldKind)='l' then
                     CTRL.Tag :=5;

                    if picklist<>'' then
                    begin
                      CTRL.Tag:=12;
                    end
                    else
                     CTRL.Tag :=1;
              end;
            4,5,10:        CTRL.Tag :=1;
            1,2  :         CTRL.Tag :=9;
            3:             CTRL.Tag :=7;
            6:             CTRL.Tag :=6;
            7 :            CTRL.Tag :=13;
            end;

      end;
end;

procedure TfrmCreateComponent.N2Click(Sender: TObject);
begin
grpGrpParent.Height :=grpGrpParent.Height+30;
end;

procedure TfrmCreateComponent.BtnCreateColByTableClick(Sender: TObject);
var index,i,j:integer;

var FieldCNAme:string;
begin
    btnShowGirdCols.Click;

    fhlknl1.Kl_GetQuery2('select * from ' +logininfo.SysDBPubName+'.dbo.V_BatchCreateFields  '
                    +' where TableEname='+quotedstr(trim(EditColTable.Text ))  +' and FieldEname<>'+quotedstr('F_ID')+'  order by OrderID '   );


      
     for i:=0 to lstGridCols.Items.Count -1 do
    begin
        lstGridCols.ItemIndex :=i;
        edtFieldname.Text :=lstGridCols.Items[lstGridCols.ItemIndex ];
        btn9GetFieldNameClick(Sender );

        if fhlknl1.FreeQuery.Locate('FieldEname',edtFieldname.Text ,[]) then
        begin
            FieldCNAme:=fhlknl1.FreeQuery.fieldbyname('FieldCNAme').AsString;
            index  :=lstGridField.Items.IndexOf ( edtFieldname.Text+'='+FieldCNAme  );

             for j:=0 to      lstGridField.Items.Count -1 do
             begin
                 if FieldCNAme=    lstGridField.Items.ValueFromIndex [j] then
                 begin
                     index:=j;
                     break;
                 end;
             end;


            if index>-1 then
            begin
                btncolAdd.Click;
                 dbedt12.Text :=lstGridField.Items.Names[index] ;
                 dbedt18.Text:=FieldCNAme ;
                btn_saveAddCol.Click;
            end;
        end
        else
        continue;




    end;
end;

procedure TfrmCreateComponent.Lable1Click(Sender: TObject);
var i:integer;
begin
 for i:=0 to grpGrpParent.ComponentCount -1 do
 begin
      if grpGrpParent.Components[I] is Tlabel then
            (grpGrpParent.Components[I] as Tlabel ).Color :=stringtocolor('clCream');

 end;

end;

procedure TfrmCreateComponent.BtnDecWidthClick(Sender: TObject);
var i:integer;
begin
    if     self.FCollector.Count>1 then
    begin
          for i:=0 to self.FCollector.Count -1 do
          begin
             if  ((self.FCollector.Objects [i]) is Tedit     )   then
             tcontrol( self.FCollector.Objects [i]).Width   :=   tcontrol( self.FCollector.Objects [i]).Width   -2;
          end;
    end    ;
end;

procedure TfrmCreateComponent.BtnIncWidthClick(Sender: TObject);
var i:integer;
begin
    if     self.FCollector.Count>1 then
    begin
          for i:=0 to self.FCollector.Count -1 do
          begin
             if  ((self.FCollector.Objects [i]) is Tedit     )   then
             tcontrol( self.FCollector.Objects [i]).Width   :=   tcontrol( self.FCollector.Objects [i]).Width   +2;
          end;
    end;
end;

procedure TfrmCreateComponent.lable2Click(Sender: TObject);
var i:integer;
begin
 for i:=0 to grpGrpParent.ComponentCount -1 do
 begin
      if grpGrpParent.Components[I] is Tlabel then
            (grpGrpParent.Components[I] as Tlabel ).Color :=stringtocolor('clBtnFace');

 end;
end;

procedure TfrmCreateComponent.Enable1Click(Sender: TObject);

var i:integer;
begin
    if     self.FCollector.Count>1 then
    begin
          for i:=0 to self.FCollector.Count -1 do
          begin
             if  ((self.FCollector.Objects [i]) is Tedit     )   then
             begin
                Tmenuitem(Sender).Checked :=not Tmenuitem(Sender).Checked ;
                Tedit( self.FCollector.Objects [i]).ReadOnly     :=true;//Tmenuitem(Sender).Checked;
             end;
          end;
    end    ;
end;

procedure TfrmCreateComponent.BtnCreateColByU8TableClick(Sender: TObject);
var index,i,j:integer;
var sql:string;
var FieldCNAme:string;
begin
    btnShowGirdCols.Click;





     for i:=0 to lstGridCols.Items.Count -1 do
  //  for i:=0 to 1 do
    begin
           
        lstGridCols.ItemIndex :=i;
        edtFieldname.Text :=lstGridCols.Items[lstGridCols.ItemIndex ];
        sql:='  select   *,(select top 1  cCaption From '+fhlknl1.UserConnection.DefaultDatabase  +'.dbo.AA_Columnset_base where cfld like '+'''%'''+' +w.fieldname +'+'''%'''+')as Caption2  ,(select top 1 ftypename from TFieldType where  ftypename   like  '+'''%'''+'+ w.fieldtype+ '+'''%'''+') as J '+
' ,(select top 1 findex from TFieldType where  ftypename   like '+'''%'''+'+ w.fieldtype +'+'''%'''+' ) as FTypeIndex    '+
' from '+fhlknl1.UserConnection.DefaultDatabase  +'.dbo.RPT_ItmDEF w where fieldtype not like '+'''%char%'''   +
'  and FieldName=  '+ quotedstr(edtFieldname.Text   )  +
' union all ' +
'  select   * ,(select top 1 cCaption From '+fhlknl1.UserConnection.DefaultDatabase  +'.dbo.AA_Columnset_base where cfld like '+'''%'''+'+ w.fieldname+ '+'''%'''+')as Caption2  , '''+'ftstring'+'''  as J '+
' , 0  as FTypeIndex    '+
' from '+fhlknl1.UserConnection.DefaultDatabase  +'.dbo.RPT_ItmDEF w where fieldtype   like '+'''%char%'''   +
'  and FieldName=  '+ quotedstr(edtFieldname.Text   )+'order by FTypeIndex desc       ' ;

fhlknl1.Kl_GetQuery2(sql)  ;

         if  fhlknl1.FreeQuery.FieldByName ('FTypeIndex').AsString ='' then
          begin
                 fhlknl1.FreeQuery.Next ;
          end;

            btn9GetFieldName.Click ;
            {
            FieldCNAme:=fhlknl1.FreeQuery.fieldbyname('Fielddef').AsString;

            index  :=lstGridField.Items.IndexOf ( edtFieldname.Text+'='+FieldCNAme  );

             for j:=0 to      lstGridField.Items.Count -1 do
             begin
                 if FieldCNAme=    lstGridField.Items.ValueFromIndex [j] then
                 begin
                     index:=j;
                     break;
                 end;
             end;              }


           if lstGridField.Items.Count =0 then
            begin
              qryt102.Open;
              qryt102.Append;
                 
                dbedtFieldName.Text :=  edtFieldname.Text ;
                if   fhlknl1.FreeQuery.fieldbyname('Fielddef').AsString <>'' then
                qryt102.FieldByName('f09').AsString := fhlknl1.FreeQuery.fieldbyname('Fielddef').AsString
                else
                begin
                 if   fhlknl1.FreeQuery.fieldbyname('caption2').AsString <>'' then
                    qryt102.FieldByName('f09').AsString :=    fhlknl1.FreeQuery.fieldbyname('caption2').AsString
                  else
                   qryt102.FieldByName('f09').AsString := edtFieldname.Text  ;

                end;
                
                qryt102.FieldByName('f04').AsString :=fhlknl1.FreeQuery.FieldByName ('FTypeIndex').AsString ;
                
                if (fhlknl1.FreeQuery.FieldByName ('FTypeIndex').AsString='0'    )   then
                begin
                 qryt102.FieldByName('f06').AsString   :='200';
                end;
              btnSaveT102Click(Sender );
             

            end





    end;
end;
 
procedure TfrmCreateComponent.BtnCreateaColsClick(Sender: TObject);
var i:integer;
  var temp:string;
begin
for i:=0 to lstGridCols.Items.Count -1 do
begin
      btncolAdd.Click;
    edtFieldname.Text :=   lstGridCols.Items[i];
    btn9GetFieldNameClick(Sender );

     temp:= lstGridField.Items.Names [0] ;
    dbedt12.Text := temp;
    dbedt18.Text :=  lstGridField.Items.Values   [dbedt12.Text ] ;
     btn_saveAddCol.Click;
end;
      
 


 
end;

procedure TfrmCreateComponent.BtnBatchCreatePRTFieldsClick(
  Sender: TObject);
var i:integer;
begin
if    edtDataSetID.Text='' then
begin
 showmessage('先取datasetid');
 exit;
end;
    qryT202.Open;

   for i:=0 to qryGrid.RecordCount -1 do
   begin
      qryT202.Append;
      qryT202.FieldByName('f02').AsString :=  edtDataSetID.Text ;
      qryT202.FieldByName('f03').AsString := qryGrid.FieldByName('f03').AsString;
      qryT202.FieldByName('f07').AsString := DBLookupComboBox1.Text ;
      qryT202.Post;

      qryGrid.Next ;
   end;
end;

procedure TfrmCreateComponent.lstGridFieldMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  var sql:string;
begin
  if  lstGridField.itemindex>=0 then
  begin
    sql:='select * From T102 where F01='+lstGridField.Items.Names   [lstGridField.itemindex] ;
    qryT102.SQL.Clear ;
    qryT102.SQL.Add(sql);
    qryT102.Close;
    qryT102.Open ;

  end;

end;

procedure TfrmCreateComponent.BtnIncTopGrpHeightClick(Sender: TObject);
begin
     grpGrpParent.Height :=grpGrpParent.Height +50;
end;

procedure TfrmCreateComponent.btnExpHGapClick(Sender: TObject);
var i:integer;
begin
    if     self.FCollector.Count>1 then
    begin
          for i:=0 to self.FCollector.Count -1 do
          begin
             tcontrol( self.FCollector.Objects [i]).left  :=   tcontrol( self.FCollector.Objects [i]).left  +strtoint(edMoveSpan.Text ) *i;
          end;
    end

end;

procedure TfrmCreateComponent.BtnDecHGapClick(Sender: TObject);
var i:integer;
begin
    if     self.FCollector.Count>1 then
    begin
          for i:=0 to self.FCollector.Count -1 do
          begin
             tcontrol( self.FCollector.Objects [i]).left  :=   tcontrol( self.FCollector.Objects [i]).left  -strtoint(edMoveSpan.Text )*i ;
          end;
    end

end;

procedure TfrmCreateComponent.imgtopMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var MButton2: TMouseButton;
var Shift2: TShiftState    ;
var i:integer;
begin
    if(not drawing)then
    begin
      if(oldx<>newx)then imgtop.Canvas.Rectangle(oldx,oldy,newx,newy);
      oldx:=x;
      newx:=x;
      oldy:=y;
      newy:=y;
      drawing:=true;
      imgtop.Canvas.Pen.Mode:=pmnot;
      imgtop.Canvas.Brush.Style:=bsclear;

      fstpt.X :=x;
      fstpt.Y :=y;
      MButton2:= mbLeft;
      Shift2 :=[ssleft	];
      for i:=0 to self.grpGrpParent.ComponentCount -1 do
      begin
      chyMouseUp(Twincontrol(grpGrpParent.Components[i]),MButton2, Shift2,x,y);
      end;
    end;
end;

procedure TfrmCreateComponent.imgtopMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
    if drawing then
    begin
         imgtop.Canvas.Rectangle(oldx,oldy,newx,newy);
         newx:=x;
         newy:=y;
         imgtop.Canvas.Rectangle(oldx,oldy,newx,newy);
    end;
end;

procedure TfrmCreateComponent.imgtopMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var i:integer;
var mmButton2: TMouseButton;
var Shift2: TShiftState    ;
var xo,xn,yo,yn:integer;
begin
   if drawing then drawing:=false;

   if fstpt.X <   x then
   begin
      xo:=fstpt.X  ;
      xn:=x;
   end
   else
   begin
       xo:=  x;
       xn:=  fstpt.X
   end;

   if fstpt.Y  <   y then
   begin
      yo:= fstpt.Y;
      yn:=y;
   end
   else
   begin
      yo:=y;
      yn:= fstpt.Y;
   end;

   mmButton2:= mbLeft;
   Shift2 :=[ ssshift ,ssleft	];
   for i:=0 to self.grpGrpParent.ComponentCount -1 do
   begin
       if (
                (Twincontrol(grpGrpParent.Components[i]).top   >yo  )
            and (Twincontrol(grpGrpParent.Components[i]).Top   <yn+10)
            and (Twincontrol(grpGrpParent.Components[i]).left   >xo   )
            and (Twincontrol(grpGrpParent.Components[i]).left <xn+10 )
          ) then
        chyMouseDown(grpGrpParent.Components[i],mmButton2,  Shift2,0,0); { }
   end;
end;


procedure TfrmCreateComponent.chyMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  var i:integer;
begin
if FCollector=nil then exit       ;
if Sender=nil     then exit;

    if ( Sender is tlabel) then
    begin
         if ( Sender as tlabel_mtn).FCollector=nil  then exit;
         if    (Shift <>[ ssshift 	]	)  then
         begin
                 (  Sender as tlabel_mtn).Cursor  :=crdefault;
                 (  Sender as tlabel_mtn).Font.Style :=  (  Sender as tlabel_mtn).Font.Style  -[fsBold];

              for i:=0 to   ( Sender as tlabel_mtn).FCollector.Count -1 do
              begin
                  if ( Sender as tlabel_mtn).FCollector.Objects [i] is tlabel_mtn then
                  begin
                    tlabel_mtn( (  Sender as tlabel_mtn).FCollector.Objects [i]).Cursor   :=crdefault;
                    tlabel_mtn( (  Sender as tlabel_mtn).FCollector.Objects [i]).Font.Style := tlabel_mtn( (  Sender as tlabel_mtn).FCollector.Objects [i]).Font.Style  -[fsBold];
                  end;
              end;
              ( Sender as tlabel_mtn).FCollector.Clear ;
         end;
    end;

    if ( Sender is Tedit_Mtn) then
    begin
         if ( Sender as Tedit_Mtn).FCollector=nil  then exit;
         if ( Shift <>[ ssshift 	]	)  then
         begin
              ( Sender as Tedit_Mtn).Ctl3D :=false;
              ( Sender as Tedit_Mtn).Cursor  :=crdefault;
              ( Sender as Tedit_Mtn).Font.Style  :=( Sender as Tedit_Mtn).Font.Style-[fsBold];

                 for i:=0 to   ( Sender as Tedit_Mtn).FCollector.Count -1 do
                begin
                    if ( Sender as Tedit_Mtn).FCollector.Objects [i] is Tedit_Mtn then
                    begin
                      Tedit_Mtn( (  Sender as Tedit_Mtn).FCollector.Objects [i]).Cursor   :=crdefault;
                      Tedit_Mtn( (  Sender as Tedit_Mtn).FCollector.Objects [i]).Font.Style := Tedit_Mtn( (  Sender as Tedit_Mtn).FCollector.Objects [i]).Font.Style  -[fsBold];
                      Tedit_Mtn( (  Sender as Tedit_Mtn).FCollector.Objects [i]).Ctl3D := false;
                    end;
                end;
                ( Sender as Tedit_Mtn).FCollector.Clear ;
         end;
    end;

end;

procedure TfrmCreateComponent.chyMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  var sql:string;
  var txt,boxid:string;
begin


    if ( Sender is Tlabel_Mtn) and (  Button=mbleft ) then
    begin

         ( Sender as tlabel).Font.Style := ( Sender as tlabel).Font.Style   +[fsBold];
         ( Sender as tlabel).Cursor  :=crsizeall;
           if    (Shift =[ ssshift ,ssleft	]	)  then
                Tlabel_Mtn(Sender).FCollector.AddObject(Tlabel_Mtn(Sender).Caption,Tlabel_Mtn(Sender));
    end;

    if ( Sender is Tedit_Mtn) and (  Button=mbleft ) then
    begin
       // ( Sender as Tedit_Mtn).Ctl3D :=true;
        ( Sender as Tedit_Mtn).Cursor  :=crsizeall;
        ( Sender as Tedit_Mtn).Font.Style  :=( Sender as Tedit_Mtn).Font.Style+[fsBold];

                   if    (Shift =[ ssshift ,ssleft	]	)  then
                Tedit_Mtn(Sender).FCollector.AddObject( Tedit_Mtn(Sender).Text  ,Tedit_Mtn(Sender));
    end;


if      (Shift =[ ssCtrl ,ssLeft	]	)  then
begin
    Twincontrol(Sender).TabOrder  :=Tcontrol(Sender).Parent.Tag ;
     Tcontrol(Sender).Parent.Tag  :=   Tcontrol(Sender).Parent.Tag +1;
end;


end;
procedure TfrmCreateComponent.imgtopDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
     if  Source is tlistbox then
Accept:=true;
end;

procedure TfrmCreateComponent.imgtopDragDrop(Sender, Source: TObject; X,  Y: Integer);
var lbl:Tlabel_Mtn;
var CTRL:Tedit_Mtn;
var FieldType:integer;
var FieldKind :string;
var picklist:string;
var name:string;
begin
    if    Source is   tlistbox then
    begin
        lbl:=Tlabel_Mtn.Create(grpGrpParent);
        lbl.Parent :=grpGrpParent;
        if  self.chkUserMode.Checked then
        lbl.isUserMode :=True;

        lbl.Left :=x;
        lbl.Top :=y;
        name:=Tlistbox (Source).Items.Names [Tlistbox (Source).ItemIndex];
        lbl.Caption :=self.qryT102.FieldValues ['f09'];
        lbl.OnDblClick := DblClick_Ex;
        lbl.Visible :=true;
        lbl.Hint :='0'         ;
        lbl.Font.Name :='宋体';
        lbl.Font.Size:=10;
        //lbl.ECaption:='';
        lbl.ECaption := Tlistbox (Source).Items.Values  [name];

        CTRL:=Tedit_Mtn.Create (grpGrpParent);
        CTRL.Parent :=grpGrpParent;
        if  self.chkUserMode.Checked then
        CTRL.isUserMode :=True;

        CTRL.Left :=x+lbl.Width +10;
        CTRL.Top :=y ;
        CTRL.ShowHint :=true;
        CTRL.Hint := name+',-1,-1,-1';
        CTRL.Text := Tlistbox (Source).Items.Values  [name];
        CTRL.Visible :=true;

        CTRL.OnDblClick := DblClick_Ex;
        FieldType:=qryT102.FieldValues ['f04'];
        FieldKind:=qryT102.Fieldbyname ('f05').AsString ;
        picklist:=qryT102.Fieldbyname ('F11').AsString ;

        //1:  TFhlDbEdit       5:  TFhlDbLookupComboBox        6:  TDbMemo       7:  TDbCheckBox        8:  TDbText      9:  TFhlDbDatePicker        10: TDbRadioGroup        12: TDbComboBox;  13 TDbImage
  //             0 :cftString  1 :cftDate  2 :cftDateTime  3 :cftBoolean  4 :cftFloat  5 :cftCurrency  6 :cftMemo  7 :cftBlob  8 :cftBytes  9 :cftAutoInc  10:cftInteger  11:cftImage  12:cftLargeint
        case FieldType of
        0:begin
               if  trim(FieldKind)='l' then
                 CTRL.Tag :=5;

                if picklist<>'' then
                begin
                  CTRL.Tag:=12;
                end
                else
                 CTRL.Tag :=1;
          end;
        4,5,10:        CTRL.Tag :=1;
        1,2  :         CTRL.Tag :=9;
        3:             CTRL.Tag :=7;
        6:             CTRL.Tag :=6;
        7 :            CTRL.Tag :=13;
        end;
    end;
end;
procedure TfrmCreateComponent.edtGridIDDblClick(Sender: TObject);
var   frmGetGridID: TfrmGetGridID;
begin
 frmGetGridID:= TfrmGetGridID.Create (nil);
 frmGetGridID.edtgridID.Text   :=tedit(sender).Text ;
 frmGetGridID.ShowModal;
end;



function TfrmCreateComponent.GetFieldECaption(FieldName: string): string;
begin


 FhlKnl1.Kl_GetQuery2('select top 1 *From '+LoginInfo.SysDBPubName+'.dbo.Tallfields where FieldEName='+quotedstr(FieldName));
 if not FhlKnl1.FreeQuery.IsEmpty then
    result:=FhlKnl1.FreeQuery.fieldbyname('FieldCName').AsString ;
end;

function TfrmCreateComponent.GetFieldType(FieldName: string): string;
begin


 FhlKnl1.Kl_GetQuery2('select top 1 *From '+LoginInfo.SysDBPubName+'.dbo.Tallfields where FieldEName='+quotedstr(FieldName));
 if not FhlKnl1.FreeQuery.IsEmpty then
    result:=FhlKnl1.FreeQuery.fieldbyname('FieldTypeiD').AsString ;

end;

function TfrmCreateComponent.GetFieldLength(FieldName: string): string;
begin

 FhlKnl1.Kl_GetQuery2('select top 1 *From '+LoginInfo.SysDBPubName+'.dbo.Tallfields where FieldEName='+quotedstr(FieldName));
 if not FhlKnl1.FreeQuery.IsEmpty then
    result:=FhlKnl1.FreeQuery.fieldbyname('FieldLength').AsString ;

end;

procedure TfrmCreateComponent.dbedtFieldNameChange(Sender: TObject);
begin
//

end;

procedure TfrmCreateComponent.edtFieldIDDblClick(Sender: TObject);
begin
 btnAddT202.Click;
   dbedtT202FieldID.Text :=TEdit(Sender).Text ;
   btnSaveT202.Click;
end;

procedure TfrmCreateComponent.btnCreateColClick(Sender: TObject);
begin
btncolAdd.Click;
  qryGrid.Open;
  if not (qryGrid.State in [dsinsert]) then
  qryGrid.Append ;
  qryGrid.FieldByName('f03').AsString :=edtFieldID.Text ;
  qryGrid.FieldByName('f14').AsString :=dbedtCaption.Text ;

  btn_saveAddCol.Click;
end;

procedure TfrmCreateComponent.dbedtFieldNameDblClick(Sender: TObject);
begin
edtFieldname.Text :=TEdit(Sender).Text +'Lkp';
  btn9GetFieldName.Click;
end;

procedure TfrmCreateComponent.MClearDbClickClick(Sender: TObject);
var i:integer;
begin
    if     self.FCollector.Count>1 then
    begin
          for i:=0 to self.FCollector.Count -1 do
          begin
             if  ((self.FCollector.Objects [i]) is Tedit     )   then
             begin
                Tedit( self.FCollector.Objects [i]).OnDblClick      :=nil;//Tmenuitem(Sender).Checked;
             end;
          end;
    end    ;
end;

procedure TfrmCreateComponent.chkUserModeClick(Sender: TObject);
var i:integer;
begin
    if     self.FCollector.Count>1 then
    begin
        for i:=0 to self.FCollector.Count -1 do
        begin
          if self.FCollector.Objects [i] is TLabel_mtn then
           Tlabel_Mtn(FCollector.Objects [i] ).isUserMode := self.chkUserMode.Checked;

          if self.FCollector.Objects [i] is TEdit_mtn then
           TEdit_Mtn(FCollector.Objects [i] ).isUserMode := self.chkUserMode.Checked;

        end;
    end;
end;

procedure TfrmCreateComponent.RefreshClick(Sender: TObject);
var i:integer;
begin
   self.FCollector.Clear ;
       for i:=0 to grpGrpParent.ComponentCount-1 do
  begin
  {
  if  grpGrpParent.Components [i] is  Tedit_Mtn then
        grpGrpParent.Components [i].Free ;
  if  grpGrpParent.Components [i] is  Tlabel_Mtn then
        grpGrpParent.Components [i].Free ;
   }
     grpGrpParent.Components [0].Free ;
  end;
  LoadControlClick(sender);
end;

end.
