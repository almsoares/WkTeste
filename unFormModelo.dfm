object FormModelo: TFormModelo
  Left = 0
  Top = 0
  Caption = 'FormModelo'
  ClientHeight = 299
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object panClient: TPanel
    Left = 0
    Top = 0
    Width = 635
    Height = 258
    Align = alClient
    TabOrder = 0
  end
  object panBottlon: TPanel
    Left = 0
    Top = 258
    Width = 635
    Height = 41
    Align = alBottom
    TabOrder = 1
    object lblEscape: TLabel
      Left = 8
      Top = 14
      Width = 142
      Height = 13
      Caption = '<Escape> - Fecha Formul'#225'rio'
    end
  end
end
