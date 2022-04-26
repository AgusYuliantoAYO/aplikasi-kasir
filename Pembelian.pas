unit Pembelian;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ZAbstractConnection, ZConnection, DB,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, frxClass, Grids, Buttons,
  Mask, DBCtrls, ComCtrls, frxDBSet, ExtCtrls;

type
  TPembelian_produk = class(TForm)
    grp1: TGroupBox;
    lbl4: TLabel;
    lbl5: TLabel;
    tglTransaksi: TDateTimePicker;
    Grb_member: TGroupBox;
    lbl1: TLabel;
    cbb_metodePembayaran: TComboBox;
    grp2: TGroupBox;
    lbl6: TLabel;
    lbl2: TLabel;
    db_kdProduk: TDBEdit;
    qtt: TEdit;
    cash: TEdit;
    kembalian: TEdit;
    hitung: TBitBtn;
    grp_total: TGroupBox;
    lbl3: TLabel;
    btn_simpan: TBitBtn;
    btn_add: TBitBtn;
    btn_cetak: TBitBtn;
    cbb_NamaProduk: TComboBox;
    db_satuan: TDBEdit;
    kd_trx: TEdit;
    tot_item: TEdit;
    edt_urut: TEdit;
    str_grd_produkMASUK: TStringGrid;
    btn_tmbh: TBitBtn;
    btn_hapus: TBitBtn;
    cbb_id_supplier: TComboBox;
    GroupBox2: TGroupBox;
    edit: TEdit;
    Label6: TLabel;
    btn_edit: TBitBtn;
    nama: TDBEdit;
    alamat: TDBEdit;
    GroupBox1: TGroupBox;
    lbl9: TLabel;
    harga_beli: TEdit;
    Label2: TLabel;
    frxReport2: TfrxReport;
    harga_jual: TEdit;
    lbl7: TLabel;
    edt_tot: TEdit;
    pnl_terbilang: TPanel;
    edt_Staff: TEdit;
    pnl1: TPanel;
    lbl8: TLabel;
    id_staff: TEdit;
    procedure rb_kiriClick(Sender: TObject);
    procedure cbb_id_supplierChange(Sender: TObject);
    procedure btn_simpanClick(Sender: TObject);
    procedure cbb_NamaProdukChange(Sender: TObject);
    procedure btn_tmbhClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btn_addClick(Sender: TObject);
    procedure btn_cetakClick(Sender: TObject);
    procedure hitungClick(Sender: TObject);
    procedure btn_hapusClick(Sender: TObject);
    procedure harga_beliChange(Sender: TObject);
    procedure harga_jualChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure harga_beliClick(Sender: TObject);
    procedure cashClick(Sender: TObject);
    procedure edt_StaffChange(Sender: TObject);
    procedure cashChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Pembelian_produk: TPembelian_produk;
  iRow: integer;

implementation

uses DM,Login_,Laporan, Transaksi,Beranda, Produk, Penjualan;
         var
 iCount, iDigit1, iDigit2, iDigit3: Integer;
 sNum2Str, s3Digit, sWord: string;

