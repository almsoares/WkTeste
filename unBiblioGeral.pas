////////////////////////////////////////////////////////////////////////////////
// Módulo          : Funções e Procedimentos Diversos
//
// Data da Versão  : 11/06/2022 - 00:00:01
// Analista        : Adriano L. de Mendonça Soares
////////////////////////////////////////////////////////////////////////////////

unit unBiblioGeral;

interface

uses
  System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  System.Variants, System.StrUtils;

const
  MascaraNumero: string = '###,###,##0.00';

Procedure FreeObjects(const strings: TStrings) ;
Procedure FreeStringList(var ObjStringList: TStringList);

procedure MostraMensagem(Titulo, Msg: String);
function Confirma(Msg: String): Boolean;

Function IIf(pCond:Boolean;pTrue,pFalse:Variant): Variant;

Function VarToSql(const pValue: Variant;
  pDateTimeFormat: string = 'DD/MM/YYYY HH:nn:ss';  // 'dd.mm.yyyy hh:nn:ss:zzz'; //'YYYY/MM/DD';
  pTrimToNull: Boolean = True; pQuoteDate: Boolean = True; pQuoteDateChar: Char = '''';
  pNullString: string = 'NULL'): string;

Function AnoMesDiaB(sData: Tdate): string;

Function Empty(Value: Variant): Boolean;

implementation

uses unModelCls;

//------------------------------------------------------------------------------
// Liberar objetos alocados em TStringList
Procedure FreeObjects(const strings: TStrings) ;
var idx : integer;
begin
  for idx := 0 to Pred(strings.Count) do
  begin
    if strings.Objects[idx]<>Nil then
    begin
      strings.Objects[idx].Free;
      strings.Objects[idx] := nil;
    end;
  end;
end;

Procedure FreeStringList(var ObjStringList: TStringList);
begin
  if ObjStringList is TStringList then
    try
      if Assigned(ObjStringList) then
        if ObjStringList<>Nil then
        begin
          FreeObjects(ObjStringList);
          ObjStringList.Free;
        end;
    finally
      ObjStringList:= Nil;
    end;
end;

//------------------------------------------------------------------------------
//Substitui o ShowMessage
procedure MostraMensagem(Titulo, Msg: String);
begin
  with CreateMessageDialog(Msg, mtInformation, [mbOk]) do
  try
    Caption := Titulo; //'Importante - Informação';
    ShowModal;
  finally
    Free
  end;
end;

//------------------------------------------------------------------------------
// exibe uma caixa de dialogo pedindo a confirmação (SIM - NÃO)
function Confirma(Msg: String): Boolean;
var i : Integer;
    f : TForm;
begin
    f:= CreateMessageDialog(Msg,MtConfirmation,[mbYes,mbNo]);
    try
      for i:=0 to f.ComponentCount -1 do
      begin
        if f.Components[i] is TButton then
          with TButton(f.Components[i]) do
            case modalresult of
              mrYes: Caption := '&Sim';
              mrNo: Caption := '&Não';
            end;
      end;
      f.Caption := 'Confirmação';
      Result := f.ShowModal = mrYes;
    finally
      f.Free;
    end;
end;


//------------------------------------------------------------------------------
// Avaliador de condições
Function IIf(pCond:Boolean;pTrue,pFalse:Variant): Variant;
begin
  If pCond Then Result := pTrue
  else Result := pFalse;
end;


function VarIsBool(const V: Variant): Boolean;
begin
  Result := (TVarData(V).vType and varTypeMask) = varboolean;
end;

Function VarToSql(const pValue: Variant; pDateTimeFormat: string; pTrimToNull: Boolean;
  pQuoteDate: Boolean; pQuoteDateChar: Char; pNullString: string): string;
var
  FDecimalSeparatorOld: Char;
  FValue              : Variant;
begin
  FValue := pValue;
  if pNullString.Trim.IsEmpty then
    pNullString := 'NULL';
  case AnsiIndexText(VarTypeAsText(VarType(FValue)), ['FMTBcdVariantType']) of
    0:
      FValue := VarAsType(FValue, varDouble);
    // poderão ser adicionados mais tipos específicos
  end;

  // varBoolean
  if VarIsBool(FValue) then
  begin
     Result := IfThen(FValue, 'True', 'False');
  end else
  // varSmallInt, varInteger, varShortInt, varByte, varWord, varLongWord, varInt64, varUInt64
  if VarIsOrdinal(FValue) then
  begin
     Result := VarToStr(FValue);
  end else
  // varSingle, varDouble, varCurrency
  if VarIsFloat(FValue) then
  begin
    with FormatSettings do
    begin
      FDecimalSeparatorOld := DecimalSeparator;
      DecimalSeparator := '.';
      Result := FloatToStr(Float(FValue), FormatSettings);
      DecimalSeparator := FDecimalSeparatorOld;
    end;
  end else
  // varOleStr, varString, varUString
  if VarIsStr(FValue) then
  begin
    Result := QuotedStr(FValue);
  end else
  // varDate
  if VarIsType(FValue, varDate) then
  begin
    if FValue>0 then
      Result := IfThen(pQuoteDate, AnsiQuotedStr(FormatDateTime(pDateTimeFormat,
                VarToDateTime(FValue)), pQuoteDateChar),
                FormatDateTime(pDateTimeFormat, VarToDateTime(FValue)))
    else Result := '';
  end;
  // Trocar valor Null por string "Null"
  if ((VarIsClear(FValue)) or (VarIsNull(FValue)) or
      (VarIsEmpty(FValue)) or (VarIsError(FValue))) then
    Result := pNullString;
  // Trocar vazio por string "Null"
  if pTrimToNull then
    if (Result.Trim.IsEmpty) or (Result.DeQuotedString.Trim.IsEmpty) then
      Result := pNullString;
end;

//------------------------------------------------------------------------------
// Formatar a Data em AAAA/MM/DD
Function AnoMesDiaB(sData: Tdate): string;
//var DataStr : string;
begin
  //DataStr := DateToStr(sData);
  //result := copy(DataStr,7,4) + '/' + copy(DataStr,4,2) + '/' + copy(DataStr,1,2) ;
  result := FormatDateTime('YYYY/MM/DD', sData);
end;

//------------------------------------------------------------------------------
// Verificar se variável está vazia
Function Empty(Value: Variant): Boolean;
var
  VariantType: tvartype;
begin
  VariantType := VarType(Value);

  Result := False;

  case VarType(Value) of
    varEmpty,
    varNull     :  Result := True;

    varSmallInt,
    varInteger,
    varShortInt,
    varByte,
    varWord,
    varInt64    :  Result := (Value = 0);

    varSingle,
    varDouble,
    varCurrency :  Result := (Value = 0.00);

    //varBoolean	:  Result := not Value;

    varDate     :  Result := (Value = 0);

    varOleStr,
    varString   :  Result := (Value = '');
  end;
end;

end.
