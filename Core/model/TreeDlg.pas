unit TreeDlg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,  UPublicFunction,
  Dialogs, StdCtrls, ComCtrls, DB, ADODB, FhlKnl;


type
  TTreeDlgFrm = class(TForm)
    TreeView1: TTreeView;
    okBtn: TButton;
    Button2: TButton;
    ADODataSet1: TADODataSet;
    ChkNull: TCheckBox;


    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure TreeView1Change(Sender: TObject; Node: TTreeNode);
    procedure TreeView1DblClick(Sender: TObject);
    procedure ChkNullClick(Sender: TObject);
  private
    fDict:TTreeDlgDict;
    fAllowPickParentNode: boolean;
    procedure SetAllowPickParentNode(const Value: boolean); 

  public
   procedure InitFrm(Fld:TField);overload;
   procedure InitFrm(DataSetID: string;aParam:variant;Isopen:boolean;CodeFldName,NameFldName:string;showCode:boolean);overload;

   property   AllowPickParentNode : boolean read FAllowPickParentNode write SetAllowPickParentNode;
 end;

var
  TreeDlgFrm: TTreeDlgFrm;

implementation
uses datamodule;
{$R *.dfm}

procedure TTreeDlgFrm.InitFrm(Fld:TField);
var FocusNode: TTreeNode;
begin
   fDict.LkpFld:=Fld;
  if Not FhlKnl1.Cf_GetDict_TreeDlg(intTostr(fDict.LkpFld.tag),fdict) then Close;
   Caption:=fDict.Caption;
   FhlKnl1.Tv_NewDataNode(TreeView1,nil,'',fDict.RootText,6,6);
   FhlKnl1.Cf_ListAllNode(Fld.LookupDataSet,TreeView1,20,0,fDict.CodeFldName,fDict.NameFldName,true,false);
   with TreeView1.Items.GetFirstNode do
   begin
     Expand(fDict.IsExpand);
     if GetFirstChild<>nil then
        GetFirstchild.Expand(False);
   end;
   //定位原有值
      if fDict.LkpFld.AsString<>'' then
      begin
        FocusNode:=FhlKnl1.Tv_FindNode(TreeView1,fDict.LkpFld.DataSet.FieldByName(fDict.LkpFld.KeyFields).AsString);
        if FocusNode<>nil then
        FocusNode.Selected:=True;
      end;
end;

procedure TTreeDlgFrm.FormClose(Sender: TObject; var Action: TCloseAction);
var i:integer;
var lstDestFld:Tstrings;
begin
  if ModalResult=mrOk then
  begin
     if assigned(fDict.LkpFld) then
     begin
         fDict.LkpFld.LookupDataSet.Locate(fDict.LkpFld.LookupKeyFields,TStrPointer(TreeView1.Selected.Data)^,[]);
         if ChkNull.Checked then
         begin
             lstDestFld:=Tstringlist.Create ;
             lstDestFld.CommaText :=fDict.ChgFldNames;
             if not(fDict.LkpFld.DataSet.State  in [dsinsert ,dsedit] ) then
              fDict.LkpFld.DataSet.Edit;
             for i:=0 to lstDestFld.Count-1 do
             begin
                if fDict.LkpFld.DataSet.FindField ( lstDestFld[i]  )<>nil then
                fDict.LkpFld.DataSet.FieldByName( lstDestFld[i]  ).Value :=null;
             end;

         end
         else
         FhlKnl1.Ds_CopyValues(fDict.LkpFld.LookupDataSet,fDict.LkpFld.DataSet,fDict.LkpChgFldNames,fDict.ChgFldNames,False,False);
     end;
  end;
end;

procedure TTreeDlgFrm.TreeView1Change(Sender: TObject; Node: TTreeNode);
begin
 OkBtn.Enabled:=(fDict.ParentSelect) or (not Node.HasChildren) or ChkNull.Checked;

  if self.ADODataSet1.Active then
    ADODataSet1.Locate(fdict.CodeFldName ,TStrPointer(Node.Data)^ ,[]);

end;

procedure TTreeDlgFrm.TreeView1DblClick(Sender: TObject);
begin

 if (Not TreeView1.Selected.HasChildren) or (self.AllowPickParentNode ) then
    ModalResult:=mrOk;
end;

procedure TTreeDlgFrm.InitFrm(DataSetID: string;aParam:variant;Isopen:boolean;CodeFldName,NameFldName:string;showCode:boolean);
begin
   fhluser.SetDataSet(self.ADODataSet1 ,datasetID,aParam,Isopen) ;
   FhlKnl1.Tv_NewDataNode(TreeView1,nil,'','全部',6,6);
   fdict.CodeFldName := CodeFldName;
   fdict.NameFldName := NameFldName;
   FhlKnl1.Cf_ListAllNode(ADODataSet1,TreeView1,20,0,CodeFldName,NameFldName,showCode);
   TreeView1.Items.GetFirstNode.Expand(true);
end;



procedure TTreeDlgFrm.ChkNullClick(Sender: TObject);
begin
 OkBtn.Enabled:=ChkNull.Checked;

end;

procedure TTreeDlgFrm.SetAllowPickParentNode(const Value: boolean);
begin
  FAllowPickParentNode := Value;
end;

 

end.
