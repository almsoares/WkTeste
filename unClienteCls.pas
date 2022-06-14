////////////////////////////////////////////////////////////////////////////////
// Classe de dados : Clientes WK Tecnology
// Templarium      : 2.0.1.00
// Data de Gera��o : 11/06/2022 - 14:45:55
// Analista        : Adriano L. Mendon�a Soares
////////////////////////////////////////////////////////////////////////////////
unit unClienteCls;

interface

uses
  System.SysUtils, System.Classes, db, System.Variants,
  System.DateUtils, unModelCls, unBiblioGeral;

type
  TClienteCls = class(TModelClass)
  private
    // Atributos internos
    fclienteid: Integer;
    fnome: String;
    fcidade: String;
    fuf: String;
  strict private
  protected
    // Fun��o de configura��o
    Function DoConfigClass: Boolean; override;
    // Procedimentos e Fun��es de altera��o dos atributos
    Procedure Setclienteid(const Value: Integer);
    Procedure Setnome(const Value: String);
    Procedure Setcidade(const Value: String);
    Procedure Setuf(const Value: String);
  public
    // Construtores da classe
    constructor Create; overload; override;
    constructor Create(sclienteid: Integer; snome: String; scidade: String; suf: String); overload;
    // Atributos vis�veis
    property clienteid: Integer read fclienteid write Setclienteid;
    property nome: String read fnome write Setnome;
    property cidade: String read fcidade write Setcidade;
    property uf: String read fuf write Setuf;
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
  Function TClienteCls.DoConfigClass: Boolean;
  begin
    result:= False;
    if ConfigClass<>Nil then
    begin
      result:= True;
      exit;
    end;
    ConfigClass := TConfigClass.Create;
    ConfigClass.ClassName := 'TClienteCls';
    ConfigClass.ClassDesc := 'Clientes WK Tecnology';
    ConfigClass.TableName := 'tbcliente';
    ConfigClass.ViewName := 'tbcliente';
    ConfigClass.ConfGrid := TStringList.Create;
    with ConfigClass.ConfGrid do
    begin
      AddObject('Cliente ID', TColGrid.Create('clienteid', 'Cliente ID', ftInteger, 7, 0, True, False, False, True, True, 1)); // 0 PK
      AddObject('Nome', TColGrid.Create('nome', 'Nome', ftString, 60, 0, False, False, True, True, True, 2)); // 1 NN
      AddObject('Cidade', TColGrid.Create('cidade', 'Cidade', ftString, 60, 0, False, False, True, True, True, 3)); // 2 NN
      AddObject('UF', TColGrid.Create('uf', 'UF', ftString, 2, 0, False, False, True, True, True, 4)); // 3 NN
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

  constructor TClienteCls.Create;
  begin
    inherited Create;
     clienteid:= 0;
     nome:= '';
     cidade:= '';
     uf:= '';
  end;

  constructor TClienteCls.Create(sclienteid: Integer; snome: String; scidade: String; suf: String);
  begin
    inherited Create;
     clienteid:= sclienteid;
     nome:= snome;
     cidade:= scidade;
     uf:= suf;
  end;

  // Procedimentos de atualiza��o de atributos

  Procedure TClienteCls.Setclienteid(const Value: Integer);
  begin
    if (Value <> fclienteid) and (Status <> osDeleted) then
    begin
      fclienteid := Value;
      UpdateStatus;
    end;
  end;

  Procedure TClienteCls.Setnome(const Value: String);
  begin
    if (Value <> fnome) and (Status <> osDeleted) then
    begin
      fnome := Value;
      UpdateStatus;
    end;
  end;

  Procedure TClienteCls.Setcidade(const Value: String);
  begin
    if (Value <> fcidade) and (Status <> osDeleted) then
    begin
      fcidade := Value;
      UpdateStatus;
    end;
  end;

  Procedure TClienteCls.Setuf(const Value: String);
  begin
    if (Value <> fuf) and (Status <> osDeleted) then
    begin
      fuf := Value;
      UpdateStatus;
    end;
  end;

  // Fun��es Complementares - Retorno ID da Classe
  Function TClienteCls.GetID: integer;
  begin
    Result := clienteid;
  end;

  // Fun��es Complementares - Configurar Classe de dados
  Function TClienteCls.SetConfigClass: Boolean;
  begin
    Result := DoConfigClass;
  end;

  // Fun��es Complementares - Retornar Configura��o de Classe de dados
  Function TClienteCls.GetConfigClass: TConfigClass;
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
