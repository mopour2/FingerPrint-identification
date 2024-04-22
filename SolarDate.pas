unit SolarDate;

interface
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type

 PDate=record
   Day: Integer;
   Month: Integer;
   Year: Integer;
   Hour : Integer;
   Minute : Integer;
   Sec : Integer;
   MSec :  Integer;
 end;

 TSolarDate= class
  public
   function IsLeap(y:integer): Boolean;
   function ConvertDate : PDate;
   function NextDay(y,m,d:Integer): PDate;
   function NextDays(D : PDate;NumOfDays : Integer): PDate;
   function PassedDays(y,m,d : Word): Integer;
   function DateToString(D : PDate): AnsiString;
   function TimeDiffer(T1 : AnsiString;T2 : AnsiString): AnsiString;
 end;

implementation

//******************************************************************
function TSolarDate.TimeDiffer(T1 : AnsiString;T2 : AnsiString): AnsiString;
var
  h1,m1,s1,h2,m2,s2 : Integer;
  c1,c2,c3,c4,c5,c6 : Integer;
  ts,te,td : Longint;
  hs,ms,ss,Sign : AnsiString;
begin
  if (T1='') or (T2='') then
  begin
     TimeDiffer :='';
     Exit;
  end;
  Val(Copy(PChar(T1),1,2),h1,c1);
  Val(Copy(PChar(T2),1,2),h2,c2);

  Val(Copy(PChar(T1),4,2),m1,c3);
  Val(Copy(PChar(T2),4,2),m2,c4);

  Val(Copy(PChar(T1),7,2),s1,c5);
  Val(Copy(PChar(T2),7,2),s2,c6);
  if ((c1<>0) or (c2<>0) or (c3<>0) or
      (c4<>0) or (c5<>0) or (c6<>0)) then
  begin
     TimeDiffer :='';
     Exit;
  end;
  if h1<h2 then
  begin
    h1 := h1+24;
    Sign :='-';
  end else Sign := '+';

  ts := h1*3600+m1*60+s1;
  te := h2*3600+m2*60+s2;
  td := ts-te;
  h1 := td div 3600;
  m1 := (td-(h1*3600)) div 60;
  s1 := td-(h1*3600) - (m1*60);
  if h1<10 then hs :='0'+IntToStr(h1) else hs := IntToStr(h1);
  if m1<10 then ms :='0'+IntToStr(m1) else ms := IntToStr(m1);
  if s1<10 then ss :='0'+IntToStr(s1) else ss := IntToStr(s1);
  TimeDiffer :=Sign + hs+':'+ms+':'+ss;
end;
//******************************************************************
function TSolarDate.ConvertDate: PDate;
var
  i,y,m,d,h,min,sec,msec,PYear,PMonth,PDay,Passed: Word;
  dat : TDateTime;
  CDate : PDate;
begin
  dat :=Date;
  DecodeDate(dat,y,m,d);
  dat := Time;
  DecodeTime(dat,h,min,sec,msec);

  CDate.Day := 11;
  CDate.Month:= 10;
  CDate.Year := y-622;

  if IsLeapYear(y) then Inc(CDate.Day);
  Passed := PassedDays(y,m,d);

  for i:=1 to Passed-1 do
    CDate:= Nextday(CDate.Year,CDate.Month,CDate.Day);

  CDate.MSec := msec;
  CDate.Sec:= sec;
  CDate.Minute:= min;
  CDate.Hour := h;

  ConvertDate := CDate;
end;
//******************************************************************
function tSolarDate.NextDays(D : PDate;NumOfDays : integer): PDate;
Var
  i : Integer;
  NextDate : PDate;
begin
  NextDate := D;
  for i:=0 to NumOfDays do
   NextDate := NextDay(NextDate.Year,NextDate.Month,NextDate.Day);
  NextDays := NextDate;
end;
//******************************************************************
function tSolarDate.DateToString(D : PDate): AnsiString;
Var
  StrDate,Sm,Sd : AnsiString;
begin
  if D.Month<10 then Sm :='0'+IntToStr(D.Month)
     else Sm :=IntToStr(D.Month);
  if D.Day<10 then Sd :='0'+IntToStr(D.Day)
     else Sd :=IntToStr(D.Day);
   StrDate:=  IntToStr(D.Year)+'/'+Sm+'/'+SD;
   DateToString := StrDate;
end;
//******************************************************************
function tSolarDate.PassedDays(y,m,d : Word):Integer;
Var
 MDays : array[1..12] of Integer;
 i,passed :  Integer;
begin
 MDays[1]:=31;  MDays[2]:=28;  MDays[3]:=31;
 MDays[4]:=30;  MDays[5]:=31;  MDays[6]:=30;
 MDays[7]:=31;  MDays[8]:=31;  MDays[9]:=30;
 MDays[10]:=31; MDays[11]:=30; MDays[12]:=31;

 passed := 0;
 for i :=1 to m-1 do
      passed := passed+MDays[i];
 passed := passed+d;
 if IsLeapYear(y)
      then Inc(passed);
  PassedDays:=passed;
end;
//******************************************************************
function TSolardate.IsLeap(y:integer):Boolean;
Var
 lyears : array [1..10] of Integer;
 i : Integer;
 Sw : Boolean;
begin
  lyears[1]:= 1379;
  lyears[2]:= 1383;
  lyears[3]:= 1387;
  lyears[4]:= 1391;
  lyears[5]:= 1395;
  lyears[6]:= 1399;
  Sw := False;
  for i := 1 to 6 do
    if y=lyears[i] then
       Sw := True;
  if Sw then
    IsLeap := True
  else
    IsLeap := False;
end;
//******************************************************************
function TSolardate.NextDay(y,m,d:Integer): PDate;
Var
 Dat : PDate;
begin
  Dat.Year :=y;
  Dat.Month := m;
  Dat.Day :=d;
  Inc(d);
  if d <= 29 then
  begin
    Dat.Day:=d;
    NextDay := Dat;
    Exit;
  end;

  case d of
  30:
     if (m=12) and Not(IsLeap(y)) then
     begin
       Dat.Day:=1;
       Dat.Month := 1;
       Dat.Year:= y+1;
     end
     else
         Dat.Day := d;
  31:
     if m > 7 then
     begin
       if m<12 then
         begin
           Dat.Day:= 1;
           Dat.Month := m+1;
         end
       else
         begin
           Dat.Day:= 1;
           Dat.Month := 1;
           Dat.Year := y+1;
         end;
     end
     else
       Dat.Day:= d;
  32:
     begin
      Dat.Day :=1;
      Dat.Month := m+1;
     end;
  end;
  NextDay := Dat;
end;

end.
