////////////////////////////////////////////////////////////////////////////////
// Classe de dados : ModelClass & classes e tipos de uso geral no sistema
// Templarium      : 1.8.0.00
// Data de Geração : 14/06/2022 - 21:00:01
// Analista        : Adriano L. de Mendonça Soares
////////////////////////////////////////////////////////////////////////////////
unit unModelCls;

interface

uses
  System.SysUtils, System.Classes, db, System.Variants, dmdatabaseWk;

Type

  //Tipos para compatilidade com gerador de Classes
  DateTime = TDateTime;
  Float = Real;

  // Definição do status de Classe de Dados
  TClassStatus   = (osClean, osUnmodified, osDeleted, osInMemory, osModified);
  TFormStatus    = (frNil, frClean, frInMemory, frShow, frEdit);

  // Classe para definição da apresentação dos atributos de uma Classe de Dados
  TColGrid = class
  private
    //fNomeTabela,
    fNomeAtributo,
    fDescricaoAtributo: string;
    fTipoAtributo: TFieldType;
    fSize: integer;
    fPrecision: integer;
    fChavePrimaria: Boolean;
    fNotNull: Boolean;
    fSQLSel: Boolean;
    fSQLIns: Boolean;
    fGrid: Boolean;
    fOrdemGrid: Integer;
    fValue: Variant;
  public
    //property NomeTabela: string read fNomeTabela write fNomeTabela;
    property NomeAtributo: string read fNomeAtributo write fNomeAtributo;
    property DescricaoAtributo: string read fDescricaoAtributo write fDescricaoAtributo;
    property TipoAtributo: TFieldType read fTipoAtributo write fTipoAtributo;
    property Size: integer read fSize write fSize;
    property Precision: integer read fPrecision write fPrecision;
    property ChavePrimaria: Boolean read fChavePrimaria write fChavePrimaria;
    property NotNull: Boolean read fNotNull write fNotNull;
    property SQLSel: Boolean read fSQLSel write fSQLSel;
    property SQLIns: Boolean read fSQLIns write fSQLIns;
    property Grid: Boolean read fGrid write fGrid;
    property OrdemGrid: Integer read fOrdemGrid write fOrdemGrid;
    property Value: Variant read fValue write fValue;
    constructor Create; overload;
    // Utilizado nas Classes de Dados
    constructor Create(const sNomeAtributo, sDescricaoAtributo: string;
      const sTipoAtributo : TFieldType; const sSize, sPrecision: integer;
      const sChavePrimaria, sChaveSecundaria, sNotNull, sSQLSel, sSQLIns: Boolean; sOrdemGrid: Integer); overload;

    constructor Create(const sNomeAtributo, sDescricaoAtributo: string;
      const sTipoAtributo : TFieldType; const sSize, sPrecision: integer;
      const sChavePrimaria, sChaveSecundaria, sNotNull, sSQLSel, sSQLIns, sGrid: Boolean;  sValorInicial: String); overload;


  end;

  // Classe de configuração gerais do form apresentação de uma Classe de Dados
  TConfigClass = class(TPersistent)
  private
    fClassName: string;
    fClassDesc: string;
    fTableName: string;
    fViewName: string;
    fSelectTable: Boolean;
    fClassSQLSelect: string;
    // Lista de objetos de identificação de coluna
    fConfGrid: TStringList;
    fListaFiltro: TStringList;
    //Coluna de mensagem de exclusão
    fIDColunaExc: integer;
   public
     property ClassName: string read fClassName write fClassName;
     property ClassDesc: string read fClassDesc write fClassDesc;
     property TableName: string read fTableName write fTableName;
     property ViewName: string read fViewName write fViewName;
     property SelectTable: Boolean read fSelectTable write fSelectTable;
     property ClassSQLSelect: string read fClassSQLSelect write fClassSQLSelect;
     property ConfGrid: TStringList read fConfGrid write fConfGrid;
     property ListaFiltro: TStringList read fListaFiltro write fListaFiltro;
     property IDColunaExc: integer read fIDColunaExc write fIDColunaExc;

     constructor Create; overload;

     procedure ClearConfGrid; virtual;
   end;

  TModelClass = class(TPersistent)
  private
    fStatus: TClassStatus; // (osClean, osUnmodified, osDeleted, osInMemory, osModified);
  protected
    // Funções de interação com banco de dados
    Function DoInsert(sModelClassOri: TModelClass): boolean; virtual;
    Function DoUpdate(sModelClassOri: TModelClass): boolean; virtual;
    Function DoDelete: boolean; virtual;
    // Função de configuração
    Function DoConfigClass: boolean; virtual;
    procedure SetStatus(const Value: TClassStatus); virtual;
  public
    constructor Create; overload; virtual;

    Function SetConfigClass: boolean; virtual;
    Function GetConfigClass: TConfigClass; virtual;

    Procedure UpdateStatus;

    Function GetValue(ColumnID: integer):Variant; virtual;
    Procedure SetValue(sAtributoID: integer; sAtributoValue: variant);
    Function ChavePrimariaOk: Boolean; //virtual;

    Function ValidaDelete(var sMensagem: string): boolean; virtual;
    Function Save(sModelClassOri: TModelClass): boolean; virtual;
    Function Delete(sModelClassOri: TModelClass): boolean; virtual;
    Function GetInsertSQL: String;
    Function GetUpdateSQL: String;
    Function GetDeleteSQL: String;

    Function SetDatasetFields(var sQryPadrao: TSQlQueryData): integer;
    Function CreateMemoryTableFields(var sMemTable: TMemoryTable): Boolean;

    Function GetID: integer; virtual;
    Function Valida(var sMensagem: string): boolean; virtual;

    property Status: TClassStatus read fStatus write SetStatus;

  end;

  Function DoSelectClass(sConfigClass: TConfigClass): string;

