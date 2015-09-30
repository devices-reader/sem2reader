unit get_start;

interface

procedure BoxGetStart;
procedure ShowGetStart;

implementation

uses SysUtils, soutput, support, box, timez;

const
  quGetStart:   querys = (Action: acGetStart; cwOut: 7+1; cwIn: 5+19+2; bNumber: $FF);

procedure QueryGetStart;
begin
  InitPushCRC;
  Push(106);
  Query(quGetStart);
end;

procedure BoxGetStart;
begin
  QueryGetStart;
end;

procedure ShowGetStart;
begin
  Stop;
  InitPopCRC();

  AddInfo('');
  AddInfo('Cтатистика выключения/включения');
  AddInfo('Дата запуска:                       '+PopTimes2Str);
  AddInfo('Дата последнего выключения питания: '+PopTimes2Str);
  AddInfo('Дата последнего включения питания:  '+PopTimes2Str);
  AddInfo('Количество выключений питания:      '+IntToStr(Pop));

  BoxRun;
end;

end.
