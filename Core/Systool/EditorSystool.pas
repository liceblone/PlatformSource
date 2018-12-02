unit EditorSystool;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,StrUtils,
  StdCtrls, ComCtrls, ToolWin, ADODB, Db, DbCtrls, CheckLst, ImgList, variants,  UnitUserDefineRpt,UnitEditorReport,
  Mask, ActnList, FhlKnl, ExtCtrls;


type
  TEditorFrmSystool = class(TForm)
    CoolBar1: TCoolBar;
    ToolBar1: TToolBar;
    SavBtn: TToolButton;
    DataSource1: TDataSource;
    CelBtn: TToolButton;
    ToolButton3: TToolButton;
    AddBtn: TToolButton;
    CpyBtn: TToolButton;
    DelBtn: TToolButton;
    ToolButton7: TToolButton;
    FirstBtn: TToolButton;
    NextBtn: TToolButton;
    PriorBtn: TToolButton;
    LastBtn: TToolButton;
    ToolButton12: TToolButton;
    ExtBtn: TToolButton;
    PageControl1: TPageControl;
    PrintBtn: TToolButton;
    ToolButton2: TToolButton;
    ChgBtn: TToolButton;
    ADODataSet1: TADODataSet;
    ActionList1: TActionList;
    AddAction: TAction;
    CopyAction: TAction;
    EditAction: TAction;
    DeleteAction: TAction;
    SaveAction: TAction;
    CancelAction: TAction;
    FirstAction: TAction;
    PriorAction: TAction;
    NextAction: TAction;
    LastAction: TAction;
    CloseAction: TAction;
    PrintAction: TAction;
    SetCaptionAction: TAction;
    actInputTaxAmt: TAction;
    Splitter1: TSplitter;
    PnlItem: TPanel;
    actSql: TAction;
    btnSql: TToolButton;
    pnlInfo: TPanel;
    mmoSql: TMemo;

    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SetEditState(CanEdit:Boolean);
    procedure AddActionExecute(Sender: TObject);
    procedure CopyActionExecute(Sender: TObject);
    procedure EditActionExecute(Sender: TObject);
    procedure DeleteActionExecute(Sender: TObject);
    procedure FirstActionExecute(Sender: TObject);
    procedure PriorActionExecute(Sender: TObject);
    procedure NextActionExecute(Sender: TObject);
    procedure LastActionExecute(Sender: TObject);
    procedure CloseActionExecute(Sender: TObject);
    procedure SaveActionExecute(Sender: TObject);
    procedure CancelActionExecute(Sender: TObject);
    procedure SetCaptionActionExecute(Sender: TObject);
    procedure PrintActionExecute(Sender: TObject);
    procedure ToolBar1DblClick(Sender: TObject);
    procedure ADODataSet1AfterPost(DataSet: TDataSet);
    procedure ADODataSet1BeforeDelete(DataSet: TDataSet);
    procedure ADODataSet1AfterEdit(DataSet: TDataSet);
    procedure ADODataSet1NewRecord(DataSet: TDataSet);
    procedure actSqlExecute(Sender: TObject);

  private
       bInsert:boolean;
       FParamDataSet:  TDataSet;
       FParams:Variant;
  public
       fDict:TEditorDict;
    procedure InitFrm(EditorId:String;fOpenParams:Variant;fDataSet:TDataSet);overload;
  end;

var
  EditorFrmSystool: TEditorFrmSystool;

implementation

{$R *.DFM}
uses datamodule,RepCard,UnitCreateComponent;

procedure TEditorFrmSystool.InitFrm(EditorId:string;fOpenParams:Variant;fDataSet:TDataSet);
var
  ftabs:TStringList;
  i:integer;
begin
  if Not FhlKnl1.Cf_GetDict_Editor(EditorId,fdict) then Close;
    //2006-7-26加toolbutton
