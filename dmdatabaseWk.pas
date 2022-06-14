////////////////////////////////////////////////////////////////////////////////
// Módulo          : Acesso a banco de dados
// Componente Base : FireDAC
// Data da Versão  : 11/06/2022 - 00:00:01
// Analista        : Adriano L. de Mendonça Soares
////////////////////////////////////////////////////////////////////////////////

unit dmdatabaseWk;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait, FireDAC.Comp.UI, Data.DB,
  FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.VCLUI.Error, FireDAC.VCLUI.Login,
  System.Variants;

type

  // Estruturas de acesso ao banco de dados
  TSQlCommandRO = class(TFDQuery)// TFDCommand) // Executa comando SEM retorno de dados
  public
    Constructor Create(AOwner: TComponent); override;
  end;

  TSQlQueryData = class(TFDQuery)// Executa comando COM retorno de dados
  public
    Constructor Create(AOwner: TComponent); override;
  end;

  TMemoryTable = class(TFDMemTable)// Executa comando COM retorno de dados
  public
    //Constructor Create(AOwner: TComponent); override;
  end;

  TdmDatabase = class(TDataModule)
    DBConnection: TFDConnection;
    FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    FDGUIxErrorDialog1: TFDGUIxErrorDialog;
    FDGUIxLoginDialog1: TFDGUIxLoginDialog;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    SQlCommandRO: TSQlCommandRO;
    SQlCalcPK: TSQlQueryData;
    LastRowsAffected: integer;
    DBDeleteFrom: Boolean;
  public
    { Public declarations }

    Function DataBaseConnect: Boolean;
    Function DataBaseClose : Boolean;
    Function DeleteClause: string;

    Function CalcKey(Const NomeTb, NomePk, StrWhere: String): integer;

    Function DBMaxID(StrID, sNomeTabela:string): string; overload;
    Function DBMaxID(StrID, sNomeTabela, sStrWhere:string): string; overload;

    Function ExecutaSQL(SQLQuery: String): Boolean; overload;
    Function ExecutaSQL(SQLQuery: TStringList): Boolean; overload;
    Function ExecutaSQL(SQLQuery: String; var ResultDataSet: TSQlQueryData): Boolean; overload;

  end;

var
  dmDatabase: TdmDatabase;

// libmysql.dll 64 buts
//C:\Program Files\MySQL\MySQL Server 8.0\lib\libmysql.dll

implementation

uses unBiblioGeral;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TdmDatabase.DataModuleCreate(Sender: TObject);
begin
  with DBConnection do
  begin
    Close;
    // create temporary connection definition
    (*
    with Params do
    begin
      Clear;
      Add('DriverID=MySQL');
      Add('Server=localhost');
      Add('Port=3306');
      Add('Database=wkteste');
      Add('User_Name=root');
      Add('password=@realsys27');
      Add('CharacterSet=utf8');
    end;
    *)
    Open;
    //qryCategories.Open;
    //qryProducts.Open;
  end;
  DBDeleteFrom:= True;
  SQlCalcPK:= TSQlQueryData.Create(Self);
end;

procedure TdmDatabase.DataModuleDestroy(Sender: TObject);
begin
  SQlCalcPK.Close;
  SQlCalcPK.Free;
end;

constructor TSQlCommandRO.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Self.Connection:= dmdatabase.DbConnection;
end;

constructor TSQlQueryData.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

function TdmDatabase.DataBaseConnect: Boolean;
var IsConnected: Boolean;
begin
 if DBConnection.Connected then
 begin
   Result := True;
   exit;
 end;
  IsConnected:= False;
  with DBConnection do
  begin
    try
      Open;
      IsConnected := True;
      //Beep;
    except
      On E: Exception do
      begin
        IsConnected := False;
        MostraMensagem('Erro - Servidor não disponível','Ocorreu um erro na conexão.');
      end;
    end;
  end;
   Result := IsConnected;
end;

function TdmDatabase.DataBaseClose: Boolean;
begin
  result := False;
  try
    if DBConnection.Connected then
      DBConnection.Connected:=False;
  finally
    if not DBConnection.Connected then
      result := True;
  end;
end;

Function TdmDatabase.DeleteClause: string;
begin
  if DBDeleteFrom then
    Result := 'delete from '
  else
    Result := 'delete ';
