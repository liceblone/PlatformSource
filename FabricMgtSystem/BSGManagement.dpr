program BSGManagement;

uses
  Forms,
  Dialogs,
  colProp in '..\Core\colProp.pas' {colPropFrm},
  colShower in '..\Core\colShower.pas' {colShowerFrm},
  Date in '..\Core\Date.pas' {DateFrm},
  desktop in '..\Core\Desktop.pas' {DesktopFrm},
  DirSelector in '..\Core\DirSelector.pas' {DirSelectorFrm},
  FhlKnl in '..\Core\FhlKnl.pas',
  Filter in '..\Core\Filter.pas' {FilterFrm},
  Finder in '..\Core\Finder.pas' {FinderFrm},
  Login in '..\Core\Login.pas' {LoginFrm},
  MacPermit in '..\Core\MacPermit.pas' {MacPermitFrm},
  main in '..\Core\MAIN.PAS' {mainFrm},
  Sort in '..\Core\Sort.pas' {SortFrm},
  splash in '..\Core\SPLASH.PAS' {splashFrm},
  UnitLockSys in '..\Core\UnitLockSys.pas' {frmLockSys},
  UnitAdoDataset in '..\Core\control\UnitAdoDataset.pas',
  UnitDBFile in '..\Core\control\UnitDBFile.pas',
  UnitGrid in '..\Core\control\UnitGrid.pas',
  UPublicCtrl in '..\Core\control\UPublicCtrl.pas',
  UPublicFunction in '..\Core\function\UPublicFunction.pas',
  Lookup in '..\Core\model\lookup.pas' {LookupFrm},
  More2More in '..\Core\model\More2More.pas' {More2MoreFrm},
  RepBill in '..\Core\model\RepBill.pas' {RepBillFrm: TQuickRep},
  RepCard in '..\Core\model\RepCard.pas' {RepCardFrm: TQuickRep},
  RepGrid in '..\Core\model\RepGrid.pas' {RepGridFrm: TQuickRep},
  TreeDlg in '..\Core\model\TreeDlg.pas' {TreeDlgFrm},
  UnitDemo in '..\Core\model\UnitDemo.pas' {FrmDemo},
  UnitEditorReport in '..\Core\model\UnitEditorReport.pas' {EditorReport: TQuickRep},
  Ole2 in '..\Core\OleAuto\Ole2.pas',
  OleAuto in '..\Core\OleAuto\OleAuto.pas',
  OleCtl in '..\Core\OleAuto\OleCtl.pas',
  SQASrvr in '..\Core\OleAuto\sqasrvr.pas',
  EditorSystool in '..\Core\Systool\EditorSystool.pas' {EditorFrmSystool},
  TreeGridSystool in '..\Core\Systool\TreeGridSysTool.pas' {TreeGridFrmSystool},
  Trigger in '..\Core\UserTool\Trigger.pas' {FrmTrigger},
  UnitActionsGrid in '..\Core\UserTool\UnitActionsGrid.pas' {FrmActions},
  UnitCreateComponent in '..\Core\UserTool\UnitCreateComponent.pas' {frmCreateComponent},
  UnitDesignMainMenu in '..\Core\UserTool\UnitDesignMainMenu.pas' {frmDesignMainMenu},
  UnitEditCtrl in '..\Core\UserTool\UnitEditCtrl.pas' {FrmEditCtrl},
  UnitMainMenu in '..\Core\UserTool\UnitMainMenu.pas' {FrmMainMenu},
  UnitManageFrm in '..\Core\UserTool\UnitManageFrm.pas' {FrmManageFrm},
  UnitUpdateProerty in '..\Core\UserTool\UnitUpdateProerty.pas' {FrmUpdateProperty},
  datamodule in 'PrivateSource\datamodule.pas' {dmFrm: TDataModule},
  UnitFrmAnalyserEx in 'PrivateSource\UnitFrmAnalyserEx.pas' {AnalyseEx},
  TreeEditor in 'PrivateSource\TreeEditor.pas' {TreeEditorFrm},
  Editor in 'PrivateSource\Editor.pas' {EditorFrm},
  TreeGrid in 'PrivateSource\TreeGrid.pas' {TreeGridFrm},
  PickWindowUniveral in 'PrivateSource\PickWindowUniveral.pas' {Form1},
  UnitCrmMain in 'PrivateSource\UnitCrmMain.pas' {FrmCrm},
  UnitBillEx in 'PrivateSource\UnitBillEx.pas' {FrmBillEx},
  TreeMgr in 'PrivateSource\TreeMgr.pas' {TreeMgrFrm},
  BillOpenDlg in 'PrivateSource\BillOpenDlg.pas' {BillOpenDlgFrm},
  UnitSpecial in 'PrivateSource\UnitSpecial.pas' {FrmSpecial},
  UnitLookUpImport in 'PrivateSource\UnitLookUpImport.pas' {FrmLoopUpImPortEx},
  UnitSerialNos in 'PrivateSource\UnitSerialNos.pas' {FrmSerialNos},
  UnitUserReport in 'PrivateSource\UnitUserReport.pas' {UserQkRpt: TQuickRep},
  UnitUserDefineRpt in 'PrivateSource\UnitUserDefineRpt.pas' {FrmUserDefineReport},
  UnitGetTreeViewID in '..\Core\UserTool\UnitGetTreeViewID.pas' {FrmGetTreeViewID},
  UnitGetGridIDTreeID in '..\Core\UserTool\UnitGetGridIDTreeID.pas' {frmGetGridID},
  about in '..\Core\about.pas' {aboutFrm},
  ADBGrid in '..\Core\control\ADBGrid.pas',
  UnitModelFrm in '..\Core\UnitModelFrm.pas' {FrmModel},
  UnitMulPrintModule in '..\Core\UnitMulPrintModule.pas',
  UnitUserQrRptEx in 'PrivateSource\UnitUserQrRptEx.pas' {FrmUserQrRptEx},
  UnitSendMsg in 'PrivateSource\UnitSendMsg.pas' {FrmSendMsg},
  UnitChgPwd in '..\Core\UnitChgPwd.pas' {FrmChgPwd},
  Myprv in 'PrivateSource\Myprv.pas' {MyPreview},
  UnitCtrlConfig in '..\Core\UserTool\UnitCtrlConfig.pas' {FrmCtrlConfig},
  UnitMDLookupImport in '..\Core\UnitMDLookupImport.pas' {FrmMDLookupImport},
  TabEditor in 'PrivateSource\TabEditor.pas' {TabEditorFrm},
  UnitChyFrReportView in 'PrivateSource\UnitChyFrReportView.pas',
  DelphiZXingQRCode in 'PrivateSource\DelphiZXingQRCode.pas',
  BarCode in 'PrivateSource\BarCode\BarCode.pas',
  UnitUpdateQLabel in '..\Core\UnitUpdateQLabel.pas' {FrmUpdateQLabel},
  UnitBillVoucher in '..\Core\model\UnitBillVoucher.pas' {FrmBillVoucher},
  UnitIBillEx in '..\Core\Interface\UnitIBillEx.pas';

{$R *.res}




 begin
  Application.Initialize;
  Application.ProcessMessages;
  SplashFrm:=TsplashFrm.Create(application);
  SplashFrm.Show;
  SplashFrm.Update;
  Application.ShowMainForm:=false;
  SplashFrm.ShowHint('正在创建数据模块,请稍候...');
  Application.CreateForm(TdmFrm, dmFrm);
  splashFrm.ShowHint('正在创建主程序,请稍候...');
  Application.CreateForm(TmainFrm, mainFrm);
  SplashFrm.ShowHint('正在创建个人桌面,请稍候...');
  Application.CreateForm(TdesktopFrm, desktopFrm);


  SplashFrm.ShowHint('正在启动程序,请稍候...');

      if (SplashFrm.SetConnection) and (desktopFrm.Reg) then
     begin
        Application.ShowMainForm:=True;
        Application.Run;
     end
     else begin
        mainFrm.Close;
        Application.Run;
        Application.Terminate;
     end;

end.

