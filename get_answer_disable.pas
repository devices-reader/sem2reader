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
  AddInfo('—татистика запрета ответа на запросы во врем€ опроса цифровых счетчиков');
  AddInfo('флаг запрета:                         ' + PopBool2Str);
  AddInfo('статус разрешени€ ответа:             ' + PopBool2Str);
  AddInfo('количество запрещений:                ' + IntToStr(PopLong));
  AddInfo('дата последнего запрещени€:           ' + PopTimes2Str);
  AddInfo('количество разрешений:                ' + IntToStr(PopLong));
  AddInfo('дата последнего разрешени€:           ' + PopTimes2Str);

  BoxRun;
end;

end.
