unit Penjualan;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, StdCtrls, Buttons, ComCtrls, ExtCtrls;

type
  TPenjualan_form = class(TForm)
    dbgrd_penjualan: TDBGrid;
    cbb_berdasarkan: TComboBox;
    search: TEdit;
    grp_Laporan: TGroupBox;
    tgl_dari: TDateTimePicker;
    tglSampai: TDateTimePicker;
    btn_tampil: TBitBtn;
    rb_lap_tanggal: TRadioButton;
    GroupBox1: TGroupBox;
    cbb_bln: TComboBox;
    edt_tahun: TEdit;
    TAMPILCetak: TBitBtn;
    PerBulan: TRadioButton;
    grp1: TGroupBox;
    btn_cetak: TBitBtn;
    Edit1: TEdit;
    Refresh: TBitBtn;
    PerTahun: TRadioButton;
    Image1: TImage;
    lbl9: TLabel;
    procedure searchChange(Sender: TObject);
    procedure cbb_berdasarkanChange(Sender: TObject);
    procedure btn_tampilClick(Sender: TObject);
    procedure rb_lap_tanggalClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure TAMPILCetakClick(Sender: TObject);
    procedure btn_cetakClick(Sender: TObject);
    procedure RefreshClick(Sender: TObject);
    procedure PerBulanClick(Sender: TObject);
    procedure edt_tahunChange(Sender: TObject);
    procedure PerTahunClick(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure cbb_blnChange(Sender: TObject);
    procedure Edit1Click(Sender: TObject);
    procedure edt_tahunClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Penjualan_form: TPenjualan_form;

implementation
uses DM, QRptPenjualan, Login_;

{$R *.dfm}

procedure TPenjualan_form.searchChange(Sender: TObject);
var a:String;
begin
dbgrd_penjualan.DataSource:=DataModule1.ds_transaksi;
 case cbb_berdasarkan.ItemIndex of
  0:a:='kd_transaksi';
  1:a:='nama_pembeli';
  2:a:='id_karyawan';
  3:a:='tanggal';
  4:a:='id_member';
 end;

 if (search.Text<>'') and (cbb_berdasarkan.Text<>'') then
  begin
   DataModule1.ADOQuery_Transaksi.SQL.Clear;
   DataModule1.ADOQuery_Transaksi.SQL.Text:='select * from transaksi_ where '+a+' like' + QuotedStr('%'+search.Text+'%');
   DataModule1.ADOQuery_Transaksi.Active:=True;
  end
 else

  begin
    DataModule1.ADOQuery_Transaksi.Close;
    DataModule1.ADOQuery_Transaksi.SQL.Clear;
    DataModule1.ADOQuery_Transaksi.SQL.Add('select * from transaksi_');
    DataModule1.ADOQuery_Transaksi.Open;
  end;
end;

procedure TPenjualan_form.cbb_berdasarkanChange(Sender: TObject);
begin
  searchChange(Sender);
  search.Enabled:=True;
  search.SetFocus;
end;

procedure TPenjualan_form.btn_tampilClick(Sender: TObject);
begin

DataModule1.ADOQuery_Transaksi.SQL.Clear;
DataModule1.ADOQuery_Transaksi.SQL.Add('select * from transaksi_ where (((tanggal) between '''+FormatDateTime('yyyy-mm-dd',tgl_dari.DateTime)+''' AND'''+FormatDateTime('yyyy-mm-dd',tglSampai.DateTime)+'''))ORDER BY kd_transaksi asc');
DataModule1.ADOQuery_Transaksi.Active:=true;
QuickReportPenjualan.Preview;
DataModule1.ADOQuery_Transaksi.SQL.Clear;
DataModule1.ADOQuery_Transaksi.SQL.Add('select * from transaksi_ ');
DataModule1.ADOQuery_Transaksi.Active:=true;

end;

procedure TPenjualan_form.rb_lap_tanggalClick(Sender: TObject);
begin
grp_Laporan.Enabled:=True;
end;

procedure TPenjualan_form.FormActivate(Sender: TObject);
begin
tgl_dari.Date:=Now;
tglSampai.Date:=Now;
end;

procedure TPenjualan_form.FormShow(Sender: TObject);
begin
tgl_dari.Date:=Now;
tglSampai.Date:=Now;
end;

procedure TPenjualan_form.TAMPILCetakClick(Sender: TObject);
var a:String;
begin
  dbgrd_penjualan.DataSource:=DataModule1.ds_transaksi;
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
DataModule1.ADOQuery_Transaksi.SQL.Clear;
DataModule1.ADOQuery_Transaksi.SQL.Add('SELECT * FROM transaksi_ where month (tanggal) ='+QuotedStr(a)+ 'and year (tanggal) ='+QuotedStr(edt_tahun.Text)+'');
DataModule1.ADOQuery_Transaksi.Active:=true;
QuickReportPenjualan.Preview;
DataModule1.ADOQuery_Transaksi.SQL.Clear;
DataModule1.ADOQuery_Transaksi.SQL.Add('select * from transaksi_ ');
DataModule1.ADOQuery_Transaksi.Active:=true;
end;

procedure TPenjualan_form.btn_cetakClick(Sender: TObject);
begin
DataModule1.ADOQuery_Transaksi.SQL.Clear;
DataModule1.ADOQuery_Transaksi.SQL.Add('SELECT * FROM transaksi_ where year (tanggal) ='+QuotedStr(Edit1.Text)+'');
DataModule1.ADOQuery_Transaksi.Active:=true;
QuickReportPenjualan.Preview;
DataModule1.ADOQuery_Transaksi.SQL.Clear;
DataModule1.ADOQuery_Transaksi.SQL.Add('select * from transaksi_ ');
DataModule1.ADOQuery_Transaksi.Active:=true;
end;

procedure TPenjualan_form.RefreshClick(Sender: TObject);
begin
  dbgrd_penjualan.DataSource:=DataModule1.ds_transaksi;
  DataModule1.ds_transaksi.DataSet:=DataModule1.ADOTable_Transaksi;
  DataModule1.ADOTable_Transaksi.Connection:=DataModule1.con1;
  DataModule1.ADOTable_Transaksi.Active:=false;
  DataModule1.ADOTable_Transaksi.Close;
  DataModule1.ADOTable_Transaksi.TableName:='transaksi_';
  DataModule1.ADOTable_Transaksi.Active:=true;
  //========= Refresh
  DataModule1.ds_transaksi.DataSet:=DataModule1.ADOQuery_Transaksi;
  DataModule1.ADOQuery_Transaksi.Connection:=DataModule1.con1;
   begin
    DataModule1.ADOQuery_Transaksi.Active:=false;
    DataModule1.ADOQuery_Transaksi.Close;
    DataModule1.ADOQuery_Transaksi.SQL.Clear;
    DataModule1.ADOQuery_Transaksi.SQL.Text:='select*from transaksi_';
    DataModule1.ADOQuery_Transaksi.Active:=true;
   end;

end;

procedure TPenjualan_form.PerBulanClick(Sender: TObject);
begin
GroupBox1.Enabled:=True;
cbb_bln.Enabled:=True;
cbb_bln.SetFocus;
end;

procedure TPenjualan_form.edt_tahunChange(Sender: TObject);
begin
TAMPILCetak.Enabled:=True;
end;

procedure TPenjualan_form.PerTahunClick(Sender: TObject);
begin
grp1.Enabled:=True;
Edit1.Enabled:=True;
Edit1.SetFocus;
end;

procedure TPenjualan_form.Edit1Change(Sender: TObject);
begin
btn_cetak.Enabled:=True;
end;

procedure TPenjualan_form.cbb_blnChange(Sender: TObject);
begin
edt_tahun.Enabled:=True;
edt_tahun.SetFocus;

end;

procedure TPenjualan_form.Edit1Click(Sender: TObject);
begin
Edit1.SetFocus;
Edit1.Clear;
end;

procedure TPenjualan_form.edt_tahunClick(Sender: TObject);
begin
edt_tahun.SetFocus;
edt_tahun.Clear;
end;

end.
