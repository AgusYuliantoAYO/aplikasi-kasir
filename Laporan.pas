unit Laporan;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls, Grids, DBGrids, frxClass, frxDBSet,
  ExtCtrls;

type
  TLaporan_form = class(TForm)
    grp_Laporan: TGroupBox;
    dbgrd_LapPembelian: TDBGrid;
    Update: TBitBtn;
    cbb_bln: TComboBox;
    edt_tahun: TEdit;
    GroupBox1: TGroupBox;
    BitBtn1: TBitBtn;
    RadioButton1: TRadioButton;
    LaporanPenjualan: TGroupBox;
    dariTGL: TDateTimePicker;
    sampaiTGL: TDateTimePicker;
    btn_cetaak: TBitBtn;
    PerBulan: TRadioButton;
    PerTanggal: TRadioButton;
    TAMPILCetak: TBitBtn;
    tahundari: TEdit;
    search: TEdit;
    cbb_berdasarkan: TComboBox;
    lbl9: TLabel;
    img1: TImage;
    procedure btn_tampilClick(Sender: TObject);
    procedure rb_lap_tanggalClick(Sender: TObject);
    procedure UpdateClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edt_tahunClick(Sender: TObject);
    procedure cbb_blnChange(Sender: TObject);
    procedure edt_tahunChange(Sender: TObject);
    procedure btn_cetaakClick(Sender: TObject);
    procedure PerBulanClick(Sender: TObject);
    procedure PerTanggalClick(Sender: TObject);
    procedure TAMPILCetakClick(Sender: TObject);
    procedure tahundariClick(Sender: TObject);
    procedure cbb_berdasarkanChange(Sender: TObject);
    procedure searchChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Laporan_form: TLaporan_form;

implementation
 uses DM,cetak, DateUtils, Login_;
{$R *.dfm}

procedure TLaporan_form.btn_tampilClick(Sender: TObject);
var a:string;
    thn :Integer;
begin
DataModule1.ADOQuery_det_Produk.SQL.Clear;
DataModule1.ADOQuery_det_Produk.SQL.Add('SELECT * FROM detail_produk_stk where year (tanggal_beli) ='+QuotedStr(tahundari.Text)+'');
DataModule1.ADOQuery_det_Produk.Active:=true;
QckReport1.Preview;
DataModule1.ADOQuery_det_Produk.SQL.Clear;
DataModule1.ADOQuery_det_Produk.SQL.Add('select * from detail_produk_stk ');
DataModule1.ADOQuery_det_Produk.Active:=true;
end;

procedure TLaporan_form.rb_lap_tanggalClick(Sender: TObject);
begin
GroupBox1.Enabled:=True;
tahundari.Enabled:=True;
//TahunSampai.Enabled:=True;
tahundari.SetFocus;
edt_tahun.Clear;
tahundari.Clear;

end;

procedure TLaporan_form.UpdateClick(Sender: TObject);
begin
  dbgrd_LapPembelian.DataSource:=DataModule1.ds_det_Produk_stk;
  DataModule1.ds_det_Produk_stk.DataSet:=DataModule1.ADOTable_det_produk;
  DataModule1.ADOTable_det_produk.Connection:=DataModule1.con1;
  DataModule1.ADOTable_det_produk.Active:=false;
  DataModule1.ADOTable_det_produk.Close;
  DataModule1.ADOTable_det_produk.TableName:='detail_produk_stk';
  DataModule1.ADOTable_det_produk.Active:=true;
  //========= Refresh
  DataModule1.ds_det_Produk_stk.DataSet:=DataModule1.ADOQuery_det_Produk;
  DataModule1.ADOQuery_det_Produk.Connection:=DataModule1.con1;
end;

procedure TLaporan_form.FormShow(Sender: TObject);
var A :TDateTime;
begin
edt_tahun.Text:='Tahun';
end;

procedure TLaporan_form.edt_tahunClick(Sender: TObject);
begin
edt_tahun.SetFocus;
end;

procedure TLaporan_form.cbb_blnChange(Sender: TObject);
begin
PerBulan.Checked:=False;
edt_tahun.Enabled:=True;
edt_tahun.SetFocus;

end;

procedure TLaporan_form.edt_tahunChange(Sender: TObject);
begin
BitBtn1.Enabled:=True;
 RadioButton1.Checked:=False;
 TAMPILCetak.Enabled:=True;
