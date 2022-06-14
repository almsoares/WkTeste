inherited FormModeloGrid: TFormModeloGrid
  Caption = 'FormModeloGrid'
  ClientHeight = 420
  ClientWidth = 667
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  ExplicitWidth = 683
  ExplicitHeight = 459
  PixelsPerInch = 96
  TextHeight = 13
  inherited panClient: TPanel
    Width = 667
    Height = 379
    object DBGridGeral: TDBGrid
      Left = 1
      Top = 1
      Width = 665
      Height = 377
      Align = alClient
      DataSource = dtsPadrao
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
    end
  end
  inherited panBottlon: TPanel
    Top = 379
    Width = 667
  end
  object dtsPadrao: TDataSource
    Left = 53
    Top = 96
  end
end
