unit QRSupplier;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls, frxpngimage;

type
  TQRSuplier = class(TQuickRep)
    QRDaftarSupplier: TQRBand;
    qrbndDetailBand1: TQRBand;
    qrbndPageHeaderBand1: TQRBand;
    img1: TQRImage;
    qrlbl4: TQRLabel;
    qrchtxt1: TQRRichText;
    Cetak: TQRLabel;
    qrlblno: TQRLabel;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText5: TQRDBText;
    qrlbl5: TQRLabel;
    QRDBText6: TQRDBText;
    QRSysData1: TQRSysData;
  private

  public

  end;

var
  QRSuplier: TQRSuplier;

implementation
    uses dm;
{$R *.DFM}

end.
