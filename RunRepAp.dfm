object Form1: TForm1
  Left = 480
  Top = 126
  Width = 405
  Height = 166
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 168
    Top = 72
    Width = 75
    Height = 25
    Caption = 'ÎÑæÌ'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Edit1: TEdit
    Left = 16
    Top = 48
    Width = 121
    Height = 21
    TabOrder = 1
    Text = 'Edit1'
  end
  object TabelLog: TTable
    TableName = 'Logrep.DB'
    Left = 120
    Top = 8
  end
  object DataSource1: TDataSource
    Left = 160
    Top = 8
  end
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Left = 320
    Top = 40
  end
end
