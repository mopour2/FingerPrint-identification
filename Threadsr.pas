unit Threadsr;

interface

uses
  Classes,Windows, Messages, SysUtils,  Graphics, Controls, Forms, Dialogs,
  StdCtrls,Db, DBTables,io_rw,UMain;
type
  TMyThread = class(TThread)

  private
    { Private declarations }
  protected
    procedure Execute; override;
  public
    constructor Create();

  end;
Var
  MyThread : TMyThread;
implementation
   uses data,servis,SolarDate,datetof;
//*****************************************************************************
constructor TMyThread.Create();
var
hook2:TFNHookProc;
ii:word;
begin
  //Formservis.Caption:='START TRHEAD';
  inherited Create(False);
end;
//*****************************************************************************
procedure LogAction(ID : AnsiString);
Var
  Stat : Integer;
  D : TSolarDate;
  Dat : PDate;
  SDate,STime : AnsiString;
  d1:TdateTime;
  Year, Month, Day: Word;
begin
  d1:=now;
  DecodeDate(d1,Year, Month, Day);
  ftodate(Year, Month, Day);

  Dm.Emp.Filter:='';
  DM.Emp.Filtered:=true;
  if DM.Emp.FindKey([ID])then
  begin
  if DM.EmpPresent.AsInteger=0 then
    Stat := 0//entrance
  else
    Stat := 1;//exit
//  Dat := D.ConvertDate;
//  SDate := D.DateToString(Dat);
  STime :=TimeToStr(Time);
  DM.ContrloLog.Append;
  DM.ContrloLogID.AsString := ID;
  DM.ContrloLogCode.AsInteger := Stat;
  DM.ContrloLogActDate.AsString := datetostrFarsi(Year, Month, Day);//SDate;
  DM.ContrloLogactDateMilad.asstring:=DateToStr(d1);
  DM.ContrloLogActTime.AsString := STime;
  DM.ContrloLog.Post;
  end;
end;

procedure OpenDoor();
begin
 WriteData(0,1);
 Formservis.delayTime(1);
 WriteData(0,0);
end;


procedure TMyThread.Execute;
  var

 FlagFind:boolean;
 ij:integer;
 FlagFind2 :boolean;

  sFeature : WideString;
  sFilename : WideString;
  InputFile : File;
  NumRead : Integer;
  sFeatureBioFast : array[1 .. 2048] of char;
  iCounter : Integer;
  sTemp:string;
begin
Formservis.FlagSendBiofast:=false;

while (Formservis.break=1)do
begin
   FlagFind2 := False;
   FlagFind:=false;
//   FMain.SetDateInstall;
   Formservis.PentacomBiometricFingerprint1.FlushImages;
   Formservis.FeatureVerify := Formservis.PentacomBiometricFingerprint1.GetVerifyFeature;
   Formservis.PentacomBiometricFingerprint1.SetVerifyFeature (Formservis.FeatureVerify);
//   FMain.SetDateDay;
//******************************************
   if (Formservis.ModControl='1') then  //COD + FING
   begin
    if (Formservis.bufkey1<> '')then
    begin
     Dm.Emp.Filter:='Id = '+Formservis.bufkey1;
     DM.Emp.Filtered:=true;
     DM.Fingers.Filter:='Id = '+Formservis.bufkey1;
     DM.Fingers.Filtered:=true;
     If DM.Fingers.RecordCount > 0 Then
       begin
         DM.Fingers.First;
         FMain.SetDateInstall;
         while (Not(DM.Fingers.Eof)and (FlagFind=False)) do
         begin
           DM.FingersFingerPrint.BlobType := ftBlob;
           Formservis.FeatureRegister:=DM.FingersFingerPrint.AsString;

           Formservis.PentacomBiometricFingerprint1.SetRegistrationFeature (Formservis.FeatureRegister);
           FlagFind2:=Formservis.PentacomBiometricFingerprint1.MatchFeatures;
           if FlagFind2 = False then
             DM.Fingers.Next
           else
             begin

//                if(DM.EmpVizaIn.AsBoolean=True ) then
//                 OpenDoor();
//                 FMain.SetDateDay;
                 LogAction(DM.EmpID.AsString);
                 DM.Emp.Edit;
                 DM.EmpPresent.AsInteger :=(DM.EmpPresent.AsInteger+1) mod 2;
                 DM.Emp.Post;
//                Formservis.MessagePalet('Verified.',1);
                FlagFind:=true;
                ij:=10;
                Formservis.imajj;
                while (ij< 209) do
                begin
                  Formservis.Image1.Height:=ij;
                  Formservis.Image1.Width:=ij;
                  ij:=ij+100;
               end;
               Formservis.Image1.Height:=209;
               Formservis.Image1.Width:=265;
               Formservis.PlaySound(DM.EmpID.AsString);
               Sleep(1000);
//               Formservis.PlaySound2(0);
//               Formservis.delayTime(1);
               Formservis.Image1.Height:=1;
               Formservis.Image1.Width:=1;

             end;//end find
         end; //end while
//         FMain.SetDateDay;
         if (FlagFind=False)then
              Formservis.MessagePalet('������� ���',1);
       end//end if count
     else
           Formservis.MessagePalet('Empty Table',1);
     end ;//end if bufkey=''
    end //mod control=1
//******************************************
   else if (Formservis.ModControl='3')then //FING ONLY
   BEGIN

   END
//******************************************
   else if (Formservis.ModControl='4')then // FING ONLY +COD ONLY
   BEGIN
     Formservis.FlagBio:= False;
     sFilename := 'c:\biofast_picture_temp.bmp';
     Formservis.PentacomBiometricFingerprint1.SaveBitmap(sFilename);
      Formservis.FlagSendBiofast:=true;
      while Formservis.FlagSendBiofast=true do ;

    if  Formservis.FlagBio= False then
      begin
        Formservis.MessagePalet('������� ���',1);
        Formservis.PlaySound('NotFond');
        Dm.Emp.Filter:='Id =2000000 ';
        DM.Emp.Filtered:=true;
      end
    else
       begin

       end;
  END;
//******************************************


 // if Terminated then Exit;
  Formservis.bufkey1:='';
  Formservis.edit1.text:='';
  FlagFind:=False;
  Formservis.Image1.Height:=1;
  Formservis.Image1.Width:=1;

end;
end;

end.

