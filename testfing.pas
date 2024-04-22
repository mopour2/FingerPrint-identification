unit testfing;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, DBCtrls, ExtCtrls, Db, DBTables, AxCtrls, OleCtrls,
  PENTACOMBIOMETRICFINGERPRINTLib_TLB, MPlayer, Buttons, ComCtrls;

Const
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
Type
lrect =record
  left : Longint;
  top: Longint;
  right : Longint;
  bottom : Longint;
End ;


type
  TFtestfing = class(TForm)
    Panel2: TPanel;
    Label1: TLabel;
    Label7: TLabel;
    Panel1: TPanel;
    Panel3: TPanel;
    Label2: TLabel;
    LNe: TLabel;
    Ne: TLabel;
    StatusBar1: TStatusBar;
    DBNavigator1: TDBNavigator;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    Panel4: TPanel;
    Label4: TLabel;
    IDE: TEdit;
    DBNavigator2: TDBNavigator;
    Image1: TImage;
    Label8: TLabel;
    Label9: TLabel;
    Image2: TImage;
    Label10: TLabel;
    Image3: TImage;
    Label11: TLabel;
    Image4: TImage;
    Label12: TLabel;
    Image5: TImage;
    Label13: TLabel;
    Image6: TImage;
    Label14: TLabel;
    Image7: TImage;
    Label15: TLabel;
    Image8: TImage;
    Label16: TLabel;
    Image9: TImage;
    Label17: TLabel;
    Image10: TImage;
    Image40: TImage;
    CheckBox10: TCheckBox;
    CheckBox9: TCheckBox;
    Label29: TLabel;
    Label30: TLabel;
    CheckBox8: TCheckBox;
    Label28: TLabel;
    CheckBox7: TCheckBox;
    Label27: TLabel;
    CheckBox6: TCheckBox;
    CheckBox5: TCheckBox;
    Label25: TLabel;
    Label26: TLabel;
    Label24: TLabel;
    CheckBox4: TCheckBox;
    CheckBox3: TCheckBox;
    Label23: TLabel;
    CheckBox2: TCheckBox;
    Label22: TLabel;
    CheckBox1: TCheckBox;
    Label21: TLabel;
    DBEdit4: TDBEdit;
    Label3: TLabel;
    BitBtn1: TBitBtn;
    PentacomBiometricFingerprint1: TPentacomBiometricFingerprint;
    BitBtn2: TBitBtn;
    Img1: TImage;
    img2: TImage;
    img3: TImage;
    img4: TImage;
    img1_1: TImage;
    img2_2: TImage;
    img3_3: TImage;
    img4_4: TImage;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    procedure FormShow(Sender: TObject);
    procedure CheckBox4Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure CheckBox3Click(Sender: TObject);
    procedure CheckBox5Click(Sender: TObject);
    procedure CheckBox6Click(Sender: TObject);
    procedure CheckBox7Click(Sender: TObject);
    procedure CheckBox8Click(Sender: TObject);
    procedure CheckBox9Click(Sender: TObject);
    procedure CheckBox10Click(Sender: TObject);
    procedure DBNavigator1Click(Sender: TObject; Button: TNavigateBtn);
    procedure BitBtn1Click(Sender: TObject);
    procedure PentacomBiometricFingerprint1Status(Sender: TObject;
      iStatus: Smallint);
    procedure IdEKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn2Click(Sender: TObject);
    procedure DBNavigator2Click(Sender: TObject; Button: TNavigateBtn);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    path:string;
    LastNoFing:integer;
    conterfingreg:integer;
    flagReg:boolean;
    procedure DelFing(ch:string);
    function  AddFing(ch:string):integer;
    procedure CopyHWnd();
    Function  StatusDescription(iStatus : Integer) :String;
    procedure GetTwipsPerPixel();
    procedure fingtik();
    procedure AccFC(NoFing:integer;conterfingreg:integer);
 end;

var
  Ftestfing: TFtestfing;
  FeatureRegister: WideString;
  FeatureVerify: WideString;
  Buf1Register: array[1..30000]of WideString;
  Buf1Id: array[1..30000]of double;
implementation

uses data, UMain, UForm1;

