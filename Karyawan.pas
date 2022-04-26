unit Karyawan;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, StdCtrls, Buttons, Mask, DBCtrls, ComCtrls,
  ExtCtrls;

type
  TKaryawan_Form = class(TForm)
    grp1: TGroupBox;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    tglRegis: TDateTimePicker;
    nama: TEdit;
    alamat: TEdit;
    no_telp: TEdit;
    grp_input: TGroupBox;
    btn_simpan: TBitBtn;
    grp_up: TGroupBox;
    btn_update: TBitBtn;
    btn_delete: TBitBtn;
    grp_rb: TGroupBox;
    rb_kiri: TRadioButton;
    rb_kanan: TRadioButton;
    grp2: TGroupBox;
    lbl6: TLabel;
    cbb_berdasarkan: TComboBox;
    search: TEdit;
    dbgrd_karyawan: TDBGrid;
    btn_tampil: TBitBtn;
    cbb_struktur: TComboBox;
    lbl8: TLabel;
    id_karyawan: TEdit;
    lbl9: TLabel;
    edt_password: TEdit;
    lbl7: TLabel;
    pnl1: TPanel;
    procedure rb_kiriClick(Sender: TObject);
    procedure btn_simpanClick(Sender: TObject);
    procedure btn_updateClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cbb_berdasarkanChange(Sender: TObject);
    procedure searchChange(Sender: TObject);
    procedure btn_deleteClick(Sender: TObject);
    procedure btn_tampilClick(Sender: TObject);
    procedure cbb_strukturChange(Sender: TObject);
    procedure dbgrd_karyawanCellClick(Column: TColumn);
    procedure namaClick(Sender: TObject);
    procedure alamatClick(Sender: TObject);
    procedure namaChange(Sender: TObject);
    procedure no_telpClick(Sender: TObject);
    procedure cbb_strukturClick(Sender: TObject);
    procedure searchClick(Sender: TObject);
    procedure rb_kananClick(Sender: TObject);
    procedure edt_passwordClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Karyawan_Form: TKaryawan_Form;

implementation
                    uses DM;
{$R *.dfm}

procedure TKaryawan_Form.rb_kiriClick(Sender: TObject);
begin
btn_simpan.Enabled:=True;
grp_input.Enabled:=True;
id_karyawan.Clear;
edt_password.Clear;
nama.Clear;
alamat.Clear;
//cbb_struktur.Clear;
no_telp.Clear;
end;

procedure TKaryawan_Form.btn_simpanClick(Sender: TObject);
var tanggal,a,b,c : string;
begin
search.Enabled:=True;
a:=nama.Text;
b:=alamat.Text;
c:=no_telp.Text;
   if (a='')
   and (b='')
   and (c='')
   then
    begin
    ShowMessage('Lengkapi Data !!!');
    end
   else

   try
    DataModule1.ADOQuery_karyawan.Connection:=DataModule1.con1;
    with DataModule1.ADOQuery_karyawan do
   begin
    tanggal:=FormatDateTime('yyyy-mm-dd',tglRegis.Date);

    Active:=false;
    Close;
    SQL.Clear;
    SQL.Text:='insert into karyawan values('+QuotedStr(id_karyawan.Text)+','+
    QuotedStr(nama.Text)+','+
    QuotedStr(alamat.Text)+','+
    QuotedStr(tanggal)+','+
    QuotedStr(no_telp.Text)+','+
    QuotedStr(cbb_struktur.Text)+','+
    QuotedStr(edt_password.Text)+')';
    ExecSQL;
   end;

 ShowMessage('Berhasil Disimpan');

     begin
      id_karyawan.Clear;
      nama.Clear;
      alamat.Clear;
      cbb_struktur.Text:='-pilih-';
      tglRegis.Date:= Now;
      no_telp.Clear;
      edt_password.Clear;
    end;


  dbgrd_karyawan.DataSource:=DataModule1.ds_karyawan;
  DataModule1.ds_karyawan.DataSet:=DataModule1.ADOTable_Karyawan;
  DataModule1.ADOTable_Karyawan.Connection:=DataModule1.con1;
  DataModule1.ADOTable_Karyawan.Active:=false;
  DataModule1.ADOTable_Karyawan.Close;
  DataModule1.ADOTable_Karyawan.TableName:='karyawan';
  DataModule1.ADOTable_Karyawan.Active:=true;

  DataModule1.ds_karyawan.DataSet:=DataModule1.ADOQuery_karyawan;
  DataModule1.ADOQuery_karyawan.Connection:=DataModule1.con1;
  begin
    DataModule1.ADOQuery_karyawan.Active:=false;
    DataModule1.ADOQuery_karyawan.Close;
    DataModule1.ADOQuery_karyawan.SQL.Clear;
    DataModule1.ADOQuery_karyawan.SQL.Text:='select*from karyawan';
    DataModule1.ADOQuery_karyawan.Active:=true;
    end;
  except
