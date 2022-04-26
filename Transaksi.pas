unit Transaksi;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Mask, DBCtrls, StdCtrls, Grids, DBGrids, Buttons, ComCtrls, DB,
  MemDS, VirtualTable, frxClass, frxDBSet, ZAbstractConnection,
  ZConnection, ZAbstractRODataset, ZAbstractDataset, ZDataset, ExtCtrls;

type
  TTransaksi_form = class(TForm)
    grp1: TGroupBox;
    lbl4: TLabel;
    lbl5: TLabel;
    tglTransaksi: TDateTimePicker;
    grp2: TGroupBox;
    lbl6: TLabel;
    lbl8: TLabel;
    cbb_kategori: TComboBox;
    Grb_member: TGroupBox;
    lbl1: TLabel;
    alamat: TDBEdit;
    nama: TDBEdit;
    btn_member: TBitBtn;
    cbb_metodePembayaran: TComboBox;
    db_kdProduk: TDBEdit;
    db_harga: TDBEdit;
    db_stok: TDBEdit;
    qtt: TEdit;
    cash: TEdit;
    kembalian: TEdit;
    hitung: TBitBtn;
    lbl2: TLabel;
    grp_total: TGroupBox;
    lbl3: TLabel;
    btn_simpan: TBitBtn;
    btn_add: TBitBtn;
    btn_cetak: TBitBtn;
    cbb_NamaProduk: TComboBox;
    db_satuan: TDBEdit;
    id_member: TEdit;
    str_grd_transaksi: TStringGrid;
    btn_tmbh: TBitBtn;
    btn_hapus: TBitBtn;
    kd_trx: TEdit;
    tot_item: TEdit;
    edt_urut: TEdit;
    frxReport2: TfrxReport;
    edt_Total: TEdit;
    pnl_terbilang: TPanel;
    lbl_disk: TLabel;
    grp_disk: TGroupBox;
    ed_diskon: TEdit;
    Compline: TButton;
    grp_EDIT: TGroupBox;
    btn_Simpan_ubah: TBitBtn;
    Label1: TLabel;
    ubah: TEdit;
    btn_ubah_TAMBAH: TBitBtn;
    btn_edit: TBitBtn;
    rb_edit: TRadioButton;
    edt_hrs_byr: TEdit;
    edt_Staff: TEdit;
    pnl1: TPanel;
    lbl9: TLabel;
    id_staff: TEdit;
    procedure cbb_NamaProdukChange(Sender: TObject);
    procedure btn_memberClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btn_tmbhClick(Sender: TObject);
    procedure btn_hapusClick(Sender: TObject);
    procedure btn_simpanClick(Sender: TObject);
    procedure hitungClick(Sender: TObject);
    procedure btn_addClick(Sender: TObject);
    procedure id_memberClick(Sender: TObject);
    procedure btn_cetakClick(Sender: TObject);
    procedure btn_editClick(Sender: TObject);
    procedure ComplineClick(Sender: TObject);
    procedure cashClick(Sender: TObject);
    procedure tot_itemChange(Sender: TObject);
    procedure qttChange(Sender: TObject);
    procedure edt_TotalChange(Sender: TObject);
    procedure ed_diskonChange(Sender: TObject);
    procedure qttClick(Sender: TObject);
    procedure btn_ubah_TAMBAHClick(Sender: TObject);
    procedure btn_Simpan_ubahClick(Sender: TObject);
    procedure rb_editClick(Sender: TObject);
    procedure ubahClick(Sender: TObject);
    //HANYA ANGKA//HURUF
    procedure AngkaSaja(Sender: TObject; var Key: Char);
    procedure HurufSaja(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure id_memberChange(Sender: TObject);
    procedure cbb_kategoriChange(Sender: TObject);
    procedure edt_hrs_byrChange(Sender: TObject);
    procedure edt_StaffChange(Sender: TObject);
    procedure cbb_metodePembayaranChange(Sender: TObject);

  private
//       procedure RunSQL(_SQL:String ; isOpen:boolean = True);

   // function GenCode: string; //fungsi auto no.nota
    { Private declarations }
  public

    { Public declarations }
    end;

var
  Transaksi_form: TTransaksi_form;
 // frmMain: TfrmMain;
  iRow: integer;

implementation
         uses DM,QuickRpt, Login_, DateUtils,Beranda, Pembelian, Produk, Penjualan,
  SysConst, TypInfo;

  //Hanya Bisa Input ANGKA/HURUF
  procedure TTransaksi_form.AngkaSaja(Sender: TObject; var Key: Char);
begin
if not (key in['0'..'9',#8,#13,#32]) then
 begin
 key:=#0;
 showmessage('inputan hanya angka bro..');
 end;
end;

procedure TTransaksi_form.HurufSaja(Sender: TObject; var Key: Char);
begin
if not (key in['a'..'z','A'..'Z',#8,#13,#32]) then
 begin
 key:=#0;
 showmessage('inputan hanya huruf bro..');
 end;
end;

  //RIBUAN/UANG
function terbilang(dNumber: Extended): string;
const
 aNum: array[1..9] of String = ('satu', 'dua', 'tiga', 'empat', 'lima', 'enam', 'tujuh', 'delapan', 'sembilan');
 aUnit: array[1..5] of String = ('trilyun', 'milyar', 'juta', 'ribu', '');
var
 iCount, iDigit1, iDigit2, iDigit3: Integer;
 sNum2Str, s3Digit, sWord: string;
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

procedure TTransaksi_form.cbb_NamaProdukChange(Sender: TObject);
 begin
  with DataModule1.ADOQuery_Produk do
    begin
      Active:=False;
      SQL.Clear;
      SQL.Text:='select * from produk_stk where nama_produk='+QuotedStr(cbb_NamaProduk.Text);
      Active:=True;
      db_kdProduk.Text:=(DataModule1.ADOQuery_Produk.FieldByName('kd_produk').AsString);
      db_satuan.Text:=(DataModule1.ADOQuery_Produk.FieldByName('satuan').AsString);
      db_harga.Text:=(DataModule1.ADOQuery_Produk.FieldByName('harga').AsString);
      db_stok.Text:=(DataModule1.ADOQuery_Produk.FieldByName('stok').AsString);
    end;
  if DataModule1.ADOQuery_Produk.RecordCount=0 then
    begin
      MessageDlg('Data Tidak Ditemukan.',mtInformation,[mbOK],0);
      DataModule1.ADOQuery_Produk.Active:=False;
      DataModule1.ADOQuery_Produk.SQL.Clear;
      DataModule1.ADOQuery_Produk.SQL.Text:='select * from produk_stk';
      DataModule1.ADOQuery_Produk.Active:=True;
    end;
 qtt.Enabled:=True;
 qtt.SetFocus;
 qtt.Clear;
 end;

procedure TTransaksi_form.btn_memberClick(Sender: TObject);
begin
  Compline.Enabled:=True;
with DataModule1.ADOQuery_Member do
    begin
      Active:=False;
      SQL.Clear;
      SQL.Text:='select * from members_ where id_member='+QuotedStr(id_member.Text);
      Active:=True;
      nama.Text:=(DataModule1.ADOQuery_Member.FieldByName('nama_member').AsString);
      alamat.Text:=(DataModule1.ADOQuery_Member.FieldByName('alamat').AsString);
    end;
Compline.Enabled:=True;
end;


procedure TTransaksi_form.FormCreate(Sender: TObject);
 begin
      Login_form_.edt_duplikat1_:=Transaksi_form.edt_Staff;
      Login_form_.edt_duplikat1_.Visible:=true;

      cbb_kategori.Text:='---pilih---';



      edt_urut.Text:='1';
  iRow := 2;
  with str_grd_transaksi do
    begin
     Cells[0,0] := 'No';
     Cells[1,0] := 'Kode Transaksi';
     Cells[2,0] := 'Kode Produk';
     Cells[3,0] := 'Nama Produk';
     Cells[4,0] := 'Satuan';
     Cells[5,0] := 'Harga';
     Cells[6,0] := 'qtt';
     Cells[7,0] := 'Total';
     Cells[8,0] := 'Tanggal';
    end;
 end;

procedure TTransaksi_form.btn_tmbhClick(Sender: TObject);
var a,b,gt:Integer;
 var    subTot,i,io:Integer;
 var tambah,z  :Integer;
 var aw:Integer;
 var seratus, limaratus, satujuta : string;
  var    sRupiah: string;
  var iRupiah: Currency;
  var    sRupiahh,iow: string;
  var iRupiahh: Currency;
  Var Digit1 : Char;
  var stok,qt: integer;
      x,min:Integer;
      kd,stg:string;
begin
  btn_add.Enabled:=True;
   btn_tmbh.Enabled:=False;
  stok:=StrToInt(db_stok.Text);
   qt:=StrToInt(qtt.Text);
   x:=qt-stok;
   min:=0;
   if (min<x) then begin
   MessageDlg('Stok tidak cukup !!!, hapus / ubah qtt !',mtWarning,[mbOK],0);
   qtt.Enabled:=True;
   qtt.SetFocus; end else
  begin
   begin
    tambah:=StrToInt(edt_urut.Text);
    kd_trx.Text:= 'TRX-'
    +IntToStr(DataModule1.ADOQuery_det_Transaksi.RecordCount+0+tambah);
   end;

str_grd_transaksi.RowCount := iRow;
    a:=StrToInt(db_harga.Text);
  sRupiah := db_harga.Text;
  sRupiah := StringReplace(sRupiah,',','',[rfReplaceAll,rfIgnoreCase]); // hilangkan char koma , pemisah //ribuan selain IDR
  sRupiah := StringReplace(sRupiah,'.','',[rfReplaceAll,rfIgnoreCase]); //remove char titik .    pemisah //ribuan IDR
 iRupiah := StrToCurrDef(sRupiah,0); // convert srupiah ke currency
  db_harga.Text := FormatCurr('#,###',iRupiah);
  db_harga.SelStart := length(db_harga.Text);

    b:=StrToInt(qtt.Text);
    subTot:=a*b;
    z :=StrToInt(edt_urut.Text)-1;
   // for io := 1 to str_grd_transaksi.RowCount -1 do
      //kd:=db_kdProduk.Text;
      stg:=str_grd_transaksi.Cells[2,z];
      if (db_kdProduk.Text=stg) then
        begin
         MessageDlg('Produk sudah ada !!!, hapus / lanjutkan dengan produk berbeda !',mtWarning,[mbOK],0)
        end else if (db_kdProduk.Text<>stg) then
 begin
  begin
//    for i :=1 to str_grd_transaksi.RowCount -1 do
//   if (db_kdProduk.Text=Cells[i,RowCount - i]) then
//    ShowMessage('Produk sudah ada !!!');
      with str_grd_transaksi do //Cells[2,RowCount - 1] := db_kdProduk.Text;
      begin
       Cells[0,RowCount - 1] := edt_urut.Text;
       Cells[1,RowCount - 1] := kd_trx.Text;
       Cells[2,RowCount - 1] := db_kdProduk.Text;
       Cells[3,RowCount - 1] := cbb_NamaProduk.Text;
       Cells[4,RowCount - 1] := db_satuan.Text;
       Cells[5,RowCount - 1] := db_harga.Text;
       Cells[6,RowCount - 1] := qtt.Text;
       Cells[7,RowCount - 1] := IntToStr (subTot) ;
       Cells[8,RowCount - 1] := FormatDateTime('yyyy-mm-dd',tglTransaksi.Date);
     end;
          end;


   begin
    for i := 1 to str_grd_transaksi.RowCount -1 do
        begin
        str_grd_transaksi.Cells[0,i] := inttostr(i);
        end;
      edt_urut.Text := inttostr(i);
     end;

cbb_NamaProduk.ItemIndex := -1; //karena style DropDownList, maka membersihkannya dengan cara seperti ini
Inc(iRow,1);

      //========Total ITEM=======
gt := 0;
for i := 1 to str_grd_transaksi.RowCount -1 do
    begin
    gt := gt + strtoint(str_grd_transaksi.Cells[6,i]);
    end;
  tot_item.Text := inttostr(gt);

      //========Total Bayar=======
gt := 0;
for i := 1 to str_grd_transaksi.RowCount -1 do
    begin
    gt := gt + StrToInt(str_grd_transaksi.Cells[7,i]);
    edt_Total.Text := IntToStr(gt);
    end;
    pnl_terbilang.Caption:=terbilang(StrToFloatDef(edt_Total.Text,0));

//    db_kdProduk.Clear;
    db_satuan.Clear;
    db_harga.Clear;
    db_stok.Clear;
    qtt.Clear;
 end;
  end;
     end;
     
procedure TTransaksi_form.btn_hapusClick(Sender: TObject);
var col, row:integer;
	  i,j:integer;
//    p:Integer;
begin
for i :=1 to str_grd_transaksi.RowCount -1 do
   str_grd_transaksi.Rows[i].Clear;
    edt_urut.Text:='1';
      Application.CreateForm(TTransaksi_form, Transaksi_form);
   Application.CreateForm(TPembelian_produk, Pembelian_produk);
    Application.CreateForm(TProduk_form, Produk_form);
       Application.CreateForm(TPenjualan_form, Penjualan_form);
end;

procedure TTransaksi_form.btn_simpanClick(Sender: TObject);
var
i :Integer;
x,stok,qt: integer;
begin
 btn_cetak.Enabled:=True;
  try
//     ==============transaksi
  DataModule1.ADOQuery_Transaksi.Connection:=DataModule1.con1;
  with DataModule1.ADOQuery_Transaksi do
  for i:=1 to str_grd_transaksi.RowCount - 1 do
  begin
    Active:=false;
    Close;
    SQL.Clear;
    SQL.Text := 'INSERT INTO transaksi_(kd_transaksi,nama_pembeli,alamat,tanggal,pembayaran,total_item,total_harga,bayar,kembalian,id_member,id_karyawan)VALUES('
    + QuotedStr(str_grd_transaksi.Cells[1,i]) + ','
    + QuotedStr(nama.Text) + ','
    + QuotedStr(alamat.Text) + ','
    + QuotedStr(FormatDateTime('yyyy-mm-dd',tglTransaksi.Date)) +','
    + QuotedStr(cbb_metodePembayaran.Text) + ','
    + QuotedStr(str_grd_transaksi.Cells[6,i]) + ','
    + QuotedStr(str_grd_transaksi.Cells[7,i]) + ','
    + QuotedStr(edt_Total.Text) + ','
    + QuotedStr(kembalian.Text) + ','
     + QuotedStr(id_member.Text) + ','
      + QuotedStr(id_staff.Text) + ')';
   ExecSQL;
  end;

     //  ==============detTransaksi
   DataModule1.ADOQuery_det_Transaksi.Connection:=DataModule1.con1;
    with DataModule1.ADOQuery_det_Transaksi do
 for i:=1 to str_grd_transaksi.RowCount - 1 do
  begin
    Active:=false;
    Close;
    SQL.Clear;
    SQL.Text:= 'INSERT INTO detail_transaksi(kd_transaksi,kd_produk,nama_produk,satuan,harga_satuan,jml_beli,sub_total,tanggal_trx)VALUES('
    + QuotedStr(str_grd_transaksi.Cells[1,i]) + ','
    + QuotedStr(str_grd_transaksi.Cells[2,i]) + ','
    + QuotedStr(str_grd_transaksi.Cells[3,i]) + ','
    + QuotedStr(str_grd_transaksi.Cells[4,i]) + ','
    + QuotedStr(str_grd_transaksi.Cells[5,i]) + ','
    + QuotedStr(str_grd_transaksi.Cells[6,i]) + ','
    + QuotedStr(str_grd_transaksi.Cells[7,i]) + ','
    + QuotedStr(str_grd_transaksi.Cells[8,i]) + ')';
     ExecSQL;

     btn_simpan.Enabled:=False;
     btn_tmbh.Enabled:=False;
     btn_hapus.Enabled:=False;
  end;
  ShowMessage('Transaksi Sukses');
 except
  Application.MessageBox('Data gagal disimpan dengan sempurna!!!','Peringatan',MB_OK or MB_ICONERROR);
 end;
end;

procedure TTransaksi_form.hitungClick(Sender: TObject);
 var uang, kembalianbeli, totalBayar : Integer;
 Var Digit1 : integer;
 var  sRupiah: string;
 var iRupiah: Currency;

begin
     totalBayar:=StrToInt(edt_Total.Text);
     uang:=StrToInt(cash.Text);
     kembalianbeli:=totalBayar-uang;
     kembalian.Text:=IntToStr(kembalianbeli);
  sRupiah := cash.Text;
  sRupiah := StringReplace(sRupiah,',','',[rfReplaceAll,rfIgnoreCase]);
  sRupiah := StringReplace(sRupiah,'.','',[rfReplaceAll,rfIgnoreCase]);
 iRupiah := StrToCurrDef(sRupiah,0);
   //currency --> format ribuan
  cash.Text := FormatCurr('#,###',iRupiah);
  cash.SelStart := length(cash.text);
end;

procedure TTransaksi_form.btn_addClick(Sender: TObject);
var a,b,hasil: Integer;
var s : String;
var i,tambah: integer;
begin
  btn_simpan.Enabled:=False;
   btn_add.Enabled:=False;
   cbb_NamaProduk.ItemIndex:=-1;
   cbb_NamaProduk.Enabled:=False;
      Application.CreateForm(TTransaksi_form, Transaksi_form);
      btn_simpan.Enabled:=True;
      btn_tmbh.Enabled:=True;
      id_member.Clear;
      ubah.Clear;
   cbb_kategori.Text:='----pilih---';
   nama.Clear;
   alamat.Clear;
   cbb_metodePembayaran.Text:='----pilih---';


   edt_urut.Text:='1';
   tot_item.Clear;
   cash.Clear;
   edt_Total.Text:='0';
   ed_diskon.Clear;
   edt_Staff.Text:=edt_Staff.Text;
cbb_kategori.Enabled:=True;
id_member.Enabled:=True;
nama.Enabled:=True;
alamat.Enabled:=True;
tglTransaksi.Enabled:=True;
cbb_metodePembayaran.Enabled:=True;

 // Application.CreateForm(TTransaksi_form, Transaksi_form);


   //DataModule1.ds_transaksi.DataSet:=DataModule1.ADOQuery_Transaksi;
//  DataModule1.ADOQuery_Transaksi.Connection:=DataModule1.con1;
//   begin
//    DataModule1.ADOQuery_Transaksi.Active:=false;
//    DataModule1.ADOQuery_Transaksi.Close;
//    DataModule1.ADOQuery_Transaksi.SQL.Clear;
//    DataModule1.ADOQuery_Transaksi.SQL.Text:='select*from transaksi_';
//    DataModule1.ADOQuery_Transaksi.Active:=true;
//   end;
 //================
  DataModule1.ds_det_Transaksi.DataSet:=DataModule1.ADOQuery_det_Transaksi;
  DataModule1.ADOQuery_det_Transaksi.Connection:=DataModule1.con1;
   begin
    DataModule1.ADOQuery_det_Transaksi.Active:=false;
    DataModule1.ADOQuery_det_Transaksi.Close;
    DataModule1.ADOQuery_det_Transaksi.SQL.Clear;
    DataModule1.ADOQuery_det_Transaksi.SQL.Text:='select*from detail_transaksi';
    DataModule1.ADOQuery_det_Transaksi.Active:=true;
   end;

   begin
    tambah:=StrToInt(edt_urut.Text);
    kd_trx.Text:= 'TRX-'
    +IntToStr(DataModule1.ADOQuery_det_Transaksi.RecordCount+0-tambah);
   end;
//   Application.CreateForm(TTransaksi_form, Transaksi_form);
//===================================bersih - bersih...
for i :=1 to str_grd_transaksi.RowCount -1 do
   str_grd_transaksi.Rows[i].Clear;
end;

procedure TTransaksi_form.id_memberClick(Sender: TObject);
begin
id_member.Clear;
end;

procedure TTransaksi_form.btn_cetakClick(Sender: TObject);
begin
    with str_grd_transaksi do
 begin
  Tfrxmemoview(frxReport2.FindObject('tanggal')).Memo.Text:=
    FormatDateTime('yyyy-mm-dd',tglTransaksi.Date);
      Tfrxmemoview(frxReport2.FindObject('Id_Member')).Memo.Text:=
    id_member.Text;
      Tfrxmemoview(frxReport2.FindObject('cash')).Memo.Text:=
    cbb_metodePembayaran.Text;
        Tfrxmemoview(frxReport2.FindObject('bayar')).Memo.Text:=
    cash.Text;
        Tfrxmemoview(frxReport2.FindObject('hrs_byr')).Memo.Text:=
    edt_hrs_byr.Text;
    Tfrxmemoview(frxReport2.FindObject('id_staff')).Memo.Text:=
    edt_Staff.Text;

     Tfrxmemoview(frxReport2.FindObject('cb')).Memo.Text:=
    ed_diskon.Text;
     Tfrxmemoview(frxReport2.FindObject('kembalian')).Memo.Text:=
    kembalian.Text;

      Tfrxmemoview(frxReport2.FindObject('no1')).Memo.Text:=
   QuotedStr(str_grd_transaksi.Cells[0,1]) ;
       Tfrxmemoview(frxReport2.FindObject('no2')).Memo.Text:=
   QuotedStr(str_grd_transaksi.Cells[0,2]) ;
       Tfrxmemoview(frxReport2.FindObject('no3')).Memo.Text:=
   QuotedStr(str_grd_transaksi.Cells[0,3]) ;
       Tfrxmemoview(frxReport2.FindObject('no4')).Memo.Text:=
   QuotedStr(str_grd_transaksi.Cells[0,4]) ;
       Tfrxmemoview(frxReport2.FindObject('no5')).Memo.Text:=
   QuotedStr(str_grd_transaksi.Cells[0,5]) ;
       Tfrxmemoview(frxReport2.FindObject('no6')).Memo.Text:=
   QuotedStr(str_grd_transaksi.Cells[0,6]) ;
       Tfrxmemoview(frxReport2.FindObject('no7')).Memo.Text:=
   QuotedStr(str_grd_transaksi.Cells[0,7]) ;

      Tfrxmemoview(frxReport2.FindObject('kd1')).Memo.Text:=
   QuotedStr(str_grd_transaksi.Cells[1,1]);
      Tfrxmemoview(frxReport2.FindObject('kd2')).Memo.Text:=
   QuotedStr(str_grd_transaksi.Cells[1,2]);
      Tfrxmemoview(frxReport2.FindObject('kd3')).Memo.Text:=
   QuotedStr(str_grd_transaksi.Cells[1,3]);
      Tfrxmemoview(frxReport2.FindObject('kd4')).Memo.Text:=
   QuotedStr(str_grd_transaksi.Cells[1,4]);
      Tfrxmemoview(frxReport2.FindObject('kd5')).Memo.Text:=
   QuotedStr(str_grd_transaksi.Cells[1,5]);
      Tfrxmemoview(frxReport2.FindObject('kd6')).Memo.Text:=
   QuotedStr(str_grd_transaksi.Cells[1,6]);
      Tfrxmemoview(frxReport2.FindObject('kd7')).Memo.Text:=
   QuotedStr(str_grd_transaksi.Cells[1,7]);

       Tfrxmemoview(frxReport2.FindObject('nama1')).Memo.Text:=
   QuotedStr(str_grd_transaksi.Cells[3,1]) ;
       Tfrxmemoview(frxReport2.FindObject('nama2')).Memo.Text:=
   QuotedStr(str_grd_transaksi.Cells[3,2]) ;
       Tfrxmemoview(frxReport2.FindObject('nama3')).Memo.Text:=
   QuotedStr(str_grd_transaksi.Cells[3,3]) ;
       Tfrxmemoview(frxReport2.FindObject('nama4')).Memo.Text:=
   QuotedStr(str_grd_transaksi.Cells[3,4]) ;
       Tfrxmemoview(frxReport2.FindObject('nama5')).Memo.Text:=
   QuotedStr(str_grd_transaksi.Cells[3,5]) ;
       Tfrxmemoview(frxReport2.FindObject('nama6')).Memo.Text:=
   QuotedStr(str_grd_transaksi.Cells[3,6]) ;
       Tfrxmemoview(frxReport2.FindObject('nama7')).Memo.Text:=
   QuotedStr(str_grd_transaksi.Cells[3,7]) ;

      Tfrxmemoview(frxReport2.FindObject('satuan1')).Memo.Text:=
   QuotedStr(str_grd_transaksi.Cells[4,1]) ;
      Tfrxmemoview(frxReport2.FindObject('satuan2')).Memo.Text:=
   QuotedStr(str_grd_transaksi.Cells[4,2]) ;
      Tfrxmemoview(frxReport2.FindObject('satuan3')).Memo.Text:=
   QuotedStr(str_grd_transaksi.Cells[4,3]) ;
      Tfrxmemoview(frxReport2.FindObject('satuan4')).Memo.Text:=
   QuotedStr(str_grd_transaksi.Cells[4,4]) ;
      Tfrxmemoview(frxReport2.FindObject('satuan5')).Memo.Text:=
   QuotedStr(str_grd_transaksi.Cells[4,5]) ;
      Tfrxmemoview(frxReport2.FindObject('satuan6')).Memo.Text:=
   QuotedStr(str_grd_transaksi.Cells[4,6]) ;
      Tfrxmemoview(frxReport2.FindObject('satuan7')).Memo.Text:=
   QuotedStr(str_grd_transaksi.Cells[4,7]) ;

      Tfrxmemoview(frxReport2.FindObject('harga1')).Memo.Text:=
   QuotedStr(str_grd_transaksi.Cells[5,1]) ;
      Tfrxmemoview(frxReport2.FindObject('harga2')).Memo.Text:=
   QuotedStr(str_grd_transaksi.Cells[5,2]) ;
      Tfrxmemoview(frxReport2.FindObject('harga3')).Memo.Text:=
   QuotedStr(str_grd_transaksi.Cells[5,3]) ;
      Tfrxmemoview(frxReport2.FindObject('harga4')).Memo.Text:=
   QuotedStr(str_grd_transaksi.Cells[5,4]) ;
      Tfrxmemoview(frxReport2.FindObject('harga5')).Memo.Text:=
   QuotedStr(str_grd_transaksi.Cells[5,5]) ;
      Tfrxmemoview(frxReport2.FindObject('harga6')).Memo.Text:=
   QuotedStr(str_grd_transaksi.Cells[5,6]) ;
      Tfrxmemoview(frxReport2.FindObject('harga7')).Memo.Text:=
   QuotedStr(str_grd_transaksi.Cells[5,7]) ;

      Tfrxmemoview(frxReport2.FindObject('qtt1')).Memo.Text:=
   QuotedStr(str_grd_transaksi.Cells[6,1]) ;
      Tfrxmemoview(frxReport2.FindObject('qtt2')).Memo.Text:=
   QuotedStr(str_grd_transaksi.Cells[6,2]) ;
      Tfrxmemoview(frxReport2.FindObject('qtt3')).Memo.Text:=
   QuotedStr(str_grd_transaksi.Cells[6,3]) ;
      Tfrxmemoview(frxReport2.FindObject('qtt4')).Memo.Text:=
   QuotedStr(str_grd_transaksi.Cells[6,4]) ;
      Tfrxmemoview(frxReport2.FindObject('qtt5')).Memo.Text:=
   QuotedStr(str_grd_transaksi.Cells[6,5]) ;
      Tfrxmemoview(frxReport2.FindObject('qtt6')).Memo.Text:=
   QuotedStr(str_grd_transaksi.Cells[6,6]) ;
      Tfrxmemoview(frxReport2.FindObject('qtt7')).Memo.Text:=
   QuotedStr(str_grd_transaksi.Cells[6,7]) ;

      Tfrxmemoview(frxReport2.FindObject('tot_qtt')).Memo.Text:=
   tot_item.Text;

      Tfrxmemoview(frxReport2.FindObject('tot1')).Memo.Text:=
   QuotedStr(str_grd_transaksi.Cells[7,1]) ;
      Tfrxmemoview(frxReport2.FindObject('tot2')).Memo.Text:=
   QuotedStr(str_grd_transaksi.Cells[7,2]) ;
      Tfrxmemoview(frxReport2.FindObject('tot3')).Memo.Text:=
   QuotedStr(str_grd_transaksi.Cells[7,3]) ;
      Tfrxmemoview(frxReport2.FindObject('tot4')).Memo.Text:=
   QuotedStr(str_grd_transaksi.Cells[7,4]) ;
      Tfrxmemoview(frxReport2.FindObject('tot5')).Memo.Text:=
   QuotedStr(str_grd_transaksi.Cells[7,5]) ;
      Tfrxmemoview(frxReport2.FindObject('tot6')).Memo.Text:=
   QuotedStr(str_grd_transaksi.Cells[7,6]) ;
      Tfrxmemoview(frxReport2.FindObject('tot7')).Memo.Text:=
   QuotedStr(str_grd_transaksi.Cells[7,7]) ;

      Tfrxmemoview(frxReport2.FindObject('tot_bayar')).Memo.Text:=
   edt_Total.Text ;
   end;
frxReport2.ShowReport();
end;

procedure TTransaksi_form.btn_editClick(Sender: TObject);
begin
  btn_Simpan_ubah.Enabled:=False;
btn_ubah_TAMBAH.Enabled:=True;
with DataModule1.ADOQuery_det_Transaksi do
    begin
      Active:=False;
      SQL.Clear;
      SQL.Text:='select * from detail_transaksi where kd_transaksi='+QuotedStr(ubah.Text);
      Active:=True;
      db_kdProduk.Text:=(DataModule1.ADOQuery_det_Transaksi.FieldByName('kd_produk').AsString);
      cbb_NamaProduk.Text:=(DataModule1.ADOQuery_det_Transaksi.FieldByName('nama_produk').AsString);
      db_satuan.Text:=(DataModule1.ADOQuery_det_Transaksi.FieldByName('satuan').AsString);
      db_harga.Text:=(DataModule1.ADOQuery_det_Transaksi.FieldByName('harga_satuan').AsString);
      qtt.Text:=(DataModule1.ADOQuery_det_Transaksi.FieldByName('jml_beli').AsString);
      edt_Total.Text:=(DataModule1.ADOQuery_det_Transaksi.FieldByName('sub_total').AsString);
    end;
end;

procedure TTransaksi_form.ComplineClick(Sender: TObject);
var hrg,dik, dua:Integer;
var akr,tb, totaldis, normal,hrgNormal: Integer;
begin
    hrg:=StrToInt(edt_Total.Text);
    akr:=StrToInt(ed_diskon.Text);
    normal:=StrToInt(edt_Total.Text);
    edt_hrs_byr.Text:=IntToStr(normal);
    cash.SetFocus;
      totaldis:=hrg-akr;
   edt_Total.text:=IntToStr(totaldis);
   lbl_disk.Caption:='harga diskon';
    pnl_terbilang.Caption:=terbilang(StrToFloatDef(edt_Total.Text,0));
 Compline.Enabled:=False;
end;

procedure TTransaksi_form.cashClick(Sender: TObject);
begin
  cash.Clear;
  cash.SetFocus;
end;

procedure TTransaksi_form.tot_itemChange(Sender: TObject);
begin
  cash.Text:='0';
end;

procedure TTransaksi_form.qttChange(Sender: TObject);
begin
    btn_tmbh.Enabled:=True;
    if qtt.Text='' then btn_tmbh.Enabled:=False
end;

procedure TTransaksi_form.edt_TotalChange(Sender: TObject);
  var hrg,dik, dua:Integer;
  var akr,aw,tb,se,li,sa, totaldis: Integer;
begin
  cash.Enabled:=True;
  btn_simpan.Enabled:=True;
 begin
    se:=2000;
    li:=5000;
    sa:=10000;
     aw:=StrToInt(edt_Total.Text);
    if (aw>=100000)AND (cbb_kategori.Text='Member') then ed_diskon.Text:=IntToStr(se)  //dis.Caption:='2%'
    else if (aw>=500000)AND (cbb_kategori.Text='Member') then  ed_diskon.Text:=IntToStr(li) //dis.Caption:='5%'
    else if (aw>=1000000) AND (cbb_kategori.Text='Member') then ed_diskon.Text:=IntToStr(sa) //dis.Caption:='10%'
 end;
end;

procedure TTransaksi_form.ed_diskonChange(Sender: TObject);
begin
      Compline.Enabled:=True;
end;

procedure TTransaksi_form.qttClick(Sender: TObject);
begin
qtt.Clear;
  if cbb_kategori.Text='Member' then Compline.Enabled:=True
 else if cbb_kategori.Text='NonMember' then Compline.Enabled:=False;
end;

procedure TTransaksi_form.btn_ubah_TAMBAHClick(Sender: TObject);
  var i,a,b,gt,subTot : Integer;
  var    sRupiah: string;
  var iRupiah: Currency;
begin
        btn_Simpan_ubah.Enabled:=True;
        btn_ubah_TAMBAH.Enabled:=True;
        a:=StrToInt(db_harga.Text);
         sRupiah := db_harga.Text;
  sRupiah := StringReplace(sRupiah,',','',[rfReplaceAll,rfIgnoreCase]);
  sRupiah := StringReplace(sRupiah,'.','',[rfReplaceAll,rfIgnoreCase]);
 iRupiah := StrToCurrDef(sRupiah,0); //
  db_harga.Text := FormatCurr('#,###',iRupiah);
  db_harga.SelStart := length(db_harga.Text);

    b:=StrToInt(qtt.Text);
    subTot:=a*b;

with str_grd_transaksi do
  begin
   Cells[0,RowCount - 1] := edt_urut.Text;
   Cells[1,RowCount - 1] := ubah.Text;
   Cells[2,RowCount - 1] := db_kdProduk.Text;
   Cells[3,RowCount - 1] := cbb_NamaProduk.Text;
   Cells[4,RowCount - 1] := db_satuan.Text;
   Cells[5,RowCount - 1] := db_harga.Text;
   Cells[6,RowCount - 1] := qtt.Text;
   Cells[7,RowCount - 1] := IntToStr (subTot) ;
   Cells[8,RowCount - 1] := FormatDateTime('yyyy-mm-dd',tglTransaksi.Date);
  end;

  begin
    for i := 1 to str_grd_transaksi.RowCount -1 do
        begin
          str_grd_transaksi.Cells[0,i] := inttostr(i);
        end;
      edt_urut.Text := inttostr(i);
     end;

    //========Total ITEM=======
gt := 0;
for i := 1 to str_grd_transaksi.RowCount -1 do
    begin
        gt := gt + strtoint(str_grd_transaksi.Cells[6,i]);
    end;
tot_item.Text := inttostr(gt);

   //========Total Bayar=======
gt := 0;
for i := 1 to str_grd_transaksi.RowCount -1 do
    begin
      gt := gt + StrToInt(str_grd_transaksi.Cells[7,i]);
      edt_Total.Text := IntToStr(gt);
    end;
      pnl_terbilang.Caption:=terbilang(StrToFloatDef(edt_Total.Text,0));
end;

procedure TTransaksi_form.btn_Simpan_ubahClick(Sender: TObject);
begin
 try DataModule1.con1.BeginTrans;
 with DataModule1.ADOQuery_det_Transaksi do
  begin
  Active:=false;
  Close;
  SQL.Clear;
  SQL.Text:='update detail_transaksi set kd_produk='+QuotedStr(str_grd_transaksi.Cells[2,1]) +
  ',nama_produk='+QuotedStr(str_grd_transaksi.Cells[3,1]) +
  ',satuan='+QuotedStr(str_grd_transaksi.Cells[4,1]) +
  ',harga_satuan='+QuotedStr(str_grd_transaksi.Cells[5,1]) +
  ',jml_beli='+QuotedStr(str_grd_transaksi.Cells[6,1]) +
  ',sub_total='+QuotedStr(str_grd_transaksi.Cells[7,1]) +
  ',tanggal_trx='+QuotedStr(str_grd_transaksi.Cells[8,1]) +
  'where kd_transaksi='+QuotedStr(str_grd_transaksi.Cells[1,1]);
  ExecSQL;
  end;
  DataModule1.con1.CommitTrans;
  ShowMessage('berhasil diupdate');
  begin
    DataModule1.ADOQuery_det_Transaksi.Active:=false;
    DataModule1.ADOQuery_det_Transaksi.Close;
    DataModule1.ADOQuery_det_Transaksi.SQL.Clear;
    DataModule1.ADOQuery_det_Transaksi.SQL.Text:='select*from detail_transaksi';
    DataModule1.ADOQuery_det_Transaksi.Active:=true;
  end;
  except
    DataModule1.con1.RollbackTrans;
    ShowMessage('gagal update');
  end;
end;

procedure TTransaksi_form.rb_editClick(Sender: TObject);
begin
  grp_EDIT.Enabled:=True;
  ubah.Clear;
  ubah.SetFocus;
  cbb_kategori.Enabled:=False;
  id_member.Enabled:=False;
  nama.Enabled:=False;
  alamat.Enabled:=False;
  tglTransaksi.Enabled:=False;
  cbb_metodePembayaran.Enabled:=False;
  btn_tmbh.Enabled:=False;
  btn_hapus.Enabled:=False;
  btn_Simpan_ubah.Enabled:=False;
  btn_ubah_TAMBAH.Enabled:=False;
end;

procedure TTransaksi_form.ubahClick(Sender: TObject);
begin
  rb_edit.Checked:=False;
end;

procedure TTransaksi_form.FormShow(Sender: TObject);
begin
  Login_form_.edt_duplikast2_:=Transaksi_form.edt_Staff;
  Login_form_.edt_duplikast2_.Visible:=true;
  edt_Staff.Enabled:=False;
  tglTransaksi.DateTime:=Now;
  ed_diskon.Text:='0';
DataModule1.ADOQuery_Produk.First;
 While not DataModule1.ADOQuery_Produk.Eof do
  begin
  cbb_NamaProduk.Items.Add(DataModule1.ADOQuery_Produk['nama_produk']);
  DataModule1.ADOQuery_Produk.Next;
 end;
end;

procedure TTransaksi_form.id_memberChange(Sender: TObject);
begin
  if (cbb_kategori.Text='NonMember') then
with DataModule1.ADOQuery_Member do
    begin
      Active:=False;
      SQL.Clear;
      SQL.Text:='select * from members_ where id_member='+QuotedStr(id_member.Text);
      Active:=True;
      nama.Text:=(DataModule1.ADOQuery_Member.FieldByName('nama_member').AsString);
      alamat.Text:=(DataModule1.ADOQuery_Member.FieldByName('alamat').AsString);
    end
    else if (cbb_kategori.Text='Member') then
end;

procedure TTransaksi_form.cbb_kategoriChange(Sender: TObject);
begin
  if cbb_kategori.Text='Member' then
     begin
     id_member.Clear;
     nama.Text:='';
     alamat.Text:='';
     Grb_member.Enabled:=True;
     id_member.Enabled:=True;
     Compline.Enabled:=True;
     id_member.SetFocus;
     id_member.Clear;
     end
  else if cbb_kategori.Text='NonMember' then //if cbb_kategori.Text='NonMember' then
     //===
    Grb_member.Enabled:=False;
  id_member.Text:='Non';
  btn_member.Click;
  Compline.Enabled:=False;
end;

procedure TTransaksi_form.edt_hrs_byrChange(Sender: TObject);
begin
cash.Enabled:=True;
end;

procedure TTransaksi_form.edt_StaffChange(Sender: TObject);
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

procedure TTransaksi_form.cbb_metodePembayaranChange(Sender: TObject);
begin
  cbb_NamaProduk.Enabled:=True;
  cbb_NamaProduk.SetFocus;
end;

end.