{$R *.DFM}
//***********************************************************************
procedure TFtestfing.FormShow(Sender: TObject);
begin
  PentacomBiometricFingerprint1.Initialize;
  SetLength(FeatureRegister, 300);
  SetLength(FeatureVerify, 300);
  flagReg:=false;
     fingtik();
end;
//***********************************************************************
procedure TFtestfing.DelFing(ch:string);
begin
  if(Dm.Fingers.FindKey([DM.EmpID.AsString,ch])=True) then
  begin
    Dm.Fingers.Delete;
  end
end;
//***********************************************************************
function TFtestfing.AddFing(ch:string):integer;
var
  bl: TBlobField;
begin
    PentacomBiometricFingerprint1.FlushImages;
    Application.MessageBox('áÕİÃ ÇäÔÊ ÎæÏ ÑÇ åÇÑ ÈÇÑ Ñæí ÓíÓÊã ŞÑÇÑ ÏåíÏ', 'Register', MB_OK);

    conterfingreg:=0;
    flagReg:=true;
     Img1.Visible:=false;
     Img2.Visible:=false;
     Img3.Visible:=false;
     Img4.Visible:=false;
     Img1_1.Visible:=false;
     Img2_2.Visible:=false;
     Img3_3.Visible:=false;
     Img4_4.Visible:=false;

    FeatureRegister := PentacomBiometricFingerprint1.GetRegistrationFeature;
    sleep(100);

    flagReg:=false;

   if conterfingreg=4 then
   begin
    if(DM.Fingers.FindKey([DM.EmpID.AsString,ch])=True) then
    begin
      DM.Fingers.Edit;
      DM.FingersFingerPrint.BlobType := ftBlob;
      DM.FingersFingerPrint.value:=FeatureRegister;
      DM.Fingers.Post;
    end
   else
    begin
      DM.Fingers.insert;
      DM.FingersFingerPrint.BlobType := ftBlob;
      DM.FingersFingerPrint.value:=FeatureRegister;
      DM.FingersID.AsString := DM.EmpID.AsString;
      DM.FingersFingerID.AsString :=ch;
      DM.Fingers.Post;
    end;
     Img1.Visible:=false;
     Img2.Visible:=false;
     Img3.Visible:=false;
     Img4.Visible:=false;
     Img1_1.Visible:=false;
     Img2_2.Visible:=false;
     Img3_3.Visible:=false;
     Img4_4.Visible:=false;

    result:=1;
    exit
  end
  else
  begin
        if  conterfingreg=1 then
           Img1_1.Visible:=true
        else if  conterfingreg=2 then
           Img2_2.Visible:=true
        else if  conterfingreg=3 then
           Img3_3.Visible:=true
        else if  conterfingreg=4 then
           Img4_4.Visible:=true;
     Ftestfing.Refresh;
     sleep(2000);
     Img1.Visible:=false;
     Img2.Visible:=false;
     Img3.Visible:=false;
     Img4.Visible:=false;
     Img1_1.Visible:=false;
     Img2_2.Visible:=false;
     Img3_3.Visible:=false;
     Img4_4.Visible:=false;

  end;
result:=0;
end;

procedure TFtestfing.CheckBox4Click(Sender: TObject);
begin
if ( CheckBox4.Checked=True)then
  begin
      LastNoFing:=4;
     if AddFing('4')=0 then
        CheckBox4.Checked:=false
     else label24.Visible:=true;
  end
else
 begin
     label24.Visible:=false;
     DelFing('4');
 end
end;

procedure TFtestfing.CheckBox1Click(Sender: TObject);
begin
if ( CheckBox1.Checked=True)then
  begin
     LastNoFing:=1;
     if AddFing('1')=0 then
       CheckBox1.Checked:=false
     else label21.Visible:=true;
   end
else
 begin
     DelFing('1');
     label21.Visible:=false;
 end

end;

procedure TFtestfing.CheckBox2Click(Sender: TObject);
begin
if ( CheckBox2.Checked=True)then
  begin
     LastNoFing:=2;
     if AddFing('2')=0 then
       CheckBox2.Checked:=false
     else label22.Visible:=true;
  end
else
 begin
     DelFing('2');
     label22.Visible:=false;
 end

end;

procedure TFtestfing.CheckBox3Click(Sender: TObject);
begin
if ( CheckBox3.Checked=True)then
  begin
     LastNoFing:=3;
     if AddFing('3')=0 then
       CheckBox3.Checked:=false
     else label23.Visible:=true;
  end
