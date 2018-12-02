unit More2More;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, DBGrids, ExtCtrls, ComCtrls, DB, ADODB,FhlKnl,UnitCreateComponent;

type
  TMore2MoreFrm = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Bevel2: TBevel;
    Label1: TLabel;
    Image3: TImage;
    DBGrid1: TDBGrid;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button1: TButton;
    Button2: TButton;
    DataSource2: TDataSource;
    ADODataSet2: TADODataSet;
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure InitFrm(fFrmId:String;fParams:Variant);
    procedure Button1Click(Sender: TObject);
    procedure FormDblClick(Sender: TObject);
  private
    fDict:TMore2MoreDict;
  public
    { Public declarations }
  end;

var
  More2MoreFrm: TMore2MoreFrm;

implementation
uses lookup,TreeDlg,DataModule;
{$R *.dfm}

procedure TMore2MoreFrm.InitFrm(fFrmId:String;fParams:Variant);
begin
  if Not FhlKnl1.Cf_GetDict_More2More(fFrmId,fdict) then Close;
  Caption:=fDict.Caption;
  Label1.Caption:=fDict.Subject;
  if varIsStr(fParams) then fParams:=FhlKnl1.Vr_CommaStrToVarArray(fParams);
  FhlUser.SetDbGridAndDataSet(DbGrid1,fDict.DbGridId,fParams);
  if not varIsnull(fParams) then
     AdoDataSet2.FieldByName(fDict.mtFld).DefaultExpression:=fParams[0];
end;

procedure TMore2MoreFrm.Button3Click(Sender: TObject);
begin
  if fDict.LkpType='1' then
  begin
    Screen.Cursor:=crSqlWait;
    TreeDlgFrm:=TTreeDlgFrm.Create(Application);
    try
      DataSource2.DataSet.Append;
      TreeDlgFrm.InitFrm(AdoDataSet2.FieldByName(fDict.dlFld));
      if TreeDlgFrm.ShowModal=mrOk then
        AdoDataSet2.Post
      else
        AdoDataSet2.Cancel;
    finally
      TreeDlgFrm.Free;
      Screen.Cursor:=crDefault;
    end;
  end
  else begin
    Screen.Cursor:=crSqlWait;
    LookupFrm:=TLookupFrm.Create(Application);
    try
      DataSource2.DataSet.Append;
      LookupFrm.InitFrm(AdoDataSet2.FieldByName(fDict.dlFld));
      if LookupFrm.ShowModal=mrOk then
        AdoDataSet2.Post
      else
        AdoDataSet2.Cancel;
    finally
      LookupFrm.Free;
      Screen.Cursor:=crDefault;
    end;
  end;
end;

procedure TMore2MoreFrm.Button4Click(Sender: TObject);
begin
if not AdoDataSet2.IsEmpty then
  AdoDataSet2.Delete;
end;

procedure TMore2MoreFrm.Button1Click(Sender: TObject);
var
  s:widestring;
begin
  FhlUser.CheckRight(fDict.EditRitId);
  //客户,存盘前检测
 { if Self.Caption='客户' then
  begin
    with AdoDataSet2 do
    begin
      First;
      While not eof do
      begin
        dmFrm.GetQuery1('select EmpId from sl_EmpClient where EmpId<>'''+FieldByName('EmpId').AsString+''' and ClientId='''+FieldByName('ClientId').AsString+'''');
        if not dmFrm.FreeQuery1.IsEmpty then
          s:=s+#13#10+FieldByName('ClientId').AsString+' '+FieldByName('ClientName').AsString+' 已分配给:'+dmFrm.FreeQuery1.Fields[0].AsString;
        next;
      end;
    end;


    if s<>'' then
    begin
      MessageDlg(#13#10'对不起,以下客户已被分配:'#13#10#13#10+s+#13#10#13#10'请重新指定!',mtWarning,[mbOk],0);
      Self.ModalResult:=mrNone;
      Abort;
    end;
  end;
   }

  AdoDataSet2.UpdateBatch();
end;

procedure TMore2MoreFrm.FormDblClick(Sender: TObject);
var CrtCom:TfrmCreateComponent    ;

begin
// modeltpe:=Bill;
  if LoginInfo.Sys  then  begin
    CrtCom:=TfrmCreateComponent.Create(self);
    CrtCom.Hide;

    CrtCom.mtDataSet1:= ADODataSet2;
    CrtCom.ModelType :=ModelMore2MoreDict;
    CrtCom.DlGridId := fDict.DbGridId;
           try
          CrtCom.Show;
      finally

      end;
   
  end;

 
end;

end.
