////////////////////////////////////////////////////////////////////////////////
// Classe de dados : Pedido  WK Tecnology
// Templarium      : 2.0.1.00
// Data de Geração : 13/06/2022 - 08:52:39
// Analista        : Adriano L. Mendonça Soares
////////////////////////////////////////////////////////////////////////////////
unit unPedidoCls;

interface

uses
  System.SysUtils, System.Classes, db, System.Variants,
  System.DateUtils, unModelCls, unBiblioGeral;

Type
  TPedidoCls = class(TModelClass)
  private
    // Atributos internos
    fnumeropedido: Integer;
    fclienteid: Integer;
    fdataemissao: DateTime;
    fvalor: Float;
    fnome: String;
    fcidade: String;
    fuf: String;
  strict private
  protected
    // Função de configuração
    Function DoConfigClass: Boolean; override;
    // Procedimentos e Funções de alteração dos atributos
    Procedure Setnumeropedido(const Value: Integer);
    Procedure Setclienteid(const Value: Integer);
    Procedure Setdataemissao(const Value: DateTime);
    Procedure Setvalor(const Value: Float);
    Procedure Setnome(const Value: String);
    Procedure Setcidade(const Value: String);
    Procedure Setuf(const Value: String);
  public
    // Construtores da classe
    constructor Create; overload; override;
    constructor Create(snumeropedido: Integer; sclienteid: Integer; sdataemissao: DateTime; svalor: Float; snome: String;
      scidade: String; suf: String); overload;
    // Atributos visíveis
    property numeropedido: Integer read fnumeropedido write Setnumeropedido;
    property clienteid: Integer read fclienteid write Setclienteid;
    property dataemissao: DateTime read fdataemissao write Setdataemissao;
    property valor: Float read fvalor write Setvalor;
    property nome: String read fnome write Setnome;
    property cidade: String read fcidade write Setcidade;
    property uf: String read fuf write Setuf;
    // Procedimentos e Funções Diversos da classe
    Function GetValue(sAtributoID: integer): variant; override;
    Function GetID: integer; override;
    Function SetConfigClass: Boolean; override;
    Function GetConfigClass: TConfigClass; override;
  end;

  // Variáveis Globais
  var
    ConfigClass: TConfigClass;

implementation

  // Configuração da Classe
  Function TPedidoCls.DoConfigClass: Boolean;
  begin
    result:= False;
    if ConfigClass<>Nil then
    begin
      result:= True;
      exit;
    end;
    ConfigClass := TConfigClass.Create;
    ConfigClass.ClassName := 'TPedidoCls';
    ConfigClass.ClassDesc := 'Pedido  WK Tecnology';
    ConfigClass.TableName := 'tbpedido';
    ConfigClass.ViewName := 'vwpedido';
    ConfigClass.SelectTable:= False;
    ConfigClass.ConfGrid := TStringList.Create;
    with ConfigClass.ConfGrid do
    begin
      AddObject('Numero Pedido', TColGrid.Create('numeropedido', 'Numero Pedido', ftInteger, 7, 0, True, False, False, True, True, 1)); // 0 PK
      AddObject('Cliente ID', TColGrid.Create('clienteid', 'Cliente ID', ftInteger, 7, 0, False, False, True, True, True, 2)); // 1 NN
      AddObject('Data Emissão', TColGrid.Create('dataemissao', 'Data Emissão', ftDate, 12, 0, False, False, True, True, True, 3)); // 2 NN
      AddObject('Valor', TColGrid.Create('valor', 'Valor', ftFloat, 15, 2, False, False, True, True, True, 4)); // 3 NN
      AddObject('Nome', TColGrid.Create('nome', 'Nome', ftString, 60, 0, False, False, False, True, False, 0)); // 4
      AddObject('Cidade', TColGrid.Create('cidade', 'Cidade', ftString, 60, 0, False, False, False, True, False, 0)); // 5
      AddObject('UF', TColGrid.Create('uf', 'UF', ftString, 2, 0, False, False, False, True, False, 0)); // 6
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

  constructor TPedidoCls.Create;
  begin
    inherited Create;
    numeropedido:= 0;
    clienteid:= 0;
    dataemissao:= Date;
    valor:= 0.0;
    nome:= '';
    cidade:= '';
    uf:= '';
  end;

  constructor TPedidoCls.Create(snumeropedido: Integer; sclienteid: Integer; sdataemissao: DateTime; svalor: Float; snome: String;
      scidade: String; suf: String);
  begin
    inherited Create;
    numeropedido:= snumeropedido;
    clienteid:= sclienteid;
    dataemissao:= sdataemissao;
    valor:= svalor;
    nome:= snome;
    cidade:= scidade;
    uf:= suf;
  end;

  // Procedimentos de atualização de atributos

  Procedure TPedidoCls.Setnumeropedido(const Value: Integer);
  begin
    if (Value <> fnumeropedido) and (Status <> osDeleted) then
    begin
      fnumeropedido := Value;
      UpdateStatus;
    end;
  end;

  Procedure TPedidoCls.Setclienteid(const Value: Integer);
  begin
    if (Value <> fclienteid) and (Status <> osDeleted) then
    begin
      fclienteid := Value;
      UpdateStatus;
    end;
  end;

  Procedure TPedidoCls.Setdataemissao(const Value: DateTime);
  begin
    if (Value <> fdataemissao) and (Status <> osDeleted) then
    begin
      fdataemissao := Value;
      UpdateStatus;
    end;
  end;

  Procedure TPedidoCls.Setvalor(const Value: Float);
  begin
    if (Value <> fvalor) and (Status <> osDeleted) then
    begin
      fvalor := Value;
      UpdateStatus;
    end;
  end;

  Procedure TPedidoCls.Setnome(const Value: String);
  begin
    if (Value <> fnome) and (Status <> osDeleted) then
    begin
      fnome := Value;
      UpdateStatus;
    end;
  end;

  Procedure TPedidoCls.Setcidade(const Value: String);
  begin
    if (Value <> fcidade) and (Status <> osDeleted) then
    begin
      fcidade := Value;
      UpdateStatus;
    end;
  end;

  Procedure TPedidoCls.Setuf(const Value: String);
  begin
    if (Value <> fuf) and (Status <> osDeleted) then
    begin
      fuf := Value;
      UpdateStatus;
    end;
  end;

  // Funções de retorno dos valores dos atributos
  Function TPedidoCls.GetValue(sAtributoID: integer): variant;
  begin
    case sAtributoID of
        0: Result := numeropedido;
        1: Result := clienteid;
        2: Result := dataemissao;
        3: Result := valor;
        4: Result := nome;
        5: Result := cidade;
        6: Result := uf;
        7: Result := integer(Status = osDeleted);
    end;
  end;

  // Funções Complementares - Retorno ID da Classe
  Function TPedidoCls.GetID: integer;
  begin
    Result := numeropedido;
  end;

  // Funções Complementares - Configurar Classe de dados
  Function TPedidoCls.SetConfigClass: Boolean;
  begin
    Result := DoConfigClass;
  end;

  // Funções Complementares - Retornar Configuração de Classe de dados
  Function TPedidoCls.GetConfigClass: TConfigClass;
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