if (trim(fDict.Actions)<>''  ) and   (trim(fDict.Actions)<>'-1' )then
  FhlKnl1.Tb_CreateActionBtns(ToolBar1,self.ActionList1 ,fDict.Actions,false);


  if (self.Width <  fDict.Width) then
  self.Width :=  fDict.Width;

  if (height < fDict.Height) then
  height:=fDict.Height;

  Caption:=fDict.Caption+'系统配置';
  CpyBtn.Visible:=Not (fDict.CpyFlds='');
  if (fDataSet<>nil)and ((fDict.DataSetId ='-1' )or (trim(fDict.DataSetId) ='')) then
     DataSource1.DataSet:=fDataSet
  else
  Begin
     self.FParamDataSet :=  fDataSet ;
     FParams:=fOpenParams;
     try
     FhlUser.SetDataSet(AdoDataSet1,fDict.DataSetId,fOpenParams);
     except
     end;
  end;

  ftabs:=TStringList.Create;
  ftabs.CommaText:=fDict.BoxIds;
  for i:=0 to ftabs.Count-1 do
  begin
      FhlKnl1.Cf_SetBox(ftabs.Strings[i],DataSource1,FhlKnl1.Pc_CreateTabSheet(PageControl1),dmFrm.DbCtrlActionList1);

  end;

  SetEditState(false);
  ftabs.Free;

  if   PnlItem.Height =1 then
  Splitter1.Enabled :=false; 
end;

procedure TEditorFrmSystool.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 if (DataSource1.State=dsEdit) or (DataSource1.State=dsInsert) then
    case MessageDlg(fsDbChanged,mtConfirmation,[mbYes,mbNo,mbCancel],0) of
         mrYes:begin
                 SaveActionExecute(SavBtn);
                 Action:=caHide;
               end;
         mrNo:begin
                 CancelActionExecute(celBtn);
                 Action:=caHide;
              end;
         else begin
                 Action:=caNone;
              end;
    end;
end;

procedure TEditorFrmSystool.SetEditState(CanEdit:Boolean);
  var i:integer;bkColor:TColor;
begin

     CelBtn.Enabled:=CanEdit;
     SavBtn.Enabled:=CelBtn.Enabled;
     FirstBtn.Enabled:=Not CanEdit;
     PriorBtn.Enabled:=FirstBtn.Enabled;
     NextBtn.Enabled:=FirstBtn.Enabled;
     LastBtn.Enabled:=FirstBtn.Enabled;
     ExtBtn.Enabled:=FirstBtn.Enabled;
        AddBtn.Enabled:=FirstBtn.Enabled;
        CpyBtn.Enabled:=FirstBtn.Enabled;
        ChgBtn.Enabled:=FirstBtn.Enabled;
        DelBtn.Enabled:=FirstBtn.Enabled;
        PrintBtn.Enabled:=FirstBtn.Enabled;
     if CanEdit then
        bkColor:=clWhite
     else
        bkColor:=clCream;
     For i:=0 to PageControl1.PageCount-1 do
         FhlKnl1.Vl_SetCtrlStyle(bkColor,PageControl1.Pages[i],CanEdit);
     //dmFrm.SetDataSetStyle(DataSource1.DataSet,Not CanEdit);
end;

procedure TEditorFrmSystool.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if SavBtn.Enabled then
 begin
   case Key of
     vk_Return:begin
               if ssCtrl in Shift then
                  SavBtn.Click
               else if Not (ActiveControl is TDbMemo) then
                  FhlKnl1.Vl_DoBoxEnter(ActiveControl)
               end;
     vk_Escape:begin
              CelBtn.Click;
             end;
   end;
 end else
 begin
   case Key of
     vk_Escape:begin
             ExtBtn.Click;
             end;
     vk_Insert:begin
              if ssCtrl in Shift then
                 ChgBtn.Click
              else
                 AddBtn.Click;
             end;
     vk_Delete:begin
                 DelBtn.Click;
             end;
     vk_Home:firstBtn.Click;
     vk_End:lastBtn.Click;
     vk_Prior:priorBtn.Click;
     vk_Next:nextBtn.Click;
     vk_Print:printBtn.Click;
   end;
 end;

end;

procedure TEditorFrmSystool.AddActionExecute(Sender: TObject);
begin
  SetEditState(True);
  FhlUser.AssignDefault(DataSource1.DataSet,false);
if not (DataSource1.DataSet.State in [dsinsert] ) then
 DataSource1.DataSet.Append;

  FhlKnl1.Vl_FocueACtrl(PageControl1.ActivePage);
end;