function terbilang(dNumber: Extended): string;
const
 aNum: array[1..9] of String = ('satu', 'dua', 'tiga', 'empat', 'lima', 'enam', 'tujuh', 'delapan', 'sembilan');
 aUnit: array[1..5] of String = ('trilyun', 'milyar', 'juta', 'ribu', '');
 begin

 Result := '';
 if (dNumber=0) then Exit;
 sNum2Str:=Copy(Format('%18.2f', [dNumber]), 1, 15);
 for ICount:=1 to 5 do
 begin
 s3Digit:=Copy(sNum2Str, iCount*3-2, 3);
 if (StrToIntDef(s3Digit, 0)<>0) then
   begin
   sWord:='';
   iDigit1:=StrToIntDef(Copy(s3Digit, 1, 1), 0);
   iDigit2:=StrToIntDef(Copy(s3Digit, 2, 1), 0);
   iDigit3:=StrToIntDef(Copy(s3Digit, 3, 1), 0);
      case iDigit1 of
       2..9: sWord:=sWord+aNum[iDigit1]+' ratus ';
       1: sWord:=sWord+'seratus ';
       end; { case }

      case iDigit2 of
         2..9: sWord:=sWord+aNum[iDigit2]+' puluh ';
         1: case iDigit3 of
         2..9: sWord:=sWord+aNum[iDigit3]+' belas ';
         1: sWord:=sWord+'sebelas ';
         0: sWord:=sWord+'sepuluh ';
         end; { case }
         end; { case }

        if (iDigit2<>1) then
         case iDigit3 of
         2..9: sWord:=sWord + aNum[iDigit3] + ' ';
         1: if (iCount=4) and ((iDigit1+iDigit2)=0) then
         sWord:=sWord+'se'
         else
         sWord:=sWord+'satu ';
         end;
         Result:=Result+sWord+aUnit[iCount]+' ';
      end;
 end;
 while Result[Length(Result)]=' ' do
 SetLength(Result, Length(Result)-1);
end;

       {$R *.dfm}


procedure TPembelian_produk.rb_kiriClick(Sender: TObject);
begin
     Begin
       DataModule1.ADOQuery_Supplier.First;
       While not DataModule1.ADOQuery_Supplier.Eof do
        begin
        cbb_id_supplier.Items.Add(DataModule1.ADOQuery_Supplier['id_supplier']);
        DataModule1.ADOQuery_Supplier.Next;
       end;
    end;


end;

procedure TPembelian_produk.cbb_id_supplierChange(Sender: TObject);
begin

with DataModule1.ADOQuery_Supplier do
    begin
      Active:=False;
      SQL.Clear;
      SQL.Text:='select * from supplier_ where id_supplier='+QuotedStr(cbb_id_supplier.Text);
      Active:=True;
      nama.Text:=(DataModule1.ADOQuery_Supplier.FieldByName('nama_supplier').AsString);
      alamat.Text:=(DataModule1.ADOQuery_Supplier.FieldByName('alamat').AsString);
     end;

    nama.Enabled:=True;
   // cbb_satuan.Enabled:=True;

end;

procedure TPembelian_produk.btn_simpanClick(Sender: TObject);
var a,b,hasil: Integer;
var s : String;
var i: integer;
var SQL: string;
begin
btn_add.Enabled:=True;
btn_cetak.Enabled:=True;
btn_simpan.Enabled:=False;
cbb_id_supplier.Enabled:=True;
 with DataModule1.ADOQuery_det_Produk do
   for i:=1 to str_grd_produkMASUK.RowCount - 1 do
  begin
  Active:=false;
  Close;
  SQL.Clear;
  SQL.Text:= 'INSERT INTO detail_produk_stk (kd_produk,id_supplier,nama_produk,satuan,harga_satuan,jml_beli,sub_total,tanggal_beli,id_karyawan)VALUES('
    + QuotedStr(str_grd_produkMASUK.Cells[1,i]) + ','
   //+ QuotedStr(kd_trx.Text) + ','
    + QuotedStr(cbb_id_supplier.Text) + ','
    + QuotedStr(str_grd_produkMASUK.Cells[3,i]) + ','
    //+ QuotedStr(FormatDateTime('yyyy-mm-dd',tglTransaksi.Date)) +','
    + QuotedStr(str_grd_produkMASUK.Cells[4,i]) + ','
    + QuotedStr(str_grd_produkMASUK.Cells[5,i]) + ','
    + QuotedStr(str_grd_produkMASUK.Cells[6,i]) + ','
    + QuotedStr(str_grd_produkMASUK.Cells[7,i]) + ','
    + QuotedStr(str_grd_produkMASUK.Cells[8,i]) + ','
    + QuotedStr(id_staff.Text) + ')';
  ExecSQL;
  end;
  ShowMessage('berhasil SIMPAN');
   end;

