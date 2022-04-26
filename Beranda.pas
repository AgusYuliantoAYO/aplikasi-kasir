unit Beranda;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, frxpngimage, jpeg, Buttons;

type
  TBeranda_form = class(TForm)
    Panel_SideBar: TPanel;
    Panel1: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    GroupBox1: TGroupBox;
    pnl1: TPanel;
    edt_info: TEdit;
    grp_owner: TGroupBox;
    edt_passINFO: TEdit;
    pnl_Halaman: TPanel;
    img1: TImage;
    Profil: TLabel;
    lbl2: TLabel;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Transaksi: TBitBtn;
    Penjualan: TBitBtn;
    Member: TBitBtn;
    btnSupplier: TBitBtn;
    btnPembelian: TBitBtn;
    btnSaldo: TBitBtn;
    btnLaporan: TBitBtn;
    btnProduk: TBitBtn;
    btnStaff: TBitBtn;
    btnKeluar: TBitBtn;
    btnTentang: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure edt_infoChange(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure btn2Click(Sender: TObject);
    procedure btnMemberClick(Sender: TObject);
    procedure btnSupplierClick(Sender: TObject);
    procedure btnPembelianClick(Sender: TObject);
    procedure btnSaldoClick(Sender: TObject);
    procedure btnLaporanClick(Sender: TObject);
    procedure btnProdukClick(Sender: TObject);
    procedure btnStaffClick(Sender: TObject);
    procedure btnKeluarClick(Sender: TObject);
    procedure btnTentangClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Beranda_form: TBeranda_form;

implementation

uses Transaksi, Supplier, Laporan, Login_,Saldo ,penjualan, Member,Pembelian, Produk,
  Karyawan, DM;

{$R *.dfm}

procedure TBeranda_form.FormCreate(Sender: TObject);
begin
   Login_form_.edt_nama:=Beranda_form.edt_info;
    Login_form_.edt_nama.Visible:=true;
    edt_info.Enabled:=False;
    edt_passINFO.Enabled:=False;
end;

procedure TBeranda_form.edt_infoChange(Sender: TObject);
begin
with DataModule1.ADOQuery_karyawan do
    begin
      Active:=False;
      SQL.Clear;
      SQL.Text:='select * from karyawan where nama='+QuotedStr(edt_info.Text);
      Active:=True;
      edt_passINFO.Text:=(DataModule1.ADOQuery_karyawan.FieldByName('id_karyawan').AsString);
    end;
     if edt_info.Text<>'Basri S. Farm., Apt.' then
    grp_owner.Enabled:=False
    else if edt_info.Text = 'Basri S. Farm., Apt.' then
    grp_owner.Enabled:=True;
end;

procedure TBeranda_form.btn1Click(Sender: TObject);
begin
Transaksi_form.Parent:=Beranda_form.pnl_Halaman;
Member_form.Close; Supplier_form.Close; Produk_form.Close; Laporan_form.Close;
Pembelian_produk.Close;Saldo_Form.Close;Penjualan_form.Close;Karyawan_form.Close;
Transaksi_form.Visible:=true;
end;

procedure TBeranda_form.btn2Click(Sender: TObject);
begin
  Penjualan_form.Parent:=Beranda_form.pnl_Halaman;
  Transaksi_form.Close;Member_form.Close;
  Supplier_form.Close;Produk_form.Close;Laporan_form.Close;Pembelian_produk.Close;
  Saldo_Form.Close;Karyawan_form.Close;Penjualan_form.Visible:=True;
end;

procedure TBeranda_form.btnMemberClick(Sender: TObject);
begin
Member_form.Parent:=Beranda_form.pnl_Halaman;
Supplier_form.Close;Produk_form.Close;Laporan_form.Close;
Pembelian_produk.Close;Saldo_Form.Close;Penjualan_form.Close;Karyawan_form.Close;
Transaksi_form.Close;Member_form.Visible:=true;
end;

procedure TBeranda_form.btnSupplierClick(Sender: TObject);
begin
Supplier_form.Parent:=Beranda_form.pnl_Halaman;
Member_form.Close;Produk_form.Close;Laporan_form.Close;
Pembelian_produk.Close;Saldo_Form.Close;Penjualan_form.Close;Karyawan_form.Close;
Transaksi_form.Close;Supplier_form.Visible:=true;
end;

procedure TBeranda_form.btnPembelianClick(Sender: TObject);
begin
Pembelian_produk.Parent:=Beranda_form.pnl_Halaman;
Member_form.Close;Supplier_form.Close;Produk_form.Close;
Laporan_form.Close;Saldo_Form.Close;Penjualan_form.Close;Karyawan_form.Close;
Transaksi_form.Close;Pembelian_produk.Visible:=true;
end;

procedure TBeranda_form.btnSaldoClick(Sender: TObject);
begin
Saldo_Form.Parent:=Beranda_form.pnl_Halaman;
Member_form.Close;Supplier_form.Close;Produk_form.Close;
Laporan_form.Close;Pembelian_produk.Close;Penjualan_form.Close;Karyawan_form.Close;
Transaksi_form.Close;Saldo_Form.Visible:=true;
end;

procedure TBeranda_form.btnLaporanClick(Sender: TObject);
begin
Laporan_form.Parent:=Beranda_form.pnl_Halaman;
Member_form.Close;Supplier_form.Close;Produk_form.Close;
Pembelian_produk.Close;Saldo_Form.Close;Penjualan_form.Close;Karyawan_form.Close;
Transaksi_form.Close;Laporan_form.Visible:=true;
end;

procedure TBeranda_form.btnProdukClick(Sender: TObject);
begin
Produk_form.Parent:=Beranda_form.pnl_Halaman;
Member_form.Close;Supplier_form.Close;Laporan_form.Close;
Pembelian_produk.Close;Saldo_Form.Close;Penjualan_form.Close;Karyawan_form.Close;
Transaksi_form.Close;Produk_form.Visible:=true;
end;

procedure TBeranda_form.btnStaffClick(Sender: TObject);
begin
Karyawan_Form.Parent:=Beranda_form.pnl_Halaman;
Member_form.Close;Supplier_form.Close;Produk_form.Close;
Laporan_form.Close;Pembelian_produk.Close;Saldo_Form.Close;Penjualan_form.Close;
Transaksi_form.Close;Karyawan_Form.Visible:=true;
end;

procedure TBeranda_form.btnKeluarClick(Sender: TObject);
begin
Member_form.Close;Supplier_form.Close;Produk_form.Close;Laporan_form.Close;Pembelian_produk.Close;
Saldo_Form.Close;Penjualan_form.Close;Karyawan_form.Close;Transaksi_form.Close;
Beranda_form.Hide;Login_form_.Show;
end;

procedure TBeranda_form.btnTentangClick(Sender: TObject);
begin
Member_form.Close;Supplier_form.Close;Produk_form.Close;Laporan_form.Close;Pembelian_produk.Close;
Saldo_Form.Close;Penjualan_form.Close;Karyawan_form.Close;Transaksi_form.Close;
end;

end.
