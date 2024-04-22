unit UMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, StdCtrls, jpeg, ExtCtrls;

type
  TFMain = class(TForm)
    MainMenu1: TMainMenu;
    Panel1: TPanel;
    Image1: TImage;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    procedure N2Click(Sender: TObject);
    procedure N7Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
//   procedure SetToInDate;
   procedure SetDateInstall;
   procedure SetDateDay;
   procedure RunProc(Str:String);
    { Public declarations }
  end;

var
  FMain: TFMain;
 Dir : AnsiString;
 datei,Yi,Mi,Di:string;
 dater,Yr,Mr,Dr:string;
 dCurent:TdateTime;
 d:TdateTime;
 PI: TProcessInformation;
implementation

uses Addfing,data, servis ,io_rw,ioport;

{$R *.DFM}

procedure TFMain.N2Click(Sender: TObject);
begin
//  Msg.Visible := True;
  AddfingForm := TAddfingForm.Create(Application);
  AddfingForm.ShowModal;
  AddfingForm.Free;

 // Msg.Visible := False;

end;

procedure TFMain.N7Click(Sender: TObject);
begin
  close
end;

procedure TFMain.FormCreate(Sender: TObject);
var
  dtemp:TdateTime;
  Year, Month, Day: Word;
  Hour, Min, Sec, MSec: Word;
  f1,f2:TextFile;
  s1,s2:string;
begin
  Dir :=  GetCurrentDir;
  StartUpIoPorts($378);
  Set8087CW($133f);
  Dm.TDateIns.open;

  Yi:=Dm.TDateInsYI.asstring;
  Mi:=Dm.TDateInsMi.asstring;
  Di:=Dm.TDateInsDi.asstring;
  datei:=Mi+'/'+Di+'/'+Yi;

 dCurent:=now;
 DecodeDate(dCurent, Year, Month, Day);
  Dm.TDateIns.Edit;
  Dm.TDateInsDateRezerv.asstring:= inttostr(Year)+'/'+inttostr(Month) +'/'+inttostr(Day);
  Dm.TDateInsYr.asstring:=inttostr(Year);
  Dm.TDateInsMr.asstring:=inttostr(Month);
  Dm.TDateInsDr.asstring:=inttostr(Day);
  Dm.TDateIns.post;

  Yr:=Dm.TDateInsYr.asstring;
  Mr:=Dm.TDateInsMr.asstring;
  Dr:=Dm.TDateInsDr.asstring;
  dater:=Mr+'/'+Dr+'/'+Yr;

//  Dm.TDateIns.close;

  AssignFile(f1,'instd.bat');
  AssignFile(f2,'dayd.bat');
  {$I-}
   rewrite(f1);
 //  Reset(F1, 1);	{ Record size = 1 }
  {$I+}
  if IOResult <> 0 then
  begin
    close;
  end;
  rewrite(f2);
//    BlockRead(F1, Buf, SizeOf(Buf), BytesRead);
//    BlockWrite(F2, Buf, BytesRead );
s1:='date '+datei;
s2:='date '+dater;
  Writeln(f1,s1);
  Writeln(f2,s2);

 CLOSEfile(F1);
 CLOSEfile(F2);

// SetDateInstall;
// SetDateDay;
//  SetToInDate;

end;
//************************************************************
procedure TFMain.SetDateInstall;
VAR
  dtemp:TdateTime;
  Year, Month, Day: Word;
  Hour, Min, Sec, MSec: Word;
  RET:INTEGER;
begin
//Dm.TDateIns.open;
  dCurent:=now;
  DecodeDate(dCurent, Year, Month, Day);
  Dm.TDateIns.Edit;
//  Dm.TDateInsDateRezerv.asstring:= inttostr(Year)+'/'+inttostr(Month) +'/'+inttostr(Day);
  Dm.TDateInsYr.asstring:=inttostr(Year);
  Dm.TDateInsMr.asstring:=inttostr(Month);
  Dm.TDateInsDr.asstring:=inttostr(Day);
  Dm.TDateIns.post;
//  Dm.TDateIns.CLOSE;
//  RET:=WinExec('instd.bat',SW_HIDE);
  RunProc('instd.bat');
  SLEEP(1);

end;
//************************************************************
procedure TFMain.SetDateDay;
VAR

  dtemp:TdateTime;
  Year, Month, Day: Word;
  Hour, Min, Sec, MSec: Word;
  f1,f2:TextFile;
  s1,s2:string;
  RET:INTEGER;
begin
  AssignFile(f2,'dayd.bat');
//  Dm.TDateIns.open;
  rewrite(f2);
  Yr:=Dm.TDateInsYr.asstring;
  Mr:=Dm.TDateInsMr.asstring;
  Dr:=Dm.TDateInsDr.asstring;
  dater:=Mr+'/'+Dr+'/'+Yr;

 s2:='date '+dater;
 Writeln(f2,s2);
 CLOSEfile(F2);
//  RET:=WinExec('dayd.bat',SW_HIDE);
  RunProc('dayd.bat');
  SLEEP(1);

end;

//*****************************************************************
procedure TFMain.RunProc(Str:String);
var
 Com: String;
 Par: String;
 ExitCode: longbool;
 SI: TStartupInfo;
 Dir : AnsiString;
begin

 Dir :=  GetCurrentDir;
 Com:=Dir+'\'+Str;
 Par:='';
 SI.wShowWindow :=SW_Hide; //SW_SHOW	;//SW_Hide;
 SI.cb := SizeOf(SI);
 SI.lpReserved:= nil;
 SI.lpDesktop := nil;
 SI.lpTitle := nil;
 SI.dwFlags := STARTF_USESHOWWINDOW;
 SI.cbReserved2 := 0;
 SI.lpReserved2 := nil;

 ExitCode:= CreateProcess({Pchar(Com)}nil,PChar(Com+Par),nil,nil,False,Create_Default_Error_Mode,nil,nil,SI,PI);
 if ExitCode=False then
 begin
    showmessage('Can not create process');
    Exit;
 end;
 WaitForSingleObject(pi.hProcess,INFINITE);
//end;//end while

end;

//************************************************************
procedure SetToInDate;
var
  dtemp:TdateTime;
  Year, Month, Day: Word;
  Hour, Min, Sec, MSec: Word;
  lpSystemTime: TSystemTime;
begin
 dCurent:=now;
 DecodeDate(dCurent, Year, Month, Day);
 DecodeTime(dCurent, Hour, Min, Sec, MSec);
 dtemp:=dCurent;
 // ftodate(Year, Month, Day);
// datestr:=inttostr(Year)+'-'+inttostr(Month)+'-'+inttostr(Day);

 dtemp:=StrTotime(inttostr(Hour)+':'+inttostr(Min)+':'+inttostr(Sec));
 dtemp:=StrToDate(Yi+'/'+Mi+'/'+Di);
// dtemp:=StrToDate('14/03/05');
 DecodeDate(dtemp, Year, Month, Day);
 DecodeTime(dtemp, Hour, Min, Sec, MSec);
 DateTimeToSystemTime(dtemp,lpSystemTime );
 //SE_SYSTEMTIME_NAME
// AdjustTokenPrivileges
 SetSystemTime(lpSystemTime);
end;

procedure TFMain.N4Click(Sender: TObject);
begin
{  Searchfinger := TSearchfinger.Create(Application);
  Searchfinger.ShowModal;
  Searchfinger.Free;
}
 Formservis.ShowModal;
end;

procedure TFMain.FormShow(Sender: TObject);
begin
// Formservis.ShowModal;
end;

end.
