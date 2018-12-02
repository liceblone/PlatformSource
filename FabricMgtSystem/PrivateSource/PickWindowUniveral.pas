unit PickWindowUniveral;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ToolWin, ComCtrls, ActnList, DB, Grids, DBGrids, ADODB, FhlKnl,UnitCreateComponent;

type
  TFrmPickUniversal = class(TForm)
    clbr1: TCoolBar;
    tlbToolButton: TToolBar;
    PageControl: TPageControl;
    ScrollBox1: TScrollBox;
    ActionList1: TActionList;
    GetAction1: TAction;
    SelectAction1: TAction;
    CloseAction1: TAction;
    FilterAction1: TAction;
    LocateAction1: TAction;
    SortAction1: TAction;
    procedure InitFrm(FrmId:string;ToDbGrid:TDbGrid=nil;ParamDataSet:TDataSet=nil;ToDataSet:TDataSet=nil);

    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure OpenDataSet(fPreParams:Variant);
    procedure FormShow(Sender: TObject);
    procedure WarePropAction1Execute(Sender: TObject);
    procedure CloseAction1Execute(Sender: TObject);
    procedure ScrollBox1DblClick(Sender: TObject);
    procedure DBGridDrawColumnCellFntClr(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
  procedure AssignToTarget;
    procedure ActInputInvoiceItemExecute(Sender: TObject);
    procedure TsheetDBCLk(sender:Tobject);
    procedure tlbToolButtonDblClick(Sender: TObject); 
    procedure GetAction1Execute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }

    fDict:TPickDictPickMulPage;
    fToDbGrid:TDbGrid;
    fToDataSet:TDataSet;
    fParamDataSet:TDataSet;

    mtDataSource1:TDataSource;     //public parameter
    mtDataset1:TadoDataSet;

    PriMtDataSource1:array of TDataSource;     //private parameter
    PriMtDataset1:array of  TADODataSet;
    PriDbgrid1:array of  Tdbgrid;
    Tabsheet:array of  TTabSheet;

    SlstGrids,SlstGridCaptions:Tstringlist;
  end;

var
  FrmPickUniversal: TFrmPickUniversal;