else
 begin
     DelFing('3');
     label23.Visible:=false;
 end

end;

procedure TFtestfing.CheckBox5Click(Sender: TObject);
begin
if ( CheckBox5.Checked=True)then
  begin
     LastNoFing:=5;
     if AddFing('5')=0 then
       CheckBox5.Checked:=false
     else label25.Visible:=true;
  end
else
 begin
     DelFing('5');
     label25.Visible:=false;
 end

end;

procedure TFtestfing.CheckBox6Click(Sender: TObject);
begin
if ( CheckBox6.Checked=True)then
  begin
     LastNoFing:=6;
     if AddFing('6')=0 then
       CheckBox6.Checked:=false
     else label26.Visible:=true;
  end
else
 begin
     DelFing('6');
     label26.Visible:=false;
 end


end;

procedure TFtestfing.CheckBox7Click(Sender: TObject);
begin
if ( CheckBox7.Checked=True)then
  begin
     LastNoFing:=7;
     if AddFing('7')=0 then
       CheckBox7.Checked:=false
     else label27.Visible:=true;
  end
else
 begin
     DelFing('7');
     label27.Visible:=false;
 end

end;

procedure TFtestfing.CheckBox8Click(Sender: TObject);
begin
if ( CheckBox8.Checked=True)then
  begin
     LastNoFing:=8;
     if AddFing('8')=0 then
       CheckBox8.Checked:=false
     else label28.Visible:=true;
  end
else
 begin
     DelFing('8');
     label28.Visible:=false;
 end

end;

procedure TFtestfing.CheckBox9Click(Sender: TObject);
begin
if ( CheckBox9.Checked=True)then
  begin
     LastNoFing:=9;
     if AddFing('9')=0 then
       CheckBox9.Checked:=false
     else label29.Visible:=true;
  end
else
 begin
     DelFing('9');
     label29.Visible:=false;
 end

end;

procedure TFtestfing.CheckBox10Click(Sender: TObject);
begin
if ( CheckBox10.Checked=True)then
  begin
     LastNoFing:=10;
     if AddFing('10')=0 then
       CheckBox10.Checked:=false
    else label30.Visible:=true;
  end
else
 begin
     DelFing('10');
     label30.Visible:=true;
 end

end;


//*****************************************************

Function TFtestfing.StatusDescription(iStatus : Integer) :String;
begin
  Case iStatus of
  MESSAGE_VB_FINGER_GOOD:       StatusDescription := 'Finger Good';
  MESSAGE_VB_FINGER_BAD :       StatusDescription := 'Finger Bad';
  MESSAGE_VB_IMAGE_RECEIVED:    StatusDescription := 'Image Received';
  MESSAGE_VB_READY_TO_FILL_BUF: StatusDescription := 'Ready To Fill Buffer';
  MESSAGE_VB_FT_IMAGE_INFO:     StatusDescription := 'Image Info';
  MESSAGE_VB_FT_FEATURES_INFO:  StatusDescription := 'Features Info';
  MESSAGE_VB_FT_WAITING_FOR_IMAGE: StatusDescription := 'Waiting For Image';
  MESSAGE_VB_FT_REGISTERING :     StatusDescription := 'Registering';
  MESSAGE_VB_FT_VERIFYING   :     StatusDescription := 'Verifying';

  MESSAGE_VB_FT_FEATURE_GOOD:     begin
                                  StatusDescription := 'Feature Good';
                                  if flagReg=true then
                                  begin
                                     inc(conterfingreg);
                                   if  conterfingreg=1 then
                                   Img1.Visible:=true
                                   else if  conterfingreg=2 then
                                   Img2.Visible:=true
                                   else  if  conterfingreg=3 then
                                   Img3.Visible:=true
                                   else  if  conterfingreg=4 then
                                   Img4.Visible:=true;
                                   AccFC(LastNoFing,conterfingreg);
                                  end;
                                     end;
  MESSAGE_VB_FT_FEATURE_BAD :     begin
                                      StatusDescription := 'Feature Bad';
                                      if  conterfingreg=1 then
                                         Img1_1.Visible:=true
                                      else if  conterfingreg=2 then
                                         Img2_2.Visible:=true
                                      else if  conterfingreg=3 then
                                         Img3_3.Visible:=true
                                      else if  conterfingreg=4 then
                                         Img4_4.Visible:=true;
                                  end;
  MESSAGE_VB_FT_IMAGE_GOOD  :     StatusDescription := 'Image Good';
  MESSAGE_VB_FT_IMAGE_BAD   :     StatusDescription := 'Image Bad';
  MESSAGE_VB_USERVERIFIED   :      StatusDescription := 'User Verified';
  MESSAGE_VB_USERREGISTERED :      StatusDescription := 'User Registered';
  MESSAGE_VB_USERDECLINED   :      StatusDescription := 'User Declined';
  MESSAGE_VB_KILLTHREAD     :      StatusDescription := 'Killing Thread';
  Else
    StatusDescription := 'Unkown';
 End;

