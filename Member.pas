unit Member;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, StdCtrls, Mask, DBCtrls, Buttons, ComCtrls,
  ExtCtrls;

type
  TMember_form = class(TForm)
    grp1: TGroupBox;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    tglRegis: TDateTimePicker;
    grp2: TGroupBox;
    cbb_berdasarkan: TComboBox;
    search: TEdit;
    dbgrd_member: TDBGrid;
    nama: TEdit;
    alamat: TEdit;
    no_telp: TEdit;
    grp_input: TGroupBox;
    btn_simpan: TBitBtn;
    grp_up: TGroupBox;
    btn_update: TBitBtn;
    grp_rb: TGroupBox;
    rb_kiri: TRadioButton;
    rb_kanan: TRadioButton;
    btn_delete: TBitBtn;
    btn_tampil: TBitBtn;
    id_member: TEdit;
    img1: TImage;
    Cetak: TBitBtn;
    lbl6: TLabel;
    nl: TPanel;
    procedure btn_simpanClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cbb_berdasarkanChange(Sender: TObject);
    procedure searchChange(Sender: TObject);
    procedure btn_updateClick(Sender: TObject);
    procedure rb_kiriClick(Sender: TObject);
    procedure btn_deleteClick(Sender: TObject);
    procedure btn_tampilClick(Sender: TObject);
    procedure cekKananClick(Sender: TObject);
    procedure rb_kananClick(Sender: TObject);
    procedure CetakClick(Sender: TObject);
    procedure namaClick(Sender: TObject);
    procedure alamatClick(Sender: TObject);
    procedure no_telpClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Member_form: TMember_form;

implementation
          uses DM,Transaksi, Math,QRMember,cetak ;
{$R *.dfm}

procedure TMember_form.btn_simpanClick(Sender: TObject);
var tanggal,a,b,c : string;
begin
//   ============== Kondisi data ga lengkap =====
search.Enabled:=True;
a:=nama.Text;
b:=alamat.Text;
c:=no_telp.Text;
   if (a='')
   and (b='')
   and (c='')
   then
    begin
    ShowMessage('Lengkapi Data');
    end
   else

   //   ============== SIMPAN Member =====

   try
    DataModule1.ADOQuery_Member.Connection:=DataModule1.con1;
    with DataModule1.ADOQuery_Member do
   begin
    tanggal:=FormatDateTime('yyyy-mm-dd',tglRegis.Date);

    Active:=false;
    Close;
    SQL.Clear;
    SQL.Text:='insert into members_ values('+QuotedStr(id_member.Text)+','+
    QuotedStr(nama.Text)+','+
    QuotedStr(alamat.Text)+','+
    //QuotedStr(cbb_struktur.Text)+','+
    QuotedStr(tanggal)+','+
    QuotedStr(no_telp.Text)+')';
    ExecSQL;
   end;

 ShowMessage('Berhasil Disimpan');

     begin
      id_member.Clear;
      nama.Clear;
      alamat.Clear;
      tglRegis.Date:= Now;
      no_telp.Clear;
    end;


  dbgrd_member.DataSource:=DataModule1.ds_member;
  DataModule1.ds_member.DataSet:=DataModule1.ADOTable_Member;
  DataModule1.ADOTable_Member.Connection:=DataModule1.con1;
  DataModule1.ADOTable_Member.Active:=false;
  DataModule1.ADOTable_Member.Close;
  DataModule1.ADOTable_Member.TableName:='members_';
  DataModule1.ADOTable_Member.Active:=true;

  DataModule1.ds_member.DataSet:=DataModule1.ADOQuery_Member;
  DataModule1.ADOQuery_Member.Connection:=DataModule1.con1;
  begin
    DataModule1.ADOQuery_Member.Active:=false;
    DataModule1.ADOQuery_Member.Close;
    DataModule1.ADOQuery_Member.SQL.Clear;
    DataModule1.ADOQuery_Member.SQL.Text:='select*from members_';
    DataModule1.ADOQuery_Member.Active:=true;
    end;
 except
ShowMessage('Gagal Disimpan');
 end;
end;

