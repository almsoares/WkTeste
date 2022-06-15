////////////////////////////////////////////////////////////////////////////////
// Módulo          : Formulário Pedido de Venda
// Tipo            : Mestre Detalhe Tabela em Memória
// Data da Versão  : 11/06/2022 - 00:00:01
// Analista        : Adriano L. de Mendonça Soares
////////////////////////////////////////////////////////////////////////////////
unit unPedidoVenda;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, unFormModelo, Vcl.ExtCtrls, Vcl.StdCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Buttons,
  unModelCls, unPedidoCls, unPedidoProdutoCls, Vcl.Grids, Vcl.DBGrids, Vcl.Mask,
  Vcl.ComCtrls;

type
  TFormPedidoVenda = class(TFormModelo)
    mtbPedido: TFDMemTable;
    gbPedidoProdutos: TGroupBox;
    tbPedidoProduto: TFDMemTable;
    spbGravarPedido: TSpeedButton;
    lblValorPedido: TLabel;
    dtsPedidoProduto: TDataSource;
    panedtprodutopedido: TPanel;
    panGrid: TPanel;
    DBGridPedidoProduto: TDBGrid;
    spbProduto: TSpeedButton;
    edProdutoID: TLabeledEdit;
    edDescricao: TLabeledEdit;
    edQuantidade: TLabeledEdit;
    edValorUnitario: TLabeledEdit;
    gbPedidoGeral: TGroupBox;
    spbCliente: TSpeedButton;
    spbSelecionaPedido: TSpeedButton;
    lblNumeroPedido: TLabel;
    Label1: TLabel;
    lbldataemissao: TLabel;
    edClienteID: TLabeledEdit;
    edNome: TLabeledEdit;
    edDataEmissao: TDateTimePicker;
    BtnConfirmaProduto: TButton;
    ValorPedido: TLabeledEdit;
    edNumeroPedido: TLabeledEdit;
    edCidade: TLabeledEdit;
    edUF: TLabeledEdit;
    spbExcluirPedido: TSpeedButton;
    procedure spbProdutoClick(Sender: TObject);
    procedure spbClienteClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure spbSelecionaPedidoClick(Sender: TObject);
    procedure edClienteIDExit(Sender: TObject);
    procedure edProdutoIDExit(Sender: TObject);
    procedure BtnConfirmaProdutoClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure DBGridPedidoProdutoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure tbPedidoProdutoAfterPost(DataSet: TDataSet);
    procedure tbPedidoProdutoAfterDelete(DataSet: TDataSet);
    procedure spbGravarPedidoClick(Sender: TObject);
    procedure spbExcluirPedidoClick(Sender: TObject);
    procedure DBGridPedidoProdutoDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
  private
    { Private declarations }
    Pedido: TPedidoCls;
    PedidoProduto: TPedidoProdutoCls;

    Procedure LimpaPedido;
  public
    { Public declarations }
  end;

var
  FormPedidoVenda: TFormPedidoVenda;

implementation

uses dmdatabaseWk, unBiblioGeral, unProdutoGrid, unClienteGrid, unClienteCls, unProdutoCls;

{$R *.dfm}

procedure TFormPedidoVenda.FormCreate(Sender: TObject);
begin
  inherited;
  Pedido:= TPedidoCls.Create;
  PedidoProduto:= TPedidoProdutoCls.Create;
  spbExcluirPedido.Enabled:= False;
end;

