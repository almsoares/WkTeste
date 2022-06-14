////////////////////////////////////////////////////////////////////////////////
// Módulo          : Formulário Padrão Grid de Dados (Será Herdado)
// Tipo            : 1 = Grid;
// Data da Versão  : 12/06/2022 - 00:00:01
// Analista        : Adriano L. de Mendonça Soares
////////////////////////////////////////////////////////////////////////////////

unit unFormModeloGrid;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Vcl.ExtCtrls, dmdatabaseWk, unModelCls, unFormModelo;


type
  TFormModeloGrid = class(TFormModelo)
    DBGridGeral: TDBGrid;
    dtsPadrao: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  protected
    QryPadrao: TSQlQueryData;
    DataCls: TModelClass;
  public
    { Public declarations }
  end;

var
  FormModeloGrid: TFormModeloGrid;

implementation

{$R *.dfm}

procedure TFormModeloGrid.FormCreate(Sender: TObject);
begin
  inherited;
  QryPadrao:= TSQlQueryData.Create(Self);
  dtsPadrao.DataSet:= QryPadrao;
  DBGridGeral.DataSource:= dtsPadrao;
end;

procedure TFormModeloGrid.FormShow(Sender: TObject);
Var AuxSql: string;
  TamGrid: integer;
begin
  inherited;
  if DataCls<>Nil then
  begin
    Self.Caption:= DataCls.GetConfigClass.ClassDesc;
    if DataCls.SetConfigClass then
      AuxSql:= DoSelectClass(DataCls.GetConfigClass);
    if dmdatabase.ExecutaSQL(AuxSql, qryPadrao) then
    begin
      TamGrid:= DataCls.SetDatasetFields(QryPadrao);
      Self.Width:= TamGrid;
    end;
  end;
end;

procedure TFormModeloGrid.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  if QryPadrao.Active then
    QryPadrao.Close;
  QryPadrao.Free;

  if DataCls<> Nil then
    DataCls.Free;

  Action := caFree;
end;

end.
