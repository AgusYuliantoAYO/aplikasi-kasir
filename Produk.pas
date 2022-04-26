unit Produk;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, DBGrids, Mask, DBCtrls, Buttons, ComCtrls,
  ExtCtrls;

type
  TProduk_form = class(TForm)
    grp1: TGroupBox;
    lbl2: TLabel;
    lbl3: TLabel;
    grp2: TGroupBox;
    lbl6: TLabel;
    dbgrid_produk: TDBGrid;
    btn_tampilData: TBitBtn;
    cbb_berdasarkan: TComboBox;
    search: TEdit;
    Label1: TLabel;
    grp3: TGroupBox;
    lbl8: TLabel;
    lbl9: TLabel;
    cbb_jenisProduk: TComboBox;
    cbb_satuan: TComboBox;
    lbl_nama: TLabel;
    kd_produk: TEdit;
    nama: TEdit;
    harga: TEdit;
    grp_rb: TGroupBox;
    rb_kanan: TRadioButton;
    grp_input: TGroupBox;
    grp_up: TGroupBox;
    btn_edit: TBitBtn;
    btn_hapus: TBitBtn;
    btn_add: TBitBtn;
    btn_simpan: TBitBtn;
    rb_kiri: TRadioButton;
    tgl_masukDataProduk: TDateTimePicker;
    Label2: TLabel;
    StokNol: TEdit;
    Label3: TLabel;
    img1: TImage;
    nl: TPanel;
    procedure cbb_jenisProdukChange(Sender: TObject);
    procedure btn_simpanClick(Sender: TObject);
    procedure dbgrid_produkCellClick(Column: TColumn);
    procedure btn_editClick(Sender: TObject);
    procedure btn_addClick(Sender: TObject);
    procedure rb_kiriClick(Sender: TObject);
    procedure rb_kananClick(Sender: TObject);
    procedure cbb_berdasarkanChange(Sender: TObject);
    procedure searchChange(Sender: TObject);
    procedure btn_tampilDataClick(Sender: TObject);
    procedure btn_hapusClick(Sender: TObject);
    procedure kd_produkChange(Sender: TObject);
    procedure stokChange(Sender: TObject);
    procedure kd_produkClick(Sender: TObject);
    procedure namaClick(Sender: TObject);
    procedure hargaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Produk_form: TProduk_form;

implementation
 uses DM,Transaksi;
{$R *.dfm}

procedure TProduk_form.cbb_jenisProdukChange(Sender: TObject);
begin
  StokNol.Text:='0';
  rb_kiri.Checked:=False;
 DataModule1.ADOQuery_Satuan.First;
 While not DataModule1.ADOQuery_Satuan.Eof do

 if cbb_jenisProduk.ItemIndex=1 then
  begin
    kd_produk.Text:= 'OBT-'
    +IntToStr(DataModule1.ADOQuery_JenisProduk.RecordCount+3);
  cbb_satuan.Items.Add(DataModule1.ADOQuery_Satuan['obat']);
    DataModule1.ADOQuery_Satuan.Next;
  end
  else if cbb_jenisProduk.ItemIndex=0 then
  begin
     kd_produk.Text:= 'AK-'
    +IntToStr(DataModule1.ADOQuery_JenisProduk.RecordCount+3);
    cbb_satuan.Items.Add(DataModule1.ADOQuery_Satuan['alat']);
    DataModule1.ADOQuery_Satuan.Next;
  end;

   cbb_jenisProduk.Enabled:=True;
    nama.Enabled:=True;
    cbb_satuan.Enabled:=True;
    harga.Enabled:=True;
    cbb_jenisProduk.Enabled:=False;
end;

