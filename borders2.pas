unit borders2;

interface

function TestParams: boolean;
function TestShifts: boolean;
function GetParamName(i: byte): string;

implementation

uses SysUtils, kernel, main, support;

type
  param_map = record
    ibLine:     byte;
    stName:     string;
  end;

const
  mpParamsMap:    array[0..DEVICES_LINES-1] of param_map =
  (
    (ibLine: 0;  stName: 'нет'),
    (ibLine: 10; stName: 'P, Вт всего'),
    (ibLine: 11; stName: 'P, Вт фаза 1'),
    (ibLine: 12; stName: 'P, Вт фаза 2'),
    (ibLine: 13; stName: 'P, Вт фаза 3'),

    (ibLine: 20; stName: 'Q, ВАР всего'),
    (ibLine: 21; stName: 'Q, ВАР фаза 1'),
    (ibLine: 22; stName: 'Q, ВАР фаза 2'),
    (ibLine: 23; stName: 'Q, ВАР фаза 3'),

    (ibLine: 30; stName: 'S, ВА всего'),
    (ibLine: 31; stName: 'S, ВА фаза 1'),
    (ibLine: 32; stName: 'S, ВА фаза 2'),
    (ibLine: 33; stName: 'S, ВА фаза 3'),

    (ibLine: 40; stName: 'U, В всего'),
    (ibLine: 41; stName: 'U, В фаза 1'),
    (ibLine: 42; stName: 'U, В фаза 2'),
    (ibLine: 43; stName: 'U, В фаза 3'),

    (ibLine: 50; stName: 'I, мА всего'),
    (ibLine: 51; stName: 'I, мА фаза 1'),
    (ibLine: 52; stName: 'I, мА фаза 2'),
    (ibLine: 53; stName: 'I, мА фаза 3'),

    (ibLine: 60; stName: 'cos Ф всего'),
    (ibLine: 61; stName: 'cos Ф фаза 1'),
    (ibLine: 62; stName: 'cos Ф фаза 2'),
    (ibLine: 63; stName: 'cos Ф фаза 3'),

    (ibLine: 70; stName: 'f, Гц всего'),
    (ibLine: 71; stName: 'f, Гц фаза 1'),
    (ibLine: 72; stName: 'f, Гц фаза 2'),
    (ibLine: 73; stName: 'f, Гц фаза 3')
  );

function TestParams: boolean;
begin
  with frmMain do begin
    Result := False;

    if (updParamMin.Position < 1) or (updParamMin.Position > 500) then begin ErrBox('Начальный номер параметра должен быть задан в диапазоне 1..500 !'); exit; end;
    if (updParamMax.Position < 1) or (updParamMax.Position > 500) then begin ErrBox('Конечный номер параметра должен быть задан в диапазоне 1..500 !'); exit; end;
    if (updParamMax.Position <= updParamMin.Position) then begin ErrBox('Конечный номер параметра должен быть больше начального !'); exit; end;

    Result := True;
  end;
end;

function TestShifts: boolean;
begin
  with frmMain do begin
    Result := False;

    if (updParamMin.Position > 480-1) then begin ErrBox('Начальный номер интервала должен быть задан в диапазоне 0..479 !'); exit; end;
    if (updParamMax.Position > 480-1) then begin ErrBox('Конечный номер интервала должен быть задан в диапазоне 0..479 !'); exit; end;
    if (updParamMax.Position <= updParamMin.Position) then begin ErrBox('Конечный номер интервала должен быть больше начального !'); exit; end;

    Result := True;
  end;
end;

function GetParamName(i: byte): string;
var
  j: byte;
begin
  Result := mpParamsMap[0].stName;
  for j := 0 to DEVICES_LINES-1 do begin
    if (mpParamsMap[j].ibLine = i) then Result := mpParamsMap[j].stName;
  end;
end;

end.
