object dmfrm: Tdmfrm
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Left = 192
  Top = 133
  Height = 261
  Width = 386
  object SysConnection1: TADOConnection
    LoginPrompt = False
    Left = 32
    Top = 8
  end
  object UserCnn: TADOConnection
    LoginPrompt = False
    Left = 24
    Top = 64
  end
  object CnnMaster: TADOConnection
    LoginPrompt = False
    Left = 128
    Top = 32
  end
end
