unit datetof;
interface
uses sysutils;
procedure ftodate(var yeart,montt, dayt:word);
function datetostrFarsi(Year, Month, Day: Word):string;

implementation

function datetostrFarsi(Year, Month, Day: Word):string;
var Temp1,Temp2,Temp3:string;
begin
  Temp2:=inttostr(year)+'/';
   temp1:=inttostr(Month);
   if (length(Temp1)<2) then
     Temp3:='0'+Temp1
   else Temp3:=Temp1;
   Temp2:=Temp2+Temp3+'/';
   temp1:=inttostr(Day);
   if (length(Temp1)<2) then
     Temp3:='0'+Temp1
   else Temp3:=Temp1;
   Temp2:=Temp2+Temp3;
result:=temp2;
end;

procedure ftodate(var yeart,montt, dayt:word);
const

 MonMil:array [0..11] of integer =(31, 29, 31, 30, 31, 30, 31, 31, 30, 30, 30, 31);
 Mon:array [0..11] of integer =(31, 31, 31, 31, 31, 31, 30, 30, 30, 30, 30, 29);

var
 kabise:boolean;
 Temp,DayLastYear:integer;
 Day , Cnt:integer;
begin

{dayt,montt,yeart}
 Temp := yeart Mod 4; {Kabise Year}
 If temp=1 then
     Kabise:=True
 else  Kabise:=False;
{----------------------------------------------------------}
         Day:=0;

	 for Cnt := 0  to  ( montt - 2) do
	      if (Cnt=1) And (kabise=True)then
		 Day :=Day+29
	      else
		 Day :=Day+ MonMil[Cnt];

	 Day:= Day + dayt;                {total day of date year Miladi}
{----------------------------------------------------------}

	 if (kabise=True) then
	    DayLastYear:=80
	 else DayLastYear:=79;

	 Day:= Day - DayLastYear;
					    {total day of date year Shamsi}
{---------------------------------------------------------------}
	 if (Day > 0 ) then
	       yeart := yeart- 621  {2001 -621 = 1380}
	 else
	   begin
	       yeart := yeart- 622 ;
               if (kabise=True) then
	        Day :=Day+ 366
               else Day :=Day+ 365 ;
	    end;                                       {year}

{---------------------------------------------------------------}
          cnt:=0;
          while(Day > 0) And (Day  > Mon[Cnt]) and (cnt<12) do
           begin
	      if (cnt=11) and (kabise=true)  then Day :=Day - 30
              else Day :=Day -  Mon[Cnt] ;
              cnt:=cnt+1;
           end;
{---------------------------------------------------------------}
          if Day=0 then
           Montt:=12
          else montt:=cnt+1;   {mont}
{---------------------------------------------------------------}
          if day=0 then
             dayt:=30
          else dayt:=day;  {day}
{---------------------------------------------------------------}
end;

end.
 