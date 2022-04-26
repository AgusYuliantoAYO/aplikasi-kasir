unit QRStokBarang;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls, frxpngimage;

type
  TQRStok = class(TQuickRep)
    qrbndDetailBand1: TQRBand;
    qrbndPageHeaderBand1: TQRBand;
    qrbndColumnHeaderBand1: TQRBand;
    Cetak: TQRLabel;
    qrchtxt1: TQRRichText;
    qrlbl4: TQRLabel;
    img1: TQRImage;
    qrlblno: TQRLabel;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText5: TQRDBText;
    QRDBText6: TQRDBText;
    qrlbl5: TQRLabel;
    QRDBText7: TQRDBText;
    QRSysData1: TQRSysData;
  private

  public

  end;

var
  QRStok: TQRStok;

implementation
            uses DM;
{$R *.DFM}

end.