End ;

procedure TFtestfing.CopyHWnd();
var
   winSize:lrect ;
   hwndSrc: Longint;
   hSrcDC:Longint;
   xSrc: Longint;
   ySrc: Longint;
   nWidth : Longint;
   nHeight : Longint;
   hDestDC : Longint;
   x : Longint;
   y : Longint;
   dwRop : cardinal;
   Suc : longbool;
   Dmy : Longint;
begin
{   hwndSrc := PentacomBiometricFingerprint1.hwnd;
   hSrcDC := GetDC(hwndSrc);
   xSrc := 0;
   ySrc := 0;
//   GetWindowRect(hwndSrc, @winSize);
   FormAddFing.ScaleBy(3,2);
   Image12.Width := PentacomBiometricFingerprint1.Width;
   Image12.Height := PentacomBiometricFingerprint1.Height;
   nWidth := Image12.Width;
   nHeight := Image12.Height;
//   hDestDC := Image12.hdc;
   x := 0;
   y := 0;
   GetTwipsPerPixel;
   dwRop := $CC0020;

   Suc := BitBlt(hDestDC, x, y, nWidth, nHeight, hSrcDC, xSrc, ySrc, dwRop);

   Dmy := ReleaseDC(hwndSrc, hSrcDC);}
End;

procedure TFtestfing.GetTwipsPerPixel();
var
   NumPix:Longint;
begin
   // Set a global variable with the Twips to Pixel ratio.
   Ftestfing.Scaleby(3,2);
   NumPix := Ftestfing.Height;
   Ftestfing.Scaleby (1,1);
//   TwipsPerPixel := FormAddFing.Height / NumPix;
End;

//*****************************************************

procedure TFtestfing.PentacomBiometricFingerprint1Status(Sender: TObject;
  iStatus: Smallint);
begin
  StatusBar1.Panels[0].Text :=StatusDescription(iStatus );
  StatusBar1.Refresh;
//  sleep(1000);

