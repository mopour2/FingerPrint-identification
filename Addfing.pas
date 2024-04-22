unit Addfing;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, DBCtrls, ExtCtrls, Db, DBTables, AxCtrls, OleCtrls,
  PENTACOMBIOMETRICFINGERPRINTLib_TLB, MPlayer, Buttons, ComCtrls, Grids,
  DBGrids, prjBioFast_TLB;

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
Type
lrect =record
  left : Longint;
  top: Longint;
  right : Longint;
  bottom : Longint;
End ;


type
  TAddfingForm = class(TForm)
    Panel2: TPanel;
    Panel1: TPanel;
    Panel3: TPanel;
    StatusBar1: TStatusBar;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    Image5: TImage;
    Image6: TImage;
    Image7: TImage;
    Image8: TImage;
    Image9: TImage;
    Image10: TImage;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Panel4: TPanel;
    Image40: TImage;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Img1: TImage;
    img2: TImage;
    img2_2: TImage;
    img3: TImage;
    img4: TImage;
    img4_4: TImage;
    img1_1: TImage;
    img3_3: TImage;
    CheckBox10: TCheckBox;
    CheckBox9: TCheckBox;
    CheckBox8: TCheckBox;
    CheckBox7: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox1: TCheckBox;
    CheckBox5: TCheckBox;
    CheckBox6: TCheckBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    DBNavigator1: TDBNavigator;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    PentacomBiometricFingerprint1: TPentacomBiometricFingerprint;
    Panel5: TPanel;
    BioFast1: TBioFast;
    Label4: TLabel;
    DBGrid1: TDBGrid;
    Edit1: TEdit;
    Button1: TButton;
    Edit2: TEdit;
    Edit3: TEdit;
    DBEdit1: TDBEdit;
    Label5: TLabel;
    Edit4: TEdit;
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
    procedure Edit2KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Edit1Enter(Sender: TObject);
    procedure DataSourceEmpDataChange(Sender: TObject; Field: TField);
    procedure Edit2KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Edit3KeyPress(Sender: TObject; var Key: Char);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure Edit2KeyPress(Sender: TObject; var Key: Char);
    procedure Button1Click(Sender: TObject);
    procedure Edit2Enter(Sender: TObject);
    procedure Edit4KeyPress(Sender: TObject; var Key: Char);
    procedure DBGrid1CellClick(Column: TColumn);
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
    procedure CompEnabel;
    procedure CompDesable;
 end;

var
  AddfingForm: TAddfingForm;
  FeatureRegister: WideString;
  FeatureRegisterFast: WideString;
  FeatureVerify: WideString;
  keyZal:Boolean;

  sFeature:String;
  sFeatures : array[1..4] of String ;
  sFeatureToSave : array[1..3] of String ;
  sTemp:string;
  FlagRegFeature:Boolean;
implementation

uses data, UMain, UForm1;

{$R *.DFM}
//***********************************************************************
procedure TAddfingForm.FormShow(Sender: TObject);
begin
 FMain.SetDateInstall;
//   PentacomBiometricFingerprint1.GetConnectedDeviceCount
//   for first id    PentacomBiometricFingerprint1.GetConnectedDeviceID()
//   for next id    PentacomBiometricFingerprint1.GetConnectedDeviceID()
//   PentacomBiometricFingerprint1.DeviceID:= ?


 PentacomBiometricFingerprint1.Initialize;
 BioFast1.oleobject.BinarizationThresholdPercentEnabled := false;
 BioFast1.oleobject.RecognitionThreshold := ConstRecognitionThreshold;
 FMain.SetDateDay;

  SetLength(FeatureRegister, 300);
  SetLength(FeatureVerify, 300);
  flagReg:=false;
     fingtik();
  DM.Emp.open;
//  DM.Emp.IndexName:='IX_Employees';
  DM.Emp.IndexName:='IX_AtentEmploy';
  Dm.Fingers.open;
 // dbedit2.SetFocus;
//PentacomBiometricFingerprint1.Width:= 360;
//PentacomBiometricFingerprint1.Top:=80;
//PentacomBiometricFingerprint1.Height:=364;
//PentacomBiometricFingerprint1.Left:=3;
end;
//***********************************************************************
procedure TAddfingForm.DelFing(ch:string);
begin

  if MessageDlg('Deleted Finger Info',mtWarning, [mbYes, mbNo], 0) = 3 then
  begin
    if (length(DM.EmpId.AsString)>=1) and (length(DM.EmpId.AsString)<=6) then
    if(Dm.Fingers.FindKey([DM.EmpId.AsString,ch])=True) then
    begin
      Dm.Fingers.Delete;
    end
  end;
end;
//***********************************************************************
procedure TAddfingForm.CompEnabel;
begin
    DBGrid1.Enabled:=true;;
    DBNavigator1.Enabled:=true;
    Button1.Enabled:=true;
{  CheckBox1.Enabled:=true;CheckBox2.Enabled:=true;CheckBox3.Enabled:=true;
  CheckBox4.Enabled:=true;CheckBox5.Enabled:=true;CheckBox6.Enabled:=true;
  CheckBox7.Enabled:=true;CheckBox8.Enabled:=true;CheckBox9.Enabled:=true;
  CheckBox10.Enabled:=true;
}
end;
//***********************************************************************
procedure TAddfingForm.CompDesable;
begin
    DBGrid1.Enabled:=false;
    DBNavigator1.Enabled:=false;
    Button1.Enabled:=false;
{  CheckBox1.Enabled:=false;CheckBox2.Enabled:=false;CheckBox3.Enabled:=false;
  CheckBox4.Enabled:=false;CheckBox5.Enabled:=false;CheckBox6.Enabled:=false;
  CheckBox7.Enabled:=false;CheckBox8.Enabled:=false;CheckBox9.Enabled:=false;
  CheckBox10.Enabled:=false;
}
end;
//***********************************************************************
function TAddfingForm.AddFing(ch:string):integer;
var
  bl: TBlobField;
