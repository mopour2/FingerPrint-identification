unit servis;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, DBCtrls, ExtCtrls, Db, DBTables, AxCtrls, OleCtrls,
  MPlayer, Buttons, jpeg,PENTACOMBIOMETRICFINGERPRINTLib_TLB,io_rw,data,UMain,
  prjBioFast_TLB;

Const
ConstRecognitionThreshold = 220;
WM_USER = $400;
MESSAGE_VB_FINGER_GOOD = WM_USER + 12;
MESSAGE_VB_FINGER_BAD = WM_USER + 13 ;
MESSAGE_VB_IMAGE_RECEIVED = WM_USER + 14;
MESSAGE_VB_READY_TO_FILL_BUF = WM_USER + 15;
MESSAGE_VB_FT_IMAGE_INFO = WM_USER + 16;
MESSAGE_VB_FT_FEATURES_INFO = WM_USER + 17;
MESSAGE_VB_FT_WAITING_FOR_IMAGE = WM_USER + 18;
MESSAGE_VB_FT_REGISTERING = WM_USER + 19;
MESSAGE_VB_FT_VERIFYING = WM_USER + 20;
MESSAGE_VB_FT_FEATURE_GOOD = WM_USER + 21;
MESSAGE_VB_FT_FEATURE_BAD = WM_USER + 22;
MESSAGE_VB_FT_IMAGE_GOOD = WM_USER + 23  ;
MESSAGE_VB_FT_IMAGE_BAD = WM_USER + 24;
MESSAGE_VB_USERVERIFIED = WM_USER + 28;
MESSAGE_VB_USERREGISTERED = WM_USER + 29;
MESSAGE_VB_USERDECLINED = WM_USER + 31;
MESSAGE_VB_KILLTHREAD = WM_USER + 32;