procedure TPembelian_produk.cbb_NamaProdukChange(Sender: TObject);
begin
qtt.Enabled:=True;
qtt.SetFocus;
with DataModule1.ADOQuery_JenisProduk do
    begin
      Active:=False;
      SQL.Clear;
      SQL.Text:='select * from jenis_produk where nama_produk='+QuotedStr(cbb_NamaProduk.Text);
      Active:=True;
      db_kdProduk.Text:=(DataModule1.ADOQuery_JenisProduk.FieldByName('kd_produk').AsString);
      db_satuan.Text:=(DataModule1.ADOQuery_JenisProduk.FieldByName('satuan').AsString);
      harga_jual.Text:=(DataModule1.ADOQuery_JenisProduk.FieldByName('harga_jual').AsString);
    end;
  if DataModule1.ADOQuery_JenisProduk.RecordCount=0 then
    begin
      MessageDlg('Data Tidak Ditemukan.',mtInformation,[mbOK],0);
      DataModule1.ADOQuery_JenisProduk.Active:=False;
      DataModule1.ADOQuery_JenisProduk.SQL.Clear;
      DataModule1.ADOQuery_JenisProduk.SQL.Text:='select * from jenis_produk';
      DataModule1.ADOQuery_JenisProduk.Active:=True;
    end
end;

procedure TPembelian_produk.btn_tmbhClick(Sender: TObject);
 var a,b,gt,z:Integer;
 var    subTot,i,byr:Integer;
 var tambah:Integer;
var stg:String;
begin

str_grd_produkMASUK.RowCount := iRow;

    a:=StrToInt(harga_beli.Text);
    b:=StrToInt(qtt.Text);
    subTot:=a*b;
   byr := subTot ;
   z :=StrToInt(edt_urut.Text)-1;
     stg:=str_grd_produkMASUK.Cells[1,z];
    if (db_kdProduk.Text=stg) then
        begin
         MessageDlg('Produk sudah ada !!!, hapus / lanjutkan dengan produk berbeda !',mtWarning,[mbOK],0)
        end else if (db_kdProduk.Text<>stg) then
        begin
with str_grd_produkMASUK do
  begin
   Cells[0,RowCount - 1] := edt_urut.Text;
   Cells[1,RowCount - 1] := db_kdProduk.Text;
   Cells[2,RowCount - 1] := cbb_id_supplier.Text;
   Cells[3,RowCount - 1] := cbb_NamaProduk.Text;
   Cells[4,RowCount - 1] := db_satuan.Text;
   Cells[5,RowCount - 1] := harga_beli.Text;
   Cells[6,RowCount - 1] := qtt.Text;
   Cells[7,RowCount - 1] := IntToStr (subTot);
   Cells[8,RowCount - 1] := FormatDateTime('yyyy-mm-dd',tglTransaksi.Date);
   //Cells[4,RowCount - 1] := db_stok.Text;
   //Cells[6,RowCount - 1] := qtt.Text;
   //Cells[7,RowCount - 1] := IntToStr (subTot) ;
  end;



  begin
    for i := 1 to str_grd_produkMASUK.RowCount -1 do
        begin
        str_grd_produkMASUK.Cells[0,i] := inttostr(i);
        //gt := gt + strtoint(str_grd_transaksi.Cells[6,i]);
        end;
      edt_urut.Text := inttostr(i);
     end;

//bersihkan isi cbBarang
cbb_NamaProduk.ItemIndex := -1; //karena style DropDownList, maka membersihkannya dengan cara seperti ini

//tambah jumlah baris
Inc(iRow,1);

      //========Total ITEM=======
gt := 0;
for i := 1 to str_grd_produkMASUK.RowCount -1 do
    begin
  //  str_grd_transaksi.Cells[6,i] := inttostr(i);
    gt := gt + strtoint(str_grd_produkMASUK.Cells[6,i]);
    end;
tot_item.Text := inttostr(gt);


      //========Total Bayar=======
