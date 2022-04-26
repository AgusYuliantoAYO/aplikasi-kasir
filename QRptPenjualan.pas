unit QRptPenjualan;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls, DB, ADODB, frxpngimage;

type
  TQuickReportPenjualan = class(TQuickRep)
    PageHeaderBand1: TQRBand;
    Cetak: TQRLabel;
    garis: TQRBand;
    qrbnd2: TQRBand;
    harga: TQRLabel;
    no: TQRLabel;
    id_transaksi: TQRLabel;
    nama_produk: TQRLabel;
    qtt: TQRLabel;
    total: TQRLabel;
    qrbnd1: TQRBand;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    kd_transaksi: TQRDBText;
    QRDBText4: TQRDBText;
    harga_satuan: TQRDBText;
    jml_beli: TQRDBText;
    sub_total: TQRDBText;
    QRDBText3: TQRDBText;
    QRDBText5: TQRDBText;
    PageFooterBand1: TQRBand;
    QRDBText7: TQRDBText;
    QRDBText8: TQRDBText;
    QRDBText6: TQRDBText;
    qrchtxt1: TQRRichText;
    img1: TQRImage;
    qrlbl1: TQRLabel;
    qrlbl2: TQRLabel;
    qrlbl3: TQRLabel;
    qrlbl4: TQRLabel;
    qrlbl5: TQRLabel;
    qrlbl6: TQRLabel;
    qrlbl7: TQRLabel;
    QRLabel1: TQRLabel;
    QRDBText9: TQRDBText;
    QRSysData1: TQRSysData;
  private

  public

  end;

var
  QuickReportPenjualan: TQuickReportPenjualan;

implementation
          uses DM;
{$R *.DFM}

end.
