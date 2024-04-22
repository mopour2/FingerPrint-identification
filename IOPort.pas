unit IOPort;

interface

uses windows,winsvc;

procedure outport(portid : integer; value : integer);
procedure outportb(portid : integer; value : BYTE);
function inportb(portid : integer) : byte;
function inport(portid : integer) : integer;
function StartUpIoPorts(PortToAccess : integer) : boolean;

implementation

var
 bPrivException : boolean;

procedure outport(portid : integer; value : integer);
Begin
  asm
    mov edx,portid;
    mov eax,value;
    out dx,ax;
  end;
end;

procedure outportb(portid : integer; value : BYTE);
Begin
  asm
    mov edx,portid
    mov al,value
    out dx,al
  end;
end;

function inportb(portid : integer) : byte;
Var value : byte;
Begin
  asm
    mov edx,portid
    in al,dx
    mov value,al
  end;
  inportb := value;
end;

function inport(portid : integer) : integer;
Var value : integer;
Begin
  value := 0;
  asm
    mov edx,portid
    in ax,dx
    mov value,eax
  end;
  inport := value;
end;

function StartUpIoPorts(PortToAccess : integer) : boolean;
Var hUserPort : THandle;
schSCManager: THandle;
schService: THandle;
DriverName:string;
szDriverFileName:string;
lpServiceArgVectors: PChar;
LastError:integer;
i:integer;
szTmp:pchar;
ss:string;
Begin
DriverName:='UserPort';
szDriverFileName:='D:\\WINNT\\System32\\Drivers\\UserPort.sys';
//szDriverFileName:='c:\\UserPort.sys';

//i:=GetWindowsDirectory(szTmp,sizeof(szTmp));
//szDriverFileName:=string(szTmp)+'\\System32\\Drivers\\UserPort.sys';

  hUserPort := CreateFile('\\.\UserPort', GENERIC_READ, 0, nil,OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0);
  CloseHandle(hUserPort); // Activate the driver
  Sleep(100); // We must make a process switch


    schSCManager:=0;
    schSCManager := OpenSCManager(NIl,NIl,SC_MANAGER_ALL_ACCESS);

    schService := CreateService (schSCManager,pchar(DriverName),pchar(DriverName),SERVICE_START,
                                  SERVICE_KERNEL_DRIVER,SERVICE_SYSTEM_START,
                                  SERVICE_ERROR_NORMAL,pchar(szDriverFileName),NIL,
                                  NIL,NIL,NIL,NIL);

  if (schService = 0) Then
  begin
    LastError := GetLastError;
    if (LastError = ERROR_SERVICE_EXISTS) then
      ss:='Driver already started! UserPort'
    else if (LastError	=ERROR_ACCESS_DENIED)then
      ss:='You are not authorized to install drivers.\r\nPlase contact your administrator. UserPort'
    else
      ss:='Unable to start driver! UserPort';
   CloseServiceHandle (schSCManager);

  end;

  StartService (schService,0,lpServiceArgVectors);

  CloseServiceHandle (schService);
  CloseServiceHandle (schSCManager);

  try
  //  inportb(PortToAccess);  // Try to access the given port address
  except
   // MessageBox(0,'fel','fel',MB_OK);
  end;
end;

end.




