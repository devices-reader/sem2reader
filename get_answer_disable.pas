unit get_answer_disable;

interface

procedure BoxGetAnswerDisable;
procedure ShowGetAnswerDisable;

implementation

uses SysUtils, soutput, support, box, timez;

const
  quGetAnswerDisable:   querys = (Action: acGetAnswerDisable; cwOut: 7+1; cwIn: 5+22+2; bNumber: $FF);

procedure QueryGetAnswerDisable;
begin
  InitPushCRC;
  Push(101);
  Query(quGetAnswerDisable);
end;

procedure BoxGetAnswerDisable;
begin
  QueryGetAnswerDisable;
end;

procedure ShowGetAnswerDisable;
begin
  Stop;
  InitPop(5);

  AddInfo('');
  AddInfo('���������� ������� ������ �� ������� �� ����� ������ �������� ���������');
  AddInfo('���� �������:                         ' + PopBool2Str);
  AddInfo('������ ���������� ������:             ' + PopBool2Str);
  AddInfo('���������� ����������:                ' + IntToStr(PopLong));
  AddInfo('���� ���������� ����������:           ' + PopTimes2Str);
  AddInfo('���������� ����������:                ' + IntToStr(PopLong));
  AddInfo('���� ���������� ����������:           ' + PopTimes2Str);

  BoxRun;
end;

end.
