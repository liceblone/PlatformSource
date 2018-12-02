unit UnitSerialNos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, StdCtrls, ExtCtrls, Grids, DBGrids, ComCtrls, ToolWin,
  ActnList,Fhlknl;

type
  TFrmSerialNos = class(TForm)
    ToolBar1: TToolBar;
    PageControl1: TPageControl;
    TabSerial: TTabSheet;
    Splitter1: TSplitter;
    GrpCandidate: TGroupBox;
    GridCandidate: TDBGrid;
    GrpHaveOut: TGroupBox;
    PnlSerialno: TPanel;
    Label1: TLabel;
    EdtSerialNo: TEdit;
    BtnAdd: TButton;
    BtnDelete: TButton;
    Panel2: TPanel;
    GridSerialNOs: TDBGrid;
    MtDataSource1: TDataSource;
    MtDataSet1: TADODataSet;
    MtDataSet1F_MchApplyID: TIntegerField;
    MtDataSet1F_Whcode: TStringField;
    MtDataSet1F_ChkTime: TDateTimeField;
    MtDataSet1F_OutMan: TStringField;
    MtDataSet1F_OutDate: TDateTimeField;
    MtDataSet1F_BillTime: TDateTimeField;
    MtDataSet1F_WhName: TStringField;
    MtDataSet1F_FlagName: TStringField;
    DsSourceCandidate: TDataSource;
    AdoDsCandidate: TADODataSet;
    DsSourceSerialNo: TDataSource;
    AdoDsSerialNO: TADODataSet;
    ActionList1: TActionList;
    NewAction1: TAction;
    CopyAction: TAction;
    EditAction: TAction;
    DeleteAction: TAction;
    SaveAction1: TAction;
    CancelAction1: TAction;
    FirstAction1: TAction;
    PriorAction1: TAction;
    NextAction1: TAction;
    LastAction1: TAction;
    CloseAction1: TAction;
    PrintAction1: TAction;
    SetCaptionAction: TAction;
    actInputTaxAmt: TAction;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    TlBtnChk: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    ToolButton10: TToolButton;
    CheckAction1: TAction;
    ToolButton11: TToolButton;
    PnlOutQty: TPanel;
    EdtQty: TEdit;
    Label2: TLabel;
    BtnUpdateOutQty: TButton;
    statLabel1: TLabel;
    ScrollTop: TScrollBox;
    Label3: TLabel;
    LblState: TLabel;
    procedure GrpOutOrderDblClick(Sender: TObject);
    procedure GridCandidateDblClick(Sender: TObject);
    procedure GridSerialNOsDblClick(Sender: TObject);
    procedure CheckAction1Execute(Sender: TObject);
    procedure FirstAction1Execute(Sender: TObject);
    procedure PriorAction1Execute(Sender: TObject);
    procedure NextAction1Execute(Sender: TObject);
    procedure LastAction1Execute(Sender: TObject);
    procedure CloseAction1Execute(Sender: TObject);
    procedure BtnAddClick(Sender: TObject);
    procedure AdoDsSerialNOAfterScroll(DataSet: TDataSet);
    procedure EdtSerialNoChange(Sender: TObject);

    Function  IsSerialExists(DataSet:TAdoDataSet;FIeld,Value:string):boolean;
    procedure DsSourceCandidateDataChange(Sender: TObject; Field: TField);
    procedure BtnDeleteClick(Sender: TObject);
    procedure MtDataSet1AfterOpen(DataSet: TDataSet);
    procedure BtnUpdateOutQtyClick(Sender: TObject);
    procedure OpenBill(BillCode: string);
    procedure OpenCloseAfter(IsOpened:Boolean);
    procedure SetRitBtn;
    procedure SetCheckStyle(IsChecked:Boolean);
    procedure SetBillStyle(fReadOnly:Boolean);
    procedure SetCtrlStyle(fEnabled:Boolean);
    procedure CloseBill;
    procedure ScrollTopDblClick(Sender: TObject);
  private
      fDict: TSerialNoDict;
      F_GridOutBill:TDbGrid;
      F_BillCode:string;
      F_BillCodeFieldName:string ;
      F_SerialLen:integer;
      F_FlagFldName:string;
      F_FlagCompeleteState:string;

      fDbGridColsColor:Variant;
    { Private declarations }
  public
      { Public declarations }
      procedure FrmIni(FormID:string;OPenParam:string;P_BillCodeFieldName:string);
      procedure SetGridOutBill(P_GridOutBill: TDbGrid);
      Procedure ChangeBillCode;
      Procedure SetSerialEnable(IsNeedSerial :boolean);
      Procedure SetStateAndFlagFld( P_FlagFldName:string;      P_FlagCompeleteState:string);
  end;


