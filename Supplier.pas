unit Supplier;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Grids, DBGrids, Buttons, Mask, DBCtrls,
  ExtCtrls;

type
  TSupplier_form = class(TForm)
    grp1: TGroupBox;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    tglRegis: TDateTimePicker;
    grp2: TGroupBox;
    btn_tampilData: TBitBtn;
    cbb_berdasarkan: TComboBox;
    lbl6: TLabel;
    search: TEdit;
    dbgrd_supplier: TDBGrid;
    nama: TEdit;
    alamat: TEdit;
    no_hp: TEdit;
    id_supplier: TDBEdit;
    grp_rb: TGroupBox;
    rb_kiri: TRadioButton;
    rb_kanan: TRadioButton;
    grp_up: TGroupBox;
    btn_update: TBitBtn;
    btn_delete: TBitBtn;
    grp_input: TGroupBox;
    btn_simpan: TBitBtn;
    Image1: TImage;
    Cetak: TBitBtn;
    Label1: TLabel;
    nl: TPanel;
    procedure btn_simpanClick(Sender: TObject);
    procedure btn_updateClick(Sender: TObject);
    procedure btn_deleteClick(Sender: TObject);
    procedure rb_kiriClick(Sender: TObject);
    procedure rb_kananClick(Sender: TObject);
    procedure cbb_berdasarkanChange(Sender: TObject);
    procedure searchChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CetakClick(Sender: TObject);
    procedure namaClick(Sender: TObject);
    procedure alamatClick(Sender: TObject);
    procedure no_hpClick(Sender: TObject);
    procedure btn_tampilDataClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Supplier_form: TSupplier_form;

implementation
          uses DM, cetak,QRSupplier;
{$R *.dfm}

procedure TSupplier_form.btn_simpanClick(Sender: TObject);
var tanggal,a,b,c : string;
begin

  //   ============== Kondisi data ga lengkap =====
search.Enabled:=True;
a:=nama.Text;
b:=alamat.Text;
c:=no_hp.Text;
   if (a='')
   and (b='')
   and (c='')
   //+ (no_telp.Text:='')
   then
    begin
    ShowMessage('Lengkapi Data');
    end
   else

      //   ============== SIMPAN Member =====

try
  DataModule1.ADOQuery_Supplier.Connection:=DataModule1.con1;
  with DataModule1.ADOQuery_Supplier do
  begin
  tanggal:=FormatDateTime('yyyy-mm-dd',tglRegis.Date);

  Active:=false;
  Close;
  SQL.Clear;
  SQL.Text:='insert into supplier_ values('+QuotedStr(id_supplier.Text)+','+
  QuotedStr(nama.Text)+','+
  QuotedStr(alamat.Text)+','+
  QuotedStr(tanggal)+','+
  QuotedStr(no_hp.Text)+')';
  ExecSQL;
 end;
ShowMessage('Berhasil Disimpan');
    begin
      id_supplier.Clear;
      nama.Clear;
      alamat.Clear;
      tglRegis.Date:= Now;
      no_hp.Clear;
    end;

dbgrd_supplier.DataSource:=DataModule1.ds_supplier;
DataModule1.ds_supplier.DataSet:=DataModule1.ADOTable_Supplier;
DataModule1.ADOTable_Supplier.Connection:=DataModule1.con1;
DataModule1.ADOTable_Supplier.Active:=false;
DataModule1.ADOTable_Supplier.Close;
DataModule1.ADOTable_Supplier.TableName:='supplier_';
DataModule1.ADOTable_Supplier.Active:=true;

DataModule1.ds_supplier.DataSet:=DataModule1.ADOQuery_Supplier;
DataModule1.ADOQuery_Supplier.Connection:=DataModule1.con1;
 begin
  DataModule1.ADOQuery_Supplier.Active:=false;
  DataModule1.ADOQuery_Supplier.Close;
  DataModule1.ADOQuery_Supplier.SQL.Clear;
  DataModule1.ADOQuery_Supplier.SQL.Text:='select*from supplier_';
  DataModule1.ADOQuery_Supplier.Active:=true;
 end;
     id_supplier.Text:= 'ID-'
     +IntToStr(DataModule1.ADOQuery_Supplier.RecordCount+1);
     grp_input.Enabled:=True;
     grp_up.Enabled:=False;

  except
  ShowMessage('Gagal Disimpan');
  end;
end;

procedure TSupplier_form.btn_updateClick(Sender: TObject);
var a,b,c : string;
begin
  //   ============== Kondisi Ga Lengkap =====
