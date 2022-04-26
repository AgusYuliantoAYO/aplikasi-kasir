object Karyawan_Form: TKaryawan_Form
  Left = 195
  Top = 197
  Width = 1096
  Height = 480
  Align = alClient
  Caption = 'Karyawan'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lbl9: TLabel
    Left = 352
    Top = 24
    Width = 115
    Height = 36
    Caption = 'Karyawan'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'Gill Sans Ultra Bold Condensed'
    Font.Style = []
    ParentFont = False
  end
  object grp1: TGroupBox
    Left = 24
    Top = 72
    Width = 289
    Height = 369
    Caption = 'Data'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Futura Md BT'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object lbl1: TLabel
      Left = 8
      Top = 24
      Width = 45
      Height = 16
      Caption = 'ID Staff'
    end
    object lbl2: TLabel
      Left = 8
      Top = 112
      Width = 41
      Height = 16
      Caption = 'Nama '
    end
    object lbl3: TLabel
      Left = 8
      Top = 144
      Width = 43
      Height = 16
      Caption = 'Alamat'
    end
    object lbl4: TLabel
      Left = 8
      Top = 216
      Width = 83
      Height = 16
      Caption = 'Tgl. Registrasi'
    end
    object lbl5: TLabel
      Left = 24
      Top = 248
      Width = 63
      Height = 16
      Caption = 'No Telpon'
    end
    object lbl8: TLabel
      Left = 8
      Top = 184
      Width = 94
      Height = 16
      Caption = 'Struktur Bagian'
    end
    object lbl7: TLabel
      Left = 8
      Top = 72
      Width = 58
      Height = 16
      Caption = 'Password'
    end
    object tglRegis: TDateTimePicker
      Left = 104
      Top = 208
      Width = 130
      Height = 24
      Date = 43810.744730497690000000
      Time = 43810.744730497690000000
      Enabled = False
      TabOrder = 0
    end
    object nama: TEdit
      Left = 88
      Top = 112
      Width = 153
      Height = 24
      TabOrder = 1
      OnChange = namaChange
      OnClick = namaClick
    end
    object alamat: TEdit
      Left = 88
      Top = 144
      Width = 177
      Height = 24
      TabOrder = 2
      OnClick = alamatClick
    end
    object no_telp: TEdit
      Left = 104
      Top = 240
      Width = 153
      Height = 24
      TabOrder = 3
      OnClick = no_telpClick
    end
    object grp_input: TGroupBox
      Left = 0
      Top = 288
      Width = 113
      Height = 81
      Enabled = False
      TabOrder = 4
      object btn_simpan: TBitBtn
        Left = 16
        Top = 16
        Width = 75
        Height = 57
        Caption = 'Simpan'
        TabOrder = 0
        OnClick = btn_simpanClick
      end
    end
    object grp_up: TGroupBox
      Left = 144
      Top = 288
      Width = 121
      Height = 81
      Enabled = False
      TabOrder = 5
      object btn_update: TBitBtn
        Left = 32
        Top = 16
        Width = 51
        Height = 25
        Caption = 'Update'
        TabOrder = 0
        OnClick = btn_updateClick
      end
      object btn_delete: TBitBtn
        Left = 24
        Top = 48
        Width = 75
        Height = 25
        Caption = 'Delete'
        TabOrder = 1
        OnClick = btn_deleteClick
      end
    end
    object grp_rb: TGroupBox
      Left = 0
      Top = 264
      Width = 289
      Height = 33
      TabOrder = 6
      object rb_kiri: TRadioButton
        Left = 40
        Top = 8
        Width = 33
        Height = 17
        TabOrder = 0
        OnClick = rb_kiriClick
      end
      object rb_kanan: TRadioButton
        Left = 176
        Top = 8
        Width = 33
        Height = 17
        TabOrder = 1
        OnClick = rb_kananClick
      end
      object pnl1: TPanel
        Left = 160
        Top = 8
        Width = 65
        Height = 25
        TabOrder = 2
      end
    end
    object cbb_struktur: TComboBox
      Left = 112
      Top = 176
      Width = 145
      Height = 24
      ItemHeight = 16
      TabOrder = 7
      OnChange = cbb_strukturChange
      OnClick = cbb_strukturClick
      Items.Strings = (
        'AA'
        'ASNAKES')
    end
    object id_karyawan: TEdit
      Left = 104
      Top = 24
      Width = 121
      Height = 24
      Enabled = False
      TabOrder = 8
    end
    object edt_password: TEdit
      Left = 104
      Top = 72
      Width = 121
      Height = 24
      TabOrder = 9
      OnClick = edt_passwordClick
    end
  end
  object grp2: TGroupBox
    Left = 327
    Top = 80
    Width = 753
    Height = 297
    Caption = 'Entry'
    TabOrder = 1
    object lbl6: TLabel
      Left = 280
      Top = 232
      Width = 19
      Height = 13
      Caption = 'Cari'
    end
    object cbb_berdasarkan: TComboBox
      Left = 320
      Top = 224
      Width = 145
      Height = 21
      ItemHeight = 13
      TabOrder = 0
      Text = '--- Berdasarkan ---'
      OnChange = cbb_berdasarkanChange
      Items.Strings = (
        'ID Staff'
        'Nama'
        'Alamat'
        'Tanggal Registrasi'
        'Nomor HP')
    end
    object search: TEdit
      Left = 528
      Top = 224
      Width = 121
      Height = 21
      Enabled = False
      TabOrder = 1
      OnChange = searchChange
      OnClick = searchClick
    end
    object dbgrd_karyawan: TDBGrid
      Left = 24
      Top = 80
      Width = 721
      Height = 120
      DataSource = DataModule1.ds_karyawan
      TabOrder = 2
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      OnCellClick = dbgrd_karyawanCellClick
    end
    object btn_tampil: TBitBtn
      Left = 16
      Top = 48
      Width = 81
      Height = 25
      Caption = 'Tampil Data'
      Enabled = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Futura Md BT'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      OnClick = btn_tampilClick
    end
  end
end