const
  cBillManId='F_BillManId';
  cIsChk='F_IsChk';
  cChkTime='F_ChkTime';
var
  FrmSerialNos: TFrmSerialNos;

implementation
     uses datamodule,UnitCreateComponent,UPublicFunction;
{$R *.dfm}

{ TFrmSerialNos }

procedure TFrmSerialNos.FrmIni(FormID: string; OPenParam: string;P_BillCodeFieldName:string);
var SerialParam:string;
var I:integer;
begin

      F_BillCode:=OPenParam;
      F_BillCodeFieldName:=P_BillCodeFieldName;


      if not  fhlknl1.Cf_GetDict_SerialNO(FormID,fDict) then exit;
      self.Caption :=   fDict.caption ;
      CheckAction1.Caption :=self.fDict.chkCaption ;

      FhlUser.SetDataSet(mtDataSet1,fDict.MtdatasetID ,OPenParam,true);

     if fDict.Boxid <>'-1' then
     FhlKnl1.Cf_SetBox(fDict.Boxid ,MtDataSource1,ScrollTop ,dmFrm.UserDbCtrlActLst);


      if fDict.actsID   <>'-1' then
         FhlKnl1.Tb_CreateActionBtns_ex(self.ToolBar1,self.ActionList1,fDict.actsID ) ;



      FhlUser.SetDbGridAndDataSet(self.GridCandidate   ,fDict.CandidateGridID  ,OPenParam,true );

      SerialParam:= AdoDsCandidate.FieldValues [fdict.CandidateFldName ];
      FhlUser.SetDbGridAndDataSet(self.GridSerialNOs    ,fDict.SerialGridID    ,OPenParam+','+SerialParam,true );


     fhlknl1.Kl_GetUserQuery('select F_value as F_SerialLen From T_SysParam where F_item='+quotedstr(self.fDict.serialNolenghtparams ));
     if not fhlknl1.User_Query.IsEmpty then
     self.F_SerialLen:=    fhlknl1.User_Query.Fieldbyname('F_SerialLen').AsInteger ;

     EdtSerialNo.MaxLength :=F_SerialLen;

     SetSerialEnable (AdoDsCandidate.FieldByName ('IsNeedSerial').AsBoolean)  ;

      fDbGridColsColor:=VarArrayCreate([0,self.GridCandidate.Columns.Count-1],varVariant);
     for i:=0 to GridCandidate.Columns.Count-1 do
     fDbGridColsColor[i]:=GridCandidate.Columns[i].Color;


     OpenBill(OPenParam );
end;

procedure TFrmSerialNos.GrpOutOrderDblClick(Sender: TObject);
var CrtCom:TfrmCreateComponent    ;

begin
// modeltpe:=Bill;
  if LoginInfo.Sys  then  begin
      CrtCom:=TfrmCreateComponent.Create(self);
        CrtCom.mtDataSetId :=inttostr(self.mtDataSet1.tag) ;
         CrtCom.mtDataSet1 :=  mtDataSet1 ;
         CrtCom.TopOrBtm :=true;
         CrtCom.TOPBoxId  :=self.fDict.Boxid ;

 

try
    CrtCom.Show;
finally

end;   end;
end;

procedure TFrmSerialNos.GridCandidateDblClick(Sender: TObject);
var CrtCom:TfrmCreateComponent    ;
begin
// modeltpe:=Bill;
  if LoginInfo.Sys  then  begin
    CrtCom:=TfrmCreateComponent.Create(self);
    CrtCom.Hide;

    CrtCom.mtDataSet1:= self.AdoDsCandidate  ;
    CrtCom.mtDataSetId :=inttostr(self.AdoDsCandidate.tag) ;

    CrtCom.DLGrid :=self.GridCandidate  ;
    CrtCom.DlGridId :=inttostr(self.GridCandidate.Tag);
 


try
    CrtCom.Show;
finally

end;   end;