procedure TProduk_form.btn_simpanClick(Sender: TObject);
var a, stokNolll: string;
begin
a:=harga.Text;

   if (a='')
  then
    begin
    ShowMessage('Lengkapi Data');
    end
   else
 try
  DataModule1.ADOQuery_JenisProduk.Connection:=DataModule1.con1;
  with DataModule1.ADOQuery_JenisProduk do
   begin
  Active:=false;
  Close;
  SQL.Clear;
  SQL.Text:='insert into jenis_produk values('+QuotedStr(kd_produk.Text)+','+
  QuotedStr(cbb_jenisProduk.Text)+','+
  QuotedStr(nama.Text)+','+
  QuotedStr(FormatDateTime('yyyy-mm-dd',tgl_masukDataProduk.Date))+','+
  QuotedStr(cbb_satuan.Text)+','+
  QuotedStr(harga.Text)+','+
  QuotedStr(StokNol.Text)+')';
  ExecSQL;
  end;
    ShowMessage('Berhasil Disimpan');

    cbb_jenisProduk.ItemIndex:=-1;
    kd_produk.Clear;
    nama.Clear;
    cbb_satuan.Clear;
    harga.Clear;
    lbl_nama.Caption:='';

    dbgrid_produk.DataSource:=DataModule1.ds_JenisProduk;
    DataModule1.ds_JenisProduk.DataSet:=DataModule1.ADOTable_Produk;
    DataModule1.ADOTable_JenisProduk.Connection:=DataModule1.con1;
    DataModule1.ADOTable_JenisProduk.Active:=false;
    DataModule1.ADOTable_JenisProduk.Close;
    DataModule1.ADOTable_JenisProduk.TableName:='jenis_produk';
    DataModule1.ADOTable_JenisProduk.Active:=true;

    DataModule1.ds_JenisProduk.DataSet:=DataModule1.ADOQuery_JenisProduk;
    DataModule1.ADOQuery_JenisProduk.Connection:=DataModule1.con1;
   begin
    DataModule1.ADOQuery_JenisProduk.Active:=false;
    DataModule1.ADOQuery_JenisProduk.Close;
    DataModule1.ADOQuery_JenisProduk.SQL.Clear;
    DataModule1.ADOQuery_JenisProduk.SQL.Text:='select*from jenis_produk';
    DataModule1.ADOQuery_JenisProduk.Active:=true;
   end;

    except
    ShowMessage('Gagal Disimpan');
    end;

end;

procedure TProduk_form.dbgrid_produkCellClick(Column: TColumn);
begin
   btn_tampilData.Enabled:=True;
end;

procedure TProduk_form.btn_editClick(Sender: TObject);
var a,b,hasil: Integer;
var s : String;
begin
cbb_jenisProduk.Enabled:=True;
 try DataModule1.con1.BeginTrans;
 with DataModule1.ADOQuery_JenisProduk do
  begin
  Active:=false;
  Close;
  SQL.Clear;
  SQL.Text:='update jenis_produk set nama_produk='+QuotedStr(nama.Text)+
  ',jenis_produk='+QuotedStr(cbb_jenisProduk.Text)+
  ',satuan='+QuotedStr(cbb_satuan.Text)+
  ',harga_jual='+QuotedStr(harga.Text)+
  'where kd_produk='+QuotedStr(kd_produk.Text);
  ExecSQL;
  end;

  DataModule1.con1.CommitTrans;
  ShowMessage('berhasil diupdate');

    cbb_jenisProduk.Enabled:=False;
    kd_produk.Enabled:=False;
    nama.Enabled:=False;
    cbb_satuan.Enabled:=False;
    harga.Enabled:=False;

  dbgrid_produk.DataSource:=DataModule1.ds_JenisProduk;
  DataModule1.ds_JenisProduk.DataSet:=DataModule1.ADOTable_JenisProduk;
  DataModule1.ADOTable_JenisProduk.Connection:=DataModule1.con1;
  DataModule1.ADOTable_JenisProduk.Active:=false;
  DataModule1.ADOTable_JenisProduk.Close;
  DataModule1.ADOTable_JenisProduk.TableName:='jenis_produk';
  DataModule1.ADOTable_JenisProduk.Active:=true;

  DataModule1.ds_JenisProduk.DataSet:=DataModule1.ADOQuery_JenisProduk;
  DataModule1.ADOQuery_JenisProduk.Connection:=DataModule1.con1;
 begin
  DataModule1.ADOQuery_JenisProduk.Active:=false;
  DataModule1.ADOQuery_JenisProduk.Close;
  DataModule1.ADOQuery_JenisProduk.SQL.Clear;
  DataModule1.ADOQuery_JenisProduk.SQL.Text:='select*from jenis_produk';
  DataModule1.ADOQuery_JenisProduk.Active:=true;
 end;

  except
  DataModule1.con1.RollbackTrans;
  ShowMessage('gagal update');
  end;


