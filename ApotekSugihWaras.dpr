program ApotekSugihWaras;

uses
  Forms,
  Supplier in 'Supplier.pas' {Supplier_form},
  Produk in 'Produk.pas' {Produk_form},
  Transaksi in 'Transaksi.pas' {Transaksi_form},
  Laporan in 'Laporan.pas' {Laporan_form},
  DM in 'DM.pas' {DataModule1: TDataModule},
  Beranda in 'Beranda.pas' {Beranda_form},
  Member in 'Member.pas' {Member_form},
  Cetak in 'Cetak.pas' {QckReport1: TQuickRep},
  Pembelian in 'Pembelian.pas' {Pembelian_produk},
  Saldo in 'Saldo.pas' {Saldo_Form},
  Penjualan in 'Penjualan.pas' {Penjualan_form},
  Karyawan in 'Karyawan.pas' {Karyawan_Form},
  Login_ in 'Login_.pas' {Login_form_},
  QRptPenjualan in 'QRptPenjualan.pas' {QuickReportPenjualan: TQuickRep},
  QRMember in 'QRMember.pas' {QuickR_MEMBER: TQuickRep},
  QRSupplier in 'QRSupplier.pas' {QRSuplier: TQuickRep},
  QRStokBarang in 'QRStokBarang.pas' {QRStok: TQuickRep};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TLogin_form_, Login_form_);
  Application.CreateForm(TSupplier_form, Supplier_form);
  Application.CreateForm(TProduk_form, Produk_form);
  Application.CreateForm(TTransaksi_form, Transaksi_form);
  Application.CreateForm(TDataModule1, DataModule1);
  Application.CreateForm(TBeranda_form, Beranda_form);
  Application.CreateForm(TMember_form, Member_form);
  Application.CreateForm(TQckReport1, QckReport1);
  Application.CreateForm(TPembelian_produk, Pembelian_produk);
  Application.CreateForm(TSaldo_Form, Saldo_Form);
  Application.CreateForm(TPenjualan_form, Penjualan_form);
  Application.CreateForm(TKaryawan_Form, Karyawan_Form);
  Application.CreateForm(TLaporan_form, Laporan_form);
  Application.CreateForm(TQuickReportPenjualan, QuickReportPenjualan);
  Application.CreateForm(TQuickR_MEMBER, QuickR_MEMBER);
  Application.CreateForm(TQRSuplier, QRSuplier);
  Application.CreateForm(TQRStok, QRStok);
  Application.Run;
end.