iCounter,iCounterInner:integer;
bMatchingOk:boolean;
begin
   if (length(DM.EmpId.AsString)<1) or (length(DM.EmpId.AsString) > 6) then
    Application.MessageBox('òœ «‘ﬂ«· œ«—œ', 'Register', MB_OK)
   else
   begin

    Application.MessageBox('·’›√ «‰ê‘  ŒÊœ —« çÂ«— »«— —ÊÌ ”Ì” „ ﬁ—«— œÂÌœ', 'Register', MB_OK);
    FMain.SetDateInstall;

    PentacomBiometricFingerprint1.FlushImages;
     Img1.Visible:=false;
     Img2.Visible:=false;
     Img3.Visible:=false;
     Img4.Visible:=false;
     Img1_1.Visible:=false;
     Img2_2.Visible:=false;
     Img3_3.Visible:=false;
     Img4_4.Visible:=false;
    CompDesable;

    FlagRegFeature:=true;
    conterfingreg:=0;
    flagReg:=true;

    FeatureRegister := PentacomBiometricFingerprint1.GetRegistrationFeature;

    FMain.SetDateDay;

    CompEnabel;

    flagReg:=false;

   if (conterfingreg=4) and  (length(DM.EmpId.AsString)>=1)  and (length(DM.EmpId.AsString)<=6)and (FlagRegFeature=true)then
   begin
//*************************************
    for iCounter := 1 to 4 do
    begin
      for iCounterInner := iCounter + 1 to 4 do
      begin
        if BioFast1.oleobject.MinutiaeCount(sFeatures[iCounter]) < BioFast1.oleobject.MinutiaeCount(sFeatures[iCounterInner]) then
        begin
          sTemp := sFeatures[iCounter];
          sFeatures[iCounter] := sFeatures[iCounterInner];
          sFeatures[iCounterInner] := sTemp;
        end;
      end;
    end;

    bMatchingOk := False;
    //If 1 matches 2, then if 1 matches at least 3 or 4 then Ok
    if BioFast1.oleobject.MatchFeatures(sFeatures[1], sFeatures[2], True) then
    begin
      if BioFast1.oleobject.MatchFeatures(sFeatures[1], sFeatures[3], True) then
      begin
        bMatchingOk := True;
        sFeatureToSave[1] := sFeatures[1];
        sFeatureToSave[2] := sFeatures[2];
        sFeatureToSave[3] := sFeatures[3];
      end
      else if BioFast1.oleobject.MatchFeatures(sFeatures[1], sFeatures[4], True) Then
      begin
        bMatchingOk := True;
        sFeatureToSave[1] := sFeatures[1];
        sFeatureToSave[2] := sFeatures[2];
        sFeatureToSave[3] := sFeatures[4];
      end;
    end;

    //If 2 matches 3, then if 2 matches at least 1 or 4 then Ok
    if Not bMatchingOk then
    begin
      if BioFast1.oleobject.MatchFeatures(sFeatures[2], sFeatures[3], True) then
      begin
        if BioFast1.oleobject.MatchFeatures(sFeatures[2], sFeatures[1], True) then
        begin
          bMatchingOk := True;
          sFeatureToSave[1] := sFeatures[1];
          sFeatureToSave[2] := sFeatures[2];
          sFeatureToSave[3] := sFeatures[3];
        end
        else if BioFast1.oleobject.MatchFeatures(sFeatures[2], sFeatures[4], True) Then
        begin
          bMatchingOk := True;
          sFeatureToSave[1] := sFeatures[2];
          sFeatureToSave[2] := sFeatures[3];
          sFeatureToSave[3] := sFeatures[4];
        end;
      end;
    end;

    //If 3 matches 4, then if 3 matches at least 1 or 2 then Ok
    if Not bMatchingOk then
    begin
      if BioFast1.oleobject.MatchFeatures(sFeatures[3], sFeatures[4], True) then
      begin
        if BioFast1.oleobject.MatchFeatures(sFeatures[3], sFeatures[1], True) then
        begin
          bMatchingOk := True;
          sFeatureToSave[1] := sFeatures[1];
          sFeatureToSave[2] := sFeatures[3];
          sFeatureToSave[3] := sFeatures[4];
        end
        else if BioFast1.oleobject.MatchFeatures(sFeatures[3], sFeatures[2], True) Then
        begin
          bMatchingOk := True;
          sFeatureToSave[1] := sFeatures[2];
          sFeatureToSave[2] := sFeatures[3];
          sFeatureToSave[3] := sFeatures[4];
        end;
      end;
    end;

    //If 4 matches 1, then if 4 matches at least 2 or 3 then Ok
    if Not bMatchingOk then
    begin
      if BioFast1.oleobject.MatchFeatures(sFeatures[4], sFeatures[1], True) then
      begin
        if BioFast1.oleobject.MatchFeatures(sFeatures[4], sFeatures[2], True) then
        begin
          bMatchingOk := True;
          sFeatureToSave[1] := sFeatures[1];
          sFeatureToSave[2] := sFeatures[2];
          sFeatureToSave[3] := sFeatures[4];
        end
        else if BioFast1.oleobject.MatchFeatures(sFeatures[4], sFeatures[3], True) Then
        begin
          bMatchingOk := True;
          sFeatureToSave[1] := sFeatures[1];
          sFeatureToSave[2] := sFeatures[3];
          sFeatureToSave[3] := sFeatures[4];
        end;
      end;
    end;

    //If 1 matches 3, then if 1 matches at least 2 or 4 then Ok
    if Not bMatchingOk then
    begin
      if BioFast1.oleobject.MatchFeatures(sFeatures[1], sFeatures[3], True) then
      begin
        if BioFast1.oleobject.MatchFeatures(sFeatures[1], sFeatures[2], True) then
        begin
          bMatchingOk := True;
          sFeatureToSave[1] := sFeatures[1];
          sFeatureToSave[2] := sFeatures[2];
          sFeatureToSave[3] := sFeatures[3];
        end
        else if BioFast1.oleobject.MatchFeatures(sFeatures[1], sFeatures[4], True) Then
        begin
          bMatchingOk := True;
          sFeatureToSave[1] := sFeatures[1];
          sFeatureToSave[2] := sFeatures[3];
          sFeatureToSave[3] := sFeatures[4];
        end;
      end;
    end;

    //If 2 matches 4, then if 1 matches at least 1 or 3 then Ok
    if Not bMatchingOk then
    begin
      if BioFast1.oleobject.MatchFeatures(sFeatures[2], sFeatures[4], True) then
      begin
        if BioFast1.oleobject.MatchFeatures(sFeatures[2], sFeatures[1], True) then
        begin
          bMatchingOk := True;
          sFeatureToSave[1] := sFeatures[1];
          sFeatureToSave[2] := sFeatures[2];
          sFeatureToSave[3] := sFeatures[4];
        end
        else if BioFast1.oleobject.MatchFeatures(sFeatures[2], sFeatures[3], True) Then
        begin
          bMatchingOk := True;
          sFeatureToSave[1] := sFeatures[2];
          sFeatureToSave[2] := sFeatures[3];
          sFeatureToSave[3] := sFeatures[4];
        end;
      end;
    end;

    sFeature :=  BioFast1.oleobject.FeaturesAverage(sFeatureToSave[1], sFeatureToSave[2],sFeatureToSave[3]);
    FeatureRegisterFast:=sFeature;