procedure TEditorFrmSystool.CopyActionExecute(Sender: TObject);
begin
 if fDict.CpyFlds='' then exit;
  SetEditState(true);
  FhlKnl1.Ds_AssignValues(DataSource1.DataSet,FhlKnl1.Vr_CommaStrToVarArray(fDict.CpyFlds),FhlKnl1.Ds_GetFieldsValue(DataSource1.DataSet,fDict.CpyFlds),True,False);
  FhlKnl1.Vl_FocueACtrl(PageControl1.ActivePage);
end;

procedure TEditorFrmSystool.EditActionExecute(Sender: TObject);
var k,i,J:integer;
var FilterStr,F_FilterFlds,SourceFldValue,SourceFldName:string;



var SourceLookUpCombox:  TFhlDbLookupComboBox;
var DestLookUpCombox  :  TFhlDbLookupComboBox;

var FldsLst:TStrings;
begin

for k:=0 to self.PageControl1.ActivePage.ControlCount  -1 do
begin
    if  (self.PageControl1.ActivePage.Components[k] is TFhlDbLookupComboBox) then
    begin
          SourceLookUpCombox:= ( self.PageControl1.ActivePage.Components[k] as  TFhlDbLookupComboBox  );

          F_FilterFlds  :=SourceLookUpCombox.F_FilterFlds    ;
          SourceFldName :=SourceLookUpCombox.Field.FieldName ;

          if (SourceLookUpCombox.Field.Value =null)  then
              SourceFldValue:=''
          else
              SourceFldValue:=(self.PageControl1.ActivePage.Components[k] as  TFhlDbLookupComboBox).Field.Value  ;


          if  (F_FilterFlds<>'') and (F_FilterFlds<>'sEmpty') then
          begin
             FldsLst:=TStringlist.Create ;
             FldsLst.CommaText:=F_FilterFlds;

             for j:=0 to FldsLst.Count -1 do
             begin

                    for i:=0 to self.PageControl1.ActivePage.ControlCount -1 do
                    begin
                        if  self.PageControl1.ActivePage.Controls[i] is TDBLookupComboBox then
                           if   uppercase(trim(TDBLookupComboBox (self.PageControl1.ActivePage.Controls[i]).DataField)) =uppercase(trim(FldsLst[J])) then
                                 DestLookUpCombox:=   TFhlDbLookupComboBox (self.PageControl1.ActivePage.Controls[i]) ;
                    end;

               //     if FilterLookUpCombox<>nil then
               //     FilterLookUpCombox.DataSource.DataSet.FieldByName(FilterLookUpCombox.DataField ).Value :=NULL;

                    if   (SourceFldValue<>'')   then
                    begin
                       FilterStr:=SourceFldName +' like '+quotedstr(SourceFldValue+'%' );
                    DestLookUpCombox.ListSource.DataSet.Filter :=FilterStr;
                    DestLookUpCombox.ListSource.DataSet.Filtered :=true;
                    end
                    else
                    begin
                       // FilterStr:=SourceFldName +' like '+quotedstr(''+'%' )    ;
                        //DestLookUpCombox.ListSource.DataSet.Filtered :=true;
                    end;




                    if DestLookUpCombox<>nil then
                    if DestLookUpCombox.ListSource.DataSet.IsEmpty then
                        DestLookUpCombox.Enabled  :=false
                    else
                        DestLookUpCombox.Enabled  :=true ;
             end;

    end;

    end;
end;

  if DataSource1.DataSet.IsEmpty then Exit;
  SetEditState(true);
  DataSource1.DataSet.Edit;
  FhlKnl1.Vl_FocueACtrl(PageControl1.ActivePage);
end;

procedure TEditorFrmSystool.DeleteActionExecute(Sender: TObject);
begin
  if DataSource1.DataSet.IsEmpty then Exit;


 
      if MessageBox(0, '确定删除？', '', MB_YESNO + MB_ICONQUESTION) = IDYES 
        then
      begin
          DataSource1.DataSet.Delete;
      end;

  
end;

procedure TEditorFrmSystool.FirstActionExecute(Sender: TObject);
begin
      if self.FParamDataSet <>nil then
      begin
         FParamDataSet.First;
         FhlKnl1.Ds_OpenDataSet(DataSource1.DataSet,self.FParams );
      end
      else
      begin
          DataSource1.DataSet.First;
      end;
end;

