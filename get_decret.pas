unit get_decret;

interface

procedure BoxGetDecret;
procedure ShowGetDecret;

implementation

uses SysUtils, soutput, support, box, timez;

const
  quGetDecret:  querys = (Action: acGetDecret; cwOut: 7+1; cwIn: 5+15+2; bNumber: $FF);

procedure QueryGetDecret;
begin
  InitPushCRC;
  Push(105);
  Query(quGetDecret);
end;

procedure BoxGetDecret;
begin
  QueryGetDecret;
end;

function GetDecret2Str: string;
var
  i:  byte;
begin
  i := Pop();
  case i of
    0:  Result := '���';
    1:  Result := '��������������';
    2:  Result := '�����������';
    else  Result := '?';
  end;
  Result := IntToStr(i) + ' - ' + Result;
end;

procedure ShowGetDecret;
begin
  Stop;
  InitPopCRC();

  AddInfo('');
  AddInfo('������� �� ������/������ �����');
  AddInfo('��� ��������:                         '+GetDecret2Str);
  AddInfo('���� �������� �� ������ �����:        '+PopTimes2Str);
  AddInfo('���������� ��������� �� ������ �����: '+IntToStr(Pop));
  AddInfo('���� �������� �� ������ �����:        '+PopTimes2Str);
  AddInfo('���������� ��������� �� ������ �����: '+IntToStr(Pop));

  BoxRun;
end;

end.