//    edit2.text:=inttostr(length(sFeature));
    if sFeature = '' then
      begin
       FlagRegFeature:=false; //cancel register
      end
      else
      begin
        if BioFast1.oleobject.MinutiaeCount(sFeature) < 15 then
        begin
         FlagRegFeature:=false; //cancel register
        end
        else
        begin
        end;
      end;
 FMain.SetDateDay;

//*************************************
   if FlagRegFeature=true then
   begin
    if(DM.Fingers.FindKey([DM.EmpId.AsString,ch])=True) then
    begin
      DM.Fingers.Edit;
      DM.FingersFingerPrint.BlobType := ftBlob;
      DM.FingersFingerPrint.value:=FeatureRegister;
      DM.FingersFingerPrintFast.BlobType := ftBlob;
      DM.FingersFingerPrintFast.value:=FeatureRegisterFast;
      DM.Fingers.Post;
    end
   else
    begin
      DM.Fingers.insert;
      DM.FingersFingerPrint.BlobType := ftBlob;
      DM.FingersFingerPrint.value:=FeatureRegister;
      DM.FingersID.AsString := DM.EmpId.AsString;
      DM.FingersFingerPrintFast.BlobType := ftBlob;
      DM.FingersFingerPrintFast.value:=FeatureRegisterFast;
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
     AddfingForm.Refresh;
     sleep(2000);
     Img1.Visible:=false;
     Img2.Visible:=false;
     Img3.Visible:=false;
     Img4.Visible:=false;
     Img1_1.Visible:=false;
     Img2_2.Visible:=false;
     Img3_3.Visible:=false;
     Img4_4.Visible:=false;
     result:=0;
     end;
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
     AddfingForm.Refresh;
     sleep(2000);
     Img1.Visible:=false;
     Img2.Visible:=false;
     Img3.Visible:=false;
     Img4.Visible:=false;
     Img1_1.Visible:=false;
     Img2_2.Visible:=false;
     Img3_3.Visible:=false;
     Img4_4.Visible:=false;
     result:=0;
  end;
  End;
result:=0;
end;
//****************************************************************************
procedure TAddfingForm.CheckBox4Click(Sender: TObject);
begin
if flagReg=false then
if ( CheckBox4.Checked=True)then
  begin
      LastNoFing:=4;
     if AddFing('4')=0 then
      begin
       CheckBox4.OnClick:=nil;
       CheckBox4.Checked:=false;
       CheckBox4.OnClick:=CheckBox4Click;
      end
     else label24.Visible:=true;
  end
else
 begin
     label24.Visible:=false;
     DelFing('4');
 end
else
      begin
       CheckBox4.OnClick:=nil;
       CheckBox4.Checked:=true;
       CheckBox4.OnClick:=CheckBox4Click;
      end

end;
//****************************************************************************
procedure TAddfingForm.CheckBox1Click(Sender: TObject);
begin
if flagReg=false then
if ( CheckBox1.Checked=True)then
  begin
     LastNoFing:=1;
     if AddFing('1')=0 then
      begin
       CheckBox1.OnClick:=nil;
       CheckBox1.Checked:=false;
       CheckBox1.OnClick:=CheckBox1Click;
      end
     else label21.Visible:=true;
   end
else
 begin
     DelFing('1');
     label21.Visible:=false;
 end
else
      begin
       CheckBox1.OnClick:=nil;
       CheckBox1.Checked:=true;
       CheckBox1.OnClick:=CheckBox1Click;
      end

end;
//****************************************************************************
procedure TAddfingForm.CheckBox2Click(Sender: TObject);
begin
if flagReg=false then
if ( CheckBox2.Checked=True)then
  begin
     LastNoFing:=2;
     if AddFing('2')=0 then
      begin
       CheckBox2.OnClick:=nil;
       CheckBox2.Checked:=false;
       CheckBox2.OnClick:=CheckBox2Click;
      end
     else label22.Visible:=true;
  end