end;
//*****************************************************
procedure TFtestfing.fingtik();
begin
//MediaPlayer1.FileName:=path+'sound\'+TableInfoId.asstring+'.wav';
//MediaPlayer1.Open;
//Image100.Picture.LoadFromFile(path+'image\'+TableInfoId.asstring+'.jpg');

  DM.Fingers.Filter:='ID = '+DM.EmpID.AsString;
  DM.Fingers.Filtered := True;

  CheckBox1.OnClick:=nil;CheckBox2.OnClick:=nil;CheckBox3.OnClick:=nil;CheckBox4.OnClick:=nil;
  CheckBox5.OnClick:=nil;CheckBox6.OnClick:=nil;CheckBox7.OnClick:=nil;CheckBox8.OnClick:=nil;
  CheckBox9.OnClick:=nil;CheckBox10.OnClick:=nil;

  label21.Visible:=false;label22.Visible:=false;label23.Visible:=false;label24.Visible:=false;
  label25.Visible:=false;label26.Visible:=false;label27.Visible:=false;label28.Visible:=false;
  label29.Visible:=false;label30.Visible:=false;

  CheckBox1.Checked:=false;CheckBox2.Checked:=false;CheckBox3.Checked:=false;
  CheckBox4.Checked:=false;CheckBox5.Checked:=false;CheckBox6.Checked:=false;
  CheckBox7.Checked:=false;CheckBox8.Checked:=false;CheckBox9.Checked:=false;
  CheckBox10.Checked:=false;

  while Not(dm.Fingers.eof) do
   begin
   if (Dm.FingersFingerID.asstring='1')then
    begin  CheckBox1.Checked:=True; label21.Visible:=True; end
  else if (Dm.FingersFingerID.asstring='2')then
    begin  CheckBox2.Checked:=True; label22.Visible:=True; end
  else if (Dm.FingersFingerID.asstring='3')then
    begin  CheckBox3.Checked:=True; label23.Visible:=True; end
  else if (Dm.FingersFingerID.asstring='4')then
    begin  CheckBox4.Checked:=True; label24.Visible:=True; end
  else if (Dm.FingersFingerID.asstring='5')then
    begin  CheckBox5.Checked:=True; label25.Visible:=True; end
  else if (Dm.FingersFingerID.asstring='6')then
    begin  CheckBox6.Checked:=True; label26.Visible:=True; end
  else if (Dm.FingersFingerID.asstring='7')then
    begin  CheckBox7.Checked:=True; label27.Visible:=True; end
  else if (Dm.FingersFingerID.asstring='8')then
    begin  CheckBox8.Checked:=True; label28.Visible:=True; end
  else if (Dm.FingersFingerID.asstring='9')then
    begin  CheckBox9.Checked:=True; label29.Visible:=True; end
  else if (Dm.FingersFingerID.asstring='10')then
    begin  CheckBox10.Checked:=True; label30.Visible:=True; end;
  DM.Fingers.Next;
 end;

  CheckBox1.OnClick:=CheckBox1Click; CheckBox2.OnClick:=CheckBox2Click;
  CheckBox3.OnClick:=CheckBox3Click; CheckBox4.OnClick:=CheckBox4Click;
  CheckBox5.OnClick:=CheckBox5Click; CheckBox6.OnClick:=CheckBox6Click;
  CheckBox7.OnClick:=CheckBox7Click; CheckBox8.OnClick:=CheckBox8Click;
  CheckBox9.OnClick:=CheckBox9Click; CheckBox10.OnClick:=CheckBox10Click;

end;

procedure TFtestfing.DBNavigator1Click(Sender: TObject;
  Button: TNavigateBtn);
begin
     fingtik();
     Img1.Visible:=false;
     Img2.Visible:=false;
     Img3.Visible:=false;
     Img4.Visible:=false;
end;
//*****************************************************
procedure TFtestfing.BitBtn2Click(Sender: TObject);
var
 FlagFind:boolean;
// Str : TStringStream;
// W : WideString;
begin
//  Str := TStringStream.Create(w);
  FlagFind:=false;
  PentacomBiometricFingerprint1.FlushImages;
  Application.MessageBox('áÕİÃİŞØ í˜ ÇäÔÊ ÎæÏ ÑÇ íß ÈÇÑ Ñæí ÓíÓÊã ŞÑÇÑ ÏåíÏ', 'Register', MB_OK);
  FeatureVerify := PentacomBiometricFingerprint1.GetVerifyFeature;
  PentacomBiometricFingerprint1.SetVerifyFeature (FeatureVerify);


   DM.Fingers.Filter:='ID = '+DM.EmpID.AsString;
   DM.Fingers.Filtered:=True;
   DM.Fingers.First;
   If DM.Fingers.RecordCount > 0 Then
    begin
      DM.Fingers.First;

     while (not DM.Fingers.eof)and (FlagFind=False) do
     begin
       DM.FingersFingerPrint.BlobType := ftBlob;
       FeatureRegister:=DM.FingersFingerPrint.AsString;
       PentacomBiometricFingerprint1.SetRegistrationFeature (FeatureRegister);
       if PentacomBiometricFingerprint1.MatchFeatures = False then
         DM.Fingers.Next
      else
         begin
           Application.MessageBox('ÇËÑ ÇäÔÊ ÔãÇ ÔäÇÓÇíí ÔÏ', 'Match', MB_OK);
           FlagFind:=True;
           AccFC(LastNoFing,1);

         end;
     end; //end while

     if (FlagFind=False)then
       Application.MessageBox('ÔãÇ ÔäÇÓÇíí äÔÏ', 'Match', MB_OK);
   end
   else
    Application.MessageBox('ÈÑÇí ÔãÇ ÇËÑ ÇäÔÊí ÊÚÑíİ äÔÏå ÇÓÊ', 'Match', MB_OK);