end;

function TdmDatabase.ExecutaSQL(SQLQuery: String): Boolean; //overload;
begin
  result := False;
  LastRowsAffected:= 0;
  if dmDatabase.DataBaseConnect then
  begin
    // Iniciar a Transação no Banco de Dados
    DBConnection.StartTransaction;
    try
      // Executar o comando
     DBConnection.ExecSQL(SQLQuery);
    except
      // se houver algum erro bar Roll back
      DBConnection.Rollback;
      MostraMensagem('SQL Error', SQLQuery);
    end;
    // Se não houve erro "comitar" a transação
    if DBConnection.InTransaction then
    begin
      DBConnection.Commit;
      Result := True;
    end;
  end;
end;

Function TdmDatabase.ExecutaSQL(SQLQuery: TStringList): Boolean;
var StrID: integer;
    AuxSql: string;
begin
  result := False;
  LastRowsAffected:= 0;
  if dmDatabase.DataBaseConnect then
  begin
    // Iniciar a Transação no Banco de Dados
    DBConnection.StartTransaction;
    try
      // Executar o comando
      for StrID:= 0 to SQLQuery.Count -1 do
      begin
        AuxSql:= SQLQuery[StrID];
        DBConnection.ExecSQL(AuxSql);
        //LastRowsAffected:= LastRowsAffected + DBConnection.RowsAffected;
      end;
    except
      // se houver algum erro bar Roll back
      DBConnection.Rollback;
      MostraMensagem('SQL Error', SQLQuery[StrID]);
    end;
    // Se não houve erro "comitar" a transação
    if DBConnection.InTransaction then
    begin
      DBConnection.Commit;
      Result := True;
    end;
  end;
end;

Function TdmDatabase.ExecutaSQL(SQLQuery: String; var ResultDataSet: TSQlQueryData): Boolean;
begin
  result := False;
  if dmDatabase.DataBaseConnect then
  begin
    try
      try
        ResultDataSet.Connection:= dmdatabase.DbConnection;
        ResultDataSet.SQL.Clear;
        ResultDataSet.SQL.Add(SQLQuery);
        ResultDataSet.Open;
      except
        on E : Exception do
          begin
           MostraMensagem('Exception Error', E.ClassName + #13 + E.Message);
          end;
        else MostraMensagem('SQL Error', SQLQuery);
        exit;
      end;
    finally
      //dmDatabase.DataBaseClose;
      ResultDataSet.Open;
      Result := True;
    end;
  end;
end;

Function TdmDatabase.CalcKey(Const NomeTb, NomePk, StrWhere: String): integer;
var AuxSql: string;
    sSqlError,
    sErrorMsg: string;
begin
  result := 0;
  //if IniciaRestDB(BancoDadoConexao, RDwDBConnection) then
    if DBConnection.Connected then
    begin
      // Cálculo da Primary Key
      try
        if SQlCalcPK.Active then
          SQlCalcPK.Close;
        SQlCalcPK.Connection:= DBConnection;
        SQlCalcPK.SQL.Clear;
        AuxSql := 'select max(' + NomePk + ') as maxi from ' + NomeTb;
        if (StrWhere<>'') then
         AuxSql := AuxSql + ' ' + StrWhere;
        SQlCalcPK.SQL.Add(AuxSql);
        SQlCalcPK.Open;
        SQlCalcPK.First;
        if not SQlCalcPK.FieldByName('maxi').IsNull then
          result := (SQlCalcPK.FieldByName('maxi').AsInteger + 1)
        else
          result := 1;
      finally
        SQlCalcPK.Close;
      end;
      //if CloseDB then dmDatabase.DataBaseClose;
    end;// else MostraMensagem('Erro de conexão','DataServer não conectado!');
end;

// Tratamento para calculao de valor maximo
Function TdmDatabase.DBMaxID(StrID, sNomeTabela:string): string;
begin
  Result:= '(Select Coalesce(Max(' + StrID + ')+1,1) From ' + sNomeTabela + ')';
end;

Function TdmDatabase.DBMaxID(StrID, sNomeTabela, sStrWhere:string): string;  //overload;
begin
  Result:= '(Select Coalesce(Max(' + StrID + ')+1,1) From ' + sNomeTabela + ' ' + sStrWhere + ')';
end;

end.
