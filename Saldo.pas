unit Saldo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, StdCtrls, Buttons;

type
  TSaldo_Form = class(TForm)
    dbgrd_saldo: TDBGrid;
    btn_: TBitBtn;
    Cetak: TBitBtn;
    Saldo: TLabel;
    procedure btn_Click(Sender: TObject);
    procedure CetakClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Saldo_Form: TSaldo_Form;

implementation
uses DM,QRStokBarang, Login_, Laporan;

{$R *.dfm}

procedure TSaldo_Form.btn_Click(Sender: TObject);
begin
dbgrd_saldo.DataSource:=DataModule1.ds_produk;
  DataModule1.ds_produk.DataSet:=DataModule1.ADOTable_Produk;
  DataModule1.ADOTable_Produk.Connection:=DataModule1.con1;
  DataModule1.ADOTable_Produk.Active:=false;
  DataModule1.ADOTable_Produk.Close;
  DataModule1.ADOTable_Produk.TableName:='produk_stk';
  DataModule1.ADOTable_Produk.Active:=true;
  //========= Refresh
  DataModule1.ds_produk.DataSet:=DataModule1.ADOQuery_Produk;
  DataModule1.ADOQuery_Produk.Connection:=DataModule1.con1;
   begin
    DataModule1.ADOQuery_Produk.Active:=false;
    DataModule1.ADOQuery_Produk.Close;
    DataModule1.ADOQuery_Produk.SQL.Clear;
    DataModule1.ADOQuery_Produk.SQL.Text:='select*from produk_stk';
    DataModule1.ADOQuery_Produk.Active:=true;
   end;
end;

procedure TSaldo_Form.CetakClick(Sender: TObject);
begin
DataModule1.ADOQuery_Produk.SQL.Clear;
DataModule1.ADOQuery_Produk.SQL.Add('SELECT * FROM produk_stk ');//ORDER BY kd_transaksi asc');
DataModule1.ADOQuery_Produk.Active:=true;
QRStok.Preview;
DataModule1.ADOQuery_Produk.SQL.Clear;
DataModule1.ADOQuery_Produk.SQL.Add('select * from produk_stk ');
DataModule1.ADOQuery_Produk.Active:=true;
end;

end.