implementation

uses unBiblioGeral;

// Classe TColGrid
constructor TColGrid.Create;
begin
  //fNomeTabela:= '';
  fNomeAtributo:= '';
  fDescricaoAtributo:= '';
  fTipoAtributo:= ftUnknown;
  fSize:= -1;
  fPrecision:= 0;
  fChavePrimaria:= False;
  fNotNull:= False;
  fSQLSel:= False;
  fSQLIns:= False;
  fGrid:= False;
  fValue:= Unassigned;
end;

constructor TColGrid.Create(const sNomeAtributo, sDescricaoAtributo: string;
  const sTipoAtributo : TFieldType; const sSize, sPrecision: integer;
  const sChavePrimaria, sChaveSecundaria, sNotNull, sSQLSel, sSQLIns: Boolean; sOrdemGrid: Integer);
begin
  //fNomeTabela:= sNomeTabela;
  fNomeAtributo:= sNomeAtributo;
  fDescricaoAtributo:= sDescricaoAtributo;
  fTipoAtributo:= sTipoAtributo;
  fSize:= sSize;
  fPrecision:= sPrecision;
  fChavePrimaria:= sChavePrimaria;
  fNotNull:= sNotNull;
  fSQLSel:= sSQLSel;
  fSQLIns:= sSQLIns;
  fGrid:= (sOrdemGrid>0);
  fOrdemGrid:= sOrdemGrid;
  // Não inicializados
  fValue:= Unassigned;
end;

constructor TColGrid.Create(const sNomeAtributo, sDescricaoAtributo: string;
  const sTipoAtributo : TFieldType; const sSize, sPrecision: integer;
  const sChavePrimaria, sChaveSecundaria, sNotNull, sSQLSel, sSQLIns, sGrid: Boolean;  sValorInicial: String);
begin
  //fNomeTabela:= sNomeTabela;
  fNomeAtributo:= sNomeAtributo;
  fDescricaoAtributo:= sDescricaoAtributo;
  fTipoAtributo:= sTipoAtributo;
  fSize:= sSize;
  fPrecision:= sPrecision;
  fChavePrimaria:= sChavePrimaria;
  fNotNull:= sNotNull;
  fSQLSel:= sSQLSel;
  fSQLIns:= sSQLIns;
  fGrid:= sGrid;
  if sValorInicial<>'' then
    fValue:= sValorInicial
  else
    fValue:= Unassigned;
