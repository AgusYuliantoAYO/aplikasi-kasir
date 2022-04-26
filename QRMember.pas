unit QRMember;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls, frxpngimage;

type
  TQuickR_MEMBER = class(TQuickRep)
    qrbndColumnHeaderBand1: TQRBand;
    qrbndPageHeaderBand1: TQRBand;
    qrbndDetailBand1: TQRBand;
    qrdbtxt1: TQRDBText;
    qrchtxt1: TQRRichText;
    qrlbl4: TQRLabel;
    img1: TQRImage;
    Cetak: TQRLabel;
    qrlblno: TQRLabel;
    qrlbl1: TQRLabel;
    qrlbl2: TQRLabel;
    qrlbl3: TQRLabel;
    qrlbl5: TQRLabel;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    QRLabel1: TQRLabel;
    QRDBText5: TQRDBText;
    QRSysData1: TQRSysData;
  private

  public

  end;

var
  QuickR_MEMBER: TQuickR_MEMBER;

implementation
  uses DM;
{$R *.DFM}

end.