end;

procedure TProduk_form.btn_addClick(Sender: TObject);
begin
   rb_kiri.Checked:=False;
   cbb_jenisProduk.Enabled:=True;
   rb_kanan.Checked:=False;
    kd_produk.Clear;
    nama.Clear;
    kd_produk.Clear;
    nama.Clear;
    cbb_satuan.ItemIndex := 100;
    cbb_jenisProduk.Text := '---pilih---';
    harga.Clear;

    cbb_jenisProduk.Enabled:=False;
    kd_produk.Enabled:=False;
    nama.Enabled:=False;
    cbb_satuan.Enabled:=False;
    harga.Enabled:=False;
end;

procedure TProduk_form.rb_kiriClick(Sender: TObject);
begin
        cbb_jenisProduk.Enabled:=True;
        btn_simpan.Enabled:=True;
        grp_input.Enabled:=True;
end;

procedure TProduk_form.rb_kananClick(Sender: TObject);
begin
grp_input.Enabled:=False;
grp_up.Enabled:=True;
end;

procedure TProduk_form.cbb_berdasarkanChange(Sender: TObject);
begin
searchChange(Sender);
  search.Enabled:=True;
  search.Clear;
 search.SetFocus;
end;

procedure TProduk_form.searchChange(Sender: TObject);
var a:String;
begin
  dbgrid_produk.DataSource:=DataModule1.ds_JenisProduk;
 case cbb_berdasarkan.ItemIndex of
  0:a:='kd_produk';
  1:a:='nama_produk';
  2:a:='tgl_masuk';
  3:a:='satuan';
  end;

 if (search.Text<>'') and (cbb_berdasarkan.Text<>'') then
  begin
  DataModule1.ADOQuery_JenisProduk.SQL.Clear;
  DataModule1.ADOQuery_JenisProduk.SQL.Text:='select * from jenis_produk where '+a+' like' + QuotedStr('%'+search.Text+'%');
  DataModule1.ADOQuery_JenisProduk.Active:=True;
  end
 else

  begin
    DataModule1.ADOQuery_JenisProduk.Close;
    DataModule1.ADOQuery_JenisProduk.SQL.Clear;
    DataModule1.ADOQuery_JenisProduk.SQL.Add('select * from jenis_produk');
    DataModule1.ADOQuery_JenisProduk.Open;
  end;
end;


procedure TProduk_form.btn_tampilDataClick(Sender: TObject);
var jika : Integer;
 begin
   rb_kanan.Checked:=True;
  kd_produk.Text:=DataModule1.ADOQuery_JenisProduk.FieldValues['kd_produk'];
  nama.Text:=DataModule1.ADOQuery_JenisProduk.FieldValues['nama_produk'];
  cbb_jenisProduk.Text:=DataModule1.ADOQuery_JenisProduk.FieldValues['jenis_produk'];
  cbb_satuan.Text:=DataModule1.ADOQuery_JenisProduk.FieldValues['satuan'];
  harga.Text:=DataModule1.ADOQuery_JenisProduk.FieldValues['harga_jual'];
     cbb_jenisProduk.Enabled:=True;
   nama.Enabled:=True;
   harga.Enabled:=True;
    kd_produk.Enabled:=False;
    cbb_satuan.Enabled:= False;
 end;

