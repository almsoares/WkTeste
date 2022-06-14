////////////////////////////////////////////////////////////////////////////////
// Classe de dados : Produtos Pedido WK Tecnology
// Templarium      : 2.0.1.00
// Data de Geração : 13/06/2022 - 08:52:44
// Analista        : Adriano L. Mendonça Soares
////////////////////////////////////////////////////////////////////////////////

unit unPedidoProdutoCls;

interface

uses
  System.SysUtils, System.Classes, db, System.Variants,
  System.DateUtils, unModelCls, unBiblioGeral;

Type
  TPedidoProdutoCls = class(TModelClass)
  private
    // Atributos internos
    fpedidoprodutoid: Integer; //AutoInc;
    fnumeropedido: Integer;
    fprodutoid: Integer;
    fdescricao: String;
    fquantidade: Float;
    fvalorunitario: Float;
    fvalortotal: Float;
  strict private
  protected
    // Função de configuração
    Function DoConfigClass: Boolean; override;
    // Procedimentos e Funções de alteração dos atributos
    Procedure Setpedidoprodutoid(const Value: Integer);
    Procedure Setnumeropedido(const Value: Integer);
    Procedure Setprodutoid(const Value: Integer);
    Procedure Setdescricao(const Value: String);
    Procedure Setquantidade(const Value: Float);
    Procedure Setvalorunitario(const Value: Float);
    Procedure Setvalortotal(const Value: Float);
  public
    // Construtores da classe
    constructor Create; overload; override;
    constructor Create(spedidoprodutoid: Integer; snumeropedido: Integer; sprodutoid: Integer; sdescricao: String; squantidade: Float;
      svalorunitario: Float; svalortotal: Float); overload;
    // Atributos visíveis
    property pedidoprodutoid: Integer read fpedidoprodutoid write Setpedidoprodutoid;
    property numeropedido: Integer read fnumeropedido write Setnumeropedido;
    property produtoid: Integer read fprodutoid write Setprodutoid;
    property descricao: String read fdescricao write Setdescricao;
    property quantidade: Float read fquantidade write Setquantidade;
    property valorunitario: Float read fvalorunitario write Setvalorunitario;
    property valortotal: Float read fvalortotal write Setvalortotal;
    // Procedimentos e Funções Diversos da classe
    Function GetValue(sAtributoID: integer): variant; override;
    Function GetID: integer; override;
    Function SetConfigClass: Boolean; override;
    Function GetConfigClass: TConfigClass; override;

  published
  end;

  // Variáveis Globais
  var
    ConfigClass: TConfigClass;