else
 begin
     DelFing('2');
     label22.Visible:=false;
 end
else
      begin
       CheckBox2.OnClick:=nil;
       CheckBox2.Checked:=true;
       CheckBox2.OnClick:=CheckBox2Click;
      end
end;
//****************************************************************************
procedure TAddfingForm.CheckBox3Click(Sender: TObject);
begin
if flagReg=false then
if ( CheckBox3.Checked=True)then
  begin
     LastNoFing:=3;
     if AddFing('3')=0 then
      begin
       CheckBox3.OnClick:=nil;
       CheckBox3.Checked:=false;
       CheckBox3.OnClick:=CheckBox3Click;
      end
     else label23.Visible:=true;
  end
else
 begin
     DelFing('3');
     label23.Visible:=false;
 end
else
      begin
       CheckBox3.OnClick:=nil;
       CheckBox3.Checked:=true;
       CheckBox3.OnClick:=CheckBox3Click;
      end
end;
//****************************************************************************
procedure TAddfingForm.CheckBox5Click(Sender: TObject);
begin
if flagReg=false then
if ( CheckBox5.Checked=True)then
  begin
     LastNoFing:=5;
     if AddFing('5')=0 then
      begin
       CheckBox5.OnClick:=nil;
       CheckBox5.Checked:=false;
       CheckBox5.OnClick:=CheckBox5Click;
      end
     else label25.Visible:=true;
  end
else
 begin
     DelFing('5');
     label25.Visible:=false;
 end
else
     begin
       CheckBox5.OnClick:=nil;
       CheckBox5.Checked:=true;
       CheckBox5.OnClick:=CheckBox5Click;
      end

end;
//****************************************************************************
procedure TAddfingForm.CheckBox6Click(Sender: TObject);
begin
if flagReg=false then
if ( CheckBox6.Checked=True)then
  begin
     LastNoFing:=6;
     if AddFing('6')=0 then
      begin
       CheckBox6.OnClick:=nil;
       CheckBox6.Checked:=false;
       CheckBox6.OnClick:=CheckBox6Click;
      end
     else label26.Visible:=true;
  end
else
 begin
     DelFing('6');
     label26.Visible:=false;
 end
else
      begin
       CheckBox6.OnClick:=nil;
       CheckBox6.Checked:=true;
       CheckBox6.OnClick:=CheckBox6Click;
      end
end;
//****************************************************************************
procedure TAddfingForm.CheckBox7Click(Sender: TObject);
begin
if flagReg=false then
if ( CheckBox7.Checked=True)then
  begin
     LastNoFing:=7;
     if AddFing('7')=0 then
      begin
       CheckBox7.OnClick:=nil;
       CheckBox7.Checked:=false;
       CheckBox7.OnClick:=CheckBox7Click;
      end
     else label27.Visible:=true;
  end
else
 begin
     DelFing('7');
     label27.Visible:=false;
 end
else
      begin
       CheckBox7.OnClick:=nil;
       CheckBox7.Checked:=true;
       CheckBox7.OnClick:=CheckBox7Click;
      end
end;
//****************************************************************************
procedure TAddfingForm.CheckBox8Click(Sender: TObject);
begin
if flagReg=false then
if ( CheckBox8.Checked=True)then
  begin
     LastNoFing:=8;
     if AddFing('8')=0 then
      begin
       CheckBox8.OnClick:=nil;
       CheckBox8.Checked:=false;
       CheckBox8.OnClick:=CheckBox8Click;
      end
     else label28.Visible:=true;
  end
else
 begin
     DelFing('8');
     label28.Visible:=false;
 end
else
      begin
       CheckBox8.OnClick:=nil;
       CheckBox8.Checked:=true;
       CheckBox8.OnClick:=CheckBox8Click;
      end
end;
//****************************************************************************
procedure TAddfingForm.CheckBox9Click(Sender: TObject);
begin
if flagReg=false then
if ( CheckBox9.Checked=True)then
  begin
     LastNoFing:=9;
     if AddFing('9')=0 then
      begin
       CheckBox9.OnClick:=nil;
       CheckBox9.Checked:=false;
       CheckBox9.OnClick:=CheckBox9Click;
      end
     else label29.Visible:=true;
  end
else
 begin
     DelFing('9');
     label29.Visible:=false;
 end
else
      begin
       CheckBox9.OnClick:=nil;
       CheckBox9.Checked:=true;
       CheckBox9.OnClick:=CheckBox9Click;
      end
end;
//****************************************************************************
procedure TAddfingForm.CheckBox10Click(Sender: TObject);
begin
if flagReg=false then
if ( CheckBox10.Checked=True)then
  begin
     LastNoFing:=10;
     if AddFing('10')=0 then
      begin
       CheckBox10.OnClick:=nil;
       CheckBox10.Checked:=false;
       CheckBox10.OnClick:=CheckBox10Click;
      end
    else label30.Visible:=true;
  end
else
 begin
     DelFing('10');
     label30.Visible:=false;
 end
else
      begin
       CheckBox10.OnClick:=nil;
       CheckBox10.Checked:=true;
       CheckBox10.OnClick:=CheckBox10Click;
      end
end;
//****************************************************************************
Function TAddfingForm.StatusDescription(iStatus : Integer) :String;
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

                                   if FlagRegFeature=true then
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
//****************************************************************************
procedure TAddfingForm.CopyHWnd();
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
//****************************************************************************
procedure TAddfingForm.GetTwipsPerPixel();
var
   NumPix:Longint;
begin
   // Set a global variable with the Twips to Pixel ratio.
   AddfingForm.Scaleby(3,2);
   NumPix := AddfingForm.Height;
   AddfingForm.Scaleby (1,1);
//   TwipsPerPixel := FormAddFing.Height / NumPix;
End;

//*****************************************************

