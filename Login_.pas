unit Login_;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  TLogin_form_ = class(TForm)
    grpLoginGroup: TGroupBox;
    lbl2: TLabel;
    btn_cancel: TBitBtn;
    edt_id_staff: TEdit;
    Login: TButton;
    edt_nama: TEdit;
    edt_duplikast2_: TEdit;
    edt_duplikat1_: TEdit;
    procedure LoginClick(Sender: TObject);
    procedure btn_cancelClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Login_form_: TLogin_form_;

implementation

uses DM, Beranda, Transaksi, Pembelian, Penjualan, Saldo;

{$R *.dfm}

procedure TLogin_form_.LoginClick(Sender: TObject);
begin
 begin
     with DataModule1.ADOQuery_karyawan do
    begin
      Active:=False;
      SQL.Clear;
      SQL.Text:='select * from karyawan where pass='+QuotedStr(edt_id_staff.Text);
      Active:=True;
      edt_nama.Text:=(DataModule1.ADOQuery_karyawan.FieldByName('nama').AsString);
     end;
    edt_duplikat1_.Text:=edt_nama.Text;
    edt_duplikast2_.Text:=edt_nama.Text;
    edt_id_staff.Clear;
  end;
    if edt_nama.Text='' then
    MessageDlg('Password Salah !!!',mtWarning,[mbOK],0) else
    begin
    Beranda_form.Show;
    Login_form_.Hide;
    end
end;

procedure TLogin_form_.btn_cancelClick(Sender: TObject);
begin
close;
end;

end.
