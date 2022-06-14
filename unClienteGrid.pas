////////////////////////////////////////////////////////////////////////////////
// Módulo          : Formulário Grid de Cliente
// Tipo            : 1 = Grid;
// Data da Versão  : 12/06/2022 - 00:00:01
// Analista        : Adriano L. de Mendonça Soares
////////////////////////////////////////////////////////////////////////////////

unit unClienteGrid;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, unFormModeloGrid, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Vcl.ExtCtrls;

type
  TFormClienteGrid = class(TFormModeloGrid)
  procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormClienteGrid: TFormClienteGrid;

implementation

uses dmdatabaseWk, unClienteCls;

{$R *.dfm}

procedure TFormClienteGrid.FormCreate(Sender: TObject);
begin
  DataCls:= TClienteCls.Create;
  inherited;
end;

end.
