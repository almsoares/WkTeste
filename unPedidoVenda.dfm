inherited FormPedidoVenda: TFormPedidoVenda
  Caption = 'FormPedidoVenda'
  ClientHeight = 542
  ClientWidth = 772
  OnClose = FormClose
  OnShow = FormShow
  ExplicitWidth = 788
  ExplicitHeight = 581
  PixelsPerInch = 96
  TextHeight = 13
  inherited panClient: TPanel
    Width = 772
    Height = 501
    ExplicitWidth = 772
    ExplicitHeight = 501
    object gbPedidoProdutos: TGroupBox
      Left = 1
      Top = 105
      Width = 770
      Height = 395
      Align = alClient
      Caption = 'Pedido - Produtos'
      TabOrder = 0
      object panedtprodutopedido: TPanel
        Left = 2
        Top = 342
        Width = 766
        Height = 51
        Align = alBottom
        TabOrder = 0
        object spbProduto: TSpeedButton
          Left = 65
          Top = 20
          Width = 50
          Height = 22
          Caption = 'Produto'
          OnClick = spbProdutoClick
        end
        object edProdutoID: TLabeledEdit
          Left = 3
          Top = 21
          Width = 60
          Height = 21
          EditLabel.Width = 52
          EditLabel.Height = 13
          EditLabel.Caption = 'Produto ID'
          NumbersOnly = True
          TabOrder = 0
          OnExit = edProdutoIDExit
        end
        object edDescricao: TLabeledEdit
          Left = 116
          Top = 21
          Width = 250
          Height = 21
          TabStop = False
          Color = clMoneyGreen
          EditLabel.Width = 46
          EditLabel.Height = 13
          EditLabel.Caption = 'Descri'#231#227'o'
          ReadOnly = True
          TabOrder = 1
        end
        object edQuantidade: TLabeledEdit
          Left = 369
          Top = 21
          Width = 60
          Height = 21
          EditLabel.Width = 56
          EditLabel.Height = 13
          EditLabel.Caption = 'Quantidade'
          TabOrder = 2
        end
        object edValorUnitario: TLabeledEdit
          Left = 430
          Top = 21
          Width = 80
          Height = 21
          EditLabel.Width = 64
          EditLabel.Height = 13
          EditLabel.Caption = 'Valor Unitario'
          TabOrder = 3
        end
        object BtnConfirmaProduto: TButton
          Left = 516
          Top = 18
          Width = 75
          Height = 25
          Caption = 'Confirma'
          TabOrder = 4
          OnClick = BtnConfirmaProdutoClick
        end
      end
      object panGrid: TPanel
        Left = 2
        Top = 15
        Width = 766
        Height = 327
        Align = alClient
        TabOrder = 1
        object DBGridPedidoProduto: TDBGrid
          Left = 1
          Top = 1
          Width = 764
          Height = 325
          Align = alClient
          DataSource = dtsPedidoProduto
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'Tahoma'
          TitleFont.Style = []
          OnKeyDown = DBGridPedidoProdutoKeyDown
        end
      end
    end
    object gbPedidoGeral: TGroupBox
      Left = 1
      Top = 1
      Width = 770
      Height = 104
      Align = alTop
      Caption = 'Pedido - Dados Gerais'
      TabOrder = 1
      object spbCliente: TSpeedButton
        Left = 68
        Top = 29
        Width = 50
        Height = 22
        Caption = 'Cliente'
        OnClick = spbClienteClick
      end
      object spbSelecionaPedido: TSpeedButton
        Left = 441
        Top = 69
        Width = 100
        Height = 22
        Caption = 'Visualizar Pedido'
        OnClick = spbSelecionaPedidoClick
      end
      object lblNumeroPedido: TLabel
        Left = 702
        Top = 12
        Width = 60
        Height = 19
        Caption = '000000'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label1: TLabel
        Left = 565
        Top = 12
        Width = 131
        Height = 19
        Caption = 'N'#250'mero Pedido:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lbldataemissao: TLabel
        Left = 379
        Top = 16
        Width = 64
        Height = 13
        Caption = 'Data Emiss'#227'o'
      end
      object spbExcluirPedido: TSpeedButton
        Left = 545
        Top = 69
        Width = 100
        Height = 22
        Caption = 'Excluir Pedido'
        OnClick = spbExcluirPedidoClick
      end
      object edClienteID: TLabeledEdit
        Left = 6
        Top = 30
        Width = 60
        Height = 21
        EditLabel.Width = 47
        EditLabel.Height = 13
        EditLabel.Caption = 'Cliente ID'
        NumbersOnly = True
        TabOrder = 0
        OnExit = edClienteIDExit
      end
      object edNome: TLabeledEdit
        Left = 121
        Top = 30
        Width = 250
        Height = 21
        TabStop = False
        Color = clMoneyGreen
        EditLabel.Width = 27
        EditLabel.Height = 13
        EditLabel.Caption = 'Nome'
        ReadOnly = True
        TabOrder = 1
      end
      object edDataEmissao: TDateTimePicker
        Left = 378
        Top = 30
        Width = 87
        Height = 21
        Date = 44725.000000000000000000
        Time = 0.505571851848799300
        TabOrder = 2
      end
      object ValorPedido: TLabeledEdit
        Left = 468
        Top = 29
        Width = 80
        Height = 21
        TabStop = False
        Alignment = taRightJustify
        Color = clMoneyGreen
        EditLabel.Width = 59
        EditLabel.Height = 13
        EditLabel.Caption = 'Valor Pedido'
        ReadOnly = True
        TabOrder = 3
      end
      object edNumeroPedido: TLabeledEdit
        Left = 378
        Top = 69
        Width = 61
        Height = 21
        Alignment = taRightJustify
        EditLabel.Width = 57
        EditLabel.Height = 13
        EditLabel.Caption = 'N'#250'm.Pedido'
        NumbersOnly = True
        TabOrder = 4
        OnExit = edProdutoIDExit
      end
      object edCidade: TLabeledEdit
        Left = 68
        Top = 69
        Width = 264
        Height = 21
        TabStop = False
        Color = clMoneyGreen
        EditLabel.Width = 33
        EditLabel.Height = 13
        EditLabel.Caption = 'Cidade'
        ReadOnly = True
        TabOrder = 5
      end
      object edUF: TLabeledEdit
        Left = 336
        Top = 69
        Width = 33
        Height = 21
        TabStop = False
        Color = clMoneyGreen
        EditLabel.Width = 13
        EditLabel.Height = 13
        EditLabel.Caption = 'UF'
        ReadOnly = True
        TabOrder = 6
      end
    end
  end
  inherited panBottlon: TPanel
    Top = 501
    Width = 772
    ExplicitTop = 501
    ExplicitWidth = 772
    object spbGravarPedido: TSpeedButton
      Left = 645
      Top = 7
      Width = 120
      Height = 27
      Caption = 'GRAVAR PEDIDO'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = spbGravarPedidoClick
    end
    object lblValorPedido: TLabel
      Left = 514
      Top = 11
      Width = 125
      Height = 19
      Alignment = taRightJustify
      Caption = '999.999.999,99'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object mtbPedido: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 584
    Top = 18
  end
  object tbPedidoProduto: TFDMemTable
    AfterPost = tbPedidoProdutoAfterPost
    AfterDelete = tbPedidoProdutoAfterDelete
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 576
    Top = 178
  end
  object dtsPedidoProduto: TDataSource
    DataSet = tbPedidoProduto
    Left = 252
    Top = 243
  end
end
