object Searchfinger: TSearchfinger
  Left = 98
  Top = 75
  BiDiMode = bdRightToLeft
  BorderStyle = bsToolWindow
  ClientHeight = 559
  ClientWidth = 780
  Color = clGray
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  ParentBiDiMode = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 777
    Height = 539
    Align = alLeft
    BevelInner = bvSpace
    BevelOuter = bvLowered
    TabOrder = 2
    object Image1: TImage
      Tag = 1
      Left = 305
      Top = 25
      Width = 28
      Height = 40
      Stretch = True
    end
    object Image2: TImage
      Tag = 2
      Left = 275
      Top = 25
      Width = 28
      Height = 40
      Stretch = True
    end
    object Image3: TImage
      Tag = 3
      Left = 245
      Top = 25
      Width = 28
      Height = 40
      Stretch = True
    end
    object Image4: TImage
      Tag = 4
      Left = 214
      Top = 25
      Width = 28
      Height = 40
      Stretch = True
    end
    object Image5: TImage
      Tag = 5
      Left = 183
      Top = 25
      Width = 28
      Height = 40
      Stretch = True
    end
    object Image6: TImage
      Tag = 6
      Left = 153
      Top = 25
      Width = 28
      Height = 40
      Stretch = True
    end
    object Image7: TImage
      Tag = 7
      Left = 122
      Top = 25
      Width = 28
      Height = 40
      Stretch = True
    end
    object Image8: TImage
      Tag = 8
      Left = 92
      Top = 25
      Width = 28
      Height = 40
      Stretch = True
    end
    object Image9: TImage
      Tag = 9
      Left = 62
      Top = 25
      Width = 28
      Height = 40
      Stretch = True
    end
    object Image10: TImage
      Tag = 10
      Left = 32
      Top = 25
      Width = 28
      Height = 40
      Stretch = True
    end
    object Label8: TLabel
      Left = 315
      Top = 8
      Width = 8
      Height = 13
      Caption = '1'
      Color = clRed
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clLime
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
    end
    object Label9: TLabel
      Left = 285
      Top = 8
      Width = 8
      Height = 13
      Caption = '2'
      Color = clRed
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clLime
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
    end
    object Label10: TLabel
      Left = 254
      Top = 8
      Width = 8
      Height = 13
      Caption = '3'
      Color = clRed
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clLime
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
    end
    object Label11: TLabel
      Left = 224
      Top = 8
      Width = 8
      Height = 13
      Caption = '4'
      Color = clRed
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clLime
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
    end
    object Label12: TLabel
      Left = 193
      Top = 8
      Width = 8
      Height = 13
      Caption = '5'
      Color = clRed
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clLime
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
    end
    object Label13: TLabel
      Left = 163
      Top = 8
      Width = 8
      Height = 13
      Caption = '6'
      Color = clRed
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clLime
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
    end
    object Label14: TLabel
      Left = 132
      Top = 8
      Width = 8
      Height = 13
      Caption = '7'
      Color = clRed
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clLime
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
    end
    object Label15: TLabel
      Left = 102
      Top = 8
      Width = 8
      Height = 13
      Caption = '8'
      Color = clRed
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clLime
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
    end
    object Label16: TLabel
      Left = 71
      Top = 8
      Width = 8
      Height = 13
      Caption = '9'
      Color = clRed
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clLime
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
    end
    object Label17: TLabel
      Left = 41
      Top = 8
      Width = 15
      Height = 13
      Caption = '10'
      Color = clRed
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clLime
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
    end
    object PentacomBiometricFingerprint1: TPentacomBiometricFingerprint
      Left = 3
      Top = 68
      Width = 360
      Height = 364
      TabOrder = 0
      OnStatus = PentacomBiometricFingerprint1Status
      ControlData = {
        000452E30B918FCE119DE300AA004BB8516C740000000000000100000000009A
        9999999999B93F0001000000000100352500009F25000000000000}
    end
    object DBGrid1: TDBGrid
      Left = 16
      Top = 452
      Width = 729
      Height = 77
      DataSource = DataSourceEmp
      TabOrder = 1
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      Columns = <
        item
          Color = clMenu
          Expanded = False
          FieldName = 'name'
          Font.Charset = ARABIC_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Title.Caption = '‰«„'
          Title.Color = clPurple
          Title.Font.Charset = ARABIC_CHARSET
          Title.Font.Color = clWhite
          Title.Font.Height = -15
          Title.Font.Name = 'Arial'
          Title.Font.Style = [fsBold]
          Width = 102
          Visible = True
        end
        item
          Color = clMenu
          Expanded = False
          FieldName = 'famil'
          Font.Charset = ARABIC_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Title.Caption = '‰«„ Œ«‰Ê«œêÌ'
          Title.Color = clPurple
          Title.Font.Charset = ARABIC_CHARSET
          Title.Font.Color = clWhite
          Title.Font.Height = -15
          Title.Font.Name = 'Arial'
          Title.Font.Style = [fsBold]
          Width = 147
          Visible = True
        end
        item
          Color = clMenu
          Expanded = False
          FieldName = 'father'
          Font.Charset = ARABIC_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Title.Caption = '‰«„ ˜œ—'
          Title.Color = clPurple
          Title.Font.Charset = ARABIC_CHARSET
          Title.Font.Color = clWhite
          Title.Font.Height = -15
          Title.Font.Name = 'Arial'
          Title.Font.Style = [fsBold]
          Visible = True
        end
        item
          Color = clMenu
          Expanded = False
          FieldName = 'sh_shen'
          Font.Charset = ARABIC_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Title.Caption = '‘„«—Â ‘‰«”‰«„Â'
          Title.Color = clPurple
          Title.Font.Charset = ARABIC_CHARSET
          Title.Font.Color = clWhite
          Title.Font.Height = -15
          Title.Font.Name = 'Arial'
          Title.Font.Style = [fsBold]
          Visible = True
        end
        item
          Color = clMenu
          Expanded = False
          FieldName = 'shomare_bazn'
          Font.Charset = ARABIC_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Title.Caption = 'òœ »«“‰‘” êÌ'
          Title.Color = clPurple
          Title.Font.Charset = ARABIC_CHARSET
          Title.Font.Color = clWhite
          Title.Font.Height = -15
          Title.Font.Name = 'Arial'
          Title.Font.Style = [fsBold]
          Visible = True
        end>
    end
    object BitBtn1: TBitBtn
      Left = 406
      Top = 18
      Width = 137
      Height = 25
      Caption = ' ”  ’Õ  «‰Ã«„ ⁄„·Ì« '
      TabOrder = 2
      OnClick = BitBtn1Click
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 539
    Width = 780
    Height = 20
    Panels = <
      item
        Width = 50
      end>
    SimplePanel = False
  end
  object Panel5: TPanel
    Left = 714
    Top = 16
    Width = 756
    Height = 430
    Caption = 'Panel5'
    TabOrder = 1
    Visible = False
    object BioFast1: TBioFast
      Left = 3
      Top = 24
      Width = 752
      Height = 402
      TabOrder = 0
      ControlData = {
        93B20000AC000000030008000BF25747200000005F0065007800740065006E00
        74007800B94D0000030008000AF25747200000005F0065007800740065006E00
        740079008C29000004001000FC1817BB30000000660069006E00670065007200
        7000720069006E007400770069006400740068000018AB4504001100A891DFAF
        90FFFFFF660069006E006700650072007000720069006E007400680065006900
        6700680074000058B6450000}
    end
  end
  object DataSourceEmp: TDataSource
    DataSet = DM.Emp
    OnDataChange = DataSourceEmpDataChange
    Left = 376
    Top = 8
  end
end