gt := 0;
for i := 1 to str_grd_produkMASUK.RowCount -1 do
    begin
   // str_grd_transaksi.Cells[7,i] := inttostr(i);
    gt := gt + strtoint(str_grd_produkMASUK.Cells[7,i]);
    edt_tot.Text := inttostr(gt);
    end;
    pnl_terbilang.Caption:=terbilang(StrToFloatDef(edt_tot.Text,0));

db_kdProduk.Clear;
db_satuan.Clear;
harga_jual.Clear;
qtt.Clear;
harga_beli.Clear;
end;
end;

procedure TPembelian_produk.FormCreate(Sender: TObject);
begin
  Login_form_.edt_duplikast2_:=Pembelian_produk.edt_Staff;
   Login_form_.edt_duplikast2_.Visible:=true;

  tglTransaksi.Date:=Now;
 cbb_id_supplier.Enabled:=True;
 edt_urut.Text:='1';

  iRow := 2;
  with str_grd_produkMASUK do
    begin
     Cells[0,0] := 'No';
     Cells[1,0] := 'Kode Produk';
     Cells[2,0] := 'Id Supplier';
     Cells[3,0] := 'Nama Produk';
     Cells[4,0] := 'Satuan';
     Cells[5,0] := 'Harga';
     Cells[6,0] := 'qtt';
     Cells[7,0] := 'Total';
     Cells[8,0] := 'Tanggal';
    end;
end;

procedure TPembelian_produk.btn_addClick(Sender: TObject);
var a,b,hasil: Integer;
var s : String;
var i: integer;
begin
   btn_add.Enabled:=False;
   btn_simpan.Enabled:=True;
   cbb_id_supplier.Text:='----pilih---';
   nama.Clear;
   alamat.Clear;
   Application.CreateForm(TPembelian_produk, Pembelian_produk);
   cbb_metodePembayaran.Text:='----pilih---';
   edt_urut.Text:='1';
   tot_item.Clear;
   cash.Clear;
   edt_tot.Text:='0';

//===================================bersih - bersih...

for i :=1 to str_grd_produkMASUK.RowCount -1 do
   str_grd_produkMASUK.Rows[i].Clear;
end;

