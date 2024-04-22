program P_FP_Pers;

uses
  Forms,
  data in 'DATA.PAS' {DM: TDataModule},
  UForm1 in 'UForm1.pas' {Form1},
  UMain in 'UMain.pas' {FMain},
  Addfing in 'Addfing.pas' {AddfingForm},
  servis in 'servis.pas' {Formservis},
  Threadsr in 'Threadsr.pas',
  datetof in 'DATETOF.PAS';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TFMain, FMain);
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TFormservis, Formservis);
  Application.Run;
end.
