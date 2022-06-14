////////////////////////////////////////////////////////////////////////////////
// Módulo          : Formulário Padrão Base do Sistema (Será Herdado)
// Tipo            : 0 = Principal; 1 = Grid; 2 = Editar; 3 = Pesquisa/Filtro
// Data da Versão  : 11/06/2022 - 00:00:01
// Analista        : Adriano L. de Mendonça Soares
////////////////////////////////////////////////////////////////////////////////

unit unFormModelo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, unModelCls, Vcl.StdCtrls;

type
  TFormModelo = class(TForm)
    panClient: TPanel;
    panBottlon: TPanel;
    lblEscape: TLabel;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  protected
    FormStatus: TFormStatus;
    DesabledColor: TColor;
  public
    { Public declarations }
    procedure NumberEditkeyPress(Sender: TObject; var Key: Char);
    Procedure HabilitaCampo(sNomeCampo: String); overload;
    Procedure HabilitaCampo(sComponent: TComponent); overload;
    Procedure DesabilitaCampo(sNomeCampo: String); overload;
    Procedure DesabilitaCampo(sComponent: TComponent); overload;
  end;

var
  FormModelo: TFormModelo;

implementation

uses unBiblioGeral;

{$R *.dfm}

procedure TFormModelo.FormCreate(Sender: TObject);
begin
  FormStatus:= frClean;
  DesabledColor:= clMoneyGreen; //clSkyBlue;
end;

procedure TFormModelo.FormKeyPress(Sender: TObject; var Key: Char);
begin
  If (key = #13) and (FormStatus in [frEdit]) then
  begin
    Key:= #0;
    exit;
  end;
  If (key = #13) then // and not (FormStatus in [frEdit]) then
  Begin
    Key:= #0;
    Perform(Wm_NextDlgCtl,0,0);
  end else
    if (key = #27) then
    begin
      if (FormStatus in [frInMemory, frShow, frEdit]) then
      begin
        if Confirma('Fechar Formulário ?') then
          close;
      end else
        close;
    end;
end;

procedure TFormModelo.NumberEditkeyPress(Sender: TObject; var Key: Char);
var
  fs : TFormatSettings;
begin
  fs := TFormatSettings.Create();
  if (Key In ['0'..'9', #8, fs.DecimalSeparator, #13, #27]) Then // #8 = backspace
  begin
    inherited;
  end else
    Key := #0;
end;

Procedure TFormModelo.HabilitaCampo(sNomeCampo: String);
var
  Component: TComponent;
  CompName: string;
begin
  if sNomeCampo='' then
    exit;
  CompName:= sNomeCampo;
  Component:= Nil;
  Component:= FindComponent(CompName);
  if Component<>Nil then
  begin
    HabilitaCampo(Component);
    Self.Refresh;
  end;
end;

Procedure TFormModelo.HabilitaCampo(sComponent: TComponent);
begin
  if sComponent<>Nil then
    if assigned(sComponent) then
    begin
      if (sComponent is TLabeledEdit) then
        (sComponent as TLabeledEdit).Color:= clwindow
      else if (sComponent is TCustomEdit) then
      begin
        //(sComponent as TCustomEdit).Color:= clDefault;
        (sComponent as TCustomEdit).TabStop:= True;
        (sComponent as TCustomEdit).ReadOnly:= False;
      end;
    end;
end;

Procedure TFormModelo.DesabilitaCampo(sNomeCampo: String);
var
  Component: TComponent;
  CompName: string;
begin
  if sNomeCampo='' then
    exit;
  CompName:= sNomeCampo;
  Component:= Nil;
  Component:= FindComponent(CompName);
  if Component<>Nil then
  begin
    DesabilitaCampo(Component);
    Self.Refresh;
  end;
end;

Procedure TFormModelo.DesabilitaCampo(sComponent: TComponent);
begin
  if sComponent<>Nil then
    if assigned(sComponent) then
    begin
      if (sComponent is TLabeledEdit) then
        (sComponent as TLabeledEdit).Color:= DesabledColor
      else if (sComponent is TCustomEdit) then
      begin
        //(sComponent as TCustomEdit).Color:= DesabledColor;
        (sComponent as TCustomEdit).TabStop:= False;
        (sComponent as TCustomEdit).ReadOnly:= True;
      end;

    end;
end;



end.