procedure TPembelian_produk.btn_cetakClick(Sender: TObject);
var i: integer;
begin


  with str_grd_produkMASUK do
  begin
    Tfrxmemoview(frxReport2.FindObject('tanggal')).Memo.Text:=
    FormatDateTime('yyyy-mm-dd',tglTransaksi.Date);
      Tfrxmemoview(frxReport2.FindObject('Id_Supplier')).Memo.Text:=
    cbb_id_supplier.Text;
      Tfrxmemoview(frxReport2.FindObject('cash')).Memo.Text:=
    cbb_metodePembayaran.Text;
        Tfrxmemoview(frxReport2.FindObject('bayar')).Memo.Text:=
    cash.Text;
        Tfrxmemoview(frxReport2.FindObject('id_staff')).Memo.Text:=
    edt_Staff.Text;
        Tfrxmemoview(frxReport2.FindObject('kembalian')).Memo.Text:=
    kembalian.Text;

      Tfrxmemoview(frxReport2.FindObject('no1')).Memo.Text:=
   QuotedStr(str_grd_produkMASUK.Cells[0,1]) ;
       Tfrxmemoview(frxReport2.FindObject('no2')).Memo.Text:=
   QuotedStr(str_grd_produkMASUK.Cells[0,2]) ;
       Tfrxmemoview(frxReport2.FindObject('no3')).Memo.Text:=
   QuotedStr(str_grd_produkMASUK.Cells[0,3]) ;
       Tfrxmemoview(frxReport2.FindObject('no4')).Memo.Text:=
   QuotedStr(str_grd_produkMASUK.Cells[0,4]) ;
       Tfrxmemoview(frxReport2.FindObject('no5')).Memo.Text:=
   QuotedStr(str_grd_produkMASUK.Cells[0,5]) ;
       Tfrxmemoview(frxReport2.FindObject('no6')).Memo.Text:=
   QuotedStr(str_grd_produkMASUK.Cells[0,6]) ;
       Tfrxmemoview(frxReport2.FindObject('no7')).Memo.Text:=
   QuotedStr(str_grd_produkMASUK.Cells[0,7]) ;

      Tfrxmemoview(frxReport2.FindObject('kd1')).Memo.Text:=
   QuotedStr(str_grd_produkMASUK.Cells[1,1]);
      Tfrxmemoview(frxReport2.FindObject('kd2')).Memo.Text:=
   QuotedStr(str_grd_produkMASUK.Cells[1,2]);
      Tfrxmemoview(frxReport2.FindObject('kd3')).Memo.Text:=
   QuotedStr(str_grd_produkMASUK.Cells[1,3]);
      Tfrxmemoview(frxReport2.FindObject('kd4')).Memo.Text:=
   QuotedStr(str_grd_produkMASUK.Cells[1,4]);
      Tfrxmemoview(frxReport2.FindObject('kd5')).Memo.Text:=
   QuotedStr(str_grd_produkMASUK.Cells[1,5]);
      Tfrxmemoview(frxReport2.FindObject('kd6')).Memo.Text:=
   QuotedStr(str_grd_produkMASUK.Cells[1,6]);
      Tfrxmemoview(frxReport2.FindObject('kd7')).Memo.Text:=
   QuotedStr(str_grd_produkMASUK.Cells[1,7]);

       Tfrxmemoview(frxReport2.FindObject('nama1')).Memo.Text:=
   QuotedStr(str_grd_produkMASUK.Cells[3,1]) ;
       Tfrxmemoview(frxReport2.FindObject('nama2')).Memo.Text:=
   QuotedStr(str_grd_produkMASUK.Cells[3,2]) ;
       Tfrxmemoview(frxReport2.FindObject('nama3')).Memo.Text:=
   QuotedStr(str_grd_produkMASUK.Cells[3,3]) ;
       Tfrxmemoview(frxReport2.FindObject('nama4')).Memo.Text:=
   QuotedStr(str_grd_produkMASUK.Cells[3,4]) ;
       Tfrxmemoview(frxReport2.FindObject('nama5')).Memo.Text:=
   QuotedStr(str_grd_produkMASUK.Cells[3,5]) ;
       Tfrxmemoview(frxReport2.FindObject('nama6')).Memo.Text:=
   QuotedStr(str_grd_produkMASUK.Cells[3,6]) ;
       Tfrxmemoview(frxReport2.FindObject('nama7')).Memo.Text:=
   QuotedStr(str_grd_produkMASUK.Cells[3,7]) ;

      Tfrxmemoview(frxReport2.FindObject('satuan1')).Memo.Text:=
   QuotedStr(str_grd_produkMASUK.Cells[4,1]) ;
      Tfrxmemoview(frxReport2.FindObject('satuan2')).Memo.Text:=
   QuotedStr(str_grd_produkMASUK.Cells[4,2]) ;
      Tfrxmemoview(frxReport2.FindObject('satuan3')).Memo.Text:=
   QuotedStr(str_grd_produkMASUK.Cells[4,3]) ;
      Tfrxmemoview(frxReport2.FindObject('satuan4')).Memo.Text:=
   QuotedStr(str_grd_produkMASUK.Cells[4,4]) ;
      Tfrxmemoview(frxReport2.FindObject('satuan5')).Memo.Text:=
   QuotedStr(str_grd_produkMASUK.Cells[4,5]) ;
      Tfrxmemoview(frxReport2.FindObject('satuan6')).Memo.Text:=
   QuotedStr(str_grd_produkMASUK.Cells[4,6]) ;
      Tfrxmemoview(frxReport2.FindObject('satuan7')).Memo.Text:=
   QuotedStr(str_grd_produkMASUK.Cells[4,7]) ;

      Tfrxmemoview(frxReport2.FindObject('harga1')).Memo.Text:=
   QuotedStr(str_grd_produkMASUK.Cells[5,1]) ;
      Tfrxmemoview(frxReport2.FindObject('harga2')).Memo.Text:=
   QuotedStr(str_grd_produkMASUK.Cells[5,2]) ;
      Tfrxmemoview(frxReport2.FindObject('harga3')).Memo.Text:=
   QuotedStr(str_grd_produkMASUK.Cells[5,3]) ;
      Tfrxmemoview(frxReport2.FindObject('harga4')).Memo.Text:=
   QuotedStr(str_grd_produkMASUK.Cells[5,4]) ;
      Tfrxmemoview(frxReport2.FindObject('harga5')).Memo.Text:=
   QuotedStr(str_grd_produkMASUK.Cells[5,5]) ;
      Tfrxmemoview(frxReport2.FindObject('harga6')).Memo.Text:=
   QuotedStr(str_grd_produkMASUK.Cells[5,6]) ;
      Tfrxmemoview(frxReport2.FindObject('harga7')).Memo.Text:=
   QuotedStr(str_grd_produkMASUK.Cells[5,7]) ;

      Tfrxmemoview(frxReport2.FindObject('qtt1')).Memo.Text:=
   QuotedStr(str_grd_produkMASUK.Cells[6,1]) ;
      Tfrxmemoview(frxReport2.FindObject('qtt2')).Memo.Text:=
   QuotedStr(str_grd_produkMASUK.Cells[6,2]) ;
      Tfrxmemoview(frxReport2.FindObject('qtt3')).Memo.Text:=
   QuotedStr(str_grd_produkMASUK.Cells[6,3]) ;
      Tfrxmemoview(frxReport2.FindObject('qtt4')).Memo.Text:=
   QuotedStr(str_grd_produkMASUK.Cells[6,4]) ;
      Tfrxmemoview(frxReport2.FindObject('qtt5')).Memo.Text:=
   QuotedStr(str_grd_produkMASUK.Cells[6,5]) ;
      Tfrxmemoview(frxReport2.FindObject('qtt6')).Memo.Text:=
   QuotedStr(str_grd_produkMASUK.Cells[6,6]) ;
      Tfrxmemoview(frxReport2.FindObject('qtt7')).Memo.Text:=
   QuotedStr(str_grd_produkMASUK.Cells[6,7]) ;

      Tfrxmemoview(frxReport2.FindObject('tot_qtt')).Memo.Text:=
   tot_item.Text;

      Tfrxmemoview(frxReport2.FindObject('tot1')).Memo.Text:=
   QuotedStr(str_grd_produkMASUK.Cells[7,1]) ;
      Tfrxmemoview(frxReport2.FindObject('tot2')).Memo.Text:=
   QuotedStr(str_grd_produkMASUK.Cells[7,2]) ;
      Tfrxmemoview(frxReport2.FindObject('tot3')).Memo.Text:=
   QuotedStr(str_grd_produkMASUK.Cells[7,3]) ;
      Tfrxmemoview(frxReport2.FindObject('tot4')).Memo.Text:=
   QuotedStr(str_grd_produkMASUK.Cells[7,4]) ;
      Tfrxmemoview(frxReport2.FindObject('tot5')).Memo.Text:=
   QuotedStr(str_grd_produkMASUK.Cells[7,5]) ;
      Tfrxmemoview(frxReport2.FindObject('tot6')).Memo.Text:=
   QuotedStr(str_grd_produkMASUK.Cells[7,6]) ;
      Tfrxmemoview(frxReport2.FindObject('tot7')).Memo.Text:=
   QuotedStr(str_grd_produkMASUK.Cells[7,7]) ;

      Tfrxmemoview(frxReport2.FindObject('tot_bayar')).Memo.Text:=
   edt_tot.Text ;

  frxReport2.ShowReport();
  end;

