object DM: TDM
  OldCreateOrder = False
  Left = 141
  Top = 196
  Height = 479
  Width = 741
  object DB: TDatabase
    AliasName = 'dbfinger'
    Connected = True
    DatabaseName = 'DBFINGLocal'
    LoginPrompt = False
    Params.Strings = (
      'USER NAME=test')
    SessionName = 'Default'
    Left = 400
    Top = 8
  end
  object Fingers: TTable
    DatabaseName = 'DBFINGLocal'
    TableName = 'dbo.AtentFingers'
    Left = 24
    Top = 72
    object FingersID: TStringField
      FieldName = 'ID'
      Required = True
      Size = 30
    end
    object FingersFingerID: TFloatField
      FieldName = 'FingerID'
      Required = True
    end
    object FingersFingerPrint: TBlobField
      FieldName = 'FingerPrint'
      BlobType = ftBlob
      Size = 1
    end
    object FingersFingerPrintFast: TBlobField
      FieldName = 'FingerPrintFast'
      BlobType = ftBlob
      Size = 1
    end
  end
  object TDateIns: TTable
    TableName = 'DateInst.db'
    Left = 480
    Top = 80
    object TDateInsDateInstall: TStringField
      FieldName = 'DateInstall'
      Size = 12
    end
    object TDateInsYI: TStringField
      FieldName = 'YI'
      Size = 4
    end
    object TDateInsMi: TStringField
      FieldName = 'Mi'
      Size = 2
    end
    object TDateInsDi: TStringField
      FieldName = 'Di'
      Size = 2
    end
    object TDateInsDateRezerv: TStringField
      FieldName = 'DateRezerv'
      Size = 12
    end
    object TDateInsYr: TStringField
      FieldName = 'Yr'
      Size = 4
    end
    object TDateInsMr: TStringField
      FieldName = 'Mr'
      Size = 2
    end
    object TDateInsDr: TStringField
      FieldName = 'Dr'
      Size = 2
    end
  end
  object Emp: TTable
    DatabaseName = 'DBFINGLocal'
    TableName = 'dbo.AtentEmploy'
    Left = 24
    Top = 16
    object EmpID: TStringField
      FieldName = 'ID'
      Size = 30
    end
    object EmpFname: TStringField
      FieldName = 'Fname'
      Size = 50
    end
    object EmpLName: TStringField
      FieldName = 'LName'
      Size = 50
    end
    object EmpDadName: TStringField
      FieldName = 'DadName'
      Size = 50
    end
    object EmpPNo: TStringField
      FieldName = 'PNo'
      Size = 50
    end
    object EmpBCN: TStringField
      FieldName = 'BCN'
      Size = 50
    end
    object EmpBDate: TIntegerField
      FieldName = 'BDate'
    end
    object EmpGender: TIntegerField
      FieldName = 'Gender'
    end
    object EmpState: TIntegerField
      FieldName = 'State'
    end
    object EmpNid: TStringField
      FieldName = 'Nid'
      Size = 50
    end
    object EmpPCode: TStringField
      FieldName = 'PCode'
      Size = 50
    end
    object EmpPresent: TIntegerField
      FieldName = 'Present'
    end
    object EmpVizaIn: TBooleanField
      FieldName = 'VizaIn'
    end
    object Emppassword1: TStringField
      FieldName = 'password1'
      Size = 50
    end
    object Emppassword2: TStringField
      FieldName = 'password2'
      Size = 50
    end
  end
  object DSAtentEmploy: TDataSource
    DataSet = Emp
    Left = 96
    Top = 16
  end
  object Tpath: TTable
    TableName = 'seting.db'
    Left = 480
    Top = 136
    object TpathDir: TStringField
      FieldName = 'Dir'
      Size = 100
    end
    object TpathModApp: TStringField
      FieldName = 'ModApp'
      Size = 2
    end
    object TpathModControl: TStringField
      FieldName = 'ModControl'
      Size = 2
    end
    object TpathPass: TStringField
      FieldName = 'Pass'
    end
  end
  object ContrloLog: TTable
    DatabaseName = 'DBFINGLocal'
    TableName = 'dbo.ControlLog'
    Left = 24
    Top = 136
    object ContrloLogId: TStringField
      FieldName = 'Id'
      Size = 30
    end
    object ContrloLogCode: TStringField
      FieldName = 'Code'
      Size = 50
    end
    object ContrloLogActDate: TStringField
      FieldName = 'ActDate'
      Size = 15
    end
    object ContrloLogActTime: TStringField
      FieldName = 'ActTime'
      Size = 15
    end
    object ContrloLogSendFlag: TStringField
      FieldName = 'SendFlag'
      Size = 1
    end
    object ContrloLogactDateMilad: TStringField
      FieldName = 'actDateMilad'
      Size = 15
    end
  end
end