end;
procedure TFrmSerialNos.GridSerialNOsDblClick(Sender: TObject);
var CrtCom:TfrmCreateComponent    ;
begin
// modeltpe:=Bill;
  if LoginInfo.Sys  then  begin
    CrtCom:=TfrmCreateComponent.Create(self);
    CrtCom.Hide;

    CrtCom.mtDataSet1:= self.AdoDsSerialNO  ;
    CrtCom.mtDataSetId :=inttostr(self.AdoDsSerialNO.tag) ;

    CrtCom.DLGrid :=self.GridSerialNOs  ;
    CrtCom.DlGridId :=inttostr(self.GridSerialNOs.Tag);
 
  

try
    CrtCom.Show;
finally

end;   end;

end;
procedure TFrmSerialNos.CloseBill;
begin
   mtDataSet1.Close;
   AdoDsCandidate.Close;
 //  OpenCloseAfter(false);
end;
procedure TFrmSerialNos.OpenBill(BillCode: string);
begin
  // self.fBillex.BillCode := BillCode;
   FhlKnl1.Ds_OpenDataSet(mtDataSet1,varArrayof([BillCode]));
   if (mtDataSet1.RecordCount<>1) and (BillCode<>'0000') then
   begin
     self.F_BillCode:='0000';
     MessageDlg(#13#10+'没有找到编号为"'+BillCode+'"的单据记录.',mtInformation,[MbYes],0);
     CloseBill;
     Exit;
   end;
  
   OpenCloseAfter(True);
end;
procedure TFrmSerialNos.SetCtrlStyle(fEnabled:Boolean);
 var bkColor:TColor;
begin
// dmFrm.SetDataSetStyle(mtDataSet1,fReadOnly);
 if fEnabled then
    bkColor:=clWhite
 else
    bkColor:=clCream;
  // bkColor:=clWhite;

 FhlKnl1.Vl_SetCtrlStyle(bkColor,self.ScrollTop ,fEnabled);
// FhlKnl1.Vl_SetCtrlStyle(bkColor,self.ScrollBtm ,fEnabled);
  FhlKnl1.Dg_SetDbGridStyle(self.GridCandidate ,not  fEnabled,bkColor,fDbGridColsColor);
end;
procedure TFrmSerialNos.SetBillStyle(fReadOnly:Boolean);
begin
 //set btn.enabled to false
// LinkAction1.Enabled:=Not fReadOnly;
// ImportAction1.Enabled:=Not fReadOnly;
// AppendAction1.Enabled:=Not fReadOnly;
// DeleteAction1.Enabled:=Not fReadOnly;
 SetCtrlStyle(Not fReadOnly);
end;
procedure TFrmSerialNos.SetCheckStyle(IsChecked:Boolean);
begin
   BtnUpdateOutQty.Enabled :=   not IsChecked;
  if IsChecked then begin
     SetBillStyle(IsChecked);
     CheckAction1.Caption :='弃审';
     CheckAction1.Hint    :='弃审';
//     RemoveAction1.Enabled:=false;
     LblState.caption :='已审';
  end
  else begin
     SetBillStyle(false);
     CheckAction1.Caption :='审核';
     CheckAction1.Hint    :='审核';
//     RemoveAction1.Enabled:=true;
     LblState.caption :='未审';
  end;

end;
procedure TFrmSerialNos.SetRitBtn;
var LstChkState:Tstrings;
begin
    PrintAction1.Enabled:=true;

 //   DownAction1.Enabled:=true;
    NewAction1.Enabled:=true;
  //  CopyAction1.Enabled:=true;

    CheckAction1.Enabled:=true;


            if mtDataSet1.FindField(fDict.ChkFieldName)<>nil then
            begin
                  self.LblState.Visible :=false;
                  LstChkState:=Tstringlist.Create ;
                  LstChkState.CommaText :=fDict.IsChkValue;
                   if LstChkState.IndexOf( mtDataSet1.FieldByName (fDict.ChkFieldName).AsString )>-1 then
                     SetCheckStyle(true)
                  else
                     SetCheckStyle(false);

                  LstChkState.Free ;
            end
            else
              LblState.Visible :=true;


    begin
        if trim(fDict.IsChkValue)='' then
        if mtDataSet1.findfield(cIsChk)<>nil then
           SetCheckStyle(mtDataSet1.FieldByName(cIsChk).AsBoolean);
    end;




end;
procedure TFrmSerialNos.OpenCloseAfter(IsOpened:Boolean);
begin

if (self.mtDataSet1.LockType = ltReadOnly ) and (self.AdoDsCandidate.locktype=ltReadOnly)   then
  begin
    NewAction1.Enabled:=false;
    CloseAction1.Enabled:=true;
    exit;
  end;


  if IsOpened then
     SetRitBtn
  else begin
    PrintAction1.Enabled:=IsOpened;
//    DownAction1.Enabled:=IsOpened;
//    MailAction1.Enabled:=IsOpened;
 //   FaxAction1.Enabled:=IsOpened;
   // CopyAction1.Enabled:=IsOpened;
//    RemoveAction1.Enabled:=IsOpened;
    CheckAction1.Enabled:=IsOpened;
//    AppendAction1.Enabled:=IsOpened;
 //   DeleteAction1.Enabled:=IsOpened;
   // linkAction1.Enabled:=IsOpened;
//    ImportAction1.Enabled:=IsOpened;
  end;
  NewAction1.Enabled:=true;
 // RefreshAction1.Enabled:=IsOpened;
  FirstAction1.Enabled:=IsOpened;
  PriorAction1.Enabled:=IsOpened;
  NextAction1.Enabled:=IsOpened;
  LastAction1.Enabled:=IsOpened;
//  LocateAction1.Enabled:=IsOpened;

  SaveAction1.Enabled:=false;


 // actedit.Enabled :=true;
  CancelAction1.Enabled:=false;

  CloseAction1.Enabled:=true;
  self.GridCandidate.Enabled:=IsOpened;
  if not IsOpened then
     SetCtrlStyle(false);
end;
procedure TFrmSerialNos.CheckAction1Execute(Sender: TObject);
begin
      {
         Screen.Cursor:=CrSqlWait;
        try

            FhlUser.CheckRight(fdict.ChkRightId );
            if dmFrm.ExecStoredProc(fdict.chkproc,varArrayof([self.F_BillCode ,LoginInfo.EmpId,LoginInfo.LoginId])) then
            begin
                MtDataSet1.Close;
                MtDataSet1.Open;
                TlBtnChk.Enabled :=false;
                if not logininfo.isAdmin then
                BtnDelete.Enabled :=  TlBtnChk.Enabled;
            end;

        finally
        Screen.Cursor:=crDefault;
        end;
        }
        
  if    (Taction(Sender)).Hint  ='审核' then
  begin
             Screen.Cursor:=CrSqlWait;
        try
        FhlUser.CheckRight(fdict.ChkRightId );
        if   dmFrm.ExecStoredProc(fdict.chkproc,varArrayof([self.F_BillCode,LoginInfo.EmpId,LoginInfo.LoginId])) then
        begin
              OpenBill(self.F_BillCode);
               (Taction(Sender)).Hint    :='弃审' ;
              if fdict.chkproc='' then
              Taction(Sender).Enabled :=false;
        end;
        finally
        Screen.Cursor:=crDefault;
        end;


  end
  else
  begin

        Screen.Cursor:=CrSqlWait;
        try
        FhlUser.CheckRight(self.fdict.UnChkRightId );
        if  dmFrm.ExecStoredProc(fdict.UnchkProc ,varArrayof([self.F_BillCode ,LoginInfo.EmpId,LoginInfo.LoginId])) then
        begin
            OpenBill(self.F_BillCode);
            (Taction(Sender)).Hint   :='审核' ;
        end;
        finally
        Screen.Cursor:=crDefault;
        end;
        
  end;

end;
procedure TFrmSerialNos.SetGridOutBill(P_GridOutBill: TDbGrid);
begin
    self.F_GridOutBill:=P_GridOutBill ;
end;

procedure TFrmSerialNos.ChangeBillCode;
begin
    self.F_BillCode :=F_GridOutBill.DataSource.DataSet.FieldValues [F_BillCodeFieldName];//  ''
end;

procedure TFrmSerialNos.FirstAction1Execute(Sender: TObject);
begin
  self.F_GridOutBill.DataSource.DataSet.First;
  ChangeBillCode;
//  MtDataSet1.Close ;
   FhlKnl1.Ds_OpenDataSet(self.MtDataSet1 ,self.F_BillCode );

   FhlKnl1.Ds_OpenDataSet(self.AdoDsCandidate ,self.F_BillCode );


end;

procedure TFrmSerialNos.PriorAction1Execute(Sender: TObject);
begin
  self.F_GridOutBill.DataSource.DataSet.Prior;
  ChangeBillCode;
  FhlKnl1.Ds_OpenDataSet(MtDataSet1 ,self.F_BillCode );
     FhlKnl1.Ds_OpenDataSet(self.AdoDsCandidate ,self.F_BillCode );
end;

procedure TFrmSerialNos.NextAction1Execute(Sender: TObject);
begin
  self.F_GridOutBill.DataSource.DataSet.Next ;
  ChangeBillCode;
  FhlKnl1.Ds_OpenDataSet(MtDataSet1 ,self.F_BillCode );
     FhlKnl1.Ds_OpenDataSet(self.AdoDsCandidate ,self.F_BillCode );
end;

procedure TFrmSerialNos.LastAction1Execute(Sender: TObject);
begin
  self.F_GridOutBill.DataSource.DataSet.Last  ;
  ChangeBillCode;
  FhlKnl1.Ds_OpenDataSet(MtDataSet1 ,self.F_BillCode );
     FhlKnl1.Ds_OpenDataSet(self.AdoDsCandidate ,self.F_BillCode );
end;

procedure TFrmSerialNos.CloseAction1Execute(Sender: TObject);
begin
self.Close;
end;
Function TFrmSerialNos.IsSerialExists(DataSet:TAdoDataSet;FIeld,Value:string):boolean;
var i:integer;
begin
    result:=false;
    
    DataSet.DisableControls ;

    for i:=0 to DataSet.RecordCount-1 do
    begin
        if  Uppercase(DataSet.FieldByName (FIeld).AsString)=Uppercase(Value) then
        begin
            result:=true;
           // DataSet.EnableControls ;
            Break;
        end;
        DataSet.Next ;
    end;
    DataSet.EnableControls ;


end;

procedure TFrmSerialNos.BtnAddClick(Sender: TObject);
begin
//dict.WriteSerialRitID
FhlUser.CheckRight(fdict.WriteSerialRitID );

  {
    if self.EdtFlag.Text <>'' then
    begin
    showmessage('这张单已经出库');
    exit;
    end;
           }

   if not TlBtnChk.Enabled then
   begin
       showmessage('该单已经出库');
       exit;
   end;
    if    length(Tedit(Sender).Text)=F_SerialLen then
    begin
          if (self.F_BillCode <>'') and(EdtSerialNo.Text <>''  ) then
          begin

                if not  IsSerialExists(AdoDsSerialNO,  'F_SerialNo', trim(EdtSerialNo.Text)) then
                begin

                   if  ( (AdoDsSerialNO.RecordCount =0)  or    (AdoDsSerialNO.RecordCount <   AdoDsCandidate.fieldbyname('F_chkQty').AsInteger ) ) then
                    begin
                       AdoDsSerialNO.Append ;

                         AdoDsSerialNO.FieldByName ('F_SerialNo').AsString :=EdtSerialNo.Text ;
                         AdoDsSerialNO.FieldByName (fDict.CandidateFldName).AsString :=AdoDsCandidate.FieldByName(fDict.CandidateFldName).AsString ;
                         AdoDsSerialNO.FieldByName (self.F_BillCodeFieldName ).Value :=   self.F_BillCode ;

                        AdoDsSerialNO.Post ;

                       AdoDsCandidate.Edit ;
                       AdoDsCandidate.FieldByName('F_OutQty').AsInteger :=AdoDsSerialNO.RecordCount ;// AdoDsCandidate.FieldByName('F_OutQty').AsInteger +1;
                       AdoDsCandidate.Post ;
                    end
                    else
                    begin
                       windows.Beep(2600,1200);  
                         showmessage('该型号的机器 数量:'+AdoDsCandidate.fieldbyname('F_chkQty').AsString +'  已经全部出库！');
                    end;
                end;
          end
          else
          begin
              showmessage('条形码不能为空，单号不能为空!');
          end;
    end
    else
        showmessage('条形码应该有'+inttostr(F_SerialLen)+'位数字!');

end;

procedure TFrmSerialNos.AdoDsSerialNOAfterScroll(DataSet: TDataSet);
begin
         statLabel1.Caption:= '总数: '+intTostr(AdoDsSerialNO.RecordCount);

end;

procedure TFrmSerialNos.EdtSerialNoChange(Sender: TObject);
begin
     if   length(Tedit(Sender).Text)= F_SerialLen then
    begin
        BtnAddClick(sender);
        Tedit(Sender).text:='';//.SelectAll ;
    end;
end;

procedure TFrmSerialNos.DsSourceCandidateDataChange(Sender: TObject;
  Field: TField);
  var Pras:string;
begin

      if    AdoDsSerialNO.CommandText <>'' then
      begin
         Pras:=self.AdoDsCandidate.fieldbyname(self.F_BillCodeFieldName ).AsString +','+self.AdoDsCandidate.fieldbyname(self.fDict.CandidateFldName ).AsString ;
         FhlKnl1.Ds_SetParams(self.AdoDsSerialNO,  Pras);
         AdoDsSerialNO.Open;
         SetSerialEnable(AdoDsCandidate.FieldByName ('IsNeedSerial').AsBoolean)   ;
      end;

end;

procedure TFrmSerialNos.BtnDeleteClick(Sender: TObject);
begin
if not AdoDsSerialNO.IsEmpty then
begin
    self.AdoDsSerialNO.Delete ;
    AdoDsCandidate.Edit ;
    AdoDsCandidate.FieldByName('F_OutQty').AsInteger :=AdoDsSerialNO.RecordCount ;// AdoDsCandidate.FieldByName('F_OutQty').AsInteger +1;
    AdoDsCandidate.Post ;
end;

end;

procedure TFrmSerialNos.SetSerialEnable(IsNeedSerial :boolean);
begin
//AdoDsCandidate.FieldByName ('IsNeedSerial').AsBoolean


                 EdtSerialNo.Enabled :=IsNeedSerial;
                 BtnAdd.Enabled:=IsNeedSerial;
                 BtnDelete.Enabled:=IsNeedSerial;

                 if IsNeedSerial then
                 EdtSerialNo.Color :=clwhite
                 else
                 EdtSerialNo.Color :=clScrollBar;

if (not IsNeedSerial) then
begin
     PnlOutQty.Visible :=true;
    PnlSerialno.Visible :=false;
    GridSerialNOs.Visible :=false;
end
else
begin
    PnlOutQty.Visible:=false;
    PnlSerialno.Visible :=true;
    GridSerialNOs.Visible :=true;

end;
           {
          if (MtDataSet1.FieldByName(F_FlagFldName).AsInteger  <>strtoint(F_FlagCompeleteState) ) then
             self.TlBtnChk.Enabled :=true
          else
             self.TlBtnChk.Enabled :=false;
                            }

end;

procedure TFrmSerialNos.SetStateAndFlagFld( P_FlagFldName:string;      P_FlagCompeleteState:string);
begin

      self.F_FlagFldName :=  P_FlagFldName ;
      self.F_FlagCompeleteState:= P_FlagCompeleteState ;

end;

procedure TFrmSerialNos.MtDataSet1AfterOpen(DataSet: TDataSet);
begin
if  DataSet.FindField(self.F_FlagFldName )<>nil then
  if   DataSet.FieldByName(F_FlagFldName).AsString =self.F_FlagCompeleteState then
  begin
   //  self.TlBtnChk.Enabled :=true ;
  //   SetSerialEnable(true) ;
  end
  else
  begin
   //  self.TlBtnChk.Enabled :=false;
     SetSerialEnable(false) ;
  end;


end;

procedure TFrmSerialNos.BtnUpdateOutQtyClick(Sender: TObject);
begin
   if not TlBtnChk.Enabled then
   begin
       showmessage('该单已经出库');
       exit;
   end;

if AdoDsCandidate.Active then
  if not AdoDsCandidate.IsEmpty then
    if ( not Isnumeric(EdtQty.Text))   then
    showmessage('请输入数字')
    else
    begin
     AdoDsCandidate.Edit;
     AdoDsCandidate.FieldByName('F_OutQty').Value :=strtofloat(EdtQty.Text ) ;
     AdoDsCandidate.Post ;
    end;
end;

procedure TFrmSerialNos.ScrollTopDblClick(Sender: TObject);
var CrtCom:TfrmCreateComponent    ;

begin



// modeltpe:=Bill;
  if LoginInfo.Sys  then  begin
    CrtCom:=TfrmCreateComponent.Create(self);
    CrtCom.Hide;
//    CrtCom.fbilldict:=  fbilldict;
    CrtCom.mtDataSet1:= self.mtDataSet1 ;
    CrtCom.mtDataSetId :=self.fDict.MtdatasetID ;
     CrtCom.TOPBoxId := self.fDict.Boxid  ;
   CrtCom.DLGrid :=self.GridCandidate   ;
   CrtCom.DlGridId :=self.fDict.CandidateGridID ;
    CrtCom.TopOrBtm :=true;
  

try
    CrtCom.Show;
finally

end;
  end;
end;

end.