ShowMessage('Gagal Disimpan');
 end;
end;


procedure TKaryawan_Form.btn_updateClick(Sender: TObject);
var a,b,c : string;
begin
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

 try DataModule1.con1.BeginTrans;
 with DataModule1.ADOQuery_karyawan do
  begin
  Active:=false;
  Close;
  SQL.Clear;
  SQL.Text:='update karyawan set nama='+QuotedStr(nama.Text)+
  ',alamat='+QuotedStr(alamat.Text)+
  ',no_hp='+QuotedStr(no_telp.Text)+
  ',struktur='+QuotedStr(cbb_struktur.Text)+
  ',pass='+QuotedStr(edt_password.Text)+
  'where id_karyawan='+QuotedStr(id_karyawan.Text);
  ExecSQL;
  end;
  DataModule1.con1.CommitTrans;
  ShowMessage('berhasil diupdate');
  id_karyawan.Clear;
  nama.Clear;
  alamat.Clear;
  tglRegis.Date:= Now;
  no_telp.Clear;
  cbb_struktur.Clear;
  edt_password.Clear;

  dbgrd_karyawan.DataSource:=DataModule1.ds_karyawan;
  DataModule1.ds_karyawan.DataSet:=DataModule1.ADOTable_Karyawan;
  DataModule1.ADOTable_Karyawan.Connection:=DataModule1.con1;
  DataModule1.ADOTable_Karyawan.Active:=false;
  DataModule1.ADOTable_Karyawan.Close;
  DataModule1.ADOTable_Karyawan.TableName:='karyawan';
  DataModule1.ADOTable_Karyawan.Active:=true;

  DataModule1.ds_karyawan.DataSet:=DataModule1.ADOQuery_karyawan;
  DataModule1.ADOQuery_karyawan.Connection:=DataModule1.con1;
 begin
  DataModule1.ADOQuery_karyawan.Active:=false;
  DataModule1.ADOQuery_karyawan.Close;
  DataModule1.ADOQuery_karyawan.SQL.Clear;
  DataModule1.ADOQuery_karyawan.SQL.Text:='select*from karyawan';
  DataModule1.ADOQuery_karyawan.Active:=true;
 end;
  except
  DataModule1.con1.RollbackTrans;
  ShowMessage('gagal update');
  end;
end;


procedure TKaryawan_Form.FormShow(Sender: TObject);
begin
dbgrd_karyawan.DataSource:=DataModule1.ds_karyawan;
grp1.Enabled:=True;

nama.SetFocus;
tglRegis.Date:=Now;

  dbgrd_karyawan.DataSource:=DataModule1.ds_karyawan;
  DataModule1.ds_karyawan.DataSet:=DataModule1.ADOTable_Karyawan;
  DataModule1.ADOTable_Karyawan.Connection:=DataModule1.con1;
  DataModule1.ADOTable_Karyawan.Active:=false;
  DataModule1.ADOTable_Karyawan.Close;
  DataModule1.ADOTable_Karyawan.TableName:='karyawan';
  DataModule1.ADOTable_Karyawan.Active:=true;
  //========= Refresh
  DataModule1.ds_karyawan.DataSet:=DataModule1.ADOQuery_karyawan;
  DataModule1.ADOQuery_karyawan.Connection:=DataModule1.con1;
   begin
    DataModule1.ADOQuery_karyawan.Active:=false;
    DataModule1.ADOQuery_karyawan.Close;
    DataModule1.ADOQuery_karyawan.SQL.Clear;
    DataModule1.ADOQuery_karyawan.SQL.Text:='select*from karyawan';
    DataModule1.ADOQuery_karyawan.Active:=true;
   end;

end;

procedure TKaryawan_Form.cbb_berdasarkanChange(Sender: TObject);
begin
searchChange(Sender);
  search.Enabled:=True;
 search.SetFocus;
end;

procedure TKaryawan_Form.searchChange(Sender: TObject);
var a:String;
begin
  dbgrd_karyawan.DataSource:=DataModule1.ds_karyawan;
 case cbb_berdasarkan.ItemIndex of
  0:a:='id_karyawan';
  1:a:='nama';
  2:a:='alamat';
  3:a:='tgl_regis';
  4:a:='no_hp';
  5:a:='struktur';
  end;

 if (search.Text<>'') and (cbb_berdasarkan.Text<>'') then
  begin
  DataModule1.ADOQuery_karyawan.SQL.Clear;
  DataModule1.ADOQuery_karyawan.SQL.Text:='select * from karyawan where '+a+' like' + QuotedStr('%'+search.Text+'%');
  DataModule1.ADOQuery_karyawan.Active:=True;
  end
 else

  begin
    DataModule1.ADOQuery_karyawan.Close;
    DataModule1.ADOQuery_karyawan.SQL.Clear;
    DataModule1.ADOQuery_karyawan.SQL.Add('select * from karyawan');
    DataModule1.ADOQuery_karyawan.Open;
  end;