end;

// Classe TConfigClass
constructor TConfigClass.Create;
begin
  ClassName:= '';
  ClassDesc:= '';
  TableName:= '';
  ViewName:= '';
  SelectTable:= True;
  ClassSQLSelect:= '';;
  ConfGrid:= Nil;
  ListaFiltro:= Nil;
  IDColunaExc:= 0;
end;

procedure TConfigClass.ClearConfGrid;
begin
  FreeObjects(ConfGrid);
  ConfGrid.Free;
end;

// Classe TModelClass
constructor TModelClass.Create;
begin
  inherited;
  Status:= osInMemory;  //osUnmodified;
end;

Procedure TModelClass.UpdateStatus;
begin
  if Status = osUnmodified then Status := osModified
  else if Status = osClean then Status := osInMemory;
end;

Function TModelClass.GetValue(ColumnID: integer):Variant;
begin
end;

Procedure TModelClass.SetValue(sAtributoID: integer; sAtributoValue: variant);
begin
end;

// Valida campos de Chave Primária
Function TModelClass.ChavePrimariaOk: Boolean;
var
  ItemColGrid: TColGrid;
  sAtributoID: integer;
  // Variáveis Globais
  ConfigClass: TConfigClass;
begin
  Result := False;
  ConfigClass:= GetConfigClass;
  if ConfigClass=Nil then exit;
  // Validar Chave Primária
  with ConfigClass do
  begin
    for sAtributoID := 0 to ConfGrid.Count - 1 do
    begin
      ItemColGrid := ConfGrid.Objects[sAtributoID] as TColGrid;
      if ItemColGrid.ChavePrimaria then
        Result := GetValue(sAtributoID)<>0;
    end;
  end;
end;

Function TModelClass.DoInsert(sModelClassOri: TModelClass): boolean;
var
  SQLQuery: string;
  ItemColGrid: TColGrid;
  sAtributoID: integer;
  // Variáveis Globais
  ConfigClass: TConfigClass;
  AuxStrWhere: string;
begin
  Result := False;
  ConfigClass:= GetConfigClass;
  if ConfigClass=Nil then exit;
  with ConfigClass do
  begin
    // Atribui Chave Primária
    for sAtributoID := 0 to ConfGrid.Count - 1 do
    begin
      ItemColGrid := ConfGrid.Objects[sAtributoID] as TColGrid;
      if ItemColGrid.ChavePrimaria then
        if GetValue(sAtributoID)=0 then
          Self.SetValue(sAtributoID, dmDatabase.CalcKey(ConfigClass.TableName, ItemColGrid.NomeAtributo, ''));
    end;
  end;
  // Valida Chave Primária e Chave Secundária
  if Self.ChavePrimariaOk then
  begin
    SQLQuery:= GetInsertSQL;
    if dmDatabase.ExecutaSQL(SQLQuery) then
    begin
      Status := osUnmodified;
      Result := True;
    end;
  end;
end;

Function TModelClass.DoUpdate(sModelClassOri: TModelClass): boolean;
var
  SQLQuery: string;
begin
  Result := False;
  // Valida Chave Primária e Cagve Secundária
  if Self.ChavePrimariaOk then
  begin
    SQLQuery:= GetUpdateSQL;
    if dmDatabase.ExecutaSQL(SQLQuery) then
    begin
      if (Status <> osDeleted) then
      begin
        Status := osUnmodified;
      end;
      Result := True;
    end;
  end;
end;

//
Function TModelClass.DoDelete: boolean;
var
  SQLQuery: string;
  // Variáveis Globais
  ConfigClass: TConfigClass;
begin
  Result := False;
  ConfigClass:= GetConfigClass;
  if ConfigClass=Nil then exit;
  // Valida Chave Primária
  if Self.ChavePrimariaOk then
  begin
    SQLQuery:= GetDeleteSQL;
    if dmDatabase.ExecutaSQL(SQLQuery) then
    begin
      Status := osDeleted;
      Result := True;
    end;
  end;
end;

Function TModelClass.DoConfigClass: boolean;
begin
  Result := False;
end;