end;


//***********************************************************************
procedure TFtestfing.BitBtn1Click(Sender: TObject);
var
 FlagFind:boolean;
// Str : TStringStream;
 W : WideString;
i:integer;
begin
//  Str := TStringStream.Create(w);
  FlagFind:=false;
  PentacomBiometricFingerprint1.FlushImages;
  Application.MessageBox('áÕİÃ ÇäÔÊ ÎæÏ ÑÇ íß ÈÇÑ Ñæí ÓíÓÊã ŞÑÇÑ ÏåíÏ', 'Register', MB_OK);
  FeatureVerify := PentacomBiometricFingerprint1.GetVerifyFeature;
  PentacomBiometricFingerprint1.SetVerifyFeature (FeatureVerify);
  Application.MessageBox('áÕİÃ ÇäÔÊ ÎæÏ ÑÇ íß ÈÇÑ Ñæí ÓíÓÊã ŞÑÇÑ ÏåíÏ', 'Register', MB_OK);
 w:= PentacomBiometricFingerprint1.GetVerifyFeature;

//   DM.Fingers.Filter:='ID = '+DM.EmpID.AsString;
   DM.Fingers.Filter:='';
   DM.Fingers.Filtered:=True;
   DM.Fingers.First;
   If DM.Fingers.RecordCount > 0 Then
    begin
      DM.Fingers.First;
i:=1;
//     while (not DM.Fingers.eof)and (FlagFind=False) do
     while (i<1000)and (FlagFind=False) do
     begin
//`       DM.FingersFingerPrint.BlobType := ftBlob;
//        FeatureRegister:=DM.FingersFingerPrint.AsString;
//         PentacomBiometricFingerprint1.SetRegistrationFeature (FeatureRegister);
         PentacomBiometricFingerprint1.SetRegistrationFeature (DM.FingersFingerPrint.AsString);
         if PentacomBiometricFingerprint1.MatchFeatures = False then
            DM.Fingers.Next
         else
            begin
              Application.MessageBox('ÇËÑ ÇäÔÊ ÔãÇ ÔäÇÓÇíí ÔÏ', 'Match', MB_OK);
              FlagFind:=True;
            end;
        inc(i);
     end; //end while

     if (FlagFind=False)then
        Application.MessageBox('ÔãÇ ÔäÇÓÇíí äÔÏíÏ', 'Match', MB_OK);
       end
       else
    Application.MessageBox('ÈÑÇí ÔãÇ ÇËÑ ÇäÔÊí ÊÚÑíİ äÔÏå ÇÓÊ', 'Match', MB_OK);

end;


//*************************************************************************

procedure TFtestfing.AccFC(NoFing:integer;conterfingreg:integer);
Var
 H,W : Integer;
 srcH,dstH,Src,Dst : HWND;
 i,x1,y1,x,y : Integer;
 Crd : TRect;
 path:string;
begin
  //UpDown1.Increment(1);
  x :=0;
  x1 :=0;
  y  :=0;
  y1 :=0;

  H := PentacomBiometricFingerprint1.Height;
  W := PentacomBiometricFingerprint1.Width;
  crd := rect(0,0,H,W);

  srcH := PentacomBiometricFingerprint1.hWnd;
  Src := GetDC(srcH);

  dstH := Form1.Handle;
  Form1.Show;
  Form1.Height := H;
  Form1.Width  := W;
  Dst := GetDC(dstH);
  BitBlt(Dst,x,y,W,H,Src,x1,y1,SRCCOPY);
  ReleaseDC(PentacomBiometricFingerprint1.Handle, Src);
  ReleaseDC(Form1.Handle,Dst);
  for i:=0 to Ftestfing.ComponentCount-1 do

    if (Ftestfing.Components[i]).Name='Image'+inttostr(NoFing) then
    begin
      x :=(Ftestfing.Components[i] as TImage).Height;
      y :=(Ftestfing.Components[i] as TImage).Width;
      (Ftestfing.Components[i] as TImage).Height := H-25;
      (Ftestfing.Components[i] as TImage).Width := W-25;
      Crd := Rect(0, 0, Form1.Width,Form1.Height );
      (Ftestfing.Components[i] as TImage).Canvas.CopyRect(Crd,Form1.Canvas,Crd);
      (Ftestfing.Components[i] as TImage).Height := x;
      (Ftestfing.Components[i] as TImage).Width := y;
      path := UMain.Dir+'/imeg_fp/'+DM.EmpID.AsString+'_'+inttostr(NoFing)+'_'+inttostr(conterfingreg)+'.bmp';