search.Enabled:=True;
a:=nama.Text;
b:=alamat.Text;
c:=no_hp.Text;
   if (a='')
   and (b='')
   and (c='')
   //+ (no_telp.Text:='')
   then
    begin
    ShowMessage('Lengkapi Data');
    end
   else

         //   ============== UPDATE =====
 try DataModule1.con1.BeginTrans;
 with DataModule1.ADOQuery_Supplier do
  begin
  Active:=false;
  Close;
  SQL.Clear;
  SQL.Text:='update supplier_ set nama_supplier='+QuotedStr(nama.Text)+
  ',alamat='+QuotedStr(alamat.Text)+
  ',no_hp='+QuotedStr(no_hp.Text)+
  'where id_supplier='+QuotedStr(id_supplier.Text);
  ExecSQL;
  end;
  DataModule1.con1.CommitTrans;
  ShowMessage('berhasil diupdate');
  //   ============== Kondisi Bersih Setelah UPDATE =====
  id_supplier.Clear;
  nama.Clear;
  alamat.Clear;
  tglRegis.Date:= Now;
  no_hp.Clear;

  dbgrd_supplier.DataSource:=DataModule1.ds_supplier;
  DataModule1.ds_supplier.DataSet:=DataModule1.ADOTable_Supplier;
  DataModule1.ADOTable_Supplier.Connection:=DataModule1.con1;
  DataModule1.ADOTable_Supplier.Active:=false;
  DataModule1.ADOTable_Supplier.Close;
  DataModule1.ADOTable_Supplier.TableName:='supplier_';
  DataModule1.ADOTable_Supplier.Active:=true;

  DataModule1.ds_member.DataSet:=DataModule1.ADOQuery_Member;
  DataModule1.ADOQuery_Supplier.Connection:=DataModule1.con1;
 begin
  DataModule1.ADOQuery_Supplier.Active:=false;
  DataModule1.ADOQuery_Supplier.Close;
  DataModule1.ADOQuery_Supplier.SQL.Clear;
  DataModule1.ADOQuery_Supplier.SQL.Text:='select*from supplier_';
  DataModule1.ADOQuery_Supplier.Active:=true;
 end;

  except
  DataModule1.con1.RollbackTrans;
  ShowMessage('gagal update');
  end;


end;

procedure TSupplier_form.btn_deleteClick(Sender: TObject);
begin
  //   ============== DELETE =====
  try DataModule1.con1.BeginTrans;
    with DataModule1.ADOQuery_Supplier do
    begin
    Active:=false;
    Close;
    SQL.Clear;
    SQL.Text:='delete from supplier_ where id_supplier='+QuotedStr(id_supplier.Text);
    ExecSQL;
    end;
    DataModule1.con1.CommitTrans;
    ShowMessage('berhasil dihapus');
      //   ============== Kondisi Clear setelah HAPUS =====
    id_supplier.Clear;
    nama.Clear;
    alamat.Clear;
    tglRegis.Date := Now;
    no_hp.Clear;
    dbgrd_supplier.DataSource:=DataModule1.ds_supplier;
    DataModule1.ds_supplier.DataSet:=DataModule1.ADOTable_Supplier;
    DataModule1.ADOTable_Supplier.Connection:=DataModule1.con1;
    DataModule1.ADOTable_Supplier.Active:=false;
    DataModule1.ADOTable_Supplier.Close;
    DataModule1.ADOTable_Supplier.TableName:='supplier_';
    DataModule1.ADOTable_Supplier.Active:=true;

    DataModule1.ds_supplier.DataSet:=DataModule1.ADOQuery_Supplier;
    DataModule1.ADOQuery_Supplier.Connection:=DataModule1.con1;
 begin
  DataModule1.ADOQuery_Supplier.Active:=false;
  DataModule1.ADOQuery_Supplier.Close;
  DataModule1.ADOQuery_Supplier.SQL.Clear;
  DataModule1.ADOQuery_Supplier.SQL.Text:='select*from supplier_';
  DataModule1.ADOQuery_Supplier.Active:=true;
 end;

 except
  DataModule1.con1.RollbackTrans;
  ShowMessage('gagal dihapus');
 end;
end;

procedure TSupplier_form.rb_kiriClick(Sender: TObject);
begin
  //=================== Membuat Auto id_supplier =========
  id_supplier.Text:= 'ID-'
  +IntToStr(DataModule1.ADOQuery_Supplier.RecordCount+1);
  grp_input.Enabled:=True;
  grp_up.Enabled:=False;
  nama.Clear;
  alamat.Clear;
  no_hp.Clear;
end;

procedure TSupplier_form.rb_kananClick(Sender: TObject);
begin
  //   ============== Kondisi RADIO Groub =====