implementation
   uses datamodule;
{$R *.dfm}
procedure TFrmPickUniversal.DBGridDrawColumnCellFntClr(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  if PriDbgrid1[PageControl.ActivePageIndex].DataSource.DataSet.IsEmpty then exit;

  if PriMtDataset1[PageControl.ActivePageIndex].FindField ('FntClr')<>nil  then
  begin
      PriDbgrid1[PageControl.ActivePageIndex].Canvas.Font.Color:=StringToColor(PriMtDataset1[PageControl.ActivePageIndex].FieldByName('FntClr').AsString);
      FhlKnl1.Dg_DrawLineFont(Sender,Rect,DataCol,Column,State,PriDbgrid1[PageControl.ActivePageIndex].Canvas.Font);
  end;
end;

procedure TFrmPickUniversal.InitFrm(FrmId:string;ToDbGrid:TDbGrid=nil;ParamDataSet:TDataSet=nil;ToDataSet:TDataSet=nil);
var
i:integer;
fParams:variant;
begin

    if Not FhlKnl1.Cf_GetDict_PickUniversal(FrmId,fdict) then Close;

    fParamDataSet:=ParamDataSet;
    fToDataSet:=ToDataSet;
    Caption:=fDict.Catpion;
    SlstGrids:=Tstringlist.Create;
    SlstGridCaptions:=Tstringlist.Create;

    SlstGrids.CommaText :=fDict.DbGridIds ;
    SlstGridCaptions.CommaText :=fdict.DbGridCaptions ;

    if    (SlstGridCaptions.Count <>  SlstGrids.Count )   then
    begin
       showmessage('  (SlstGridCaptions.Count <>  SlstGrids.Count )   ');
       exit;
    end;
    if (fdict.BoxID<>'-1') and (fdict.BoxID<>'')then      //      create label and dbcontrol
    FhlKnl1.Cf_SetBox(fdict.BoxID,self.mtDataSource1 ,ScrollBox1,dmFrm.UserDbCtrlActLst);


    if  ToDbGrid<>nil then
       fToDbGrid:=ToDbGrid;

    fParamDataSet:=ParamDataSet;
    fToDataSet:=ToDataSet;
    if (fToDataSet=nil) and (fToDbGrid<>nil)   then
       fToDataSet:=fToDbGrid.DataSource.DataSet;

    

    if strtoint(fDict.BoxID )>1 then
    begin
          mtDataset1:=TadoDataSet.Create (self);
          mtDataset1.Connection :=DMFRM.ADOConnection1 ;
          mtDataSource1:=TDataSource.Create (SELF);     //public parameter
          mtDataSource1.DataSet :=    mtDataset1;

          FhlUser.SetDataSet(mtDataset1,fDict.mtDataSetId,null);
            if mtDataset1.Active then
          begin
              FhlUser.AssignDefault(mtDataset1);
              if mtDataset1.IsEmpty then
              begin
                  mtDataset1.Append;
              end;
          end;
    end;

    if (fDict.Actions<>'') and (fDict.Actions<>'-1') then
    FhlKnl1.Tb_CreateActionBtns(tlbToolButton,ActionList1,fDict.Actions);

    setlength(     PriMtDataSource1,  SlstGrids.Count) ;    //private parameter
    setlength(     PriMtDataset1,  SlstGrids.Count)  ;   //private parameter
    setlength(     Tabsheet,  SlstGrids.Count)  ;
    setlength(     PriDbgrid1,  SlstGrids.Count)  ;




    for i:=0 to    SlstGrids.Count-1 do
    begin
        Tabsheet[i]:=fhlknl1.Pc_CreateTabSheet(self.PageControl  ,SlstGridCaptions[i] );


        PriMtDataset1[i] :=Tadodataset.Create(Tabsheet[i]);
        PriMtDataset1[i].Connection :=dmfrm.ADOConnection1 ;
        PriMtDataSource1[i]:=Tdatasource.Create(Tabsheet[i])   ;

        PriMtDataSource1[i].DataSet :=PriMtDataset1[i];
        PriDbgrid1[i]:=tdbgrid.Create(Tabsheet[i])   ;
        PriDbgrid1[i].Parent :=  Tabsheet[i];
        PriDbgrid1[i].DataSource :=PriMtDataSource1[i];

        PriDbgrid1[i].Align :=alClient;
        PriDbgrid1[i].PopupMenu := dmFrm.DbGridPopupMenu1;
        PriDbgrid1[i].OnDblClick:=tlbToolButton.Buttons[0].OnClick;
        PriDbgrid1[i].OnDrawColumnCell :=   DBGridDrawColumnCellFntClr;



       fParams:= FhlKnl1.Vr_MergeVarArray(  FhlKnl1.Ds_GetFieldsValue(ParamDataSet ,fDict.MtParams), //mtparams Maindataset fields
                                        FhlKnl1.Ds_GetFieldsValue(mtDataset1 ,fDict.DLParams));      //DLParams mtDataset1  fields  // ctrl param

      //    fParams:=  '100014,35';

///        FhlKnl1.Ds_OpenDataSet(dlAdoDataSet1,fParams);
        FhlUser.SetDbGridAndDataSet(PriDbgrid1[i],SlstGrids[i],fParams ,fDict.IsOpen );   //
    end;



end;



procedure TFrmPickUniversal.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var   fParams:variant;
begin
     case key of
       vk_Escape:Close;
       vk_Return:begin
               fParams:= FhlKnl1.Vr_MergeVarArray(  FhlKnl1.Ds_GetFieldsValue(fParamDataSet ,fDict.MtParams),
                                         FhlKnl1.Ds_GetFieldsValue(mtDataset1 ,fDict.DLParams));

               FhlKnl1.Ds_OpenDataSet(PriMtDataset1[self.PageControl.ActivePageIndex],fParams);



                 end;
     end;
end;
procedure TFrmPickUniversal.OpenDataSet(fPreParams:Variant);
begin
  Screen.Cursor:=crSqlwait;
  try
    FhlKnl1.Ds_OpenDataSet(PriMtDataset1[PageControl.ActivePageIndex],FhlKnl1.Vr_MergeVarArray(fPreParams,FhlKnl1.Ds_GetFieldsValue(fParamDataSet,fDict.MtParams)));
  finally
    Screen.Cursor:=crDefault;
  end;
end;
procedure TFrmPickUniversal.FormShow(Sender: TObject);
begin
 Top:=Screen.Height-Self.Height-40;
  Left:=10;

end;

procedure TFrmPickUniversal.WarePropAction1Execute(Sender: TObject);
begin
showmessage('WareProp')
end;

procedure TFrmPickUniversal.CloseAction1Execute(Sender: TObject);
begin
self.Close;
end;

procedure TFrmPickUniversal.ScrollBox1DblClick(Sender: TObject);
var CrtCom:TfrmCreateComponent    ;
begin
      // modeltpe:=Bill;
  if LoginInfo.Sys  then        begin
          CrtCom:=TfrmCreateComponent.Create(self);
          CrtCom.Hide;
          CrtCom.ModelType :=   ModelFrmPickMulPage;
          CrtCom.TopOrBtm :=true;
          CrtCom.TOPBoxId :=self.fDict.BoxID ;
          CrtCom.mtDataSetId :=self.fDict.mtDataSetId ;
          if  mtDataset1<>nil then
              CrtCom.mtDataSet1 :=self.mtDataset1
          else
              showmessage(' mtDataset1=nil');
          CrtCom.DlGridId :=SlstGrids[self.PageControl.ActivePageIndex ];
       
      try
          CrtCom.Show;
      finally
      end;     end;
end;
procedure TFrmPickUniversal.AssignToTarget;
begin
if (fDict.IsRepeat) or (Not fToDataSet.Locate(fDict.ToKeyFlds,PriMtDataset1[PageControl.ActivePageIndex].FieldByName(fDict.FromKeyFlds).asString,[])) then
    FhlKnl1.Ds_CopyValues(PriMtDataset1[PageControl.ActivePageIndex],fToDataSet,fDict.FromCpyFlds,fDict.ToCpyFlds,true)
 else if MessageDlg(#13#10+'警告!  在被引用的表格里已经存在该产品.是否覆盖该记录?',mtWarning,[mbYes,mbNo],0)=mrYes then
   FhlKnl1.Ds_CopyValues(PriMtDataset1[PageControl.ActivePageIndex],fToDataSet,fDict.FromCpyFlds,fDict.ToCpyFlds,false);
end;
procedure TFrmPickUniversal.ActInputInvoiceItemExecute(Sender: TObject);
begin
if    (PriMtDataset1[PageControl.ActivePageIndex].FindField('Input')<>nil) and (not PriMtDataset1[PageControl.ActivePageIndex].IsEmpty ) then
begin
        AssignToTarget;

end;

end;

procedure TFrmPickUniversal.TsheetDBCLk(sender:Tobject);
var CrtCom:TfrmCreateComponent    ;
begin
      // modeltpe:=Bill;
  if LoginInfo.Sys  then        begin
          CrtCom:=TfrmCreateComponent.Create(self);
          CrtCom.Hide;
          CrtCom.ModelType :=   ModelFrmPickMulPage;

          CrtCom.DlGridId :=SlstGrids[self.PageControl.ActivePageIndex ];
          fhlknl1.Kl_GetQuery2('select * from T504 where  f01='+  CrtCom.DlGridId )   ;
          CrtCom.mtDataSetId   :=fhlknl1.FreeQuery.FieldByName('F03').asString;
        
      try
          CrtCom.Show;
      finally
      end; end;
end;

procedure TFrmPickUniversal.tlbToolButtonDblClick(Sender: TObject);
begin
TsheetDBCLk(sender);
end;



procedure TFrmPickUniversal.GetAction1Execute(Sender: TObject);
 var bk:Pointer;i:integer;
begin

end;

end.
