unit IO_RW;

interface
var
IInt:byte;
procedure delay(del:integer);
procedure signal_IOWA();
procedure signal_IOWD();
procedure signal_ClockOn();
procedure signal_ClockOff();
procedure Signal_IORD();
procedure WriteAddress(Address:byte);
procedure WriteData(Address: byte ;Data:byte);
function ReadData(Address:byte):byte;



implementation

procedure delay(del:longint);
var kk,i:integer;
begin
for i:=0 to del do
 kk:=kk+1;
end;


//**********************************************
procedure signal_IOWA();
var i2:byte;
begin
//delay(0);
i2:=1+IInt;
 asm
 nop
 nop
 mov dx,$37a
 mov al,i2
 out dx ,al
 nop
 nop
 end;
//delay(0);
{
 delay(0);     //                         1 0     0 1
 outp(0x37a,1+Int);  //address write signal c0^=R/w  c2=A/d  C0^=C2=0=address write signall
		//  c0=1 c0^=0 c2=0     signal=== 0 0
 delay(0);
}
end;
//**********************************************
procedure signal_IOWD();
var i2:byte;
begin
//delay(0);
i2:=5+IInt;
 asm
 nop
 nop
 mov dx,$37a
 mov al,i2
 out dx ,al
 nop
 nop
 end;
//delay(0);
{
 delay(0);     //                         1 0     0 1
 outp(0x37a,5+Int);  //address write signal c0^=R/w  c2=A/d  C0^=C2=0=address write signall
		//  c0=1 c0^=0 c2=0     signal=== 0 0
 delay(0);
}
end;
//**********************************************
procedure signal_ClockOn();
var i2:byte;
begin
//delay(0);
i2:=7+IInt;
 asm
 nop
 nop
 mov dx,$37a
 mov al,i2
 out dx ,al
 nop
 nop
 end;
//delay(0);
{
 delay(0);     //                         1 0     0 1
  outp(0x37a,7+Int);  //address write signal c0^=R/w  c2=A/d  C0^=C2=0=address write signall
		//  c0=1 c0^=0 c2=0     signal=== 0 0
  delay(0);
}
end;
//**********************************************
procedure signal_ClockOff();
var i2:byte;
begin
//delay(0);
i2:=5+IInt;
 asm
 nop
 nop
 mov dx,$37a
 mov al,i2
 out dx ,al
 nop
 nop
 end;
//delay(0);
{
 delay(0);     //                         1 0     0 1
 outp(0x37a,5+Int);  //address write signal c0^=R/w  c2=A/d  C0^=C2=0=address write signall
		//  c0=1 c0^=0 c2=0     signal=== 0 0
 delay(0);
}
end;
//*********************************************************
procedure Signal_IORD();
var i2:byte;
begin
//delay(0);
i2:=4+32+IInt;
 asm
 nop
 nop
 mov dx,$37a
 mov al,i2
 out dx ,al
 nop
 nop
 end;
//delay(0);
{  int iii;
delay(0);
iii=4+32+Int;      // C5=1 Port Visibel in C5=0 port Visibel out
	       //                      1 0     0 1
	       //Data Read signal c0^=R/w  c2=A/d  C0=0 C0^=1 c2=1 read Data signal
	       // c0^=1 C2=1 signal   ==== 1 1
//delay(20);
outp(0x37a,iii); //send signal for Read Data
delay(0);
}
end;
//*********************************************************
procedure WriteAddress(Address:byte);
var i2:byte;
begin
i2:=Address;
 asm
 nop
 mov dx,$378
 mov al,i2
 out dx ,al
 nop
 end;
 signal_IOWA();

// outp(0x378,Address); // write Address of port data
// signal_IOWA();
end;
//*********************************************************
procedure WriteData(Address: byte ;Data:byte);
begin
 WriteAddress(Address);
 signal_IOWD();
// delay(0);
 asm
 nop
 nop
 mov dx,$378
 mov al,Data
 out dx ,al
 nop
 nop
 end;
// delay(0);
 signal_ClockOn();
 delay(0);
 signal_ClockOff();

{
 WriteAddress(Address);
 signal_IOWD();
 delay(0);
 outp(0x378,Data); // write Data of port data
 delay(0);
 signal_ClockOn();
 delay(0);
 signal_ClockOff();

}
end;
//*********************************************************

function ReadData(Address:byte):byte;
var i:byte;
begin
 delay(1);
 WriteAddress(Address);
 Signal_IORD();

 asm
 nop
 mov dx,$378
 in al,dx
 mov i,al
 nop
 nop
 end;
// delay(1);
 result:=i;
{int ii;
 delay(1);
 WriteAddress(Address);
 Signal_IORD();
ii=inp(0x378);  // Read Data Of Port Data
delay(1);
return ii;
}
end;
//*********************************************************
//*********************************************************

end.
