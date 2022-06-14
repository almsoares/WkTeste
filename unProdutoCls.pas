////////////////////////////////////////////////////////////////////////////////
// Classe de dados : Produtod WK Tecnology
// Templarium      : 2.0.1.00
// Data de Gera��o : 12/06/2022 - 19:39:40
// Analista        : Adriano L. Mendon�a Soares
////////////////////////////////////////////////////////////////////////////////
unit unProdutoCls;

interface

uses
  System.SysUtils, System.Classes, db, System.Variants,
  System.DateUtils, unModelCls, unBiblioGeral;

type

  TProdutoCls = class(TModelClass)
  private
    // Atributos internos
    fprodutoid: Integer;
    fdescricao: String;
    fprcvenda: Real;
  strict private
  protected
    // Fun��o de configura��o
    Function DoConfigClass: Boolean; override;
    // Procedimentos e Fun��es de altera��o dos atributos
    Procedure Setprodutoid(const Value: Integer);
    Procedure Setdescricao(const Value: String);
    Procedure Setprcvenda(const Value: Real);
  public
  // Construtores da classe
    constructor Create; overload; override;
    constructor Create(sprodutoid: Integer; sdescricao: String; sprcvenda: Real); overload;
    // Atributos vis�veis
    property produtoid: Integer read fprodutoid write Setprodutoid;
    property descricao: String read fdescricao write Setdescricao;
    property prcvenda: Real read fprcvenda write Setprcvenda;
    // Procedimentos e Fun��es Diversos da classe
    Function GetID: integer; override;
    Function SetConfigClass: Boolean; override;
    Function GetConfigClass: TConfigClass; override;
  end;

  // Vari�veis Globais
  var
    ConfigClass: TConfigClass;

implementation

  // Configura��o da Classe
  Function TProdutoCls.DoConfigClass: Boolean;
  begin
    result:= False;
    if ConfigClass<>Nil then
    begin
      result:= True;
      exit;
    end;
    ConfigClass := TConfigClass.Create;
    ConfigClass.ClassName := 'TProdutoCls';
    ConfigClass.ClassDesc := 'Produtos WK Tecnology';
    ConfigClass.TableName := 'tbproduto';
    ConfigClass.ViewName := 'tbproduto';
    ConfigClass.ConfGrid := TStringList.Create;
    with ConfigClass.ConfGrid do
    begin
      AddObject('Produto ID', TColGrid.Create('produtoid', 'Produto ID', ftInteger, 7, 0, True, False, False, True, True, 1)); // 0 PK
      AddObject('Descri��o', TColGrid.Create('descricao', 'Descri��o', ftString, 60, 0, False, False, True, True, True, 2)); // 1 NN
      AddObject('Valor', TColGrid.Create('prcvenda', 'Valor', ftFloat, 15, 2, False, False, False, True, True, 3)); // 2
    end;
    ConfigClass.ListaFiltro:= TStringList.Create;
    ConfigClass.ListaFiltro.Duplicates := dupError;
    ConfigClass.ListaFiltro.Sorted := True;
    ConfigClass.IDColunaExc := 1;
    ConfigClass.ClassSQLSelect := DoSelectClass(ConfigClass);
    result:= True;
  end;

  // Construtores

  constructor TProdutoCls.Create;
  begin
    inherited Create;
     produtoid:= 0;
     descricao:= '';
     prcvenda:= 0.0;
  end;

  constructor TProdutoCls.Create(sprodutoid: Integer; sdescricao: String; sprcvenda: Real);
  begin
    inherited Create;
     produtoid:= sprodutoid;
     descricao:= sdescricao;
     prcvenda:= sprcvenda;
  end;

  // Procedimentos de atualiza��o de atributos

  Procedure TProdutoCls.Setprodutoid(const Value: Integer);
  begin
    if (Value <> fprodutoid) and (Status <> osDeleted) then
    begin
      fprodutoid := Value;
      UpdateStatus;
    end;
  end;

  Procedure TProdutoCls.Setdescricao(const Value: String);
  begin
    if (Value <> fdescricao) and (Status <> osDeleted) then
    begin
      fdescricao := Value;
      UpdateStatus;
    end;
  end;

  Procedure TProdutoCls.Setprcvenda(const Value: Real);
  begin
    if (Value <> fprcvenda) and (Status <> osDeleted) then
    begin
      fprcvenda := Value;
      UpdateStatus;
    end;
  end;

// Fun��es Complementares - Retorno ID da Classe
  Function TProdutoCls.GetID: integer;
  begin
    Result := produtoid;
  end;

  // Fun��es Complementares - Configurar Classe de dados
  Function TProdutoCls.SetConfigClass: Boolean;
  begin
    Result := DoConfigClass;
  end;

  // Fun��es Complementares - Retornar Configura��o de Classe de dados
  Function TProdutoCls.GetConfigClass: TConfigClass;
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
