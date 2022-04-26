unit DM;

interface

uses
  SysUtils, Classes, DB, ADODB, MemDS, VirtualTable;

type
  TDataModule1 = class(TDataModule)
    con1: TADOConnection;
    ADOTable_Produk: TADOTable;
    ds_produk: TDataSource;
    ADOTable_Member: TADOTable;
    ds_member: TDataSource;
    ADOTable_Supplier: TADOTable;
    ds_supplier: TDataSource;
    ds_transaksi: TDataSource;
    ADOTable_Transaksi: TADOTable;
    ADOQuery_Produk: TADOQuery;
    ADOQuery_Member: TADOQuery;
    ADOQuery_Supplier: TADOQuery;
    ADOQuery_Satuan: TADOQuery;
    ADOQuery_det_Transaksi: TADOQuery;
    ds_det_Transaksi: TDataSource;
    ADOQuery_Transaksi: TADOQuery;
    ADOTable_JenisProduk: TADOTable;
    ds_JenisProduk: TDataSource;
    ADOQuery_JenisProduk: TADOQuery;
    ds_det_Produk_stk: TDataSource;
    ADOQuery_det_Produk: TADOQuery;
    ADOTable_Karyawan: TADOTable;
    ds_karyawan: TDataSource;
    ADOQuery_karyawan: TADOQuery;
    ADOTable_det_produk: TADOTable;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DataModule1: TDataModule1;

implementation

{$R *.dfm}

end.