implementation

  // Configuração da Classe
  Function TPedidoProdutoCls.DoConfigClass: Boolean;
  begin
    result:= False;
    if ConfigClass<>Nil then
    begin
      result:= True;
      exit;
    end;
    ConfigClass := TConfigClass.Create;
    ConfigClass.ClassName := 'TPedidoProdutoCls';
    ConfigClass.ClassDesc := 'Produtos Pedido WK Tecnology';
    ConfigClass.TableName := 'tbpedidoproduto';
    ConfigClass.ViewName := 'vwpedidoproduto';
    ConfigClass.SelectTable:= False;
    ConfigClass.ConfGrid := TStringList.Create;
    with ConfigClass.ConfGrid do
    begin
      AddObject('Pedido Produto ID', TColGrid.Create('pedidoprodutoid', 'Pedido Produto ID', ftAutoInc, 7, 0, True, False, False, True, False, 0)); // 0 PK
      AddObject('Numero Pedido', TColGrid.Create('numeropedido', 'Numero Pedido', ftInteger, 7, 0, False, False, False, True, True, 0)); // 1
      AddObject('Produto ID', TColGrid.Create('produtoid', 'Produto ID', ftInteger, 7, 0, False, False, True, True, True, 1)); // 2 NN
      AddObject('Descrição', TColGrid.Create('descricao', 'Descrição', ftString, 60, 0, False, False, False, True, False, 2)); // 3
      AddObject('Quantidade', TColGrid.Create('quantidade', 'Quantidade', ftFloat, 15, 2, False, False, True, True, True, 3)); // 4 NN
      AddObject('Valor Unitario', TColGrid.Create('valorunitario', 'Valor Unitario', ftFloat, 15, 2, False, False, True, True, True, 4)); // 5 NN
      AddObject('Valor Total', TColGrid.Create('valortotal', 'Valor Total', ftFloat, 15, 2, False, False, False, True, True, 5)); // 6
    end;
    ConfigClass.ListaFiltro:= TStringList.Create;
    ConfigClass.ListaFiltro.Duplicates := dupError;
    ConfigClass.ListaFiltro.Sorted := True;
    ConfigClass.ListaFiltro.Assign(ConfigClass.ConfGrid);
    ConfigClass.IDColunaExc := 1;
    ConfigClass.ClassSQLSelect := DoSelectClass(ConfigClass);
    result:= True;
  end;

  // Construtores
  constructor TPedidoProdutoCls.Create;
  begin
    inherited Create;
    pedidoprodutoid:= 0;
    numeropedido:= 0;
    produtoid:= 0;
    descricao:= '';
    quantidade:= 0.0;
    valorunitario:= 0.0;
    valortotal:= 0.0;
  end;

  constructor TPedidoProdutoCls.Create(spedidoprodutoid: Integer; snumeropedido: Integer; sprodutoid: Integer; sdescricao: String;
      squantidade: Float; svalorunitario: Float; svalortotal: Float);
  begin
    inherited Create;
    pedidoprodutoid:= spedidoprodutoid;
    numeropedido:= snumeropedido;
    produtoid:= sprodutoid;
    descricao:= sdescricao;
    quantidade:= squantidade;
    valorunitario:= svalorunitario;
    valortotal:= svalortotal;
  end;

  // Procedimentos de atualização de atributos

  Procedure TPedidoProdutoCls.Setpedidoprodutoid(const Value: Integer);
  begin
    if (Value <> fpedidoprodutoid) and (Status <> osDeleted) then
    begin
      fpedidoprodutoid := Value;
      UpdateStatus;
    end;
  end;

  Procedure TPedidoProdutoCls.Setnumeropedido(const Value: Integer);
  begin
    if (Value <> fnumeropedido) and (Status <> osDeleted) then
    begin
      fnumeropedido := Value;
      UpdateStatus;
    end;
  end;

  Procedure TPedidoProdutoCls.Setprodutoid(const Value: Integer);
  begin
    if (Value <> fprodutoid) and (Status <> osDeleted) then
    begin
      fprodutoid := Value;
      UpdateStatus;
    end;
  end;

  Procedure TPedidoProdutoCls.Setdescricao(const Value: String);
  begin
    if (Value <> fdescricao) and (Status <> osDeleted) then
    begin
      fdescricao := Value;
      UpdateStatus;
    end;
  end;

  Procedure TPedidoProdutoCls.Setquantidade(const Value: Float);
  begin
    if (Value <> fquantidade) and (Status <> osDeleted) then
    begin
      fquantidade := Value;
      UpdateStatus;
    end;
  end;

  Procedure TPedidoProdutoCls.Setvalorunitario(const Value: Float);
  begin
    if (Value <> fvalorunitario) and (Status <> osDeleted) then
    begin
      fvalorunitario := Value;
      UpdateStatus;
    end;
  end;

  Procedure TPedidoProdutoCls.Setvalortotal(const Value: Float);
  begin
    if (Value <> fvalortotal) and (Status <> osDeleted) then
    begin
      fvalortotal := Value;
      UpdateStatus;
    end;
  end;

  // Funções de retorno dos valores dos atributos
  Function TPedidoProdutoCls.GetValue(sAtributoID: integer): variant;
  begin
    case sAtributoID of
        0: Result := pedidoprodutoid;
        1: Result := numeropedido;
        2: Result := produtoid;
        3: Result := descricao;
        4: Result := quantidade;
        5: Result := valorunitario;
        6: Result := valortotal;
        7: Result := integer(Status = osDeleted);
    end;
  end;

  // Funções Complementares - Retorno ID da Classe
  Function TPedidoProdutoCls.GetID: integer;
  begin
    Result := pedidoprodutoid;
  end;

  // Funções Complementares - Configurar Classe de dados
  Function TPedidoProdutoCls.SetConfigClass: Boolean;
  begin
    Result := DoConfigClass;
  end;

  // Funções Complementares - Retornar Configuração de Classe de dados
  Function TPedidoProdutoCls.GetConfigClass: TConfigClass;
  begin
    if ConfigClass=Nil then
    begin
      if DoConfigClass then
      begin
        Result := ConfigClass;
      end else Result := Nil;
    end else Result := ConfigClass;
  end;

end.