procedure TModelClass.SetStatus(const Value: TClassStatus);
begin
  fStatus := Value;
end;

Function TModelClass.SetConfigClass: boolean;
begin
  Result:= False;
end;

Function TModelClass.GetConfigClass: TConfigClass;
begin
  Result:= Nil;
end;

Function TModelClass.ValidaDelete(var sMensagem: string): boolean;
begin
  //Result:= False;
  //if sMensagem='' then
  //  sMensagem:= 'Validar Processo de Deleção!'
  Result:= True;
end;

Function TModelClass.Save(sModelClassOri: TModelClass): boolean;
begin
  case Status of
    osInMemory: Result:= DoInsert(sModelClassOri);
    osModified,
    osDeleted : Result:= DoUpdate(sModelClassOri);
    osUnmodified: Result:= True;
    else Result:= False;
      //raise Exception.Create('CRUD Error for class ' + TModelClass.ClassName);
  end;
end;

Function TModelClass.Delete(sModelClassOri: TModelClass): boolean;
begin
  //Result:= DoDelete(sModelClassOri);
  Result:= DoDelete;
end;

// Gerar SQL de Inserção no banco de dados
Function TModelClass.GetInsertSQL: String;
var
 SQLQuery, SQLValues: string;
 ItemColGrid: TColGrid;
 sAtributoID: integer;
 FormatedStr : string;
 ValorReal: Real;
 ValorData: TDateTime;
 // Variáveis Globais
 ConfigClass: TConfigClass;
begin
 Result := '';
 ConfigClass:= GetConfigClass;
 if ConfigClass=Nil then exit;
 with ConfigClass do
 begin
   // Comando SQL
   SQLQuery := '';
   SQLValues := '';
   for sAtributoID := 0 to ConfGrid.Count - 1 do
   begin
     ItemColGrid := ConfGrid.Objects[sAtributoID] as TColGrid;
     if ItemColGrid.SQLIns then
     begin
       if SQLQuery = '' then
         SQLQuery := 'insert into ' + ConfigClass.TableName + '('
       else
         SQLQuery := SQLQuery + ', ';
       SQLQuery := SQLQuery + ItemColGrid.NomeAtributo;
       if SQLValues = '' then
         SQLValues := ') VALUES ('
       else
         SQLValues := SQLValues + ',';
       if ItemColGrid.ChavePrimaria then
       begin
         if GetValue(sAtributoID)=0 then
           SQLValues := SQLValues + dmDatabase.DBMaxID(ItemColGrid.NomeAtributo, ConfigClass.TableName)
         else SQLValues := SQLValues + IntToStr(GetValue(sAtributoID));
       end else
       begin
         if ItemColGrid.TipoAtributo in [ftDate, ftDateTime] then
           SQLValues := SQLValues + VarToSql(GetValue(sAtributoID), 'YYYY/MM/DD')
         else if ItemColGrid.TipoAtributo = ftTime then
           SQLValues := SQLValues + VarToSql(TDateTime(GetValue(sAtributoID)), 'HH:nn:ss')
         else SQLValues := SQLValues + VarToSql(GetValue(sAtributoID));
       end;
     end;
   end;
   SQLQuery := SQLQuery + SQLValues + ')';
   Result := SQLQuery;
 end;
end;

// Gerar SQL de Update no banco de dados
Function TModelClass.GetUpdateSQL: String;
var
 SQLQuery, SQLWhere, ValAtributoSQL: string;
 ItemColGrid: TColGrid;
 sAtributoID: integer;
 FormatedStr : string;
 ValorReal: Real;
 ValorData: TDateTime;
 // Variáveis Globais
 ConfigClass: TConfigClass;