procedure TFormPedidoVenda.FormKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if (key = #27) and (FormStatus=frEdit) then
  begin
    HabilitaCampo(edProdutoID);
    DBGridPedidoProduto.Enabled:= True;
    FormStatus:= frInMemory;
    edProdutoID.Clear;
    edDescricao.Clear;
    edQuantidade.Clear;
    edValorUnitario.Clear;
    edProdutoID.SetFocus;
  end else
  if (key = #27) and (FormStatus=frShow) then
  begin
    LimpaPedido;
  end;
end;

procedure TFormPedidoVenda.FormShow(Sender: TObject);
var oField: TAggregateField;
begin
  inherited;
  if Pedido<>Nil then
  begin
    Self.Caption:= Pedido.GetConfigClass.ClassDesc;
    if Pedido.SetConfigClass then
      if Pedido.CreateMemoryTableFields(TMemoryTable(mtbPedido)) then
      begin
        if PedidoProduto<>Nil then
        begin
          if PedidoProduto.SetConfigClass then
            if PedidoProduto.CreateMemoryTableFields(TMemoryTable(tbPedidoProduto)) then
            begin
              tbPedidoProduto.Close;
              tbPedidoProduto.FieldDefs.Updated := False;
              tbPedidoProduto.FieldDefs.Update;
              with tbPedidoProduto.Aggregates.Add do
              begin
                Name:= 'TotalPedido';
                Expression := 'SUM(valortotal)';
                Active:= True;
              end;
              tbPedidoProduto.AggregatesActive := True;
              tbPedidoProduto.Open;
              lblValorPedido.Caption:= FormatFloat( '#,###,##0.00' , IIf(Empty(tbPedidoProduto.Aggregates[0].Value),0,tbPedidoProduto.Aggregates[0].Value));
            end else
              MostraMensagem('Erro - Tabela de Produto Pedido','Ocorreu um erro na criação da tabela.');
        end;
      end else
        MostraMensagem('Erro - Tabela de Pedido','Ocorreu um erro na criação da tabela.');
  end;
  edQuantidade.OnKeyPress:= NumberEditkeyPress;
  edValorUnitario.OnKeyPress:= NumberEditkeyPress;
end;

Procedure TFormPedidoVenda.LimpaPedido;
begin
  edClienteID.Clear;
  edNome.Clear;
  edDataEmissao.Date:= Date;
  ValorPedido.Clear;
  edProdutoID.Clear;
  edDescricao.Clear;
  edQuantidade.Clear;
  edValorUnitario.Clear;
  edCidade.Clear;
  edUF.Clear;
  edNumeroPedido.Clear;
  while tbPedidoProduto.RecordCount>0 do
  begin
    tbPedidoProduto.Delete;
  end;
  tbPedidoProduto.Refresh;
  spbSelecionaPedido.Visible:= True;
  spbSelecionaPedido.Enabled:= True;
  spbExcluirPedido.Visible:= True;
  spbExcluirPedido.Enabled:= False;
  edNumeroPedido.Visible:= True;

  HabilitaCampo(edClienteID);
  HabilitaCampo(edDataEmissao);
  edDataEmissao.Enabled:= True;
  spbCliente.Enabled:= True;

  HabilitaCampo(edProdutoID);
  HabilitaCampo(edQuantidade);
  HabilitaCampo(edValorUnitario);
  spbProduto.Enabled:= True;
  BtnConfirmaProduto.Enabled:= True;
  spbGravarPedido.Enabled:= True;

  lblNumeroPedido.Caption:= '000000';
  FormStatus:= frClean;
  edClienteID.SetFocus;
end;

procedure TFormPedidoVenda.edClienteIDExit(Sender: TObject);
var Cliente: TClienteCls;
    AuxSql: String;
    QryPadrao: TSQlQueryData;
begin
  inherited;
  if Trim(edClienteID.Text)<>'' then
  begin
    if StrToInt(edClienteID.Text)>0 then
    begin
      spbSelecionaPedido.Visible:= False;
      //spbSelecionaPedido.Enabled:= True;
      spbExcluirPedido.Visible:= False;
      //spbExcluirPedido.Enabled:= False;

      edNumeroPedido.Visible:= False;
      edDataEmissao.TabStop:= True;
      edDataEmissao.Enabled:= True;
      edDataEmissao.Color:= clwindow;
      edDataEmissao.Date:= Date;
      Cliente:= TClienteCls.Create;
      if Cliente.SetConfigClass then
      begin
        QryPadrao:= TSQlQueryData.Create(Self);
        AuxSql:= DoSelectClass(Cliente.GetConfigClass);
        AuxSql:= AuxSql + ' Where ClienteID = ' + Trim(edClienteID.Text);
        if dmdatabase.ExecutaSQL(AuxSql, qryPadrao) then
        begin
          if qryPadrao.RecordCount>0 then
          begin
            edNome.Text:= Trim(qryPadrao.FieldByName('Nome').AsString);
            edCidade.Text:= Trim(qryPadrao.FieldByName('Cidade').AsString);
            edUF.Text:= Trim(qryPadrao.FieldByName('UF').AsString);
          end;
        end;
        QryPadrao.Free;
      end;
    end;
  end else
  begin
    spbSelecionaPedido.Visible:= True;
    spbExcluirPedido.Visible:= True;
    spbExcluirPedido.Enabled:= False;
    edNumeroPedido.Visible:= True;
    //DesabilitaCampo(edDataEmissao);
  end;
end;

procedure TFormPedidoVenda.edProdutoIDExit(Sender: TObject);
var Produto: TProdutoCls;
    AuxSql: String;
    QryPadrao: TSQlQueryData;
begin
  inherited;
  if Trim(edProdutoID.Text)<>'' then
  begin
    if StrToInt(edProdutoID.Text)>0 then
    begin
      Produto:= TProdutoCls.Create;
      if Produto.SetConfigClass then
      begin
        QryPadrao:= TSQlQueryData.Create(Self);
        AuxSql:= DoSelectClass(Produto.GetConfigClass);
        AuxSql:= AuxSql + ' Where ProdutoID = ' + Trim(edProdutoID.Text);
        if dmdatabase.ExecutaSQL(AuxSql, qryPadrao) then
        begin
          if qryPadrao.RecordCount>0 then
          begin
            edDescricao.Text:= Trim(qryPadrao.FieldByName('descricao').AsString);
            edValorUnitario.Text := FormatFloat( '#,###,##0.00' , qryPadrao.FieldByName('prcvenda').AsFloat)
          end else
          begin
            MostraMensagem('Erro - Produto','Produto não cadastrado');
            edProdutoID.SetFocus;
          end;
          end else
          begin
            MostraMensagem('Erro - Produto','Produto não selecionado');
            edProdutoID.SetFocus;
          end;
        QryPadrao.Free;
      end;
    end;// else
  end;
end;

procedure TFormPedidoVenda.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  if Pedido<>Nil then
    Pedido.Free;
  if PedidoProduto<>Nil then
    PedidoProduto.Free;
end;

procedure TFormPedidoVenda.spbClienteClick(Sender: TObject);
begin
  inherited;
  Application.CreateForm(TFormClienteGrid, FormClienteGrid);
  FormClienteGrid.ShowModal;
end;

procedure TFormPedidoVenda.spbExcluirPedidoClick(Sender: TObject);
var Pedido: TPedidoCls;
    PedidoProdutoNovo: TPedidoProdutoCls;
    AuxSql: string;
    SQLStr: TStringList;
begin
  inherited;

  if not Confirma('Excluir Pedido?') then
    exit;

  PedidoProdutoNovo:= TPedidoProdutoCls.Create;
  AuxSql:= PedidoProdutoNovo.GetDeleteSQL;
  AuxSql:= StringReplace(AuxSql,'pedidoprodutoid','numeropedido', [rfReplaceAll]);
  AuxSql:= StringReplace(AuxSql,'0',Trim(edNumeroPedido.Text), [rfReplaceAll]);
  SQLStr:= TStringList.Create;
  SQLStr.Add(AuxSql);

  Pedido:= TPedidoCls.Create;
  Pedido.numeropedido:= StrToInt(edNumeroPedido.Text);
  AuxSql:= Pedido.GetDeleteSQL;
  SQLStr.Add(AuxSql);

  PedidoProdutoNovo.Free;
  Pedido.Free;
  if dmdatabase.ExecutaSQL(SQLStr) then
  begin
    MostraMensagem('SQL - Pedido','Pedido ' + edNumeroPedido.Text + ' excluído com sucesso.');
    LimpaPedido;
  end else
    MostraMensagem('SQL - Pedido','Erro excluindo pedido');
  SQLStr.Free
end;

procedure TFormPedidoVenda.spbGravarPedidoClick(Sender: TObject);
var Pedido: TPedidoCls;
    PedidoProdutoNovo: TPedidoProdutoCls;
    MsgValida: string;
    AuxSql: string;
    SQLStr: TStringList;
begin
  inherited;
  Pedido:= TPedidoCls.Create;
  with Pedido do
  begin
    if Trim(edClienteID.Text)<>'' then
      clienteid:= StrToInt(edClienteID.Text);;
    dataemissao:= edDataEmissao.Date;
    if Trim(ValorPedido.Text)<>'' then
      valor:= StrToFloat(ValorPedido.Text);
  end;
  MsgValida:= '';
  if Pedido.Valida(MsgValida) then
  begin
    if tbPedidoProduto.RecordCount=0 then
    begin
      MostraMensagem('Erro - Pedido','Não Há itens neste pedido');
      exit;
    end;
    SQLStr:= TStringList.Create;
    Pedido.numeropedido:= dmdatabase.CalcKey(Pedido.GetConfigClass.TableName, 'numeropedido','');
    AuxSql:= Pedido.GetInsertSQL;
    SQLStr.Add(AuxSql);
    tbPedidoProduto.First;
    while not tbPedidoProduto.Eof do
    begin
      PedidoProdutoNovo:= TPedidoProdutoCls.Create;
      with PedidoProdutoNovo do
      begin
        numeropedido:= Pedido.numeropedido;
        produtoid:= tbPedidoProduto.FieldByName('produtoid').AsInteger;
        descricao:= tbPedidoProduto.FieldByName('descricao').AsString;
        quantidade:= tbPedidoProduto.FieldByName('quantidade').AsFloat;
        valorunitario:= tbPedidoProduto.FieldByName('valorunitario').AsFloat;
        valortotal:= tbPedidoProduto.FieldByName('valortotal').AsFloat;
      end;
      AuxSql:= PedidoProdutoNovo.GetInsertSQL;
      SQLStr.Add(AuxSql);
      tbPedidoProduto.Next;
      PedidoProdutoNovo.Free;
    end;
    if dmdatabase.ExecutaSQL(SQLStr) then
    begin
      MostraMensagem('SQL - Pedido','Pedido ' + IntToStr(Pedido.numeropedido) + ' gravado com sucesso.');
      LimpaPedido;
    end else
      MostraMensagem('SQL - Pedido','Erro gravar pedido');
  end else
  begin
    MostraMensagem('Erro - Pedido',MsgValida);
    edClienteID.SetFocus;
  end;
  Pedido.Free;
end;

procedure TFormPedidoVenda.BtnConfirmaProdutoClick(Sender: TObject);
var PedidoProdutoNovo: TPedidoProdutoCls;
    MsgValida: string;
begin
  inherited;
  if Trim(edProdutoID.Text)<>'' then
  begin
    if Trim(edClienteID.Text)='' then
    begin
      MostraMensagem('Erro - Cliente', 'Cliente não selecionado');
      edClienteID.SetFocus;
      exit;
    end;
    if StrToInt(edProdutoID.Text)>0 then
    begin
      PedidoProdutoNovo:= TPedidoProdutoCls.Create;
      with PedidoProdutoNovo do
      begin
        produtoid:= StrToInt(edProdutoID.Text);
        descricao:= Trim(edDescricao.Text);
        if Trim(edQuantidade.Text)<>'' then
          quantidade:= StrToFloat(edQuantidade.Text);
        if Trim(edValorUnitario.Text)<>'' then
        valorunitario:= StrToFloat(edValorUnitario.Text);
        valortotal:= quantidade * valorunitario;
      end;
      MsgValida:= '';
      if PedidoProdutoNovo.Valida(MsgValida) then
      begin
        if (FormStatus=frEdit) then
          tbPedidoProduto.Edit
        else tbPedidoProduto.Insert;
        with PedidoProdutoNovo do
        begin
          if not (FormStatus=frEdit) then
          begin
            tbPedidoProduto.FieldByName('produtoid').AsInteger:= produtoid;
            tbPedidoProduto.FieldByName('descricao').AsString:= descricao;
          end;
          tbPedidoProduto.FieldByName('quantidade').AsFloat:= quantidade;
          tbPedidoProduto.FieldByName('valorunitario').AsFloat:= valorunitario;
          tbPedidoProduto.FieldByName('valortotal').AsFloat:= valortotal;
        end;
        tbPedidoProduto.Post;
        FormStatus:= frInMemory;
        tbPedidoProduto.Refresh;
        if (FormStatus=frEdit) then
        begin
          HabilitaCampo(edProdutoID);
          DBGridPedidoProduto.Enabled:= True;
          FormStatus:= frInMemory;
        end;
        edProdutoID.Clear;
        edDescricao.Clear;
        edQuantidade.Clear;
        edValorUnitario.Clear;
        edProdutoID.SetFocus;
      end else
      begin
        MostraMensagem('Erro - Produto',MsgValida);
        edProdutoID.SetFocus;
      end;
    end;
  end else
    MostraMensagem('Erro - Produto', 'Produto não selecionado');
end;

procedure TFormPedidoVenda.spbProdutoClick(Sender: TObject);
begin
  inherited;
  Application.CreateForm(TFormProdutoGrid, FormProdutoGrid);
  FormProdutoGrid.ShowModal;
end;

procedure TFormPedidoVenda.DBGridPedidoProdutoDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  inherited;
  if Column.Field.DataType = ftFloat then
    TFloatField(Column.Field).DisplayFormat := MascaraNumero;
end;

procedure TFormPedidoVenda.DBGridPedidoProdutoKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
var AuxMsg: string;
begin
  inherited;
  if Key = VK_RETURN then
  begin
    edProdutoID.Text:= tbPedidoProduto.FieldByName('produtoid').AsString;
    edDescricao.Text:= tbPedidoProduto.FieldByName('descricao').AsString;
    edQuantidade.Text:= tbPedidoProduto.FieldByName('quantidade').AsString;
    edValorUnitario.Text:= tbPedidoProduto.FieldByName('valorunitario').AsString;
    DesabilitaCampo(edProdutoID);
    //DBGridPedidoProduto.Enabled:= False;
    FormStatus:= frEdit;
    key:= 0;
    edQuantidade.SetFocus;
  end else
  if Key = VK_DELETE then
  begin
    AuxMsg:= 'Excluir o item :' + #13 +
      'Produto ID: ' + tbPedidoProduto.FieldByName('produtoid').AsString + ' - ' +
      'Descrição: ' + tbPedidoProduto.FieldByName('descricao').AsString + ' - ' +
      'Quantidade: ' + tbPedidoProduto.FieldByName('quantidade').AsString + ' - ' +
      'Valor Unitario: ' + tbPedidoProduto.FieldByName('valorunitario').AsString + ' - ' +
      'Valor Tota: ' + tbPedidoProduto.FieldByName('valortotal').AsString;
    if Confirma(AuxMsg) then
    begin
      tbPedidoProduto.Delete;
      tbPedidoProduto.Refresh;
    end;
    key:= 0;
  end;
end;

procedure TFormPedidoVenda.spbSelecionaPedidoClick(Sender: TObject);
var AuxSql: String;
   QryPadrao: TSQlQueryData;
begin
  inherited;
  AuxSql:= DoSelectClass(Pedido.GetConfigClass);
  AuxSql:= AuxSql + ' Where numeropedido = ' + Trim(edNumeroPedido.Text);
  //MostraMensagem('SQLSelect - Tabela de Pedido',AuxSql);
  QryPadrao:= TSQlQueryData.Create(Self);
  if dmdatabase.ExecutaSQL(AuxSql, qryPadrao) then
  begin
    if qryPadrao.RecordCount>0 then
    begin
      edClienteID.Text:= Trim(qryPadrao.FieldByName('clienteid').AsString);
      edNome.Text:= Trim(qryPadrao.FieldByName('Nome').AsString);
      edDataEmissao.Date:= qryPadrao.FieldByName('dataemissao').AsDateTime;
      ValorPedido.Text:= FormatFloat( '#,###,##0.00' , qryPadrao.FieldByName('valor').AsFloat);
      lblNumeroPedido.Caption:= FormatFloat( '000000' , qryPadrao.FieldByName('numeropedido').AsFloat);
      edCidade.Text:= Trim(qryPadrao.FieldByName('Cidade').AsString);
      edUF.Text:= Trim(qryPadrao.FieldByName('UF').AsString);
    end else
    begin
      MostraMensagem('Erro - Tabela de Pedido','Pedido não existe.');
      exit;
    end;
  end;
  AuxSql:= DoSelectClass(PedidoProduto.GetConfigClass);
  AuxSql:= AuxSql + ' Where numeropedido = ' + Trim(edNumeroPedido.Text);
  if dmdatabase.ExecutaSQL(AuxSql, qryPadrao) then
  begin
    if qryPadrao.RecordCount>0 then
    begin
      qryPadrao.First;
      while not qryPadrao.Eof do
      begin
        tbPedidoProduto.Insert;
        tbPedidoProduto.FieldByName('produtoid').AsInteger:= qryPadrao.FieldByName('produtoid').AsInteger;
        tbPedidoProduto.FieldByName('descricao').AsString:= Trim(qryPadrao.FieldByName('descricao').AsString);
        tbPedidoProduto.FieldByName('quantidade').AsFloat:= qryPadrao.FieldByName('quantidade').AsFloat;
        tbPedidoProduto.FieldByName('valorunitario').AsFloat:= qryPadrao.FieldByName('valorunitario').AsFloat;
        tbPedidoProduto.FieldByName('valortotal').AsFloat:= qryPadrao.FieldByName('valortotal').AsFloat;
        tbPedidoProduto.Post;
        qryPadrao.Next;
      end;
      tbPedidoProduto.Refresh;
    end;
  end;
  QryPadrao.Free;
  DesabilitaCampo(edClienteID);
  DesabilitaCampo(edDataEmissao);
  edDataEmissao.Enabled:= False;
  spbCliente.Enabled:= False;

  DesabilitaCampo(edProdutoID);
  DesabilitaCampo(edQuantidade);
  DesabilitaCampo(edValorUnitario);
  spbProduto.Enabled:= False;
  BtnConfirmaProduto.Enabled:= False;
  spbGravarPedido.Enabled:= False;
  spbExcluirPedido.Visible:= True;
  spbExcluirPedido.Enabled:= True;
  spbSelecionaPedido.Enabled:= False;

  FormStatus:= frShow;
end;

procedure TFormPedidoVenda.tbPedidoProdutoAfterDelete(DataSet: TDataSet);
begin
  inherited;
  lblValorPedido.Caption:= FormatFloat( '#,###,##0.00' , IIf(Empty(tbPedidoProduto.Aggregates[0].Value),0,tbPedidoProduto.Aggregates[0].Value));
  ValorPedido.Text:= lblValorPedido.Caption;
end;

procedure TFormPedidoVenda.tbPedidoProdutoAfterPost(DataSet: TDataSet);
begin
  inherited;
  lblValorPedido.Caption:= FormatFloat( '#,###,##0.00' , IIf(Empty(tbPedidoProduto.Aggregates[0].Value),0,tbPedidoProduto.Aggregates[0].Value));
  ValorPedido.Text:= lblValorPedido.Caption;
end;

end.
