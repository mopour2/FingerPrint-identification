unit RunRepAp;

interface

uses
  Windows, Messages, SysUtils,  Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, DB, DBTables;

type
  TForm1 = class(TForm)
    TabelLog: TTable;
    DataSource1: TDataSource;
    Button1: TButton;
    Edit1: TEdit;
    Timer1: TTimer;
    procedure Button1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure logfile2;
  end;

var
  Form1: TForm1;
  PI: TProcessInformation;
  ExitFlag:boolean;
  LogMes:string;
  ContRepAppli:integer;
implementation

{$R *.dfm}
//*************************************************************************
procedure TForm1.Button1Click(Sender: TObject);
begin
 ExitFlag:=false ;

LogMes:='Exit Rep Applicatin Rep Number'+inttostr(ContRepAppli);
logfile2;
close;
end;
//*************************************************************************
procedure TForm1.Timer1Timer(Sender: TObject);
var
 Com: String;
 Par: String;
 ExitCode: longbool;
 SI: TStartupInfo;
 Dir : AnsiString;
begin
edit1.Text:=inttostr(ContRepAppli);
LogMes:='Rep Applicatin Number  '+inttostr(ContRepAppli);
logfile2;
ContRepAppli:=ContRepAppli+1;

 Dir :=  GetCurrentDir;
 Com:=Dir+'\P_FP_Pers.exe';
 Par:='';
 SI.wShowWindow := SW_SHOW	;//SW_Hide;
 SI.cb := SizeOf(SI);
 SI.lpReserved:= nil;
 SI.lpDesktop := nil;
 SI.lpTitle := nil;
 SI.dwFlags := STARTF_USESHOWWINDOW;
 SI.cbReserved2 := 0;
 SI.lpReserved2 := nil;

 Timer1.Enabled:=false;
 sleep(5000);
 ExitCode:= CreateProcess({Pchar(Com)}nil,PChar(Com+Par),nil,nil,False,Create_Default_Error_Mode,nil,nil,SI,PI);
 if ExitCode=False then
 begin
    showmessage('Can not create process');
    Exit;
 end;
 WaitForSingleObject(pi.hProcess,INFINITE);
//end;//end while
Timer1.Enabled:=true;
end;

//******************************************************************

procedure TForm1.FormShow(Sender: TObject);
var
 Com: String;
 Par: String;
 ExitCode: longbool;
 SI: TStartupInfo;
 Dir : AnsiString;
begin
ExitFlag:=true;
LogMes:='Start Rep Applicatin';
logfile2;
ContRepAppli:=1;
{
while (ExitFlag=true) do
begin
 Dir :=  GetCurrentDir;
 Com:=Dir+'\Voice.exe';
 Par:='';
 SI.wShowWindow := SW_SHOW	;//SW_Hide;
 SI.cb := SizeOf(SI);
 SI.lpReserved:= nil;
 SI.lpDesktop := nil;
 SI.lpTitle := nil;
 SI.dwFlags := STARTF_USESHOWWINDOW;
 SI.cbReserved2 := 0;
 SI.lpReserved2 := nil;


 ExitCode:= CreateProcess(nil,PChar(Com+Par),nil,nil,False,Create_Default_Error_Mode,nil,nil,SI,PI);
 if ExitCode=False then
 begin
    showmessage('Can not create process');
    Exit;
 end;

 WaitForSingleObject(pi.hProcess,INFINITE);
end;//end while
}

end;


//*********************************************************************
procedure TForm1.logfile2;
begin
 TabelLog.Open;
 TabelLog.insert;
 TabelLog.FieldByName('line').asstring:='1';
 TabelLog.FieldByName('V_line').asinteger:=1;
 TabelLog.FieldByName('TypeLog').asstring:='1';
 TabelLog.FieldByName('LogStr').asstring:=LogMes;
 TabelLog.FieldByName('State').asinteger:=1;
 TabelLog.FieldByName('LastState').asinteger:=1;
 TabelLog.FieldByName('Date1').asstring:=datetostr(date);
 TabelLog.FieldByName('Time1').asstring:=timetostr(date);
 TabelLog.post;
 TabelLog.close;
end;
//*********************************************************************

end.