procedure TMember_form.FormShow(Sender: TObject);
begin
dbgrd_member.DataSource:=DataModule1.ds_member;
tglRegis.Date:=Now;

  dbgrd_member.DataSource:=DataModule1.ds_member;
  DataModule1.ds_member.DataSet:=DataModule1.ADOTable_Member;
  DataModule1.ADOTable_Member.Connection:=DataModule1.con1;
  DataModule1.ADOTable_Member.Active:=false;
  DataModule1.ADOTable_Member.Close;
  DataModule1.ADOTable_Member.TableName:='members_';
  DataModule1.ADOTable_Member.Active:=true;
  //========= Refresh
  DataModule1.ds_member.DataSet:=DataModule1.ADOQuery_Member;
  DataModule1.ADOQuery_Member.Connection:=DataModule1.con1;
   begin
    DataModule1.ADOQuery_Transaksi.Active:=false;
    DataModule1.ADOQuery_Transaksi.Close;
    DataModule1.ADOQuery_Transaksi.SQL.Clear;
    DataModule1.ADOQuery_Transaksi.SQL.Text:='select*from transaksi_';
    DataModule1.ADOQuery_Transaksi.Active:=true;
   end;
 end;

procedure TMember_form.cbb_berdasarkanChange(Sender: TObject);
begin
 searchChange(Sender);
  search.Enabled:=True;
 search.SetFocus;
end;

procedure TMember_form.searchChange(Sender: TObject);
var a:String;
begin
  dbgrd_member.DataSource:=DataModule1.ds_member;
 case cbb_berdasarkan.ItemIndex of
  0:a:='id_member';
  1:a:='nama_member';
  2:a:='alamat';
  3:a:='tgl_regis';
  4:a:='no_hp';
  end;
 if (search.Text<>'') and (cbb_berdasarkan.Text<>'') then
  begin
  DataModule1.ADOQuery_Member.SQL.Clear;
  DataModule1.ADOQuery_Member.SQL.Text:='select * from members_ where '+a+' like' + QuotedStr('%'+search.Text+'%');
  DataModule1.ADOQuery_Member.Active:=True;
  end
 else
  begin
    DataModule1.ADOQuery_Member.Close;
    DataModule1.ADOQuery_Member.SQL.Clear;
    DataModule1.ADOQuery_Member.SQL.Add('select * from members_');
    DataModule1.ADOQuery_Member.Open;
  end;
end;

procedure TMember_form.btn_updateClick(Sender: TObject);
var a,b,c : string;
begin
search.Enabled:=True;
a:=nama.Text;
b:=alamat.Text;
c:=no_telp.Text;
   if (a='')
   and (b='')
   and (c='')
   //+ (no_telp.Text:='')
   then
    begin
    ShowMessage('Lengkapi Data');
    end
   else

 try DataModule1.con1.BeginTrans;
 with DataModule1.ADOQuery_Member do
  begin
  Active:=false;
  Close;
  SQL.Clear;
  SQL.Text:='update members_ set nama_member='+QuotedStr(nama.Text)+
  ',alamat='+QuotedStr(alamat.Text)+
  //',tgl_regis='+DateToStr(tglRegis.Date)+
  ',no_hp='+QuotedStr(no_telp.Text)+
  //',no_telp='+QuotedStr(tglRegis.Text)+
  'where id_member='+QuotedStr(id_member.Text);
  ExecSQL;
  end;
  DataModule1.con1.CommitTrans;
  ShowMessage('berhasil diupdate');
  id_member.Clear;
  nama.Clear;
  alamat.Clear;
  tglRegis.Date:= Now;
  no_telp.Clear;

  dbgrd_member.DataSource:=DataModule1.ds_member;
  DataModule1.ds_member.DataSet:=DataModule1.ADOTable_Member;
  DataModule1.ADOTable_Member.Connection:=DataModule1.con1;
  DataModule1.ADOTable_Member.Active:=false;
  DataModule1.ADOTable_Member.Close;
  DataModule1.ADOTable_Member.TableName:='members_';
  DataModule1.ADOTable_Member.Active:=true;

  DataModule1.ds_member.DataSet:=DataModule1.ADOQuery_Member;
  DataModule1.ADOQuery_Member.Connection:=DataModule1.con1;
 begin
  DataModule1.ADOQuery_Member.Active:=false;
  DataModule1.ADOQuery_Member.Close;
  DataModule1.ADOQuery_Member.SQL.Clear;
  DataModule1.ADOQuery_Member.SQL.Text:='select*from members_';
  DataModule1.ADOQuery_Member.Active:=true;
 end;
  except
  DataModule1.con1.RollbackTrans;
  ShowMessage('gagal update');
  end;
end;

