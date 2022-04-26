object Login_form: TLogin_form
  Left = 247
  Top = 426
  Width = 416
  Height = 186
  Align = alCustom
  Caption = 'Login'
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Futura Md BT'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 16
  object grpLoginGroup: TGroupBox
    Left = 24
    Top = 8
    Width = 337
    Height = 129
    Caption = 'Login'
    TabOrder = 0
    object lbl1: TLabel
      Left = 40
      Top = 24
      Width = 62
      Height = 16
      Caption = 'Username'
    end
    object lbl2: TLabel
      Left = 40
      Top = 56
      Width = 58
      Height = 16
      Caption = 'Password'
    end
    object btn_cancel: TBitBtn
      Left = 184
      Top = 96
      Width = 75
      Height = 25
      Caption = 'Cancel'
      TabOrder = 0
    end
    object edt_id_staff: TEdit
      Left = 128
      Top = 56
      Width = 121
      Height = 24
      TabOrder = 1
    end
    object Login: TButton
      Left = 104
      Top = 96
      Width = 75
      Height = 25
      Caption = 'Login'
      TabOrder = 2
    end
    object edt_nama: TEdit
      Left = 120
      Top = 16
      Width = 129
      Height = 24
      TabOrder = 3
    end
  end
end