procedure TEditorFrmSystool.PriorActionExecute(Sender: TObject);
begin
      if self.FParamDataSet <>nil then
      begin
         FParamDataSet.Prior ;
         FhlKnl1.Ds_OpenDataSet(DataSource1.DataSet,self.FParams );
      end
      else
      begin
         DataSource1.DataSet.Prior;
      end;
end;

procedure TEditorFrmSystool.NextActionExecute(Sender: TObject);
begin

      if self.FParamDataSet <>nil then
      begin
         FParamDataSet.Next  ;
         FhlKnl1.Ds_OpenDataSet(DataSource1.DataSet,self.FParams );
      end
      else
      begin
         DataSource1.DataSet.Next;
      end;
end;

procedure TEditorFrmSystool.LastActionExecute(Sender: TObject);
begin
      if self.FParamDataSet <>nil then
      begin
         FParamDataSet.Last   ;
         FhlKnl1.Ds_OpenDataSet(DataSource1.DataSet,self.FParams );
      end
      else
      begin
          DataSource1.DataSet.Last;
      end;
end;

procedure TEditorFrmSystool.CloseActionExecute(Sender: TObject);
begin
Close;
end;

procedure TEditorFrmSystool.SaveActionExecute(Sender: TObject);

begin

 DataSource1.DataSet.Post; 
 SetEditState(DataSource1.DataSet.State<>dsBrowse);


end;

procedure TEditorFrmSystool.CancelActionExecute(Sender: TObject);
begin
DataSource1.DataSet.Cancel;
SetEditState(false);
end;

procedure TEditorFrmSystool.SetCaptionActionExecute(Sender: TObject);
begin
Caption:=fDict.Caption+' '+intTostr(DataSource1.DataSet.RecNo)+'/'+intTostr(DataSource1.DataSet.RecordCount);
end;

procedure TEditorFrmSystool.PrintActionExecute(Sender: TObject);
var RepBillFrm:TEditorReport;

begin

    //
 
end;
procedure TEditorFrmSystool.ToolBar1DblClick(Sender: TObject);
var CrtCom:TfrmCreateComponent    ;
 
begin
  if LoginInfo.Sys  then  



  if LoginInfo.Sys  then
  begin
    CrtCom:=TfrmCreateComponent.Create(self);

    CrtCom.FEditorDict  :=  fdict;
    CrtCom.ModelType :=Modeleditor;
    CrtCom.mtDataSet1:=Tadodataset(DataSource1.DataSet);
    CrtCom.mtDataSetId :=inttostr(Tadodataset(DataSource1.DataSet).tag);
  //  CrtCom.grpGrpParent.Width :=self.Width ;
  //  CrtCom.grpGrpParent.Height :=self.Height ;
     CrtCom.ShowModal ;
    CrtCom.Free ;
  end;

try
  
finally

end;
end;





procedure TEditorFrmSystool.ADODataSet1AfterPost(DataSet: TDataSet);
var tableName:string;
begin
tableName:= rightstr(  tadodataset(DataSet).CommandText ,pos( tadodataset(DataSet).CommandText,'from'));

tableName:= rightstr(  tadodataset(DataSet).CommandText ,pos( tadodataset(DataSet).CommandText,' '));

if (trim( tableName )<>'')   then
 (fhlknl1.GetPostSQL  (DataSet,bInsert,'T511'));

end;

procedure TEditorFrmSystool.ADODataSet1BeforeDelete(DataSet: TDataSet);
begin
 (fhlknl1.GetDeleteSQL(Dataset,'T511'));

end;

procedure TEditorFrmSystool.ADODataSet1AfterEdit(DataSet: TDataSet);
begin
       bInsert:=false;
end;

procedure TEditorFrmSystool.ADODataSet1NewRecord(DataSet: TDataSet);
begin
 bInsert:=true;
end;


procedure TEditorFrmSystool.actSqlExecute(Sender: TObject);
var tableName:string ;
begin
  tableName :=fhluser.GetTableName(  inttostr(self.DataSource1.DataSet.tag));

  mmoSql.Lines.Add(  fhlknl1.GetPostSQL(self.DataSource1.DataSet , true, tableName   ) );
  mmoSql.Lines.Add('') ;
  mmoSql.Lines.Add(  fhlknl1.GetPostSQL(self.DataSource1.DataSet , false, tableName  ) );

end;

end.
