unit Bill;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ADODB, Db, Grids, DBGrids, StdCtrls, ImgList, ExtCtrls,ComCtrls, ToolWin,
  variants,BillOpenDlg,pick, ActnList, Menus,FhlKnl,UnitCreateComponent,PickWindowUniveral;

type
  TBillFrm = class(TForm)
    mtDataSource1: TDataSource;
    CoolBar1: TCoolBar;
    ToolBar1: TToolBar;
    NewBtn: TToolButton;
    FaxBtn: TToolButton;
    RemoveBtn: TToolButton;
    OpenBtn: TToolButton;
    Panel1: TPanel;
    ToolButton1: TToolButton;
    ExtBtn: TToolButton;
    SavBtn: TToolButton;
    ToolButton4: TToolButton;
    chkBtn: TToolButton;
    DlDataSource1: TDataSource;
    CelBtn: TToolButton;
    Splitter1: TSplitter;
    Splitter2: TSplitter;
    ScrollBox1: TScrollBox;
    ScrollBox2: TScrollBox;
    Refreshbtn: TToolButton;
    ToolButton5: TToolButton;
    AddBtn: TToolButton;
    DelBtn: TToolButton;
    HelpBtn: TToolButton;
    linkBtn: TToolButton;
    PrintBtn: TToolButton;
    MailBtn: TToolButton;
    DownBtn: TToolButton;
    ToolButton3: TToolButton;
    importBtn: TToolButton;
    DBGrid1: TDBGrid;
    Label2: TLabel;
    Label3: TLabel;
    TitleLabel: TLabel;
    dlDataSet1: TADODataSet;
    mtDataSet1: TADODataSet;
    Image1: TImage;
    Image2: TImage;
    ActionList1: TActionList;
    MailAction1: TAction;
    PrintAction1: TAction;
    OpenAction1: TAction;
    NewAction1: TAction;
    CopyAction1: TAction;
    RemoveAction1: TAction;
    CancelAction1: TAction;
    SaveAction1: TAction;
    CheckAction1: TAction;
    LinkAction1: TAction;
    ImportAction1: TAction;
    AppendAction1: TAction;
    DeleteAction1: TAction;
    RefreshAction1: TAction;
    LocateAction1: TAction;
    DownAction1: TAction;
    CloseAction1: TAction;
    HelpAction1: TAction;
    FirstAction1: TAction;
    PriorAction1: TAction;
    NextAction1: TAction;
    LastAction1: TAction;
    MainMenu1: TMainMenu;
    FaxAction1: TAction;
    btn2: TToolButton;
    actAftSaveBill: TAction;
    TBEdit: TToolButton;
    ActEdit: TAction;
    Panel2: TPanel;
    procedure InitFrm(FrmId:String);
    procedure CloseBill;
    procedure SetRitBtn;
    procedure EditPostAfter(IsEnabled:Boolean);
    procedure OpenCloseAfter(IsOpened:Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DlDataSource1StateChange(Sender: TObject);
    procedure mtDataSource1StateChange(Sender: TObject);
    procedure ScrollBox1CanResize(Sender: TObject; var NewWidth,
      NewHeight: Integer; var Resize: Boolean);
    procedure dlDataSet1CalcFields(DataSet: TDataSet);
    procedure OpenBill(fCode:String);

    procedure CpyBtnClick(Sender: TObject);
    procedure SetBtmBoxHeight(Sender: TObject);
    procedure SetBillStyle(fReadOnly:Boolean);
    procedure SetCtrlStyle(fEnabled:Boolean);
    procedure SetCheckStyle(IsChecked:Boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure PrintAction1Execute(Sender: TObject);
    procedure OpenAction1Execute(Sender: TObject);
    procedure NewAction1Execute(Sender: TObject);
    procedure RemoveAction1Execute(Sender: TObject);
    procedure CancelAction1Execute(Sender: TObject);
    procedure SaveAction1Execute(Sender: TObject);
    procedure CheckAction1Execute(Sender: TObject);
    procedure LinkAction1Execute(Sender: TObject);
    procedure ImportAction1Execute(Sender: TObject);
    procedure AppendAction1Execute(Sender: TObject);
    procedure DeleteAction1Execute(Sender: TObject);
    procedure RefreshAction1Execute(Sender: TObject);
    procedure CloseAction1Execute(Sender: TObject);
    procedure MailAction1Execute(Sender: TObject);
    procedure FaxAction1Execute(Sender: TObject);
    procedure DownAction1Execute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ScrollBox1DblClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure ScrollBox2DblClick(Sender: TObject);
    procedure dlDataSet1AfterPost(DataSet: TDataSet);
    procedure actAftSaveBillExecute(Sender: TObject);
    procedure ActEditExecute(Sender: TObject);

  private
    fBtmBoxMaxHeight,fBtmBoxMinHeight:Integer;
    fDbGridColsColor:Variant;
    fbilldict:TBillDict;
    fBillOpenDlgFrm:TBillOpenDlgFrm;
    fPickFrm,fBillPickFrm:TPickFrm;

    FrmPickUniversal: TFrmPickUniversal;    //2006-8


  public

  end;

const
  cBillManId='F_BillManId';
  cIsChk='F_IsChk';
  cChkTime='F_ChkTime';

var
  BillFrm: TBillFrm;
  FormId:integer;
implementation
uses editor,RepBill,datamodule,TabGrid,Mailer,Downer;
{$R *.DFM}

procedure TBillFrm.InitFrm(FrmId:String);
 var i:integer;
begin
   FormId:=strtoint( FrmId);
  if Not FhlKnl1.Cf_GetDict_Bill(FrmId,fbilldict) then Close;     //etDict_Bill
  //
  Caption:=fbilldict.BillCnName;
  TitleLabel.Caption:='  '+Caption+'  ';
  TitleLabel.Font.Color:=StringToColor(fbilldict.TitleLabelFontColor);
  TitleLabel.Font.Size:=fbilldict.TitleLabelFontSize;
  TitleLabel.Font.Name:=fbilldict.TitleLabelFontName;
  FhlUser.SetDataSet(mtDataSet1,fbilldict.mtDataSetId,Null,false);

  if ((fbilldict.TopBoxId)<>'-1') and ((fbilldict.TopBoxId)<>'')then      //top or buttom      create label and dbcontrol
  FhlKnl1.Cf_SetBox(fbilldict.TopBoxId,MtDataSource1,ScrollBox1,dmFrm.dbCtrlActionList1);

  if ((fbilldict.BtmBoxId)<>'-1') and ((fbilldict.BtmBoxId)<>'') then
  FhlKnl1.Cf_SetBox(fbilldict.BtmBoxId,MtDataSource1,ScrollBox2,dmFrm.dbCtrlActionList1);




  FhlUser.SetDbGridAndDataSet(DbGrid1,fbilldict.dlGridId,Null,false);
  //
  fDbGridColsColor:=VarArrayCreate([0,DbGrid1.Columns.Count-1],varVariant);
  for i:=0 to dbGrid1.Columns.Count-1 do
     fDbGridColsColor[i]:=DbGrid1.Columns[i].Color;
  //
  OpenCloseAfter(false);
  fBtmBoxMaxHeight:=210;
  fBtmBoxMinHeight:=ScrollBox2.Height;
  self.OnActivate:=SetBtmBoxHeight;
  self.OnDeactivate:=SetBtmBoxHeight;
//  FhlInitor.SetMainMenu('2',MainMenu1,ToolBar1,ActionList1);



end;

procedure TBillFrm.OpenBill(fCode:String);
begin
   fbilldict.BillCode:=fCode;
   FhlKnl1.Ds_OpenDataSet(mtDataSet1,varArrayof([fbilldict.BillCode]));
   if (mtDataSet1.RecordCount<>1) and (fbilldict.BillCode<>'0000') then
   begin
     MessageDlg(#13#10+'没有找到编号为"'+fbilldict.BillCode+'"的单据记录.',mtInformation,[MbYes],0);
     CloseBill;
     Exit;
   end;
   FhlKnl1.Ds_OpenDataSet(dlDataSet1,varArrayof([fbilldict.BillCode]));
   OpenCloseAfter(True);
end;



procedure TBillFrm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if SaveAction1.Enabled then
    case MessageDlg(fsDbChanged,mtConfirmation,[mbYes,mbNo,mbCancel],0) of
         mrYes:SaveAction1Execute(SavBtn);
         mrCancel:begin
                   Action:=caNone;
                   Abort;
                  end;
    end;
  fPickFrm.Free;
  fBillPickFrm.Free;
  fBillOpenDlgFrm.Free;
  Action:=caFree;


end;

procedure TBillFrm.DlDataSource1StateChange(Sender: TObject);
begin
  if (DlDataSource1.State=dsEdit) or (DlDataSource1.State=dsInsert) then begin
     DbGrid1.Options:=DbGrid1.Options-[dgColumnResize];
     EditPostAfter(false);
  end
  else
     DbGrid1.Options:=DbGrid1.Options+[dgColumnResize];
end;

procedure TBillFrm.mtDataSource1StateChange(Sender: TObject);
begin
  if (MtDataSource1.State=dsEdit) or (MtDataSource1.State=dsInsert) then
     EditPostAfter(false);
end;

procedure TBillFrm.ScrollBox1CanResize(Sender: TObject; var NewWidth,
  NewHeight: Integer; var Resize: Boolean);
begin
  Resize:=NewHeight>50;
end;

procedure TBillFrm.SetBtmBoxHeight(Sender: TObject);
begin
  if ((fPickFrm<>nil) and (fPickFrm.Visible))
  or ((fBillPickFrm<>nil) and (fBillPickFrm.Visible))
  or ((FrmPickUniversal<>nil) and (FrmPickUniversal.Visible)) then
  begin
     ScrollBox2.Height:=fBtmBoxMaxHeight;
     if fBillPickFrm<> nil then
     fBillPickFrm.top:= ScrollBox2.Top +self.Height -self.ClientHeight+self.ToolBar1.Height  ;
  end
  else
     ScrollBox2.Height:=fBtmBoxMinHeight;
end;

procedure TBillFrm.dlDataSet1CalcFields(DataSet: TDataSet);
begin
      if dataset.FindField('MyIndex')<>nil then
      begin
            with DataSet do begin
                   FieldByName('MyIndex').asInteger:=Abs(RecNo);//Is fkCalculated
                   if FindField('Price')<>nil then

                  // if state in [dsinsert ,dsedit] then
                      FieldByName('Fund').asCurrency:=FieldByName('Qty').asFloat*FieldByName('Price').asFloat;
                   //else
                   //begin
                      //showmessage('数据集状态错误!');
                   //end;
            end;
      end;
end;

procedure TBillFrm.CloseBill;
begin
   mtDataSet1.Close;
   dlDataSet1.Close;
   OpenCloseAfter(false);
end;

procedure TBillFrm.SetRitBtn;
begin
  PrintAction1.Enabled:=true;
    MailAction1.Enabled:=true;
    FaxAction1.Enabled:=true;
    DownAction1.Enabled:=true;
    NewAction1.Enabled:=true;
    CopyAction1.Enabled:=true;
    RemoveAction1.Enabled:=true;
    CheckAction1.Enabled:=true;
    SetCheckStyle(mtDataSet1.FieldByName(cIsChk).AsBoolean);{  }

end;

procedure TBillFrm.OpenCloseAfter(IsOpened:Boolean);
begin

if (self.mtDataSet1.LockType = ltReadOnly ) and (self.dlDataSet1.locktype=ltReadOnly)   then
  begin
    NewAction1.Enabled:=false;
    CloseAction1.Enabled:=true;
    exit;
  end;


  if IsOpened then
     SetRitBtn
  else begin
    PrintAction1.Enabled:=IsOpened;
    DownAction1.Enabled:=IsOpened;
    MailAction1.Enabled:=IsOpened;
    FaxAction1.Enabled:=IsOpened;
    CopyAction1.Enabled:=IsOpened;
    RemoveAction1.Enabled:=IsOpened;
    CheckAction1.Enabled:=IsOpened;
    AppendAction1.Enabled:=IsOpened;
    DeleteAction1.Enabled:=IsOpened;
    linkAction1.Enabled:=IsOpened;
    ImportAction1.Enabled:=IsOpened;
  end;
  NewAction1.Enabled:=true;
  RefreshAction1.Enabled:=IsOpened;
  FirstAction1.Enabled:=IsOpened;
  PriorAction1.Enabled:=IsOpened;
  NextAction1.Enabled:=IsOpened;
  LastAction1.Enabled:=IsOpened;
  LocateAction1.Enabled:=IsOpened;
  SaveAction1.Enabled:=false;
 

  actedit.Enabled :=true;
  CancelAction1.Enabled:=false;
  OpenAction1.Enabled:=true;
  CloseAction1.Enabled:=true;
  DbGrid1.Enabled:=IsOpened;
  if not IsOpened then
     SetCtrlStyle(false);
end;

procedure TBillFrm.EditPostAfter(IsEnabled:Boolean);
begin
    if IsEnabled then
       SetRitBtn
    else begin
     NewAction1.Enabled:=IsEnabled;
     CopyAction1.Enabled:=IsEnabled;
     RemoveAction1.Enabled:=IsEnabled;
     CheckAction1.Enabled:=IsEnabled;
    end;
     OpenAction1.Enabled:=IsEnabled;
     RefreshAction1.Enabled:=IsEnabled;
  FirstAction1.Enabled:=IsEnabled;
  PriorAction1.Enabled:=IsEnabled;
  NextAction1.Enabled:=IsEnabled;
  LastAction1.Enabled:=IsEnabled;
     CloseAction1.Enabled:=IsEnabled;
     PrintAction1.Enabled:=IsEnabled;
     DownAction1.Enabled:=IsEnabled;
     MailAction1.Enabled:=IsEnabled;
     FaxAction1.Enabled:=IsEnabled;
     SaveAction1.Enabled:=Not IsEnabled;
     CancelAction1.Enabled:=Not IsEnabled;
end;

procedure TBillFrm.CpyBtnClick(Sender: TObject);
// var f,code:wideString;
begin
{ code:=mtDataSet1.FieldByName(mkeyfld).asString;
 OpenBill('fangheling');
 with FreeQuery1 do begin
      Close;
      Sql.Clear;
      Sql.Append('select * from '+mtbl+' where '+mkeyfld+'='''+Code+'''');
      Open;
 end;
 f:=BillDict.FieldByName('CopyMasterFields').asString;
 dmFrm.CopyValues(FreeQuery1,mtDataSet1,f,f);
 f:=BillDict.FieldByName('CopyDetailFields').asString;
 with FreeQuery1 do begin
      Close;
      Sql.Clear;
      Sql.Append('select * from '+ftbl+' where '+fkeyfld+'='''+Code+'''');
      Open;
      while not eof do begin
        dmFrm.CopyValues(FreeQuery1,dlDataSet1,f,f);
        next;
      end;
 end;}
end;

procedure TBillFrm.SetBillStyle(fReadOnly:Boolean);
begin
 //set btn.enabled to false
 LinkAction1.Enabled:=Not fReadOnly;
 ImportAction1.Enabled:=Not fReadOnly;
 AppendAction1.Enabled:=Not fReadOnly;
 DeleteAction1.Enabled:=Not fReadOnly;
 SetCtrlStyle(Not fReadOnly);
end;

procedure TBillFrm.SetCtrlStyle(fEnabled:Boolean);
 var bkColor:TColor;
begin
// dmFrm.SetDataSetStyle(mtDataSet1,fReadOnly);
 if fEnabled then
    bkColor:=clWhite
 else
    bkColor:=clCream;
 FhlKnl1.Vl_SetCtrlStyle(bkColor,ScrollBox1,fEnabled);
 FhlKnl1.Vl_SetCtrlStyle(bkColor,ScrollBox2,fEnabled);
  FhlKnl1.Dg_SetDbGridStyle(DbGrid1,not  fEnabled,bkColor,fDbGridColsColor);
end;

procedure TBillFrm.SetCheckStyle(IsChecked:Boolean);
begin
  if IsChecked then begin
     SetBillStyle(IsChecked);
     ChkBtn.Caption:='弃审';
     RemoveAction1.Enabled:=false;
  end
  else begin
    // if (frit[0] or frit[1]) then
       SetBillStyle(false);
     {else
       SetBillStyle(true,clCream);}
     ChkBtn.Caption:='审核';
     RemoveAction1.Enabled:=true;//frit[2];
  end;
  Image1.Visible:=IsChecked;
  Image2.Visible:=not Image1.Visible;
end;

procedure TBillFrm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
{A.浏览状态下
  1.Ctrl+p: 打印单据
  2.Ctrl+o: 打开单据
  3.Insert: 新建单据
  4.Ctrl+Alt+C: 复制单据
  5.Delete: 删除单据
  6.Ctrl+Insert: 弃审
  7.Esc: 关闭窗体
  8.F5: 刷新
B.编辑模式下
  1.Enter: 焦点转移到下一编辑框
  3.Esc: 放弃保存
  2:Ctrl+Enter: 保存数据
  4.Ctrl+': 引用
  5.Ctrl+<-: 导入
  6.Ctrl+Delete: 删行}
  if ssCtrl in Shift then
  begin
      case Key of
        //p
        80:PrintBtn.Click;
        //o
        79:Openbtn.Click;
        //'
        222:LinkBtn.Click;
        //<-
        8:ImportBtn.Click;
        vk_Insert:chkBtn.Click;
        vk_Delete:RemoveBtn.Click;
        vk_Return:SavBtn.Click;
        67:begin
             if ssAlt in Shift then
                showmessage('copy');
           end;
      end;
  end else
  begin
    case Key of
      vk_Insert:NewBtn.Click;
      vk_F5:RefreshBtn.Click;
      vk_Escape:begin
                  if SavBtn.Enabled then
                     CelBtn.Click
                  else
                     ExtBtn.Click;  
                end;
     vk_Return:begin
                 if Not (ActiveControl is TDbGrid) then
                   FhlKnl1.Vl_DoBoxEnter(ActiveControl)
                 else
                    with TDBGrid(ActiveControl) do
                    begin
                        if    TDBGrid(ActiveControl).DataSource.DataSet.Active then
                        if FhlKnl1.Dg_SetSelectedIndex(TDbGrid(ActiveControl),False) then
                        begin
                          if (fPickFrm<>nil) and (fPickFrm.Visible) then
                              fPickFrm.ComboBox1.SetFocus
                          else
                              DataSource.DataSet.Append;
                        end;
                    end;
              end;
    end;
  end;
end;

procedure TBillFrm.PrintAction1Execute(Sender: TObject);
var
  bk:TBookmark;
begin
  FhlUser.CheckRight(fbilldict.PrintRitId);
  Screen.Cursor:=crSqlWait;
  bk:=dlDataSet1.GetBookmark;
  dlDataSet1.DisableControls;
  RepBillFrm:=TRepBillFrm.Create(Application);
  try
    RepBillFrm.SetBillRep(fbilldict.TopBoxId,fbilldict.BtmBoxId,mtDataSet1,DbGrid1,fbilldict.BillCnName);
    RepBillFrm.PreviewModal;//Preview;
  finally
    FreeAndNil(RepBillFrm);
    dlDataSet1.EnableControls;
    Screen.Cursor:=crDefault;
  end;
  dlDataSet1.GotoBookmark(bk);
end;

procedure TBillFrm.OpenAction1Execute(Sender: TObject);
var i:integer;
begin
    FhlUser.CheckRight(fbilldict.ReadRitId);
    if fBillOpenDlgFrm=nil then
    begin
      Screen.Cursor:=crSqlwait;
      try
          fBillOpenDlgFrm:=TBillOpenDlgFrm.Create(Application);
          fBillOpenDlgFrm.InitOneBill(TitleLabel.Caption,fbilldict.mtGridId,fbilldict.mkeyfld);
      finally
          Screen.Cursor:=crDefault;
      end;
    end
    else
      with fBillOpenDlgFrm.ADODataSet1 do
      begin
          Screen.Cursor:=crSqlWait;
          try
          Close;
          Open;
          finally
          Screen.Cursor:=crDefault;
          end;
          Locate(fbilldict.mkeyfld,fbilldict.BillCode,[]);
      end;
    if  fBillOpenDlgFrm.ShowModal=mrOk then
    begin
     for i:=0 to self.mtDataSet1.FieldCount -1 do
     begin
         if mtDataSet1.Fields[i].FieldKind    =fkLookup then
         mtDataSet1.Fields[i].LookupDataSet.Filtered :=false;
     end;

        self.OpenBill(fBillOpenDlgFrm.FileNameComboBox.Text);
    end;
end;

procedure TBillFrm.NewAction1Execute(Sender: TObject);
begin
if    not (mtDataSet1.LockType = ltReadOnly) then
begin
  OpenBill('0000');

  mtDataSet1.Append;
  FhlKnl1.Vl_FocueACtrl(ScrollBox1);
end;
end;

procedure TBillFrm.RemoveAction1Execute(Sender: TObject);
begin
if    not (mtDataSet1.LockType = ltReadOnly) then
begin
  if MessageDlg(#13#10+'警告! 所有本单的数据将被删除且无法恢复,您确定吗?   ',mtWarning,mbOkCancel,0)=mrOk then
  begin
     Screen.Cursor:=CrSqlWait;
    try
      FhlUser.DoExecProc(mtDataSet1,null);
      CloseBill;
    finally
     Screen.Cursor:=crDefault;
    end;
  end;
end;
{
  if mtDataSet1.FieldByName(cBillManId).AsString<>LoginInfo.EmpId then
  begin
    MessageDlg(#13#10'只有制单人才有相应单据的弃单权限!',mtWarning,[mbOk],0);
    Abort;
  end;
  if MessageDlg(#13#10+'警告! 所有本单的数据将被删除且无法恢复,您确定吗?   ',mtWarning,[mbOk,mbCancel],0)=mrOk then
  begin
    mtDataSet1.Connection.BeginTrans;
    try
      FhlKnl1.Ds_ClearAllData(dlDataSet1);
      FhlKnl1.Ds_ClearAllData(mtDataSet1);
      dlDataSet1.UpdateBatch;
      mtDataSet1.UpdateBatch;
      mtDataSet1.Connection.CommitTrans;
    except
      mtDataSet1.Connection.RollbackTrans;
      MessageDlg(#13#10+'操作失败!',mtError,[MBOK],0);
    end;
    CloseBill;
  end;
  }
end;

procedure TBillFrm.CancelAction1Execute(Sender: TObject);
begin
 if MessageDlg(fsDbCancel,mtConfirmation,[mbYes,mbNo],0)=mrYes then begin
    if fbilldict.BillCode='0000' then
       CloseBill
    else
       OpenBill(fbilldict.BillCode);
 end;
end;

procedure TBillFrm.SaveAction1Execute(Sender: TObject);
var
  //istmp:Boolean;
  s,ss,f:widestring;
begin

  Screen.Cursor:=CrSqlWait;
  try

         FhlUser.CheckRight(fbilldict.WriteRitId);
        if self.dlDataSet1.State in [dsinsert ,dsEdit	] then //4-20
        dlDataSet1.Post;
         //
        // if mtDataSet1.FieldByName(cBillManId).AsString<>LoginInfo.EmpId then         2007-3-26 去掉
        // begin
        //   MessageDlg(#13#10'只有制单人才有相应单据的修改权限!',mtWarning,[mbOk],0);
        //   Abort;
        // end;
        //   {// 做到存储过程里去吧

  
        dmFrm.GetQuery1('select isbill from '+logininfo.SysDBPubName +'.dbo.sys_id where tblid='+fbilldict.mttblid);

         if not dmFrm.FreeQuery1.IsEmpty then
         begin
                 if   dmFrm.FreeQuery1.FieldByName('Isbill').AsBoolean then
                 begin
                     with dlDataSet1 do
                     begin
                       DisableControls;
                       //Qty
                       First;
                       while not Eof do
                       begin
                             if FieldByName(fbilldict.QtyFld).asFloat<=0 then
                             begin
                                  MessageDlg(#13#10'明细中[数量]的值必须大于零,保存中止!  ',mtInformation,[mbOk],0);
                                  EnableControls;
                                  DbGrid1.SetFocus;
                                  Abort;
                             end;
                             Next;
                       end;
                       //Price
                       First;
                       if FindField('Price')<>nil then
                       while not Eof do
                       begin
                           if FieldByName('Price').asFloat<0  then
                           begin
                                MessageDlg(#13#10'明细中[单价]的值必须不小于零,保存中止!  ',mtInformation,[mbOk],0);
                                EnableControls;
                                DbGrid1.SetFocus;
                                Abort;
                           end;
                           Next;
                       end;
                       EnableControls;
                    end;
                end;
         end
         else
         begin
           MessageBox(0, '单号前缀错误?', '', MB_OK + MB_ICONQUESTION);
           exit;
         end;





       fbilldict.BillCode:=trim(mtDataSet1.FieldByName(fbilldict.mkeyfld).asString);
       if fbilldict.BillCode='' then fbilldict.BillCode:=dmFrm.GetMyId(fbilldict.mttblid);

       if  fbilldict.BillCode<>'' then
       begin

                if  not        dlDataSet1.IsEmpty then
                begin

                   FhlKnl1.Ds_AssignValues(mtDataSet1,varArrayof([fbilldict.mkeyfld]),varArrayof([fbilldict.BillCode]),False,False);
                   FhlKnl1.Ds_UpdateAllRecs(dlDataSet1,varArrayof([fbilldict.fkeyfld]),varArrayof([fbilldict.BillCode]));
               
                   if mtDataSet1.State in [dsinsert ,dsEdit	] then
                   begin
                            try
                                 mtDataSet1.UpdateBatch;
                                 dlDataSet1.UpdateBatch;  //调换了个顺序 ,影响所有bill模板
                            except
                                    on err:exception do
                                    begin
                                       // EditPostAfter(True);
                                        exit;
                                    end;
                            end;
                           EditPostAfter(True);
                           OpenBill(fbilldict.BillCode);
                   end;
                 end
                 else
                      showmessage('请先加明细');

       end
       else
            showmessage('单号为空');


 finally

       if assigned(fBillPickFrm) then
       begin
          fBillPickFrm.Hide;
          self.SetBtmBoxHeight(self);
       end;
       Screen.Cursor:=crDefault;
 end;
end;

procedure TBillFrm.CheckAction1Execute(Sender: TObject);
var
  i:integer;
  s: widestring;
  frm:TTabGridFrm;
begin
  if chkbtn.Caption='审核' then
  begin
    if fbilldict.Id='19' then
    begin
      i:=0;
      Screen.Cursor:=CrSqlWait;
      try
        FhlUser.CheckRight(fbilldict.CheckRitId);
        FhlUser.SetDataSet(dmFrm.FreeDataSet1,'657',varArrayof([fbilldict.billcode,LoginInfo.EmpId,LoginInfo.LoginId]));
        if Not dmFrm.FreeDataSet1.IsEmpty then
        begin
          with dmFrm.FreeDataSet1 do
          begin
            while not eof do
            begin
              if FieldByName('myStok').AsFloat<FieldByName('Qty').AsFloat then
                i:=i+1
              else begin
                Edit;
                FieldByName('SndQty').AsFloat:=FieldByName('Qty').AsFloat;
                Post;
              end;
              next;
            end;
            First;
          end;
          if Not ((i=0) and (MessageDlg(#13#10'提示: 本单所有的产品库存均足够,是否根据发货单一次出库?',mtInformation,[mbYes,mbNo],0)=mrYes)) then
          begin
            frm:=TTabGridFrm.Create(Application);
            with frm do
            begin
              Label1.Caption:='提示: 至少有 '+intTostr(i)+' 种商品的库存不够发货,请输入本次发货量:';
              DataSource1.DataSet:=dmFrm.FreeDataSet1;
              FhlUser.SetDbGrid('480',DbGrid1);
              hide;
              if ShowModal<>mrOk then
              begin
               Free;
               Abort;
              end;
            end;
            frm.Tag:=0;
            while frm.Tag=0 do
            begin
              s:='';
              with dmFrm.FreeDataSet1 do
              begin
                First;
                while not eof do
                begin
                  if FieldByName('SndQty').AsString='' then
                    s:='提示:本次发货数量不能为空,如果本次没有发货则必须在相应栏填入0.'
                  else if FieldByName('SndQty').AsFloat<0 then
                    s:='提示:本次发货数量不能小于0,请按 确定 重新录入'
                  else if (FieldByName('SndQty').AsFloat>FieldByName('myStok').AsFloat) then
                    s:='提示:本次发货数量不能大于库存数量.'
                  else if (FieldByName('SndQty').AsFloat>FieldByName('Qty').AsFloat) then
                    s:='提示:本次发货数量不能大于本单总的发货数量.';
                  if s<>'' then break;
                  next;
                end;
              end;
                if s<>'' then
                begin
                  MessageDlg(#13#10+s,mtWarning,[mbOk],0);
                  if frm.ShowModal<>mrOk then
                  begin
                   FreeAndNil(frm);
                   Abort;
                  end;
                end
                else
                  frm.Tag:=1;
            end;
            freeandnil(frm);
          end;
          //
        dmFrm.FreeDataSet1.UpdateBatch();
        dmFrm.ExecStoredProc('sl_invoice_out',varArrayof([LoginInfo.WhId,fbilldict.billcode,LoginInfo.EmpId]));
       end;
      finally
        dmFrm.FreeDataSet1.Close;
        OpenBill(fbilldict.BillCode);
        Screen.Cursor:=crDefault;
      end;
    end
    else begin
      Screen.Cursor:=CrSqlWait;
      try
        FhlUser.CheckRight(fbilldict.CheckRitId);
        dmFrm.ExecStoredProc(fbilldict.chkproc,varArrayof([fbilldict.billcode,LoginInfo.EmpId,LoginInfo.LoginId]));
        OpenBill(fbilldict.BillCode);
      finally
       Screen.Cursor:=crDefault;
      end;
    end;
  end
  else begin
    Screen.Cursor:=CrSqlWait;
    try
      FhlUser.CheckRight(fbilldict.UnChkRitId);
      dmFrm.ExecStoredProc(fbilldict.unchkproc,varArrayof([fbilldict.billcode,LoginInfo.EmpId,LoginInfo.LoginId]));
      OpenBill(fbilldict.BillCode);
    finally
     Screen.Cursor:=crDefault;
    end;
  end;
end;

procedure TBillFrm.LinkAction1Execute(Sender: TObject);
  var i:integer;
begin
 BillOpenDlgFrm:=TBillOpenDlgFrm.Create(Application);
 try
   if BillOpenDlgFrm.InitRefers(fbilldict.Id) then
   begin
     if BillOpenDlgFrm.ShowModal=mrOk then
     begin
       i:=BillOpenDlgFrm.FileTypeComboBox.ItemIndex;
       if fBillPickFrm=nil then
       begin
         fBillPickFrm:=TPickFrm.Create(Application);
         fBillPickFrm.ComboBox1.Visible:=false;
       end;
       fBillPickFrm.InitFrm(BillOpenDlgFrm.RefersDict.PickIds[i],dbGrid1,mtDataSet1);
       fBillPickFrm.OpenDataSet(varArrayof([BillOpenDlgFrm.FileNameComboBox.Text,LoginInfo.WhId]));
       if fBillPickFrm.AdoDataSet1.IsEmpty then
       begin
         fBillPickFrm.Close;
         MessageDlg(#13#10+'该单据没有可被引用的数据',mtInformation,[mbOk],0);
       end else
       begin
         FhlKnl1.Ds_CopyValues(BillOpenDlgFrm.AdoDataSet1,self.mtDataSet1,BillOpenDlgFrm.RefersDict.FMastFlds[i],BillOpenDlgFrm.RefersDict.TMastFlds[i],False,False);
         fBillPickFrm.Show;
       end;
     end;
   end;
 finally
   BillOpenDlgFrm.Free;
 end;
end;

procedure TBillFrm.ImportAction1Execute(Sender: TObject);
begin

if fbilldict.pickid  <>'' then
begin
    if fBillPickFrm=nil then
    begin
        Screen.Cursor:=crSqlwait;
        try
          fBillPickFrm:= TPickFrm.Create (ScrollBox2);
          fBillPickFrm.InitFrm(fbilldict.pickid ,dbGrid1,mtDataSet1);
        finally
          Screen.Cursor:=crDefault;
        end;
    end;
    fBillPickFrm.Show;
   // fBillPickFrm.Dock(Panel2,fBillPickFrm.ClientRect );
   // fBillPickFrm.Align :=alclient;
end;



if fbilldict.PickIDMulPage <>'' then
begin
    if FrmPickUniversal=nil then
    begin
        Screen.Cursor:=crSqlwait;
        try
         // FrmPickUniversal:= TFrmPickUniversal.Create (self);
             FrmPickUniversal:= TFrmPickUniversal.Create (self);

          FrmPickUniversal.InitFrm(fbilldict.PickIDMulPage,dbGrid1,mtDataSet1);
        finally
          Screen.Cursor:=crDefault;
        end;
    end;

   FrmPickUniversal.Show;
    FrmPickUniversal.Dock(Panel2,FrmPickUniversal.ClientRect );
end;



end;

procedure TBillFrm.AppendAction1Execute(Sender: TObject);
begin
if    not (dlDataSet1.LockType = ltReadOnly) then
 dlDataSet1.Append;
end;

procedure TBillFrm.DeleteAction1Execute(Sender: TObject);
begin
if    not (dlDataSet1.LockType = ltReadOnly) then
begin
         if not dlDataSet1.IsEmpty then
         begin
         dlDataSet1.Delete;
         EditPostAfter(false);
       //  dlDataSet1.Refresh;
         end;
end;
end;

procedure TBillFrm.RefreshAction1Execute(Sender: TObject);
begin
  FhlKnl1.Ds_RefreshLkpFld(mtDataSet1);
  FhlKnl1.Ds_RefreshLkpFld(dlDataSet1);
  OpenBill(fbilldict.BillCode);
end;

procedure TBillFrm.CloseAction1Execute(Sender: TObject);
begin
 Close;
end;

procedure TBillFrm.MailAction1Execute(Sender: TObject);
var
  t:TStringList;
  s,ss:string;
  i:integer;
begin
  t:=TStringList.Create;
  with Self.dlDataSet1 do
  begin
    if Active then
    begin
      DisableControls;
      First;
      While not eof do
      begin
        t.Append(' ');
        with Self.DBGrid1 do
          for i:=0 to Columns.Count-1 do
            if Columns[i].Visible then
              with t do
              begin
                if t.Count>1 then
                  s:=Columns[i].Field.AsString
                else
                  s:=Columns[i].Title.Caption;
                ss:=FhlKnl1.St_Repeat(' ',Round(Columns[i].Width/8)-Length(s));
                if Columns[i].Alignment=taLeftJustify then
                  s:=s+ss
                else
                  s:=ss+s;
                Strings[Count-1]:=Strings[Count-1]+s;
            end;
        Next;
      end;
      First;
      EnableControls;
    end;
  end;

  with TMailerFrm.Create(Application) do
  begin
    EdtSubject1.Text:=fBillDict.BillCnName;
    BodyMemo1.Lines.Assign(t);
    Show;
//    ShowModal;
//    Free;
  end;
  FreeAndNil(t);
end;

procedure TBillFrm.FaxAction1Execute(Sender: TObject);
begin
showmessage('传真功能暂未开发!');
end;

procedure TBillFrm.DownAction1Execute(Sender: TObject);
begin
  with TDownerFrm.Create(Application) do
  begin
    with HintLabel1 do Caption:=format(Caption,[fBillDict.BillCode,fBillDict.BillCnName]);
    fmtDataSet1:=Self.mtDataSet1;
    fdlDataSet1:=Self.dlDataSet1;
    ShowModal;
    Free;
  end;
end;

procedure TBillFrm.FormCreate(Sender: TObject);
begin

 

  DownAction1.Visible:=Not LoginInfo.IsLocalServer;
end;

procedure TBillFrm.ScrollBox1DblClick(Sender: TObject);
var CrtCom:TfrmCreateComponent    ;
begin
// modeltpe:=Bill;
  if LoginInfo.Sys  then  begin
    CrtCom:=TfrmCreateComponent.Create(self);
    CrtCom.Hide;
//    CrtCom.fbilldict:=  fbilldict;
    CrtCom.mtDataSet1:= self.mtDataSet1 ;
    CrtCom.mtDataSetId :=self.fbilldict.mtDataSetId ;
    CrtCom.TOPBoxId :=self.fbilldict.TopBoxId ;
   CrtCom.DLGrid :=self.DBGrid1 ;
   CrtCom.DlGridId :=self.fbilldict.dlGridId ;
    CrtCom.TopOrBtm :=true;
 

try
    CrtCom.Show;
finally

end;
  end;
end;

procedure TBillFrm.DBGrid1DblClick(Sender: TObject);
var CrtCom:TfrmCreateComponent    ;
begin
// modeltpe:=Bill;
  if LoginInfo.Sys  then  begin
    CrtCom:=TfrmCreateComponent.Create(self);
    CrtCom.Hide;
    CrtCom.fbilldict:=  fbilldict;
    CrtCom.mtDataSet1:= self.dlDataSet1  ;
    CrtCom.DLGrid :=self.DBGrid1 ;
    CrtCom.ModelType :=ModelFrmBill;
 

try
    CrtCom.Show;
finally

end;
  end;
end;

procedure TBillFrm.ScrollBox2DblClick(Sender: TObject);
var CrtCom:TfrmCreateComponent    ;
begin
// modeltpe:=Bill;
  if LoginInfo.Sys  then  begin
    CrtCom:=TfrmCreateComponent.Create(self);
    CrtCom.Hide;
   CrtCom.fbilldict:=  fbilldict;
    CrtCom.mtDataSet1:= self.mtDataSet1 ;
    CrtCom.mtDataSetId :=inttostr(mtDataSet1.Tag );
    CrtCom.DLGrid :=self.DBGrid1 ;
    CrtCom.DlGridId :=inttostr(self.DBGrid1.Tag );


    CrtCom.BtmBOXID   :=self.fbilldict.BtmBoxId ;
    CrtCom.TopOrBtm:=false;

 

try
    CrtCom.Show;
finally

end;
 end;
end;

procedure TBillFrm.dlDataSet1AfterPost(DataSet: TDataSet);
begin
    FhlKnl1.Ds_AssignValues(mtDataSet1,fBillDict.mtSumFlds,FhlKnl1.Ds_SumFlds(DataSet,fBillDict.dlSumFlds),false,false);
end;

procedure TBillFrm.actAftSaveBillExecute(Sender: TObject);
 var TrAfterSave:      TTrAfterSave;
begin

    if  FhlKnl1.Cf_GetDict_afterSave(fbilldict.Id , TrAfterSave) then
    begin
          if Not dmFrm.ExecStoredProc(TrAfterSave.ProcName,FhlKnl1.Vr_MergeVarArray(FhlUser.GetSysParamsVal(TrAfterSave.sysPrama   ),FhlKnl1.Ds_GetFieldsValue(self.dlDataSet1 ,TrAfterSave.UserPrama))) then
            MessageDlg(#13#10+TrAfterSave.ErrHint ,mtError,[mbOk],0);

    end;
end;

procedure TBillFrm.ActEditExecute(Sender: TObject);
begin
         SetCtrlStyle(true);
          EditPostAfter(false);
          ActEdit.Enabled :=false;
          self.ImportAction1.Enabled :=true;
end;

end.



