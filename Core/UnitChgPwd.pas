unit UnitChgPwd;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TFrmChgPwd = class(TForm)
    edtOriPwd: TEdit;
    Label1: TLabel;
    edtNewPwd: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    edtConfirmPwd: TEdit;
    BtnOk: TButton;
    BtnCancel: TButton;
    edtUserName: TEdit;
    Label4: TLabel;
    warningLabel: TLabel;
    procedure BtnOkClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmChgPwd: TFrmChgPwd;

implementation
uses datamodule ;
{$R *.dfm}


procedure TFrmChgPwd.BtnOkClick(Sender: TObject);
var

sql:string;
begin
try


    begin
       sql:='select * From sys_user where  loginid='  + quotedstr(edtUserName.Text) ;
       fhlknl1.Kl_GetUserQuery(sql);

       if  fhlknl1.User_Query.IsEmpty then
       begin
           self.warningLabel.Caption :='用户名不存在!';
           warningLabel.Visible :=true;
           exit;
       end;
       if  edtNewPwd.Text <>edtConfirmPwd.Text then
       begin
           self.warningLabel.Caption :='新密码不匹配!';
           warningLabel.Visible :=true;
           exit;
       end;
       sql:='select * From sys_user where  loginid='  + quotedstr(edtUserName.Text) +' and password='+quotedstr(edtOriPwd.Text );
       fhlknl1.Kl_GetUserQuery(sql);
       if  fhlknl1.User_Query.IsEmpty then
       begin
           self.warningLabel.Caption :='原密码不正确!';
           warningLabel.Visible :=true;
           exit;
       end;

       if  edtOriPwd.Text=edtNewPwd.Text then
       begin
           self.warningLabel.Caption :='新密码不跟原密码相同!';
           warningLabel.Visible :=true;
           exit;
       end;
       try
           sql:='update sys_user set password= '+quotedstr(edtNewPwd.Text)   +' ,passwordx='+quotedstr(edtNewPwd.Text)   +'   where  loginid='  + quotedstr(edtUserName.Text) +' and password='+quotedstr(edtOriPwd.Text );
           fhlknl1.Kl_GetUserQuery(sql,false);
           showmessage(' 密码修改成功!');
           self.Close ;

           warningLabel.Visible :=false;
       except
            self.warningLabel.Caption :=' 密码修改失败!';
       end;

      warningLabel.Left :=trunc(self.Width/2-warningLabel.Width /2)


    end;
finally
    FrmChgPwd.Free ;
end;

 end;
end.
