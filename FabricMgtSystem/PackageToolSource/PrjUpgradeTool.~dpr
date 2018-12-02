program PrjUpgradeTool;

uses
  Forms,
  SysUtils,
  Dialogs,
  UnitMain in 'UnitMain.pas' {FrmMain},
  uDataModule in 'uDataModule.pas' {dmfrm: TDataModule},
  ULogininfo in 'ULogininfo.pas' {FrmInstall},
  UUpgrade in 'UUpgrade.pas' {FUpgrade},
  UinstallClient in 'UinstallClient.pas' {FrmInstallClient},
  uGenerateDataSQL in 'uGenerateDataSQL.pas' {FrmGenerateDataSQL},
  UnitPub in 'UnitPub.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(Tdmfrm, dmfrm);
  if uppercase(ParamStr(1))=UpperCase('CreatePackage') then
    Application.CreateForm(TFrmMain, FrmMain)

  else if  UpperCase(ParamStr(1))=UpperCase('Install') then
  begin
      Application.CreateForm(TFrmInstall,   FrmInstall);
      if  ParamCount=1 then
      begin
         showmessage('need install path');
         application.Terminate;
      end;
  end
  else if  UpperCase(ParamStr(1))=UpperCase('InstallClient') then
    Application.CreateForm(TFrmInstallClient,   FrmInstallClient)

  else if  UpperCase(ParamStr(1))=UpperCase('Upgrade') then
    Application.CreateForm(TFUpgrade,    FUpgrade)

  else if  UpperCase(ParamStr(1))=UpperCase('GenerateDataSQL') then
    Application.CreateForm(TFrmGenerateDataSQL,     FrmGenerateDataSQL)
  else
  begin
    showmessage('需要参数才能启动本程序!')   ;
    Application.Terminate;
  end;


  Application.Run;
end.