procedure TAddfingForm.PentacomBiometricFingerprint1Status(Sender: TObject;
  iStatus: Smallint);
begin
  StatusBar1.Panels[0].Text :=StatusDescription(iStatus );
  StatusBar1.Refresh;
//  sleep(1000);

end;
//*****************************************************
procedure TAddfingForm.fingtik();
var path:string;
begin
//MediaPlayer1.FileName:=path+'sound\'+TableInfoId.asstring+'.wav';
//MediaPlayer1.Open;
//Image100.Picture.LoadFromFile(path+'image\'+TableInfoId.asstring+'.jpg');

  if FileExists(UMain.Dir+'\Null.bmp') then
  begin
    Image1.Picture.LoadFromFile(UMain.Dir+'\Null.bmp');
    Image2.Picture.LoadFromFile(UMain.Dir+'\Null.bmp');
    Image3.Picture.LoadFromFile(UMain.Dir+'\Null.bmp');
    Image4.Picture.LoadFromFile(UMain.Dir+'\Null.bmp');
    Image5.Picture.LoadFromFile(UMain.Dir+'\Null.bmp');
    Image6.Picture.LoadFromFile(UMain.Dir+'\Null.bmp');
    Image7.Picture.LoadFromFile(UMain.Dir+'\Null.bmp');
    Image8.Picture.LoadFromFile(UMain.Dir+'\Null.bmp');
    Image9.Picture.LoadFromFile(UMain.Dir+'\Null.bmp');
    Image10.Picture.LoadFromFile(UMain.Dir+'\Null.bmp');
  end;

  if (length(DM.EmpId.AsString)<1) or (length(DM.EmpId.AsString)>6)then
   begin
  label21.Visible:=false;label22.Visible:=false;label23.Visible:=false;label24.Visible:=false;
  label25.Visible:=false;label26.Visible:=false;label27.Visible:=false;label28.Visible:=false;
  label29.Visible:=false;label30.Visible:=false;
    CheckBox1.OnClick:=nil;CheckBox2.OnClick:=nil;CheckBox3.OnClick:=nil;CheckBox4.OnClick:=nil;
  CheckBox5.OnClick:=nil;CheckBox6.OnClick:=nil;CheckBox7.OnClick:=nil;CheckBox8.OnClick:=nil;
  CheckBox9.OnClick:=nil;CheckBox10.OnClick:=nil;

  CheckBox1.Checked:=false;CheckBox2.Checked:=false;CheckBox3.Checked:=false;
  CheckBox4.Checked:=false;CheckBox5.Checked:=false;CheckBox6.Checked:=false;
  CheckBox7.Checked:=false;CheckBox8.Checked:=false;CheckBox9.Checked:=false;
  CheckBox10.Checked:=false;

  CheckBox1.OnClick:=CheckBox1Click; CheckBox2.OnClick:=CheckBox2Click;
  CheckBox3.OnClick:=CheckBox3Click; CheckBox4.OnClick:=CheckBox4Click;
  CheckBox5.OnClick:=CheckBox5Click; CheckBox6.OnClick:=CheckBox6Click;
  CheckBox7.OnClick:=CheckBox7Click; CheckBox8.OnClick:=CheckBox8Click;
  CheckBox9.OnClick:=CheckBox9Click; CheckBox10.OnClick:=CheckBox10Click;

   end
  else
  begin
  DM.Fingers.Filter:='ID = '''+DM.EmpId.AsString+'''';
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
    begin
     CheckBox1.Checked:=True; label21.Visible:=True;
      path := UMain.Dir+'\imeg_fp\'+DM.EmpId.AsString+'_1_1'+'.bmp';
     if FileExists(path) then
       Image1.Picture.LoadFromFile(path);
     end
  else if (Dm.FingersFingerID.asstring='2')then
    begin
      CheckBox2.Checked:=True; label22.Visible:=True;
        path := UMain.Dir+'\imeg_fp\'+DM.EmpId.AsString+'_2_1'+'.bmp';
     if FileExists(path) then
       Image2.Picture.LoadFromFile(path);
    end
  else if (Dm.FingersFingerID.asstring='3')then
    begin
     CheckBox3.Checked:=True; label23.Visible:=True;
       path := UMain.Dir+'\imeg_fp\'+DM.EmpId.AsString+'_3_1'+'.bmp';
     if FileExists(path) then
       Image3.Picture.LoadFromFile(path);
    end
  else if (Dm.FingersFingerID.asstring='4')then
    begin
      CheckBox4.Checked:=True; label24.Visible:=True;
        path := UMain.Dir+'\imeg_fp\'+DM.EmpId.AsString+'_4_1'+'.bmp';
     if FileExists(path) then
       Image4.Picture.LoadFromFile(path);
    end
  else if (Dm.FingersFingerID.asstring='5')then
    begin
     CheckBox5.Checked:=True; label25.Visible:=True;
       path := UMain.Dir+'\imeg_fp\'+DM.EmpId.AsString+'_5_1'+'.bmp';
     if FileExists(path) then
       Image5.Picture.LoadFromFile(path);
    end
  else if (Dm.FingersFingerID.asstring='6')then
    begin
      CheckBox6.Checked:=True; label26.Visible:=True;
      path := UMain.Dir+'\imeg_fp\'+DM.EmpId.AsString+'_6_1'+'.bmp';
     if FileExists(path) then
       Image6.Picture.LoadFromFile(path);
    end
  else if (Dm.FingersFingerID.asstring='7')then
    begin
     CheckBox7.Checked:=True; label27.Visible:=True;
     path := UMain.Dir+'\imeg_fp\'+DM.EmpId.AsString+'_7_1'+'.bmp';
     if FileExists(path) then
       Image7.Picture.LoadFromFile(path);
    end
  else if (Dm.FingersFingerID.asstring='8')then
    begin
     CheckBox8.Checked:=True; label28.Visible:=True;
       path := UMain.Dir+'\imeg_fp\'+DM.EmpId.AsString+'_8_1'+'.bmp';
     if FileExists(path) then
       Image8.Picture.LoadFromFile(path);
    end
  else if (Dm.FingersFingerID.asstring='9')then
    begin
      CheckBox9.Checked:=True; label29.Visible:=True;
        path := UMain.Dir+'\imeg_fp\'+DM.EmpId.AsString+'_9_1'+'.bmp';
     if FileExists(path) then
       Image9.Picture.LoadFromFile(path);
    end
  else if (Dm.FingersFingerID.asstring='10')then
    begin
      CheckBox10.Checked:=True; label30.Visible:=True;
        path := UMain.Dir+'\imeg_fp\'+DM.EmpId.AsString+'_10_1'+'.bmp';
     if FileExists(path) then
       Image10.Picture.LoadFromFile(path);
    end;
  DM.Fingers.Next;
 end;

  CheckBox1.OnClick:=CheckBox1Click; CheckBox2.OnClick:=CheckBox2Click;
  CheckBox3.OnClick:=CheckBox3Click; CheckBox4.OnClick:=CheckBox4Click;
  CheckBox5.OnClick:=CheckBox5Click; CheckBox6.OnClick:=CheckBox6Click;
  CheckBox7.OnClick:=CheckBox7Click; CheckBox8.OnClick:=CheckBox8Click;
  CheckBox9.OnClick:=CheckBox9Click; CheckBox10.OnClick:=CheckBox10Click;
 end;
end;
//****************************************************************************
procedure TAddfingForm.DBNavigator1Click(Sender: TObject;
  Button: TNavigateBtn);
begin
     fingtik();
     Img1.Visible:=false;
     Img2.Visible:=false;
     Img3.Visible:=false;
     Img4.Visible:=false;
end;
//*****************************************************
procedure TAddfingForm.BitBtn2Click(Sender: TObject);
var
 FlagFind:boolean;
// Str : TStringStream;
// W : WideString;
begin
//  Str := TStringStream.Create(w);
  FlagFind:=false;
   if (length(DM.EmpId.AsString)<1) or (length(DM.EmpId.AsString) > 6) then
    Application.MessageBox('òœ «‘ﬂ«· œ«—œ', 'Register', MB_OK)
  else
  begin
  FMain.SetDateInstall;
  PentacomBiometricFingerprint1.FlushImages;
  FMain.SetDateDay;

  Application.MessageBox('·’›√›ﬁÿ Ìò «‰ê‘  ŒÊœ —« Ìﬂ »«— —ÊÌ ”Ì” „ ﬁ—«— œÂÌœ', 'Register', MB_OK);
  FMain.SetDateInstall;
  FeatureVerify := PentacomBiometricFingerprint1.GetVerifyFeature;
  PentacomBiometricFingerprint1.SetVerifyFeature (FeatureVerify);
  FMain.SetDateDay;

   DM.Fingers.Filter:='ID = '+DM.EmpId.AsString;
   DM.Fingers.Filtered:=True;
   DM.Fingers.First;
   If DM.Fingers.RecordCount > 0 Then
    begin
      DM.Fingers.First;
     FMain.SetDateInstall;
     while (not DM.Fingers.eof)and (FlagFind=False) do
     begin
       DM.FingersFingerPrint.BlobType := ftBlob;
       FeatureRegister:=DM.FingersFingerPrint.AsString;
        PentacomBiometricFingerprint1.SetRegistrationFeature (FeatureRegister);

       if PentacomBiometricFingerprint1.MatchFeatures = False then
         DM.Fingers.Next
      else
         begin
           Application.MessageBox('«À— «‰ê‘  ‘„« ‘‰«”«ÌÌ ‘œ', 'Match', MB_OK);
           FlagFind:=True;
           AccFC(LastNoFing,1);

         end;

     end; //end while
     FMain.SetDateDay;
     if (FlagFind=False)then
       Application.MessageBox('‘„« ‘‰«”«ÌÌ ‰‘œ', 'Match', MB_OK);
   end
   else
    Application.MessageBox('»—«Ì ‘„« «À— «‰ê‘ Ì  ⁄—Ì› ‰‘œÂ «” ', 'Match', MB_OK);
  end;
end;


//***********************************************************************
procedure TAddfingForm.BitBtn1Click(Sender: TObject);
var
 FlagFind:boolean;
// Str : TStringStream;
// W : WideString;
begin
//  Str := TStringStream.Create(w);
  FlagFind:=false;
   if (length(DM.EmpId.AsString)<1) or (length(DM.EmpId.AsString) > 6) then
    Application.MessageBox('òœ »«“‰‘” êÌ «‘ﬂ«· œ«—œ', 'Register', MB_OK)
  else
  begin
  FMain.SetDateInstall;
  PentacomBiometricFingerprint1.FlushImages;
  Application.MessageBox('·’›√ «‰ê‘  ŒÊœ —« Ìﬂ »«— —ÊÌ ”Ì” „ ﬁ—«— œÂÌœ', 'Register', MB_OK);
  FeatureVerify := PentacomBiometricFingerprint1.GetVerifyFeature;
  PentacomBiometricFingerprint1.SetVerifyFeature (FeatureVerify);
  FMain.SetDateDay;

   DM.Fingers.Filter:='ID = '+DM.EmpId.AsString;
   DM.Fingers.Filtered:=True;
   DM.Fingers.First;
   If DM.Fingers.RecordCount > 0 Then
    begin
      DM.Fingers.First;

    FMain.SetDateInstall;
     while (not DM.Fingers.eof)and (FlagFind=False) do
     begin
       DM.FingersFingerPrint.BlobType := ftBlob;
       FeatureRegister:=DM.FingersFingerPrint.AsString;
       PentacomBiometricFingerprint1.SetRegistrationFeature (FeatureRegister);
       if PentacomBiometricFingerprint1.MatchFeatures = False then
         DM.Fingers.Next
      else
         begin
           Application.MessageBox('«À— «‰ê‘  ‘„« ‘‰«”«ÌÌ ‘œ', 'Match', MB_OK);
           FlagFind:=True;
         end;
     end; //end while
     FMain.SetDateDay;

     if (FlagFind=False)then
        Application.MessageBox('‘„« ‘‰«”«ÌÌ ‰‘œÌœ', 'Match', MB_OK);
       end
       else
    Application.MessageBox('»—«Ì ‘„« «À— «‰ê‘ Ì  ⁄—Ì› ‰‘œÂ «” ', 'Match', MB_OK);
 end;
end;
//*************************************************************************

procedure TAddfingForm.AccFC(NoFing:integer;conterfingreg:integer);
Var
 H,W : Integer;
 srcH,dstH,Src,Dst : HWND;
 i,x1,y1,x,y : Integer;
 Crd : TRect;
 path:string;
 sFilename:String;
 lMinutiaeCount:Integer;
begin
 FMain.SetDateInstall;

   if (length(DM.EmpId.AsString)<1) or (length(DM.EmpId.AsString) > 6) then
    Application.MessageBox('òœ «‘ﬂ«· œ«—œ', 'Register', MB_OK)
 else
 begin
  //UpDown1.Increment(1);
{  x :=0;
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
 }
//  for i:=0 to AddfingForm.ComponentCount-1 do
//    if (AddfingForm.Components[i]).Name='Image'+inttostr(NoFing) then
//    begin
  {    x :=(AddfingForm.Components[i] as TImage).Height;
      y :=(AddfingForm.Components[i] as TImage).Width;
      (AddfingForm.Components[i] as TImage).Height := H;
      (AddfingForm.Components[i] as TImage).Width := W;
      Crd := Rect(0, 0, Form1.Width,Form1.Height );
      (AddfingForm.Components[i] as TImage).Canvas.CopyRect(Crd,Form1.Canvas,Crd);
      (AddfingForm.Components[i] as TImage).Height := x;
      (AddfingForm.Components[i] as TImage).Width := y;
    }
      path := UMain.Dir+'\imeg_fp\'+DM.EmpId.AsString+'_'+inttostr(NoFing)+'_'+inttostr(conterfingreg)+'.bmp';
//     if FileExists(path) then  Photo.Picture.LoadFromFile(path);
      PentacomBiometricFingerprint1.SaveBitmap(path);
      BioFast1.oleobject.LoadFingerprintFromBMP(path);
//    sFilename := 'c:\biofast_feature_temp.dat';
//    BioFast1.oleobject.Fingerprint2FeatureDisk(sFilename);
      sTemp := BioFast1.oleobject.Fingerprint2Feature;

      if sTemp = '' then
        begin
          lMinutiaeCount := 0;
          FlagRegFeature:=false;// cancel
        end
        else
        begin
          lMinutiaeCount := BioFast1.oleobject.MinutiaeCount(sTemp);
        end;

        if lMinutiaeCount < 15 then
        begin
          // Binarize at 2%
//          BioFast1.oleobject.BinarizationThresholdPercent := 2;
//          BioFast1.oleobject.BinarizationThresholdPercentEnabled := True;
//          BioFast1.oleobject.LoadFingerprintFromBMP(path);
//          sTemp := BioFast1.oleobject.Fingerprint2Feature;
            sTemp :='';
        end
        else if lMinutiaeCount > 50 then
        begin
          // 'Binarize at 10%';
//          BioFast1.oleobject.BinarizationThresholdPercent := 10;
//          BioFast1.oleobject.BinarizationThresholdPercentEnabled := True;
//          BioFast1.oleobject.LoadFingerprintFromBMP(path);
//          sTemp := BioFast1.oleobject.Fingerprint2Feature;
            sTemp :='';
        end;

      if sTemp = '' then
        begin
          lMinutiaeCount := 0;
         FlagRegFeature:=false;// cancel
        end
       else
        begin
           sFeatures[conterfingreg] := sTemp;
        end;

//      (AddfingForm.Components[i] as TImage).Picture.SaveToFile(path);
//    end;
  sleep(100);
  Form1.Close;
  Refresh;

 // PentacomBiometricFingerprint1.Refresh;
 end; //else Id <>1 6

FMain.SetDateDay;

end;
//***************************************************************************


procedure TAddfingForm.IdEKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
Var
  i,code : Integer;
  Sw : Boolean;
  Path : AnsiString;
begin
{   if key=13 then
   begin
     Val(dbedit2.Text,i,code);
     if ((i<0) or (code<>0)) then
     begin
       ShowMessage('‘„«—Â ‘‰«”«ÌÌ ‰«„⁄ »— «” ');
       ActiveControl := dbedit2;
       IdE.Text := '';
     end;

     Sw := DM.Emp.FindKey([IdE.Text]);
     if Not(Sw) then
     begin
       ShowMessage('‘„«—Â ‘‰«”«ÌÌ œ— ÃœÊ· Ì«›  ‰‘œ');
       ActiveControl := IdE;
     end;
     fingtik();
   end;
  }
end;
//****************************************************************************
procedure TAddfingForm.FormActivate(Sender: TObject);
begin
  FMain.Visible := False;
end;

procedure TAddfingForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  DM.Emp.close;
  Dm.Fingers.close;

  FMain.Visible := True;
end;

//****************************************************************************
procedure TAddfingForm.DBNavigator2Click(Sender: TObject;
  Button: TNavigateBtn);
begin
     Img1.Visible:=false;
     Img2.Visible:=false;
     Img3.Visible:=false;
     Img4.Visible:=false;
end;
//****************************************************************************
procedure TAddfingForm.Edit2KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var SW:boolean;
begin
   if key=66 then
    keyZal:=true;
{   if key=13 then
   begin
     DM.Emp.IndexName:='IX_Employees_1';
//     Sw:=DM.Emp.Locate('name;famil', VarArrayOf([trim(edit1.Text),trim(edit2.Text)]), [loPartialKey]);   //loCaseInsensitive
      if (length(trim(edit1.Text))>=2)and (length(trim(edit2.Text))>=2) then
         Sw:=DM.Emp.Locate('name;famil', VarArrayOf([trim(edit1.Text),trim(edit2.Text)]), [loPartialKey])   //loCaseInsensitive
      else  if (length(trim(edit1.Text))<2)and (length(trim(edit2.Text))>1) then
         Sw:=DM.Emp.Locate('famil', VarArrayOf([trim(edit2.Text)]), [loPartialKey])   //loCaseInsensitive
      else  if (length(trim(edit1.Text))>1)and (length(trim(edit2.Text))<2) then
         Sw:=DM.Emp.Locate('name', VarArrayOf([trim(edit1.Text)]), [loPartialKey]);   //loCaseInsensitive

   //     Sw := DM.Emp.FindKey([IdE.Text]);
      if Not(Sw) then
          ShowMessage('œ— ÃœÊ· Ì«›  ‰‘œ');


   end
   else
    begin
      DM.Emp.FindNearest([Edit2.Text]);
      DBGrid1.Refresh;
      fingtik();
  end;
 }
end;

//****************************************************************************
procedure TAddfingForm.DataSourceEmpDataChange(Sender: TObject;
  Field: TField);
begin
     fingtik();
end;
//****************************************************************************
//****************************************************************************
procedure TAddfingForm.Edit2KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
//    DM.Emp.IndexName:='IX_Employees';
//    DM.Emp.IndexName:='IX_Employees_1';
//    DM.Emp.FindNearest([Edit2.Text]);
//    DBGrid1.Refresh;
//    fingtik();
end;

procedure TAddfingForm.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
IF KEY=CHR(13) THEN
 Edit2.SetFocus;
end;

procedure TAddfingForm.Edit2KeyPress(Sender: TObject; var Key: Char);
begin
IF KEY=CHR(13) THEN
 Edit3.SetFocus;

 if (keyZal=true) and (key='·') then
    key:= chr(0)
   else if (keyZal=true) and (key='«') then
   begin
     keyZal:=false;
     key:='–';
   end
   else
   begin
 case Key of
  '–' :key:='Å';
  'ÿ' :key:='ê';
  'œ':key:='ç';
  'Ï':key:='œ';
  '\':key:='é';
  '∆':key:='Ÿ';
  '¡':key:='ÿ';
  'ƒ':key:='“';
  '“':key:='«';
  '…':key:='∆'
 end;
 end;

end;

procedure TAddfingForm.Edit3KeyPress(Sender: TObject; var Key: Char);
begin
IF KEY=CHR(13) THEN
 BEGIN
 Edit4.SetFocus;
 END;

 if (keyZal=true) and (key='·') then
    key:= chr(0)
   else if (keyZal=true) and (key='«') then
   begin
     keyZal:=false;
     key:='–';
   end
   else
   begin
 case Key of
  '–' :key:='Å';
  'ÿ' :key:='ê';
  'œ':key:='ç';
  'Ï':key:='œ';
  '\':key:='é';
  '∆':key:='Ÿ';
  '¡':key:='ÿ';
  'ƒ':key:='“';
  '“':key:='«';
  '…':key:='∆'
 end;
 end;

end;



procedure TAddfingForm.Button1Click(Sender: TObject);
var Sw:boolean;
begin
 Sw := DM.Emp.FindKey([edit1.Text]);
 if (Sw) then
 begin
   ShowMessage('‘„«—Â ‘‰«”«ÌÌ ÊÃÊœ œ«—œ');
   ActiveControl := edit1;
 end
 else
  begin
   DM.Emp.insert;
   DM.EmpID.AsString:=trim(edit1.text);
   DM.EmpFname.AsString:=trim(edit2.text);
   DM.EmpLName.AsString:=trim(edit3.text);
   DM.Emp.post;
  end;
end;

procedure TAddfingForm.Edit1Enter(Sender: TObject);
begin
loadkeyboardlayout('00000409' ,klf_activate);
end;

procedure TAddfingForm.Edit2Enter(Sender: TObject);
begin
loadkeyboardlayout('00000401' ,klf_activate);
end;

procedure TAddfingForm.Edit4KeyPress(Sender: TObject; var Key: Char);
begin
IF KEY=CHR(13) THEN
 BEGIN
 IF  DM.Emp.State in [dsEdit, dsInsert] THEN
    DM.Emp.POST ;
 Edit1.SetFocus;
 END;

 if (keyZal=true) and (key='·') then
    key:= chr(0)
   else if (keyZal=true) and (key='«') then
   begin
     keyZal:=false;
     key:='–';
   end
   else
   begin
 case Key of
  '–' :key:='Å';
  'ÿ' :key:='ê';
  'œ':key:='ç';
  'Ï':key:='œ';
  '\':key:='é';
  '∆':key:='Ÿ';
  '¡':key:='ÿ';
  'ƒ':key:='“';
  '“':key:='«';
  '…':key:='∆'
 end;
 end;

end;

procedure TAddfingForm.DBGrid1CellClick(Column: TColumn);
begin
     fingtik();
     Img1.Visible:=false;
     Img2.Visible:=false;
     Img3.Visible:=false;
     Img4.Visible:=false;
end;

end.