grp_input.Enabled:=False;
grp_up.Enabled:=True;

       //   ============== Kondisi EDIT Teks Bersih =====
  id_supplier.Clear;
  nama.Clear;
  alamat.Clear;
  tglRegis.Date;
  no_hp.Clear

end;

procedure TSupplier_form.cbb_berdasarkanChange(Sender: TObject);
begin
 searchChange(Sender);
  search.Enabled:=True;
  search.Clear;
 search.SetFocus;
end;

procedure TSupplier_form.searchChange(Sender: TObject);
var a:String;
begin
  dbgrd_supplier.DataSource:=DataModule1.ds_supplier;
 case cbb_berdasarkan.ItemIndex of
  0:a:='id_supplier'; //Sesuai dengan field tabel anda
  1:a:='nama_supplier'; //Sesuai dengan field tabel anda
  2:a:='alamat'; //Sesuai dengan field tabel anda
  3:a:='tgl_regis'; //Sesuai dengan field tabel anda
  4:a:='no_hp';
  end;

 if (search.Text<>'') and (cbb_berdasarkan.Text<>'') then
  begin
  DataModule1.ADOQuery_Supplier.SQL.Clear;
  DataModule1.ADOQuery_Supplier.SQL.Text:='select * from supplier_ where '+a+' like' + QuotedStr('%'+search.Text+'%');
  DataModule1.ADOQuery_Supplier.Active:=True;
  end
 else

  begin
    DataModule1.ADOQuery_Supplier.Close;
    DataModule1.ADOQuery_Supplier.SQL.Clear;
    DataModule1.ADOQuery_Supplier.SQL.Add('select * from supplier_');
    DataModule1.ADOQuery_Supplier.Open;
  end;
end;


procedure TSupplier_form.FormShow(Sender: TObject);
begin
  dbgrd_supplier.DataSource:=DataModule1.ds_supplier;
  DataModule1.ds_supplier.DataSet:=DataModule1.ADOTable_Supplier;
  DataModule1.ADOTable_Supplier.Connection:=DataModule1.con1;
  DataModule1.ADOTable_Supplier.Active:=false;
  DataModule1.ADOTable_Supplier.Close;
  DataModule1.ADOTable_Supplier.TableName:='supplier_';
  DataModule1.ADOTable_Supplier.Active:=true;
  //========= Refresh
  DataModule1.ds_supplier.DataSet:=DataModule1.ADOQuery_Supplier;
  DataModule1.ADOQuery_Supplier.Connection:=DataModule1.con1;
   begin
    DataModule1.ADOQuery_Transaksi.Active:=false;
    DataModule1.ADOQuery_Transaksi.Close;
    DataModule1.ADOQuery_Transaksi.SQL.Clear;
    DataModule1.ADOQuery_Transaksi.SQL.Text:='select*from transaksi_';
    DataModule1.ADOQuery_Transaksi.Active:=true;
   end;
end;

procedure TSupplier_form.CetakClick(Sender: TObject);
begin
  DataModule1.ADOQuery_Supplier.SQL.Clear;
  DataModule1.ADOQuery_Supplier.SQL.Add('SELECT * FROM supplier_ ');
  DataModule1.ADOQuery_Supplier.Active:=true;
  QRSuplier.Preview;
  DataModule1.ADOQuery_Supplier.SQL.Clear;
  DataModule1.ADOQuery_Supplier.SQL.Add('select * from supplier_ ');
  DataModule1.ADOQuery_Supplier.Active:=true;
end;

procedure TSupplier_form.namaClick(Sender: TObject);
begin
nama.SetFocus;
end;

procedure TSupplier_form.alamatClick(Sender: TObject);
begin
alamat.SetFocus;
end;

procedure TSupplier_form.no_hpClick(Sender: TObject);
begin
no_hp.SetFocus;
end;

procedure TSupplier_form.btn_tampilDataClick(Sender: TObject);
begin
  rb_kanan.Checked:=True;
  id_supplier.Text:=DataModule1.ADOQuery_Supplier.FieldValues['id_supplier'];
  nama.Text:=DataModule1.ADOQuery_Supplier.FieldValues['nama_supplier'];
  //jen_kel.Text:=DataModule1.ADOQuery1.FieldValues['jenis_kelamin'];
 //tglRegis.Date:=DataModule1.ADOQuery_Member.FieldValues['tgl_regis'];
  alamat.Text:=DataModule1.ADOQuery_Supplier.FieldValues['alamat'];
  no_hp.Text:=DataModule1.ADOQuery_Supplier.FieldValues['no_hp'];
end;

end.
