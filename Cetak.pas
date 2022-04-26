unit Cetak;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls, DB, ADODB, frxpngimage;

type
  TQckReport1 = class(TQuickRep)
    qrbnd1: TQRBand;
    QRDBText1: TQRDBText;
    qrchldbnd1: TQRChildBand;
    qrbnd2: TQRBand;
    QRDBText2: TQRDBText;
    kd_transaksi: TQRDBText;
    QRDBText4: TQRDBText;
    jml_beli: TQRDBText;
    sub_total: TQRDBText;
    PageFooterBand1: TQRBand;
    PageHeaderBand1: TQRBand;
    harga: TQRLabel;
    no: TQRLabel;
    id_transaksi: TQRLabel;
    nama_produk: TQRLabel;
    qtt: TQRLabel;
    total: TQRLabel;
    Cetak: TQRLabel;
    QRDBText3: TQRDBText;
    QRDBText5: TQRDBText;
    QRDBText6: TQRDBText;
    qrlbl1: TQRLabel;
    img1: TQRImage;
    qrlbl2: TQRLabel;
    qrlbl3: TQRLabel;
    qrchtxt1: TQRRichText;
    qrlbl4: TQRLabel;
    QRSysData1: TQRSysData;
    QRDBText7: TQRDBText;
    qrlbl5: TQRLabel;
  private

  public

  end;

var
  QckReport1: TQckReport1;

implementation
         uses Laporan,DM;

{$R *.DFM}

end.