begin
 Result := '';
 ConfigClass:= GetConfigClass;
 if ConfigClass=Nil then exit;
 with ConfigClass do
 begin
   // Comando SQL
   SQLQuery := '';
   SQLWhere := '';
   for sAtributoID := 0 to ConfGrid.Count - 1 do
   begin
     ItemColGrid := ConfGrid.Objects[sAtributoID] as TColGrid;
     // Valor do Atributo
     ValAtributoSQL:= '';
     if ItemColGrid.TipoAtributo in [ftDate, ftDateTime] then
       ValAtributoSQL := VarToSql(GetValue(sAtributoID), 'YYYY/MM/DD')
     else if ItemColGrid.TipoAtributo = ftTime then
       ValAtributoSQL := VarToSql(TDateTime(GetValue(sAtributoID)), 'HH:nn:ss')
     else ValAtributoSQL := VarToSql(GetValue(sAtributoID));
     // Montar SQL
     if ItemColGrid.SQLIns then
     begin
       if not ItemColGrid.ChavePrimaria then
       begin
         if ItemColGrid.SQLIns then
         begin
           if SQLQuery = '' then
             SQLQuery := 'update ' + ConfigClass.TableName + ' set '
           else
             SQLQuery := SQLQuery + ', ';
           SQLQuery := SQLQuery + ItemColGrid.NomeAtributo + '=' + ValAtributoSQL
         end;
       end else
       begin
         if SQLWhere = ''  then
           SQLWhere := ' where '
         else
           SQLWhere := SQLWhere + ' and ';
         SQLWhere := SQLWhere + ItemColGrid.NomeAtributo + '=' + ValAtributoSQL;
       end;
     end;
   end;
   SQLQuery := SQLQuery + SQLWhere;
   Result := SQLQuery;
 end;
end;

// Gerar SQL de Delete no banco de dados
Function TModelClass.GetDeleteSQL: String;
var
 SQLQuery, SQLWhere, ValAtributoSQL: string;
 ItemColGrid: TColGrid;
 sAtributoID: integer;
 FormatedStr : string;
 ValorReal: Real;
 ValorData: TDateTime;
 // Variáveis Globais
 ConfigClass: TConfigClass;
begin
  Result := '';
  ConfigClass:= GetConfigClass;
  if ConfigClass=Nil then exit;
  with ConfigClass do
  begin
   SQLWhere := '';
   ValAtributoSQL := '';
   for sAtributoID := 0 to ConfGrid.Count - 1 do
   begin
     ItemColGrid := ConfGrid.Objects[sAtributoID] as TColGrid;
     if ItemColGrid.ChavePrimaria then
     begin
       // Valor do Atributo
       ValAtributoSQL:= '';
       case ItemColGrid.TipoAtributo of
         ftSmallint, ftInteger, ftWord, ftAutoInc: ValAtributoSQL := IntToStr(GetValue(sAtributoID));
         ftFixedChar, ftString, ftMemo, ftFmtMemo,
         ftWideString, ftFixedWideChar, ftWideMemo: ValAtributoSQL := QuotedStr(GetValue(sAtributoID));
         ftFloat, ftCurrency:
           begin
             FormatedStr := '%' + IntToStr(ItemColGrid.Size) + '.' + IntToStr(ItemColGrid.Precision) + 'f';
             ValorReal := GetValue(sAtributoID);
             ValAtributoSQL := StringReplace(Trim(Format(FormatedStr, [ValorReal])), ',', '.', [rfReplaceAll]);
           end;
         ftDate, ftDateTime:
           begin
             ValorData:= GetValue(sAtributoID);
             if ValorData>0 then
               ValAtributoSQL := QuotedStr(AnoMesDiaB(ValorData))
             else
               ValAtributoSQL := 'Null'
           end;
         ftTime: ValAtributoSQL := QuotedStr(FormatDateTime('HH:nn:ss',GetValue(sAtributoID)));
         ftBoolean: ValAtributoSQL := IIf(GetValue(sAtributoID), 'True', 'False');
       end;
       // Montar SQL
       if SQLWhere = '' then
         SQLWhere := ' where '
       else
         SQLWhere := ' and ';
       SQLWhere := SQLWhere + ItemColGrid.NomeAtributo + '= ' + ValAtributoSQL
     end;
   end;
  end;
  // Comando SQL
  SQLQuery := dmDatabase.DeleteClause + ConfigClass.TableName;
  SQLQuery := SQLQuery + SQLWhere;
  Result := SQLQuery;
end;

