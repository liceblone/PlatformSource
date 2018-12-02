unit UinstallClient;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, IniFiles,
  Dialogs, DB, ADODB, StdCtrls;

type
  TFrmInstallClient = class(TForm)
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    lblMsg: TLabel;
    edtIP: TEdit;
    edtPubDBUserName: TEdit;
    edtPubDbPassword: TEdit;
    btnTest: TButton;
    Qry1: TADOQuery;
    Label1: TLabel;
    edtPubDB: TEdit;
    btnclose: TButton;
    procedure btnTestClick(Sender: TObject);
    procedure btncloseClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmInstallClient: TFrmInstallClient;

implementation

uses uDataModule;

{$R *.dfm}

procedure TFrmInstallClient.btnTestClick(Sender: TObject);
var cnn,PubDBFileName:string;
var inif2: TIniFile;
begin
  cnn:=format('Provider=SQLOLEDB.1;'+
  'Persist Security Info=true;'+
  'User ID=%s;'+
  'Password=%s;'+
  'Initial Catalog=%s;'+
  'Data Source=%s;'+
  'Use Procedure for Prepare=1;'+
  'Auto Translate=True;'+
  'Packet Size=4096;'+
  'Workstation ID=xts4;'+
  'Use Encryption for Data=False;'+
  'Tag with column collation when possible=False',
  [self.edtPubDBUserName.Text ,self.edtPubDbPassword.Text , 'master' ,edtIP.Text  ]);



  try
    logininfo.SysDBPubName:=Self.edtPubDB.Text ;
    dmfrm.CnnMaster.ConnectionString:=cnn;
    dmfrm.CnnMaster.Open ;

    self.qry1.ConnectionString :=cnn;
    qry1.SQL.Clear;
    qry1.SQL.Add('select 1');
    qry1.Open;

    lblMsg.Caption :='数据库连接成功！';
 

    inif2:=TIniFile.Create(ExtractFileDir(Application.ExeName)+'\Config.ini');
    inif2.WriteString ('DBConn','DataBase',SavePass( self.edtPubDB.Text  )  ) ;
    inif2.WriteString ('DBConn','User',SavePass( 'sa'  )) ;
    inif2.WriteString ('DBConn','Password',SavePass( self.edtPubDbPassword.Text  )  ) ;
    inif2.WriteString ('DBConn','Server',SavePass(edtIP.Text )  ) ;
    inif2.Free;

    inif2:=TIniFile.Create(ExtractFileDir(Application.ExeName)+'\Update.ini');
    inif2.WriteString ('Path','url','http://'+edtIP.Text +'/updateweb/update.inf' ) ;
    inif2.Free;
    
  except
     on err:Exception do
      ShowMessage(err.Message );
  end;
end;

procedure TFrmInstallClient.btncloseClick(Sender: TObject);
begin
  Application.Terminate;
end;

end.