type
  TFormservis = class(TForm)
    Panel2: TPanel;
    Panel3: TPanel;
    Image1: TImage;
    MediaPlayer1: TMediaPlayer;
    Timer1: TTimer;
    Edit1: TEdit;
    Label18: TLabel;
    Label12: TLabel;
    Timerdelay: TTimer;
    Image2: TImage;
    Label13: TLabel;
    MediaPlayer2: TMediaPlayer;
    Panel4: TPanel;
    PentacomBiometricFingerprint1: TPentacomBiometricFingerprint;
    BioFast1: TBioFast;
    Label4: TLabel;
    DBText1: TDBText;
    Label5: TLabel;
    DBText2: TDBText;
    Label6: TLabel;
    DBText3: TDBText;
    Label1: TLabel;
    Label2: TLabel;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure PlaySound(code: string);
    procedure PlaySound2(code: Integer);
    procedure Timer1Timer(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure PentacomBiometricFingerprint1Status(Sender: TObject;
      iStatus: Smallint);
    procedure TimerdelayTimer(Sender: TObject);
  private
    { Private declarations }
  public
     path:string;
     bufkey1:string;
     bufkey2:string;
     flagdelay:boolean;
     break:integer;
     FeatureRegister: WideString;
     FeatureVerify: WideString;
     ModControl:string;
     FlagSendBiofast:boolean;
     FlagBio:boolean;
     EmpId:string;
     procedure MessagePalet(str:string;timelimit:integer);
     procedure delayTime(timelimit:integer);
     Function StatusDescription(iStatus : Integer) :String;
     procedure imajj;
     procedure LogAction(ID : AnsiString);
     procedure OpenDoor();
     procedure LoadFingersToBioFast;
     function  FindFingersToBioFast:boolean;

    { Public declarations }
 end;

var
  Formservis: TFormservis;

implementation

uses Threadsr,SolarDate,datetof;
{$R *.DFM}
//*****************************************************************
procedure TFormservis.TimerdelayTimer(Sender: TObject);
begin
flagdelay:=false;
end;
//*****************************************************************
procedure TFormservis.delayTime(timelimit:integer);
begin
{
Timerdelay.Interval:=timelimit*1000;
Timerdelay.Enabled:=true;
flagdelay:=true;
while(flagdelay=true) do;
Timerdelay.Enabled:=false;
}
  Sleep(600);
end;
//*****************************************************************
procedure TFormservis.MessagePalet(str:string;timelimit:integer);
var ch:char;
  ss1:string;
begin
Label13.Visible:=true;
Label13.Caption:=str;
Timerdelay.Interval:=timelimit*1000;
//Timerdelay.Enabled:=true;
flagdelay:=true;
//while(flagdelay=true) do
begin
  Label13.Caption:=str; Label13.Refresh;
end;
sleep(400);
//----------
//SS1 := UMain.Dir+'\Sounds\NotFond.wav';
//if FileExists(ss1)  then
//begin MediaPlayer1.FileName:=ss1;MediaPlayer1.open; MediaPlayer1.Play; end
//else MediaPlayer1.FileName:='';
//----------
//Timerdelay.Enabled:=false;
Label13.Visible:=false;
end;
//*****************************************************************
Function TFormservis.StatusDescription(iStatus : Integer) :String;
begin
  Case iStatus of
  MESSAGE_VB_FINGER_GOOD:       StatusDescription := 'Finger Good';
  MESSAGE_VB_FINGER_BAD :       StatusDescription := 'Finger Bad';
  MESSAGE_VB_IMAGE_RECEIVED:    StatusDescription := 'Image Received';
  MESSAGE_VB_READY_TO_FILL_BUF: StatusDescription := 'Ready To Fill Buffer';
  MESSAGE_VB_FT_IMAGE_INFO:     StatusDescription := 'Image Info';
  MESSAGE_VB_FT_FEATURES_INFO:  StatusDescription := 'Features Info';
  MESSAGE_VB_FT_WAITING_FOR_IMAGE: StatusDescription := 'Waiting For Image';
  MESSAGE_VB_FT_REGISTERING :      StatusDescription := 'Registering';
  MESSAGE_VB_FT_VERIFYING   :      StatusDescription := 'Verifying';
  MESSAGE_VB_FT_FEATURE_GOOD:      StatusDescription := 'Feature Good';
  MESSAGE_VB_FT_FEATURE_BAD :      StatusDescription := 'Feature Bad';
  MESSAGE_VB_FT_IMAGE_GOOD  :      StatusDescription := 'Image Good';
  MESSAGE_VB_FT_IMAGE_BAD   :      StatusDescription := 'Image Bad';
  MESSAGE_VB_USERVERIFIED   :      StatusDescription := 'User Verified';
  MESSAGE_VB_USERREGISTERED :      StatusDescription := 'User Registered';
  MESSAGE_VB_USERDECLINED   :      StatusDescription := 'User Declined';
  MESSAGE_VB_KILLTHREAD     :      StatusDescription := 'Killing Thread';
  Else
    StatusDescription := 'Unkown';
 End;
End ;
//*****************************************************************
function  TFormservis.FindFingersToBioFast:boolean;
var
//  sFeature : WideString;
  sFilename : WideString;
  InputFile : File;
  NumRead : Integer;
  sFeatureBioFast : array[1 .. 2048] of char;
  iCounter : Integer;
  sTemp:string;

 FlagFind:boolean;
 FlagFind2 :boolean;
 ij:integer;
begin
//     MyThread.Suspend;
//     Formservis.BioFast1.Visible:=true;
 try
     FMain.SetDateInstall;
     BioFast1.oleobject.BinarizationThresholdPercentEnabled := False;
     BioFast1.oleobject.RecognitionThreshold := ConstRecognitionThreshold;
     sFilename := 'c:\biofast_picture_temp.bmp';
     PentacomBiometricFingerprint1.SaveBitmap(sFilename);
     BioFast1.oleobject.LoadFingerprintFromBMP(sFilename);

     //sFilename := 'c:\biofast_feature_temp.dat';
//     Formservis.BioFast1.oleobject.Fingerprint2FeatureDisk(sFilename);
     sTemp := Formservis.BioFast1.oleobject.Fingerprint2Feature;
    //Read From File
//    AssignFile(InputFile, sFilename);
//    Reset(InputFile, 1);
//    BlockRead(InputFile, sFeatureBioFast, FileSize(InputFile), NumRead);
//    CloseFile(InputFile);
    //Feature
//    sFeature := '';
//    for iCounter := 1 to NumRead do
//    begin
//      sFeature := sFeature + sFeatureBioFast[iCounter];
//    end;
//    Formservis.BioFast1.SearchFeature := sFeature;


//   BioFast1.oleobject.MatchFeatures(sFeatures[2], sFeatures[3], True)

 FlagFind:=false;
 FlagFind2 :=false;


    BioFast1.SearchFeature :=sTemp;
    FlagBio:=false;
    FlagBio:=BioFast1.oleobject.FindFirst;
    if FlagBio=true then
    begin
      EmpId:=BioFast1.oleobject.Id;
      Dm.Emp.Filter:='Id = '+EmpId ;
      DM.Emp.Filtered:=true;
      DM.Fingers.Filter:='Id = '+EmpId;
      DM.Fingers.Filtered:=true;
     repeat
      If DM.Fingers.RecordCount > 0 Then
       begin
            DM.Fingers.First;
            while (Not(DM.Fingers.Eof)and (FlagFind=False)) do
            begin
              DM.FingersFingerPrint.BlobType := ftBlob;
              FeatureRegister:=DM.FingersFingerPrint.AsString;

              PentacomBiometricFingerprint1.SetRegistrationFeature (Formservis.FeatureRegister);
              FlagFind2:=PentacomBiometricFingerprint1.MatchFeatures;
             if FlagFind2 = False then
               DM.Fingers.Next
             else
              begin
//                  if(DM.EmpVizaIn.AsBoolean=True ) then
//                     OpenDoor();
                  MessagePalet(Formservis.EmpId+'‘‰«”«∆Ì ',1);
                  LogAction(Formservis.EmpId);
//          DM.Emp.Edit;
//          DM.EmpPresent.AsInteger :=(DM.EmpPresent.AsInteger+1) mod 2;
//          DM.Emp.Post;
                  FlagFind:=true;
                  ij:=10;
//                  PlaySound(Formservis.EmpId);
                  imajj;
                  while (ij< 209) do
                     begin
                       Image1.Height:=ij;
                       Image1.Width:=ij;
                       ij:=ij+100;
                       sleep(100);
                       Image1.refresh;
                     end;
                 Image1.Height:=209;Image1.Width:=265;
                 Image1.refresh;  Image1.refresh;
                 Sleep(500);
//               Formservis.PlaySound2(state);
//               Formservis.delayTime(1);
                 Image1.Height:=1; Image1.Width:=1;
                 Image1.refresh; Image1.refresh;
                 Image1.refresh;

              end//end find
            end;//whil
         end;//end if >0
      if FlagFind=false then
        FlagBio:=BioFast1.oleobject.Findnext;
     until (FlagFind=true) or (FlagBio= false);
    end;//findfirst

    FlagBio:=FlagFind;
//    MyThread.Resume;
    FMain.SetDateDay;
    result:=FlagFind;
 except
    FMain.SetDateDay;
    result:=FlagFind;
 end;
end;

//*****************************************************************
procedure   TFormservis.LoadFingersToBioFast;
var RecCount:integer;
ICount:integer;
begin
 dm.Fingers.first;
 RecCount:=dm.Fingers.RecordCount;
 BioFast1.OleObject.records:=RecCount;
 ICount:=1;
 while not dm.Fingers.eof do
 begin
  BioFast1.OleObject.record:=ICount;
  DM.FingersFingerPrintFast.BlobType := ftBlob;
  BioFast1.OleObject.Feature:=dm.FingersFingerPrintFast.AsString;
  BioFast1.OleObject.Id:=dm.FingersID.asstring;
  dm.Fingers.next;
  inc(ICount);
 end;
 BioFast1.OleObject.LoadCompleted;
end;
//*****************************************************************
procedure TFormservis.FormShow(Sender: TObject);
var ss2:string;
begin
 dm.ContrloLog.open;
 dm.tpath.open;
 dm.Emp.open;
 dm.Fingers.open;
  FMain.SetDateInstall;
  PentacomBiometricFingerprint1.Initialize;
  SetLength(FeatureRegister, 300);
  SetLength(FeatureVerify, 300);
  edit1.SetFocus;

  LoadFingersToBioFast;

  FMain.SetDateDay;

  Timer1.Enabled:=true;
  break:=1;

 MyThread:= TMyThread.Create();

 ModControl:=dm.tpathModControl.asstring;
 MediaPlayer2.FileName:=UMain.Dir+'\SPEEDIS.AVI';

 MediaPlayer2.open;
 MediaPlayer2.Play;
end;
//*****************************************************************
procedure TFormservis.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Timer1.Enabled:=false;
  break:=0;
  if MyThread<>NIL then
   begin
    MyThread.Terminate ;
    MyThread.suspend;
    MyThread.Destroy;
   end;

//  MainForm1.Enabled := True;
  dm.ContrloLog.close;
  dm.tpath.close;
  dm.Emp.close;
  dm.Fingers.close;

end;
//*****************************************************************
procedure TFormservis.imajj;
var ss2:string;
begin
  SS2 := UMain.Dir+'\Photos\'+Dm.EmpID.AsString+'.jpg';
  if FileExists(ss2)  then
  Image1.Picture.LoadFromFile(ss2)
  else Image1.Picture.LoadFromFile(UMain.Dir+'\Photos\'+'NoPhoto.jpg');
end;
//*****************************************************************
procedure TFormservis.PlaySound(code: string);
var
  ss1:string;
begin
  SS1 := UMain.Dir+'\Sounds\'+code+'.wav';
  MediaPlayer1.close;
  if FileExists(ss1)  then
  begin MediaPlayer1.FileName:=ss1;MediaPlayer1.open; MediaPlayer1.Play; end
  else MediaPlayer1.FileName:='';
end;
//*****************************************************************
procedure TFormservis.PlaySound2(code : integer);
var
  ss1:string;
begin
  if code=0 then
     SS1 := UMain.Dir+'\Sounds\in.wav'
  else
     SS1 := UMain.Dir+'\Sounds\out.wav';


  MediaPlayer1.close;
  if FileExists(ss1)  then
  begin MediaPlayer1.FileName:=ss1;MediaPlayer1.open; MediaPlayer1.Play; end
  else MediaPlayer1.FileName:='';
end;
//*****************************************************************
procedure TFormservis.Timer1Timer(Sender: TObject);
var  d1:TdateTime;
  Year, Month, Day: Word;
begin
  d1:=now;
 edit1.SetFocus;
// label11.Caption:=bufkey1;label11.Refresh;
//   MediaPlayer2.
// MediaPlayer2.Play;
label12.Caption:=bufkey2;
label1.Caption:=TimeToStr(d1);
DecodeDate(d1,Year, Month, Day);
ftodate(Year, Month, Day);
Label2.Caption:=datetostrFarsi(Year, Month, Day);
if FlagSendBiofast=true then
 begin
 FindFingersToBioFast;
 FlagSendBiofast:=false;
 end;

end;
//*****************************************************************
procedure TFormservis.LogAction(ID : AnsiString);
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

//*****************************************************************
procedure TFormservis.OpenDoor();
begin
 WriteData(0,1);
 delayTime(1);
 WriteData(0,0);
end;

//*****************************************************************
procedure TFormservis.Edit1KeyPress(Sender: TObject; var Key: Char);
var TVId,TVpass:string;
l,i:integer;
begin
MyThread.Suspend;
    case key of
     '4': bufkey1:=bufkey1+'1';
     'r': bufkey1:=bufkey1+'2';
     'f': bufkey1:=bufkey1+'3';
     '3': bufkey1:=bufkey1+'4';
     'e': bufkey1:=bufkey1+'5';
     'd': bufkey1:=bufkey1+'6';
     '2': bufkey1:=bufkey1+'7';
     'w': bufkey1:=bufkey1+'8';
     's': bufkey1:=bufkey1+'9';
     '1': ;{bufkey1[]:='*';}
     'q': bufkey1:=bufkey1+'0';
     'a': bufkey1:='';{bufkey1[]:='#';}
//****************************
     '0': bufkey2:=bufkey2+'1';
     'p': bufkey2:=bufkey2+'2';
     ';': bufkey2:=bufkey2+'3';
     '9': bufkey2:=bufkey2+'4';
     'o': bufkey2:=bufkey2+'5';
     'l': bufkey2:=bufkey2+'6';
     '8': bufkey2:=bufkey2+'7';
     'i': bufkey2:=bufkey2+'8';
     'k': bufkey2:=bufkey2+'9';
//>
     '7': begin
            if bufkey2<>'' then
            if (ModControl='2')then //key ONLY
            begin
             if DM.Emp.FindKey([bufkey2]) then
              begin
                 OpenDoor();
                  PlaySound(DM.EmpID.AsString);
//                 Sleep(2000);
//                 PlaySound2(1);
                 LogAction(DM.EmpID.AsString);
                 bufkey2:='';
              end
              else bufkey2:='';
            end
            else if (ModControl='4')then //key ONLY
               begin
                     TvPass:='';
                     TVId:='';
                     i:=1;
                     l:=length(bufkey2);
                     while (bufkey2[i]<>'#') and (i<l) do
                      begin
                       TVId:=Tvid+bufkey2[i];
                       inc(i);
                      end;
                       inc(i);
                     while (i<=l) do
                      begin
                       TVPass:=TvPass+bufkey2[i];
                       inc(i);
                      end;

                     if DM.Emp.FindKey([TVId]) then
                      begin
                         if DM.Emppassword1.asstring=TVPass then
                         begin
                           OpenDoor();
                           PlaySound(TVId);
        //                 Sleep(2000);
        //                 PlaySound2(1);
                           LogAction(DM.EmpID.AsString);
                           bufkey2:='';
                         end;
                      end
                      else bufkey2:='';
               end;
          end;
     'u': bufkey2:=bufkey2+'0';
     'j': begin
             l:=length(bufkey2);
             if bufkey2<>'' then {bufkey2[]:='#';}
               if bufkey2[l]='#' then
                 bufkey2:=''
               else bufkey2:=bufkey2+'#';
          end;
   else
end;
MyThread.Resume;
end;
procedure TFormservis.PentacomBiometricFingerprint1Status(Sender: TObject;
  iStatus: Smallint);
begin
  Label18.Caption:=StatusDescription(iStatus );

end;


end.
