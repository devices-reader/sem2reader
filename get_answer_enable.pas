unit get_answer_enable;

interface

procedure BoxGetAnswerEnable;
procedure ShowGetAnswerEnable;

implementation

uses SysUtils, soutput, support, box;

const
  quGetAnswerEnable:   querys = (Action: acGetAnswerEnable; cwOut: 7; cwIn: 5+2+2; bNumber: 231);

procedure QueryGetAnswerEnable;
begin
  Query(quGetAnswerEnable);
end;

procedure BoxGetAnswerEnable;
begin
  AddInfo('Отмена запрета ответа на запросы во время опроса цифровых счетчиков');
  QueryGetAnswerEnable;
end;

procedure ShowGetAnswerEnable;
begin
  Stop;

  AddInfo('ОК');

  BoxRun;
end;

end.
