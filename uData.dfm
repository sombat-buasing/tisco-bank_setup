object dmData: TdmData
  OldCreateOrder = False
  Height = 347
  Width = 769
  object tiscoConnection: TUniConnection
    ProviderName = 'SQL Server'
    Database = 'TISCO_Bank'
    Username = 'sa'
    Server = 'UMS-SERVDB'
    Left = 40
    Top = 56
    EncryptedPassword = '8AFF91FF96FF8CFF9EFF92FF97FF90FF'
  end
  object qryFind: TUniQuery
    Connection = tiscoConnection
    Left = 40
    Top = 136
  end
  object dsFind: TUniDataSource
    DataSet = qryFind
    Left = 40
    Top = 224
  end
  object SQLServerUniProvider1: TSQLServerUniProvider
    Left = 144
    Top = 32
  end
  object qryData: TUniQuery
    Connection = tiscoConnection
    Left = 136
    Top = 120
  end
  object dsData: TUniDataSource
    DataSet = qryData
    Left = 136
    Top = 224
  end
end