procedure TProduk_form.btn_hapusClick(Sender: TObject);
begin
  try DataModule1.con1.BeginTrans;
    with DataModule1.ADOQuery_Produk do
    begin
    Active:=false;
    Close;
    SQL.Clear;
    SQL.Text:='delete from produk_stk where kd_produk='+QuotedStr(kd_produk.Text);
    ExecSQL;
    end;
    DataModule1.con1.CommitTrans;
    ShowMessage('berhasil dihapus');
    cbb_jenisProduk.Text:='---Pilih---';
    kd_produk.Clear;
    kd_produk.Clear;
    nama.Clear;
    cbb_satuan.Text:='---Pilih---';
    harga.Clear;

    dbgrid_produk.DataSource:=DataModule1.ds_produk;
    DataModule1.ds_produk.DataSet:=DataModule1.ADOTable_Produk;
    DataModule1.ADOTable_Produk.Connection:=DataModule1.con1;
    DataModule1.ADOTable_Produk.Active:=false;
    DataModule1.ADOTable_Produk.Close;
    DataModule1.ADOTable_Produk.TableName:='produk_stk';
    DataModule1.ADOTable_Produk.Active:=true;

    DataModule1.ds_produk.DataSet:=DataModule1.ADOQuery_Produk;
    DataModule1.ADOQuery_Produk.Connection:=DataModule1.con1;
 begin
  DataModule1.ADOQuery_Produk.Active:=false;
  DataModule1.ADOQuery_Produk.Close;
  DataModule1.ADOQuery_Produk.SQL.Clear;
  DataModule1.ADOQuery_Produk.SQL.Text:='select*from produk_stk';
  DataModule1.ADOQuery_Produk.Active:=true;
 end;

 except
  DataModule1.con1.RollbackTrans;
  ShowMessage('gagal dihapus');
 end;

end;

procedure TProduk_form.kd_produkChange(Sender: TObject);
begin
 if kd_produk.Text='' then
     btn_hapus.Enabled:=false
    else
     btn_hapus.Enabled:=True;

end;

procedure TProduk_form.stokChange(Sender: TObject);
begin
grp_up.Enabled:=True;
end;

procedure TProduk_form.kd_produkClick(Sender: TObject);
begin
kd_produk.SetFocus;
end;

procedure TProduk_form.namaClick(Sender: TObject);
begin
nama.SetFocus;
end;

procedure TProduk_form.hargaClick(Sender: TObject);
begin
harga.SetFocus;
end;

procedure TProduk_form.FormShow(Sender: TObject);
begin
dbgrid_produk.DataSource:=DataModule1.ds_JenisProduk;
dbgrid_produk.Enabled:=True;
tgl_masukDataProduk.DateTime:=Now;



  dbgrid_produk.DataSource:=DataModule1.ds_JenisProduk;
  DataModule1.ds_JenisProduk.DataSet:=DataModule1.ADOTable_JenisProduk;
  DataModule1.ADOTable_JenisProduk.Connection:=DataModule1.con1;
  DataModule1.ADOTable_JenisProduk.Active:=false;
  DataModule1.ADOTable_JenisProduk.Close;
  DataModule1.ADOTable_JenisProduk.TableName:='jenis_produk';
  DataModule1.ADOTable_JenisProduk.Active:=true;
  //========= Refresh
  DataModule1.ds_JenisProduk.DataSet:=DataModule1.ADOQuery_JenisProduk;
  DataModule1.ADOQuery_JenisProduk.Connection:=DataModule1.con1;
   begin
    DataModule1.ADOQuery_JenisProduk.Active:=false;
    DataModule1.ADOQuery_JenisProduk.Close;
    DataModule1.ADOQuery_JenisProduk.SQL.Clear;
    DataModule1.ADOQuery_JenisProduk.SQL.Text:='select*from jenis_produk';
    DataModule1.ADOQuery_JenisProduk.Active:=true;
   end;

end;

end.
