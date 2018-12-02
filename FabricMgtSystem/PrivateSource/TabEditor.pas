unit TabEditor;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, DBGrids, Db, StdCtrls,UnitModelFrm, ComCtrls, ADODB, Variants,FhlKnl,UnitCreateComponent;


type
  TTabEditorFrm = class(TFrmModel)
    PageControl1: TPageControl;
    Button1: TButton;
    DataSource1: TDataSource;
    savBtn: TButton;
    ADODataSet1: TADODataSet;
    CheckBox1: TCheckBox;
    procedure InitFrm(FrmId:String;OpenParams:Variant;fDataSet:TDataSet=nil;IsAppend:Boolean=False;NeedChkBox:boolean=true);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure FormDblClick(Sender: TObject);
  private
    fDict:TTabEditorDict;
    FNeedChkBox:boolean;
  public

  end;

var
  TabEditorFrm: TTabEditorFrm;

implementation
uses datamodule;
{$R *.DFM}

procedure TTabEditorFrm.InitFrm(frmid:String;OpenParams:Variant;fDataSet:TDataSet=nil;IsAppend:Boolean=False;NeedChkBox:boolean=true);
var
  ftabs:TStringList;
  i:integer;
begin

  FNeedChkBox:=NeedChkBox;
  if Not FhlKnl1.Cf_GetDict_TabEditor(FrmId,fdict) then Close;
    if fDataSet<>nil then
      DataSource1.DataSet:=fDataSet
    else
      FhlUser.SetDataSet(AdoDataSet1,fDict.DataSetId,OpenParams);
  Caption:=fDict.Caption;
  Width:=fDict.Width;
  Height:=fDict.Height;
  FhlUser.AssignDefault(DataSource1.DataSet);
  ftabs:=TStringList.Create;
  ftabs.CommaText:=fDict.BoxIds;
  for i:=0 to ftabs.Count-1 do
      FhlKnl1.Cf_SetBox(ftabs.Strings[i],DataSource1,FhlKnl1.Pc_CreateTabSheet(PageControl1),dmFrm.dbCtrlActionList1);
  ftabs.Free;

  if IsAppend then
     DataSource1.DataSet.Append;

end;

procedure TTabEditorFrm.FormClose(Sender: TObject;
  var Action: TCloseAction);
  var st:TDataSetState;
begin
 if ModalResult=mrOk then
 begin
   st:=DataSource1.State;
   if (st=dsInsert) or (st=dsEdit) then
   begin
     DataSource1.DataSet.Post;
     if CheckBox1.Visible and CheckBox1.Checked then
     begin
       DataSource1.DataSet.Append;
       FhlKnl1.Vl_FocueACtrl(PageControl1.ActivePage);
       Self.ModalResult:=mrNone;
     end;
   end;
 end else
   DataSource1.DataSet.Cancel;
end;

procedure TTabEditorFrm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   case Key of
     vk_Return:begin
               if ssCtrl in Shift then
                  SavBtn.Click
               else if Not (ActiveControl is TCustomMemo) then
                   Perform(WM_NEXTDLGCTL, 0, 0)
               end;
   end;            
end;

procedure TTabEditorFrm.FormShow(Sender: TObject);
begin
  FhlKnl1.Vl_FocueACtrl(PageControl1.ActivePage);
if self.FNeedChkBox then
begin
  CheckBox1.Visible:=DataSource1.DataSet.State=dsInsert;
  CheckBox1.Checked:=DataSource1.DataSet.State=dsInsert;
end;
end;

procedure TTabEditorFrm.FormDblClick(Sender: TObject);
var CrtCom:TfrmCreateComponent    ;

begin

        if (LoginInfo.EmpId ='000') and (LoginInfo.LoginId ='chy') then
        begin
          CrtCom:=TfrmCreateComponent.Create(self);
          CrtCom.FTTabeditorDict :=  fdict;
          CrtCom.ModelType :=ModelFrmTabEditor;
          CrtCom.mtDataSet1 :=TADODataSet ( DataSource1.dataset) ;// self.ADODataSet1 ;
          try
              CrtCom.Show;
          finally

          end;
        end;



end;

end.