//     if FileExists(path) then  Photo.Picture.LoadFromFile(path);

      (Ftestfing.Components[i] as TImage).Picture.SaveToFile(path);
    end;
  Form1.Close;
  Refresh;
 // PentacomBiometricFingerprint1.Refresh;
end;

//***************************************************************************


procedure TFtestfing.IdEKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
Var
  i,code : Integer;
  Sw : Boolean;
  Path : AnsiString;
begin
   if key=13 then
   begin
     Val(IdE.Text,i,code);
     if ((i<0) or (code<>0)) then
     begin
       ShowMessage('ÔãÇÑå ÔäÇÓÇíí äÇãÚÊÈÑ ÇÓÊ');
       ActiveControl := IdE;
       IdE.Text := '';
     end;
     Sw := DM.Emp.FindKey([IdE.Text]);
     if Not(Sw) then
     begin
       ShowMessage('ÔãÇÑå ÔäÇÓÇíí ÏÑ ÌÏæá íÇİÊ äÔÏ');
       ActiveControl := IdE;
     end;
     Ne.Caption := DM.EmpFName.AsString;
     LNe.Caption := DM.EmpLName.AsString;
     fingtik();
   end;
end;

procedure TFtestfing.FormActivate(Sender: TObject);
begin
  FMain.Visible := False;
end;

procedure TFtestfing.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FMain.Visible := True;
end;


procedure TFtestfing.DBNavigator2Click(Sender: TObject;
  Button: TNavigateBtn);
begin
     Img1.Visible:=false;
     Img2.Visible:=false;
     Img3.Visible:=false;
     Img4.Visible:=false;
end;


//***********************************************************************

procedure TFtestfing.Button1Click(Sender: TObject);
var BuffFeatureRegister:array [1..6] of WideString;
k,i:integer;
ss:string;
begin

    Application.MessageBox('áÕİÃ ÇäÔÊ ÎæÏ ÑÇ åÇÑ ÈÇÑ Ñæí ÓíÓÊã ŞÑÇÑ ÏåíÏ', 'Register', MB_OK);
    BuffFeatureRegister[1] := PentacomBiometricFingerprint1.GetRegistrationFeature;
    Application.MessageBox('áÕİÃ ÇäÔÊ ÎæÏ ÑÇ åÇÑ ÈÇÑ Ñæí ÓíÓÊã ŞÑÇÑ ÏåíÏ', 'Register', MB_OK);
    BuffFeatureRegister[2] := PentacomBiometricFingerprint1.GetRegistrationFeature;
    Application.MessageBox('áÕİÃ ÇäÔÊ ÎæÏ ÑÇ åÇÑ ÈÇÑ Ñæí ÓíÓÊã ŞÑÇÑ ÏåíÏ', 'Register', MB_OK);
    BuffFeatureRegister[3] := PentacomBiometricFingerprint1.GetRegistrationFeature;
    Application.MessageBox('áÕİÃ ÇäÔÊ ÎæÏ ÑÇ åÇÑ ÈÇÑ Ñæí ÓíÓÊã ŞÑÇÑ ÏåíÏ', 'Register', MB_OK);
    BuffFeatureRegister[4] := PentacomBiometricFingerprint1.GetRegistrationFeature;
    Application.MessageBox('áÕİÃ ÇäÔÊ ÎæÏ ÑÇ åÇÑ ÈÇÑ Ñæí ÓíÓÊã ŞÑÇÑ ÏåíÏ', 'Register', MB_OK);
    BuffFeatureRegister[5] := PentacomBiometricFingerprint1.GetRegistrationFeature;