// Criar componentes Persistent Field associados ao TDataSet
Function TModelClass.SetDatasetFields(var sQryPadrao: TSQlQueryData): integer;
var
 ItemColGrid: TColGrid;
 sAtributoID: integer;
 //FormatedStr : string;
 ConfigClass: TConfigClass;
 //DatasetField: TField;
 ColSize,
 TamGrid: integer;
begin
  result:= 0;
  TamGrid:= 0;
  if sQryPadrao=Nil then
    exit;
  ConfigClass:= GetConfigClass;
  if ConfigClass=Nil then exit;
  with ConfigClass do
  begin
    for sAtributoID := 0 to ConfGrid.Count - 1 do
    begin
      ItemColGrid := ConfGrid.Objects[sAtributoID] as TColGrid;
      sQryPadrao.FieldByName(ItemColGrid.NomeAtributo).DisplayLabel:= ItemColGrid.DescricaoAtributo;
      if ItemColGrid.TipoAtributo = ftFloat then
        TFloatField(sQryPadrao.FieldByName(ItemColGrid.NomeAtributo)).DisplayFormat:= MascaraNumero;
      if Length(ItemColGrid.DescricaoAtributo) > ItemColGrid.Size then
        ColSize:= Length(ItemColGrid.DescricaoAtributo)
      else ColSize:= ItemColGrid.Size * 1;
      sQryPadrao.FieldByName(ItemColGrid.NomeAtributo).DisplayWidth := ColSize;
      TamGrid:= TamGrid + sQryPadrao.FieldByName(ItemColGrid.NomeAtributo).DisplayWidth;
    end;
    sQryPadrao.FieldDefs.Update;
  end;
  result:= trunc(TamGrid * 6.8);
end;

Function TModelClass.CreateMemoryTableFields(var sMemTable: TMemoryTable): Boolean;
var
 ItemColGrid: TColGrid;
 sAtributoID: integer;
 //FormatedStr : string;
 ConfigClass: TConfigClass;
 ColSize,
 TamGrid: integer;
begin
  result:= False;
  if sMemTable=Nil then
    exit;
  ConfigClass:= GetConfigClass;
  if ConfigClass=Nil then exit;
  with ConfigClass do
  begin
    for sAtributoID := 0 to ConfGrid.Count - 1 do
    begin
      ItemColGrid := ConfGrid.Objects[sAtributoID] as TColGrid;
      if ItemColGrid.Grid then
      begin
        with sMemTable.FieldDefs do
        begin
          case ItemColGrid.TipoAtributo of
            ftAutoInc: Add(ItemColGrid.NomeAtributo, ItemColGrid.TipoAtributo,0, ItemColGrid.NotNull);
            ftSmallint, ftInteger, ftWord: Add(ItemColGrid.NomeAtributo, ItemColGrid.TipoAtributo,0, ItemColGrid.NotNull);
            ftFixedChar, ftString, ftMemo, ftFmtMemo,
            ftWideString, ftFixedWideChar, ftWideMemo: Add(ItemColGrid.NomeAtributo, ItemColGrid.TipoAtributo, ItemColGrid.Size, ItemColGrid.NotNull);
            ftFloat, ftCurrency:
             begin
               Add(ItemColGrid.NomeAtributo, ItemColGrid.TipoAtributo,0, ItemColGrid.NotNull);
             end;
            ftDate, ftDateTime:
             begin
               Add(ItemColGrid.NomeAtributo, ItemColGrid.TipoAtributo,0, ItemColGrid.NotNull);
             end;
            //ftTime: ValAtributoSQL := QuotedStr(FormatDateTime('HH:nn:ss',GetValue(sAtributoID)));
            ftBoolean: Add(ItemColGrid.NomeAtributo, ItemColGrid.TipoAtributo,0, ItemColGrid.NotNull);
          end;
        end;
      end;
    end;
    sMemTable.CreateDataset;
    for sAtributoID := 0 to ConfGrid.Count - 1 do
    begin
      ItemColGrid := ConfGrid.Objects[sAtributoID] as TColGrid;
      if ItemColGrid.Grid then
      begin
        sMemTable.FieldByName(ItemColGrid.NomeAtributo).DisplayLabel:= ItemColGrid.DescricaoAtributo;
        if ItemColGrid.TipoAtributo = ftFloat then
          TFloatField(sMemTable.FieldByName(ItemColGrid.NomeAtributo)).DisplayFormat:= MascaraNumero;
        if Length(ItemColGrid.DescricaoAtributo) > ItemColGrid.Size then
          ColSize:= Length(ItemColGrid.DescricaoAtributo)
        else ColSize:= ItemColGrid.Size * 1;
        sMemTable.FieldByName(ItemColGrid.NomeAtributo).DisplayWidth := ColSize;
      end;
    end;
    sMemTable.FieldDefs.Update;
    try
      sMemTable.Open;
    except
    end;
    result:= sMemTable.Active;
  end;
