object DataModule1: TDataModule1
  OldCreateOrder = False
  Left = 697
  Top = 116
  Height = 652
  Width = 453
  object con1: TADOConnection
    Connected = True
    ConnectionString = 
      'Provider=SQLOLEDB.1;Integrated Security=SSPI;Persist Security In' +
      'fo=False;Initial Catalog=Apotek Sugih Waras;Data Source=USER-PC'
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
    Left = 88
    Top = 40
  end
  object ADOTable_Produk: TADOTable
    Active = True
    Connection = con1
    CursorType = ctStatic
    TableName = 'produk_stk'
    Left = 152
    Top = 40
  end
  object ds_produk: TDataSource
    DataSet = ADOTable_Produk
    Left = 232
    Top = 40
  end
  object ADOTable_Member: TADOTable
    Active = True
    Connection = con1
    CursorType = ctStatic
    TableName = 'members_'
    Left = 152
    Top = 112
  end
  object ds_member: TDataSource
    DataSet = ADOTable_Member
    Left = 240
    Top = 104
  end
  object ADOTable_Supplier: TADOTable
    Active = True
    Connection = con1
    CursorType = ctStatic
    TableName = 'supplier_'
    Left = 152
    Top = 168
  end
  object ds_supplier: TDataSource
    DataSet = ADOTable_Supplier
    Left = 240
    Top = 168
  end
  object ds_transaksi: TDataSource
    DataSet = ADOTable_Transaksi
    Left = 240
    Top = 232
  end
  object ADOTable_Transaksi: TADOTable
    Active = True
    Connection = con1
    CursorType = ctStatic
    TableName = 'transaksi_'
    Left = 152
    Top = 232
  end
  object ADOQuery_Produk: TADOQuery
    Active = True
    Connection = con1
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select * from produk_stk')
    Left = 328
    Top = 48
  end
  object ADOQuery_Member: TADOQuery
    Active = True
    Connection = con1
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select * from members_')
    Left = 328
    Top = 104
  end
  object ADOQuery_Supplier: TADOQuery
    Active = True
    Connection = con1
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select * from supplier_')
    Left = 328
    Top = 160
  end
  object ADOQuery_Satuan: TADOQuery
    Active = True
    Connection = con1
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select * from satuan')
    Left = 328
    Top = 440
  end
  object ADOQuery_det_Transaksi: TADOQuery
    Active = True
    Connection = con1
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select * from detail_transaksi')
    Left = 320
    Top = 368
  end
  object ds_det_Transaksi: TDataSource
    DataSet = ADOQuery_det_Transaksi
    Left = 208
    Top = 368
  end
  object ADOQuery_Transaksi: TADOQuery
    Active = True
    Connection = con1
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select * from transaksi_')
    Left = 336
    Top = 232
  end
  object ADOTable_JenisProduk: TADOTable
    Active = True
    Connection = con1
    CursorType = ctStatic
    TableName = 'jenis_produk'
    Left = 136
    Top = 520
  end
  object ds_JenisProduk: TDataSource
    DataSet = ADOTable_JenisProduk
    Left = 232
    Top = 520
  end
  object ADOQuery_JenisProduk: TADOQuery
    Active = True
    Connection = con1
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select * from jenis_produk')
    Left = 336
    Top = 512
  end
  object ds_det_Produk_stk: TDataSource
    DataSet = ADOQuery_det_Produk
    Left = 232
  end
  object ADOQuery_det_Produk: TADOQuery
    Active = True
    Connection = con1
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select * from detail_produk_stk')
    Left = 344
    Top = 8
  end
  object ADOTable_Karyawan: TADOTable
    Active = True
    Connection = con1
    CursorType = ctStatic
    TableName = 'karyawan'
    Left = 152
    Top = 312
  end
  object ds_karyawan: TDataSource
    DataSet = ADOQuery_karyawan
    Left = 248
    Top = 312
  end
  object ADOQuery_karyawan: TADOQuery
    Active = True
    Connection = con1
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select * from karyawan')
    Left = 344
    Top = 304
  end
  object ADOTable_det_produk: TADOTable
    Active = True
    Connection = con1
    CursorType = ctStatic
    TableName = 'detail_produk_stk'
    Left = 152
  end
end
