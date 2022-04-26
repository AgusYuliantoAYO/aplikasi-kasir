object Login_form_: TLogin_form_
  Left = 650
  Top = 236
  Width = 439
  Height = 298
  Caption = 'Login_'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object grpLoginGroup: TGroupBox
    Left = 48
    Top = 64
    Width = 337
    Height = 129
    Caption = 'Login'
    Color = clWhite
    ParentColor = False
    TabOrder = 0
    object lbl2: TLabel
      Left = 56
      Top = 64
      Width = 69
      Height = 16
      Caption = 'Password'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tekton Pro Ext'
      Font.Style = [fsBold, fsItalic]
      ParentFont = False
    end
    object btn_cancel: TBitBtn
      Left = 192
      Top = 96
      Width = 75
      Height = 25
      Caption = 'Cancel'
      TabOrder = 0
      OnClick = btn_cancelClick
    end
    object edt_id_staff: TEdit
      Left = 128
      Top = 56
      Width = 113
      Height = 21
      TabOrder = 1
    end
    object Login: TButton
      Left = 112
      Top = 96
      Width = 75
      Height = 25
      Caption = 'Login'
      TabOrder = 2
      OnClick = LoginClick
    end
    object edt_nama: TEdit
      Left = 128
      Top = 24
      Width = 25
      Height = 21
      Enabled = False
      TabOrder = 3
    end
  end
  object edt_duplikast2_: TEdit
    Left = 240
    Top = 88
    Width = 25
    Height = 21
    Enabled = False
    TabOrder = 1
  end
  object edt_duplikat1_: TEdit
    Left = 208
    Top = 88
    Width = 25
    Height = 21
    Enabled = False
    TabOrder = 2
  end
end