procedure TMember_form.rb_kiriClick(Sender: TObject);
begin

//=================== Membuat Auto id_member =========
  id_member.Text:= 'ID-'
  +IntToStr(DataModule1.ADOQuery_Member.RecordCount+1);
  grp_input.Enabled:=True;
  grp_up.Enabled:=False;
  nama.Enabled:=True;
  alamat.Enabled:=True;
  no_telp.Enabled:=True;
  nama.Clear;
  alamat.Clear;
  no_telp.Clear;
end;

procedure TMember_form.btn_deleteClick(Sender: TObject);
begin
  try DataModule1.con1.BeginTrans;
    with DataModule1.ADOQuery_Member do
    begin
    Active:=false;
    Close;
    SQL.Clear;
    SQL.Text:='delete from members_ where id_member='+QuotedStr(id_member.Text);
    ExecSQL;
    end;
    DataModule1.con1.CommitTrans;
    ShowMessage('berhasil dihapus');
    id_member.Clear;
    nama.Clear;
    alamat.Clear;
    tglRegis.Date := Now;
    no_telp.Clear;
    dbgrd_member.DataSource:=DataModule1.ds_member;
    DataModule1.ds_member.DataSet:=DataModule1.ADOTable_Member;
    DataModule1.ADOTable_Member.Connection:=DataModule1.con1;
    DataModule1.ADOTable_Member.Active:=false;
    DataModule1.ADOTable_Member.Close;
    DataModule1.ADOTable_Member.TableName:='members_';
    DataModule1.ADOTable_Member.Active:=true;

    DataModule1.ds_member.DataSet:=DataModule1.ADOQuery_Member;
    DataModule1.ADOQuery_Member.Connection:=DataModule1.con1;
 begin
  DataModule1.ADOQuery_Member.Active:=false;
  DataModule1.ADOQuery_Member.Close;
  DataModule1.ADOQuery_Member.SQL.Clear;
  DataModule1.ADOQuery_Member.SQL.Text:='select*from members_';
  DataModule1.ADOQuery_Member.Active:=true;
 end;

 except
  DataModule1.con1.RollbackTrans;
  ShowMessage('gagal dihapus');
 end;

end;

procedure TMember_form.btn_tampilClick(Sender: TObject);
begin
  id_member.Text:=DataModule1.ADOQuery_Member.FieldValues['id_member'];
  nama.Text:=DataModule1.ADOQuery_Member.FieldValues['nama_member'];
 //tglRegis.Date:=DataModule1.ADOQuery_Member.FieldValues['tgl_regis'];
  alamat.Text:=DataModule1.ADOQuery_Member.FieldValues['alamat'];
  no_telp.Text:=DataModule1.ADOQuery_Member.FieldValues['no_hp'];

  nama.Enabled:=True;
  alamat.Enabled:=True;
  no_telp.Enabled:=True;
  rb_kanan.Checked:=True;
end;

procedure TMember_form.cekKananClick(Sender: TObject);
begin
grp_input.Enabled:=False;
grp_up.Enabled:=True;
  id_member.Clear;
  nama.Clear;
  alamat.Clear;
  tglRegis.Date;
  no_telp.Clear;
   nama.Enabled:=False;
  alamat.Enabled:=False;
  no_telp.Enabled:=False;
end;

procedure TMember_form.rb_kananClick(Sender: TObject);
begin
grp_input.Enabled:=False;
grp_up.Enabled:=True;
  id_member.Clear;
  nama.Clear;
  alamat.Clear;
  tglRegis.Date;
  no_telp.Clear
end;

procedure TMember_form.CetakClick(Sender: TObject);
begin
DataModule1.ADOQuery_Member.SQL.Clear;
DataModule1.ADOQuery_Member.SQL.Add('SELECT * FROM members_ ');//ORDER BY kd_transaksi asc');
DataModule1.ADOQuery_Member.Active:=true;
QuickR_MEMBER.Preview;
DataModule1.ADOQuery_Member.SQL.Clear;
DataModule1.ADOQuery_Member.SQL.Add('select * from members_ ');
DataModule1.ADOQuery_Member.Active:=true;
end;

procedure TMember_form.namaClick(Sender: TObject);
begin
nama.SetFocus;
end;

procedure TMember_form.alamatClick(Sender: TObject);
begin
alamat.SetFocus;
end;

procedure TMember_form.no_telpClick(Sender: TObject);
begin
   no_telp.SetFocus;
end;

end.
