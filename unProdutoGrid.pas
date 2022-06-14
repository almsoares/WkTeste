////////////////////////////////////////////////////////////////////////////////
// Módulo          : Formulário Grid de Produto
// Tipo            : 1 = Grid;
// Data da Versão  : 12/06/2022 - 00:00:01
// Analista        : Adriano L. de Mendonça Soares
////////////////////////////////////////////////////////////////////////////////

unit unProdutoGrid;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, unFormModeloGrid, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Vcl.ExtCtrls;

type
  TFormProdutoGrid = class(TFormModeloGrid)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormProdutoGrid: TFormProdutoGrid;

implementation

uses dmdatabaseWk, unProdutoCls;

{$R *.dfm}

procedure TFormProdutoGrid.FormCreate(Sender: TObject);
begin
  DataCls:= TProdutoCls.Create;
  inherited;
end;

end.
