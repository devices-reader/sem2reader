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
    (ibLine: 0;  stName: '���'),
    (ibLine: 10; stName: 'P, �� �����'),
    (ibLine: 11; stName: 'P, �� ���� 1'),
    (ibLine: 12; stName: 'P, �� ���� 2'),
    (ibLine: 13; stName: 'P, �� ���� 3'),

    (ibLine: 20; stName: 'Q, ��� �����'),
    (ibLine: 21; stName: 'Q, ��� ���� 1'),
    (ibLine: 22; stName: 'Q, ��� ���� 2'),
    (ibLine: 23; stName: 'Q, ��� ���� 3'),

    (ibLine: 30; stName: 'S, �� �����'),
    (ibLine: 31; stName: 'S, �� ���� 1'),
    (ibLine: 32; stName: 'S, �� ���� 2'),
    (ibLine: 33; stName: 'S, �� ���� 3'),

    (ibLine: 40; stName: 'U, � �����'),
    (ibLine: 41; stName: 'U, � ���� 1'),
    (ibLine: 42; stName: 'U, � ���� 2'),
    (ibLine: 43; stName: 'U, � ���� 3'),

    (ibLine: 50; stName: 'I, �� �����'),
    (ibLine: 51; stName: 'I, �� ���� 1'),
    (ibLine: 52; stName: 'I, �� ���� 2'),
    (ibLine: 53; stName: 'I, �� ���� 3'),

    (ibLine: 60; stName: 'cos � �����'),
    (ibLine: 61; stName: 'cos � ���� 1'),
    (ibLine: 62; stName: 'cos � ���� 2'),
    (ibLine: 63; stName: 'cos � ���� 3'),

    (ibLine: 70; stName: 'f, �� �����'),
    (ibLine: 71; stName: 'f, �� ���� 1'),
    (ibLine: 72; stName: 'f, �� ���� 2'),
    (ibLine: 73; stName: 'f, �� ���� 3')
  );

function TestParams: boolean;
begin
  with frmMain do begin
    Result := False;

    if (updParamMin.Position < 1) or (updParamMin.Position > 500) then begin ErrBox('��������� ����� ��������� ������ ���� ����� � ��������� 1..500 !'); exit; end;
    if (updParamMax.Position < 1) or (updParamMax.Position > 500) then begin ErrBox('�������� ����� ��������� ������ ���� ����� � ��������� 1..500 !'); exit; end;
    if (updParamMax.Position <= updParamMin.Position) then begin ErrBox('�������� ����� ��������� ������ ���� ������ ���������� !'); exit; end;

    Result := True;
  end;
end;

function TestShifts: boolean;
begin
  with frmMain do begin
    Result := False;

    if (updParamMin.Position > 480-1) then begin ErrBox('��������� ����� ��������� ������ ���� ����� � ��������� 0..479 !'); exit; end;
    if (updParamMax.Position > 480-1) then begin ErrBox('�������� ����� ��������� ������ ���� ����� � ��������� 0..479 !'); exit; end;
    if (updParamMax.Position <= updParamMin.Position) then begin ErrBox('�������� ����� ��������� ������ ���� ������ ���������� !'); exit; end;

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
