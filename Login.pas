unit Login;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Mask, DBCtrls, ExtCtrls;

type
  TLogin_form = class(TForm)
    grpLoginGroup: TGroupBox;
    btn_cancel: TBitBtn;
    lbl1: TLabel;
    lbl2: TLabel;
    edt_id_staff: TEdit;
    Login: TButton;
    edt_nama: TEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Login_form: TLogin_form;

implementation



{$R *.dfm}

end.
