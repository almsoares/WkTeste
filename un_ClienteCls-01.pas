////////////////////////////////////////////////////////////////////////////////
// Classe de dados : Clientes WK Tecnology
// Templarium      : 2.0.1.00 - LCPR
// Data de Geração : 11/06/2022 - 14:45:55
// Analista        : Adriano L. Mendonça Soares
////////////////////////////////////////////////////////////////////////////////

unit un_ClienteCls;

{$mode objfpc}{$H+}

interface

uses
  LCLIntf, Classes, SysUtils, LConvEncoding, DB, LazUTF8, Variants,
  DateUtils, un_ModelCls, dm_database, un_DBSintax, un_BiblioGeral;

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
    // Função de configuração
    Function DoConfigClass: Boolean; override;
    // Procedimentos e Funções de alteração dos atributos
    Procedure Setclienteid(const Value: Integer);
    Procedure Setnome(const Value: String);
    Procedure Setcidade(const Value: String);
    Procedure Setuf(const Value: String);
  public
    // Construtores da classe
    constructor Create; overload; override;
    constructor Create(sclienteid: Integer; snome: String; scidade: String; suf: String); overload;
    // Atributos visíveis
    property clienteid: Integer read fclienteid write Setclienteid;
    property nome: String read fnome write Setnome;
    property cidade: String read fcidade write Setcidade;
    property uf: String read fuf write Setuf;
    // Procedimentos e Funções Diversos da classe
    Function GetGridText(sAtributoID: integer): string; override;
    Function GetValue(sAtributoID: integer): variant; override;
    Procedure SetValue(sAtributoID: integer; sAtributoValue: variant); override;
    Function WCompareStr(sAtributoID: integer; sModelCls: TModelClass): PtrInt; override;
    Function GridCompareStr(sAtributoID: integer; sModelCls: TModelClass): PtrInt; override;
    Procedure CopyTo(sModelCls: TModelClass); override;
    Function Inicializa(sConfGridClass: TStringList): Boolean; override;
    Function GetID: integer; override;
    Function SetConfigClass: Boolean; override;
    Function GetConfigClass: TConfigClass; override;
    Procedure InitClassData(CustomerData: PBasicNodeRec); override;
    Procedure InitClassDataByWhere(sSqlWhere: string);
    Procedure InitClassDataByID(sclienteid:Integer); override;
    Function GetWhereByID(sclienteid:Integer):string; override;
    Procedure SetClean;

  published
  end;

  // Variáveis Globais
  var
    ConfigClass: TConfigClass;
    ClienteData: PBasicNodeRec;

  Procedure ClearConfGridClass;

  implementation

  uses un_StringList;

  // Procedimentos e Funções Globais

  Procedure ClearConfGridClass;
  begin
    FreeObjects(ConfigClass.ConfGridClass);
    ConfigClass.ConfGridClass.Free;
  end;

  // Configuração da Classe
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
    ConfigClass.ClassPopulateGrid := True;
    ConfigClass.SelectTable := True;
    ConfigClass.DeleteTable := True;
    ConfigClass.ConfGridClass := TStringList.Create;
    with ConfigClass.ConfGridClass do
    begin
      AddObject('Cliente ID', TColGrid.Create('clienteid', 'Cliente ID', ftInteger, 7, 0, True, False, False, True, True, True, False, False, 1)); // 0 PK 
      AddObject('Nome', TColGrid.Create('nome', 'Nome', ftString, 60, 0, False, False, True, True, True, True, False, False, 2)); // 1 NN 
      AddObject('Cidade', TColGrid.Create('cidade', 'Cidade', ftString, 60, 0, False, False, True, True, True, True, False, False, 3)); // 2 NN 
      AddObject('UF', TColGrid.Create('uf', 'UF', ftString, 2, 0, False, False, True, True, True, True, False, False, 4)); // 3 NN 
      //AddObject('Status', TColGrid.Create('Apagado', 'Apagado', ftFixedChar, 1, 0, False, False,  False, False, True, False, False, False, 0));
    end;
    ConfigClass.ListaFiltro:= TStringList.Create;
    ConfigClass.ListaFiltro.Duplicates := dupError;
    ConfigClass.ListaFiltro.Sorted := True;
    ConfigClass.ListaFiltro.Assign(ConfigClass.ConfGridClass);
    ConfigClass.IDColunaExc := 1;
    ConfigClass.IDColunaExc2 := 0;
    ConfigClass.IDAtributoFKSK := 0;
    ConfigClass.TipoVTGrid := 1;
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

  // Procedimentos de atualização de atributos

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

  // Funções de retorno de atributos como texto para o Grid
  Function TClienteCls.GetGridText(sAtributoID: integer): string;
  begin
    case sAtributoID of
      0: Result:= GetText(0);
      1: Result:= GetText(1);
      2: Result:= GetText(2);
      3: Result:= GetText(3);
    end;
  end;

  // Funções de retorno dos valores dos atributos
  Function TClienteCls.GetValue(sAtributoID: integer): variant;
  begin
    case sAtributoID of
        0: Result := clienteid;
        1: Result := nome;
        2: Result := cidade;
        3: Result := uf;
        4: Result := integer(Status = osDeleted);
    end;
  end;

  // Procedure de atualização dos valores de atributos 
  Procedure TClienteCls.SetValue(sAtributoID: integer; sAtributoValue: variant);
  begin
    case sAtributoID of
        0: Setclienteid(sAtributoValue);
        1: Setnome(sAtributoValue);
        2: Setcidade(sAtributoValue);
        3: Setuf(sAtributoValue);
    end;
  end;

  // Funções de retorno de comparação dos valores dos atributos para ordenação
  Function TClienteCls.WCompareStr(sAtributoID: integer; sModelCls: TModelClass): PtrInt;
  var ItemColGrid: TColGrid;
      FormatedStr : string;
      ValorI1, ValorI2: Integer;
      ValorS1, ValorS2: String;
      ValorD1, ValorD2: DateTime;
      ValorR1, ValorR2: Real;
  begin
    Result:= 0;
    ItemColGrid := ConfigClass.ConfGridClass.Objects[sAtributoID] as TColGrid;
    case ItemColGrid.TipoAtributo of
      ftBoolean:
      begin
        if GetValue(sAtributoID) then ValorS1 := 'S' else ValorS1 := 'N' ;
        if (sModelCls as TClienteCls).GetValue(sAtributoID) then ValorS2 := 'S' else ValorS2 := 'N';
        Result := UTF8CompareText(ValorS1, ValorS2);
      end;
      ftSmallint, ftInteger, ftWord, ftAutoInc:
      begin
        ValorI1:= GetValue(sAtributoID);
        ValorI2:= (sModelCls as TClienteCls).GetValue(sAtributoID);
        Result := UTF8CompareText(ZeroStr(ValorI1, ItemColGrid.Size), ZeroStr(ValorI2, ItemColGrid.Size));
      end;
      ftString, ftMemo, ftFmtMemo, ftFixedChar, ftWideString, ftFixedWideChar, ftWideMemo:
      begin
        ValorS1:= UTF8LowerCase(UTF8ToASCII(GetValue(sAtributoID)));
        ValorS2:= UTF8LowerCase(UTF8ToASCII((sModelCls as TClienteCls).GetValue(sAtributoID)));
        Result := UTF8CompareText(ValorS1, ValorS2);
      end;
      ftFloat, ftCurrency:
      begin
        FormatedStr := '%' + IntToStr(ItemColGrid.Size) + '.' + IntToStr(ItemColGrid.Precision) + 'n';
        ValorR1 := GetValue(sAtributoID);
        ValorR2 := (sModelCls as TClienteCls).GetValue(sAtributoID);
        Result := UTF8CompareText(Format(FormatedStr, [ValorR1]), Format(FormatedStr, [ValorR2]));
      end;
      ftDate, ftDateTime, ftTime:
      begin
        ValorD1:= GetValue(sAtributoID);
        ValorD2:= (sModelCls as TClienteCls).GetValue(sAtributoID);
        if ItemColGrid.TipoAtributo = ftDate then
        begin
          Result := CompareDate(ValorD1, ValorD2);
        end else if ItemColGrid.TipoAtributo = ftDateTime then
        begin
          Result := CompareDateTime(ValorD1, ValorD2);
        end else Result := CompareTime(ValorD1, ValorD2);
      end;
      else Result := 0;
    end;
  end;

  // Funções de retorno de comparação dos valores dos atributos para ordenação do Grid
  Function TClienteCls.GridCompareStr(sAtributoID: integer; sModelCls: TModelClass): PtrInt; 
  begin
    Result:= 0;
    case sAtributoID of
      0: Result:= WCompareStr(0, sModelCls);
      1: Result:= WCompareStr(1, sModelCls);
      2: Result:= WCompareStr(2, sModelCls);
      3: Result:= WCompareStr(3, sModelCls);
    end;
  end;

  // Funções de copia dos valores dos atributos entre instancias da classe
  Procedure TClienteCls.CopyTo(sModelCls: TModelClass);
  begin
    (sModelCls as TClienteCls).clienteid := Self.clienteid;
    (sModelCls as TClienteCls).nome := Self.nome;
    (sModelCls as TClienteCls).cidade := Self.cidade;
    (sModelCls as TClienteCls).uf := Self.uf;
  end;

  // Funções de inicializaçãos dos atributos entre de classe atraves da ColunaGrid
  Function TClienteCls.Inicializa(sConfGridClass: TStringList): Boolean;
  var
    sAtributoID: integer;
    ItemColGrid: TColGrid;
  begin
    for sAtributoID := 0 to sConfGridClass.Count - 1 do
    begin
      ItemColGrid := sConfGridClass.Objects[sAtributoID] as TColGrid;
      if not (VarType(ItemColGrid.Value) in [ varEmpty, varNull]) then
      begin
        try
          case sAtributoID of
              0: clienteid := ItemColGrid.Value;
              1: nome := Trim(DBAnsiToUTF8(ItemColGrid.Value));
              2: cidade := Trim(DBAnsiToUTF8(ItemColGrid.Value));
              3: uf := Trim(DBAnsiToUTF8(ItemColGrid.Value));
          end;
        except
        end;
      end;
    end;
    Result:= True;
    Status := osUnmodified;
  end;

  // Funções Complementares - Retorno ID da Classe
  Function TClienteCls.GetID: integer;
  begin
    Result := clienteid;
  end;

  // Funções Complementares - Configurar Classe de dados
  Function TClienteCls.SetConfigClass: Boolean;
  begin
    Result := DoConfigClass;
  end;

  // Funções Complementares - Retornar Configuração de Classe de dados
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

  // Funções Complementares - Inicializar dados
  Procedure TClienteCls.InitClassData(CustomerData: PBasicNodeRec);
  begin
    ClienteData:= CustomerData;
  end;

  // Funções Complementares - Inicializar dados buscando do SGBD 
  Procedure TClienteCls.InitClassDataByWhere(sSqlWhere: string);
  var
    SQLSelectByID: string;
    QryPadrao: TSQlQueryData;
    sAtributoID: integer;
  begin
    DoConfigClass;
    QryPadrao:= TSQlQueryData.Create(nil);
    SQLSelectByID:= DoSelectClass(ConfigClass);
    SQLSelectByID:= SQLSelectByID + sSqlWhere;
    if dmDatabase.ExecutaSQL(SQLSelectByID, QryPadrao) then
    begin
      if QryPadrao.Active then
      begin
        QryPadrao.First;
        with ConfigClass do
          for sAtributoID:= 0 to ConfGridClass.Count-1 do
          begin
            if (ConfGridClass.Objects[sAtributoID] as TColGrid).SQLSel then
              (ConfGridClass.Objects[sAtributoID] as TColGrid).Value:=
                QryPadrao.FieldDefs.Dataset.FieldValues[(ConfGridClass.Objects[sAtributoID] as TColGrid).NomeAtributo];
          end;
        Self.Inicializa(ConfigClass.ConfGridClass);
      end;
    end;
    QryPadrao.Free;
  end;

  // Funções Complementares - Inicializar dados buscando pelo ID
  Procedure TClienteCls.InitClassDataByID(sclienteid:Integer);
  var
    SqlWhere: string;
  begin
    SqlWhere:= ' where clienteid = ' + IntToStr(sclienteid);
    InitClassDataByWhere(SqlWhere);
  end;

  initialization

    RegisterClass(TClienteCls);
    ConfigClass:= Nil;

end.