i:=1;
k:=1;
  while i<30000 do
    begin

    DM.Emp.Insert;
    DM.EmpID.AsFloat:=i;
    ss:=inttostr(i);
    DM.EmpFName.AsString:=ss;
    DM.EmpLName.AsString:=ss;
    DM.EmpPCode.AsString:=ss;
    DM.Emp.post;

      DM.Fingers.insert;
      DM.FingersFingerPrint.BlobType := ftBlob;
      DM.FingersFingerPrint.value:=BuffFeatureRegister[k];
      DM.FingersID.Asfloat :=i;
      DM.FingersFingerID.AsString :='1';
      DM.Fingers.Post;
     if k=5 then k:=0;
     inc(k);
     inc(i);
    end;
end;

procedure TFtestfing.Button2Click(Sender: TObject);
var i:longint;
begin

   DM.Fingers.Filter:='';
   DM.Fingers.Filtered:=True;
   DM.Fingers.First;
    i:=1;
     while (not DM.Fingers.eof)and (i<30000) do
     begin
         Buf1Id[i]:=DM.FingersId.asfloat;
         Buf1Register[i]:=DM.FingersFingerPrint.AsString;
         DM.Fingers.Next;
         inc(i);
     end; //end while

    Application.MessageBox('End Load', 'Match', MB_OK);


end;

procedure TFtestfing.Button3Click(Sender: TObject);
var i:longint;
FlagFind:boolean;
tempTime,tempTime2:tdatetime;
begin
FlagFind:=false;
i:=1;
  FlagFind:=false;
  PentacomBiometricFingerprint1.FlushImages;
  Application.MessageBox('áÕİÃ ÇäÔÊ ÎæÏ ÑÇ íß ÈÇÑ Ñæí ÓíÓÊã ŞÑÇÑ ÏåíÏ', 'Register', MB_OK);
  FeatureVerify := PentacomBiometricFingerprint1.GetVerifyFeature;
  PentacomBiometricFingerprint1.SetVerifyFeature (FeatureVerify);

  tempTime:=now;
     while (i<1000)and (FlagFind=False) do
     begin
         PentacomBiometricFingerprint1.SetRegistrationFeature (Buf1Register[i]);
         if PentacomBiometricFingerprint1.MatchFeatures = False then
         else
            begin
              Application.MessageBox('ÇËÑ ÇäÔÊ ÔãÇ ÔäÇÓÇíí ÔÏ', 'Match', MB_OK);
              FlagFind:=True;
            end;
        inc(i);
     end; //end while
  tempTime2:=now;
//  DecodeTime(tempTime, Hour, Min, Sec, MSec);
  edit2.text:=timetostr(tempTime2);
  edit1.text:=timetostr(tempTime);

     if (FlagFind=False)then
        Application.MessageBox('ÔãÇ ÔäÇÓÇíí äÔÏíÏ', 'Match', MB_OK);

end;

procedure TFtestfing.Button4Click(Sender: TObject);
var i:longint;
FlagFind:boolean;
Feature:WideString;
tempTime,tempTime2:tdatetime;
begin

FlagFind:=false;
i:=1;
  FlagFind:=false;
  PentacomBiometricFingerprint1.FlushImages;
  Application.MessageBox('áÕİÃ ÇäÔÊ ÎæÏ ÑÇ íß ÈÇÑ Ñæí ÓíÓÊã ŞÑÇÑ ÏåíÏ', 'Register', MB_OK);
  Feature:= PentacomBiometricFingerprint1.GetVerifyFeature;
  Application.MessageBox('áÕİÃ ÇäÔÊ ÎæÏ ÑÇ íß ÈÇÑ Ñæí ÓíÓÊã ŞÑÇÑ ÏåíÏ', 'Register', MB_OK);
  FeatureVerify := PentacomBiometricFingerprint1.GetVerifyFeature;
  PentacomBiometricFingerprint1.SetVerifyFeature (FeatureVerify);

  tempTime:=now;


     while (i<1000) do
     begin
         PentacomBiometricFingerprint1.SetRegistrationFeature (Feature);
         PentacomBiometricFingerprint1.MatchFeatures;
        inc(i);
     end; //end while
  tempTime2:=now;
//  DecodeTime(tempTime, Hour, Min, Sec, MSec);
  edit2.text:=timetostr(tempTime2);
  edit1.text:=timetostr(tempTime);
     if (FlagFind=False)then
        Application.MessageBox('ÔãÇ ÔäÇÓÇíí äÔÏíÏ', 'Match', MB_OK);
end;
end.