end;

procedure TLaporan_form.btn_cetaakClick(Sender: TObject);
begin

DataModule1.ADOQuery_det_Produk.SQL.Clear;
DataModule1.ADOQuery_det_Produk.SQL.Add('select * from detail_produk_stk where (((tanggal_beli) between '''+FormatDateTime('yyyy-mm-dd',dariTGL.DateTime)+''' AND'''+FormatDateTime('yyyy-mm-dd',sampaiTGL.DateTime)+'''))ORDER BY tanggal_beli asc');
DataModule1.ADOQuery_det_Produk.Active:=true;
QckReport1.Preview;
DataModule1.ADOQuery_det_Produk.SQL.Clear;
DataModule1.ADOQuery_det_Produk.SQL.Add('select * from detail_produk_stk ');
DataModule1.ADOQuery_det_Produk.Active:=true;

PerTanggal.Checked:=False;
end;

procedure TLaporan_form.PerBulanClick(Sender: TObject);
begin
  cbb_bln.Enabled:=True;
  grp_Laporan.Enabled:=True;
cbb_bln.SetFocus;
tahundari.Clear;
end;

procedure TLaporan_form.PerTanggalClick(Sender: TObject);
begin
btn_cetaak.Enabled:=True;
edt_tahun.Clear;
tahundari.Clear;
end;

procedure TLaporan_form.TAMPILCetakClick(Sender: TObject);
var a:String;
begin
  dbgrd_LapPembelian.DataSource:=DataModule1.ds_det_Produk_stk;
 case cbb_bln.ItemIndex of
  0:a:='01';
  1:a:='02';
  2:a:='03';
  3:a:='04';
  4:a:='05';
  5:a:='06';
  6:a:='07';
  7:a:='08';
  8:a:='09';
  9:a:='10';
  10:a:='11';
  11:a:='12';
  end;
DataModule1.ADOQuery_det_Produk.SQL.Clear;
DataModule1.ADOQuery_det_Produk.SQL.Add('SELECT * FROM detail_produk_stk where month (tanggal_beli) ='+QuotedStr(a)+ 'and year (tanggal_beli) ='+QuotedStr(edt_tahun.Text)+'');
DataModule1.ADOQuery_det_Produk.Active:=true;     //WHERE year(tanggal_beli) ='+FormatDateTime('yyyy',TAHUNAN.Date)+'';
QckReport1.Preview;
DataModule1.ADOQuery_det_Produk.SQL.Clear;
DataModule1.ADOQuery_det_Produk.SQL.Add('select * from detail_produk_stk ');
DataModule1.ADOQuery_det_Produk.Active:=true;
end;

procedure TLaporan_form.tahundariClick(Sender: TObject);
begin
tahundari.SetFocus;
end;

procedure TLaporan_form.cbb_berdasarkanChange(Sender: TObject);
begin
    searchChange(Sender);
  search.Enabled:=True;
  search.SetFocus;
end;

procedure TLaporan_form.searchChange(Sender: TObject);
var a:String;
begin
dbgrd_LapPembelian.DataSource:=DataModule1.ds_det_Produk_stk;
 case cbb_berdasarkan.ItemIndex of
  0:a:='kd_produk';
  1:a:='id_suppplier';
  2:a:='nama_produk';
  3:a:='satuan';
  4:a:='harga_satuan';
  5:a:='jml_beli';
  6:a:='tanggal_beli';
  7:a:='id_karyawan';
 end;

 if (search.Text<>'') and (cbb_berdasarkan.Text<>'') then
  begin
   DataModule1.ADOQuery_det_Produk.SQL.Clear;
   DataModule1.ADOQuery_det_Produk.SQL.Text:='select * from detail_produk_stk where '+a+' like' + QuotedStr('%'+search.Text+'%');
   DataModule1.ADOQuery_det_Produk.Active:=True;
  end
 else

  begin
    DataModule1.ADOQuery_det_Produk.Close;
    DataModule1.ADOQuery_det_Produk.SQL.Clear;
    DataModule1.ADOQuery_det_Produk.SQL.Add('select * from detail_produk_stk');
    DataModule1.ADOQuery_det_Produk.Open;
  end;

end;

end.