end;

Function TModelClass.GetID: integer;
begin
end;

Function TModelClass.Valida(var sMensagem: string): boolean;
var
  cont, sAtributoID: integer;
  ItemColGrid: TColGrid;
  // Variáveis Globais
  ConfigClass: TConfigClass;
begin
  Result := True;
  ConfigClass:= GetConfigClass;
  if ConfigClass=Nil then exit;
  sMensagem := '';
  cont := 0;
  with ConfigClass do
  begin
    for sAtributoID := 0 to ConfGrid.Count - 1 do
    begin
      ItemColGrid := ConfGrid.Objects[sAtributoID] as TColGrid;
      if ItemColGrid.NotNull then
        if Empty(GetValue(sAtributoID)) then
        begin
          Result := False;
          sMensagem := sMensagem + ',' + ItemColGrid.DescricaoAtributo;
          Inc(cont);
        end;
    end;
  end;
  if cont > 0 then
  begin
    sMensagem:= copy(sMensagem, 2, Length(sMensagem));
    if cont > 1 then
      sMensagem := 'Os atributos [' + sMensagem + '] estão inválidos.'
    else
      sMensagem := 'O atributo [' + sMensagem + '] está inválido.';
  end else
  begin
    with ConfigClass do
    begin
      for sAtributoID := 0 to ConfGrid.Count - 1 do
      begin
        ItemColGrid := ConfGrid.Objects[sAtributoID] as TColGrid;
        if (ItemColGrid.TipoAtributo in [ftString, ftMemo, ftFmtMemo, ftFixedChar, ftWideString, ftFixedWideChar, ftWideMemo]) then
          if not Empty(GetValue(sAtributoID)) then
            if Length(GetValue(sAtributoID))>ItemColGrid.Size then
            begin
              Result := False;
              sMensagem := sMensagem + ',' + ItemColGrid.DescricaoAtributo + ' (' + IntToStr(ItemColGrid.Size) + ') ';
              Inc(cont);
            end;
      end;
    end;
    if cont > 0 then
    begin
      sMensagem:= copy(sMensagem, 2, Length(sMensagem));
      if cont > 1 then
        sMensagem := 'Atributos com tamanho maior que o máximo: [' + sMensagem + ']'
      else
        sMensagem := 'Atributo com tamanho maior que o máximo: [' + sMensagem + ']';
    end;
  end;
end;


Function DoSelectClass(sConfigClass: TConfigClass): string;
var
  sAtributoID: integer;
  ItemColGrid: TColGrid;
  SQLQuery: string;
begin
  // Montar consulta SQL de uma Classe de dados
  SQLQuery := '';
  with sConfigClass do
  begin
    for sAtributoID := 0 to ConfGrid.Count - 1 do
    begin
      ItemColGrid := ConfGrid.Objects[sAtributoID] as TColGrid;
      if ItemColGrid.SQLSel then
      begin
        if SQLQuery = '' then
          SQLQuery := 'Select '
        else
          SQLQuery := SQLQuery + ', ';
        SQLQuery := SQLQuery + ItemColGrid.NomeAtributo;
      end;
    end;
    if sConfigClass.SelectTable then
      SQLQuery := SQLQuery + ' from ' + TableName
    else
      SQLQuery := SQLQuery + ' from ' + ViewName;
  end;
  Result := SQLQuery;
end;


end.
