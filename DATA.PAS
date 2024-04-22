unit data;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables;

type
  TDM = class(TDataModule)
    DB: TDatabase;
    Fingers: TTable;
    TDateIns: TTable;
    TDateInsDateInstall: TStringField;
    TDateInsYI: TStringField;
    TDateInsMi: TStringField;
    TDateInsDi: TStringField;
    TDateInsDateRezerv: TStringField;
    TDateInsYr: TStringField;
    TDateInsMr: TStringField;
    TDateInsDr: TStringField;
    FingersID: TStringField;
    FingersFingerID: TFloatField;
    FingersFingerPrint: TBlobField;
    FingersFingerPrintFast: TBlobField;
    Emp: TTable;
    DSAtentEmploy: TDataSource;
    Tpath: TTable;
    TpathDir: TStringField;
    TpathModApp: TStringField;
    TpathModControl: TStringField;
    TpathPass: TStringField;
    ContrloLog: TTable;
    ContrloLogId: TStringField;
    ContrloLogCode: TStringField;
    ContrloLogActDate: TStringField;
    ContrloLogActTime: TStringField;
    ContrloLogSendFlag: TStringField;
    EmpID: TStringField;
    EmpFname: TStringField;
    EmpLName: TStringField;
    EmpDadName: TStringField;
    EmpPNo: TStringField;
    EmpBCN: TStringField;
    EmpBDate: TIntegerField;
    EmpGender: TIntegerField;
    EmpState: TIntegerField;
    EmpNid: TStringField;
    EmpPCode: TStringField;
    EmpPresent: TIntegerField;
    EmpVizaIn: TBooleanField;
    Emppassword1: TStringField;
    Emppassword2: TStringField;
    ContrloLogactDateMilad: TStringField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DM: TDM;

implementation

{$R *.DFM}

end.