end;


procedure TKaryawan_Form.btn_deleteClick(Sender: TObject);
begin
  try DataModule1.con1.BeginTrans;
    with DataModule1.ADOQuery_karyawan do
    begin
    Active:=false;
    Close;
    SQL.Clear;
    SQL.Text:='delete from karyawan where id_karyawan='+QuotedStr(id_karyawan.Text);
    ExecSQL;
    end;
    DataModule1.con1.CommitTrans;
    ShowMessage('berhasil dihapus');
    id_karyawan.Clear;
    nama.Clear;
    alamat.Clear;
    tglRegis.Date := Now;
    no_telp.Clear;
    cbb_struktur.Clear;
    dbgrd_karyawan.DataSource:=DataModule1.ds_karyawan;
    DataModule1.ds_karyawan.DataSet:=DataModule1.ADOTable_Karyawan;
    DataModule1.ADOTable_Karyawan.Connection:=DataModule1.con1;
    DataModule1.ADOTable_Karyawan.Active:=false;
    DataModule1.ADOTable_Karyawan.Close;
    DataModule1.ADOTable_Karyawan.TableName:='karyawan';
    DataModule1.ADOTable_Karyawan.Active:=true;

    DataModule1.ds_karyawan.DataSet:=DataModule1.ADOQuery_karyawan;
    DataModule1.ADOQuery_karyawan.Connection:=DataModule1.con1;
 begin
  DataModule1.ADOQuery_karyawan.Active:=false;
  DataModule1.ADOQuery_karyawan.Close;
  DataModule1.ADOQuery_karyawan.SQL.Clear;
  DataModule1.ADOQuery_karyawan.SQL.Text:='select*from karyawan';
  DataModule1.ADOQuery_karyawan.Active:=true;
 end;

 except
  DataModule1.con1.RollbackTrans;
  ShowMessage('gagal dihapus');
 end;
end;

procedure TKaryawan_Form.btn_tampilClick(Sender: TObject);
begin
  rb_kanan.Checked:=True;
  id_karyawan.Text:=DataModule1.ADOQuery_karyawan.FieldValues['id_karyawan'];
  nama.Text:=DataModule1.ADOQuery_karyawan.FieldValues['nama'];
 //tglRegis.Date:=DataModule1.ADOQuery_Member.FieldValues['tgl_regis'];
  alamat.Text:=DataModule1.ADOQuery_karyawan.FieldValues['alamat'];
  no_telp.Text:=DataModule1.ADOQuery_karyawan.FieldValues['no_hp'];
  cbb_struktur.Text:=DataModule1.ADOQuery_karyawan.FieldValues['struktur'];
    edt_password.Text:=DataModule1.ADOQuery_karyawan.FieldValues['pass'];


  nama.Enabled:=True;
  alamat.Enabled:=True;
  no_telp.Enabled:=True;

end;

procedure TKaryawan_Form.cbb_strukturChange(Sender: TObject);

begin

grp_input.Enabled:=True;

 if cbb_struktur.ItemIndex=0 then
  begin
    id_karyawan.Text:= 'AA-'
    +IntToStr(DataModule1.ADOQuery_karyawan.RecordCount+1)+'-'+FormatDateTime('yyyy',tglRegis.Date);
  end
  else if cbb_struktur.ItemIndex=1 then
  begin
     id_karyawan.Text:= 'ASNAKES-'
    +IntToStr(DataModule1.ADOQuery_karyawan.RecordCount+1)+'-'+FormatDateTime('yyyy',tglRegis.Date);
  end;
end;

procedure TKaryawan_Form.dbgrd_karyawanCellClick(Column: TColumn);
begin
btn_tampil.Enabled:=True;
end;

procedure TKaryawan_Form.namaClick(Sender: TObject);
begin
nama.SetFocus;
end;

procedure TKaryawan_Form.alamatClick(Sender: TObject);
begin
alamat.SetFocus;
end;

procedure TKaryawan_Form.namaChange(Sender: TObject);
begin
// alamat.SetFocus;
end;

procedure TKaryawan_Form.no_telpClick(Sender: TObject);
begin
no_telp.SetFocus;
end;

procedure TKaryawan_Form.cbb_strukturClick(Sender: TObject);
begin
btn_simpan.Enabled:=True;
end;

procedure TKaryawan_Form.searchClick(Sender: TObject);
begin
search.SetFocus;
end;

procedure TKaryawan_Form.rb_kananClick(Sender: TObject);
begin
grp_up.Enabled:=True;
btn_update.Enabled:=True;
btn_delete.Enabled:=True;
end;

procedure TKaryawan_Form.edt_passwordClick(Sender: TObject);
begin
edt_password.SetFocus;
end;

end.
