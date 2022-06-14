program PrjWKTecno;

uses
  Vcl.Forms,
  dmdatabaseWk in 'dmdatabaseWk.pas' {dmDatabase: TDataModule},
  unFormModelo in 'unFormModelo.pas' {FormModelo},
  unModelCls in 'unModelCls.pas',
  unBiblioGeral in 'unBiblioGeral.pas',
  unClienteCls in 'unClienteCls.pas',
  unFormModeloGrid in 'unFormModeloGrid.pas' {FormModeloGrid},
  unClienteGrid in 'unClienteGrid.pas' {FormClienteGrid},
  unProdutoCls in 'unProdutoCls.pas',
  unProdutoGrid in 'unProdutoGrid.pas' {FormProdutoGrid},
  unPedidoVenda in 'unPedidoVenda.pas' {FormPedidoVenda},
  unPedidoCls in 'unPedidoCls.pas',
  unPedidoProdutoCls in 'unPedidoProdutoCls.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TdmDatabase, dmDatabase);
  Application.CreateForm(TFormPedidoVenda, FormPedidoVenda);
  Application.Run;
end.