end;

procedure TPembelian_produk.hitungClick(Sender: TObject);
var uang, kembalianbeli, totalBayar : Integer;
var  sRupiah: string;
 var iRupiah: Currency;
begin
    totalBayar:=StrToInt(edt_tot.Text);
     uang:=StrToInt(cash.Text);

     kembalianbeli:=totalBayar-uang;
     kembalian.Text:=IntToStr(kembalianbeli);

  sRupiah := cash.Text;
  sRupiah := StringReplace(sRupiah,',','',[rfReplaceAll,rfIgnoreCase]);
  sRupiah := StringReplace(sRupiah,'.','',[rfReplaceAll,rfIgnoreCase]);
 iRupiah := StrToCurrDef(sRupiah,0);
  cash.Text:= FormatCurr('#,###',iRupiah);
  cash.SelStart := length(cash.text);
end;

procedure TPembelian_produk.btn_hapusClick(Sender: TObject);
var col, row:integer;
	  i,j:integer;
begin
for i :=1 to str_grd_produkMASUK.RowCount -1 do
   str_grd_produkMASUK.Rows[i].Clear;
    edt_urut.Text:='1';
      Application.CreateForm(TTransaksi_form, Transaksi_form);
   Application.CreateForm(TPembelian_produk, Pembelian_produk);
    Application.CreateForm(TProduk_form, Produk_form);
       Application.CreateForm(TPenjualan_form, Penjualan_form);
