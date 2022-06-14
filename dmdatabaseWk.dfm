object dmDatabase: TdmDatabase
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 239
  Width = 402
  object DBConnection: TFDConnection
    Params.Strings = (
      'Database=wkteste'
      'User_Name=root'
      'Password=@realsys27'
      'Server=localhost'
      'CharacterSet=latin1'
      'DriverID=MySQL')
    Connected = True
    LoginPrompt = False
    Left = 40
    Top = 128
  end
  object FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink
    VendorLib = 
      'C:\Program Files (x86)\MySQL\MySQL Connector C 6.1\lib\libmysql.' +
      'dll'
    Left = 136
    Top = 24
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    ScreenCursor = gcrHourGlass
    Left = 136
    Top = 80
  end
  object FDGUIxErrorDialog1: TFDGUIxErrorDialog
    Provider = 'Forms'
    Caption = 'FireDAC Executor Error'
    Left = 224
    Top = 80
  end
  object FDGUIxLoginDialog1: TFDGUIxLoginDialog
    Provider = 'Forms'
    Left = 224
    Top = 32
  end
end