end;

procedure TPembelian_produk.harga_beliChange(Sender: TObject);
begin

btn_tmbh.Enabled:=True;
if harga_beli.Text='' then btn_tmbh.Enabled:=False

end;

procedure TPembelian_produk.harga_jualChange(Sender: TObject);
var  sRupiah: string;
 var iRupiah: Currency;
begin

      //ribuan --> currency ( menyesuaikan setting windows )
  sRupiah := harga_jual.Text;
  sRupiah := StringReplace(sRupiah,',','',[rfReplaceAll,rfIgnoreCase]);
  sRupiah := StringReplace(sRupiah,'.','',[rfReplaceAll,rfIgnoreCase]);
 iRupiah := StrToCurrDef(sRupiah,0);
  harga_jual.Text:= FormatCurr('#,###',iRupiah);
  harga_jual.SelStart := length(harga_jual.text);

end;

procedure TPembelian_produk.FormShow(Sender: TObject);
begin

  DataModule1.ADOQuery_Supplier.First;
 While not DataModule1.ADOQuery_Supplier.Eof do
  begin
  cbb_id_supplier.Items.Add(DataModule1.ADOQuery_Supplier['id_supplier']);
  DataModule1.ADOQuery_Supplier.Next;
  cbb_id_supplier.Enabled:=True;
 end;


 DataModule1.ADOQuery_JenisProduk.First;
 While not DataModule1.ADOQuery_JenisProduk.Eof do
  begin
  cbb_NamaProduk.Items.Add(DataModule1.ADOQuery_JenisProduk['nama_produk']);
  DataModule1.ADOQuery_JenisProduk.Next;
  cbb_id_supplier.Enabled:=True;
 end;

end;

procedure TPembelian_produk.harga_beliClick(Sender: TObject);
begin
harga_beli.SetFocus;
end;

procedure TPembelian_produk.cashClick(Sender: TObject);
begin
cash.SetFocus;
end;

procedure TPembelian_produk.edt_StaffChange(Sender: TObject);
begin
with DataModule1.ADOQuery_karyawan do
    begin
      Active:=False;
      SQL.Clear;
      SQL.Text:='select * from karyawan where nama='+QuotedStr(edt_Staff.Text);
      Active:=True;
      id_staff.Text:=(DataModule1.ADOQuery_karyawan.FieldByName('id_karyawan').AsString);
    end;
end;

procedure TPembelian_produk.cashChange(Sender: TObject);
begin
btn_simpan.Enabled:=True;
end;

end.
