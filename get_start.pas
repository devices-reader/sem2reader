unit get_start;

interface

uses timez;

procedure BoxGetStart;
procedure ShowGetStart;

var
  tiStart: times;
  tiPowerOff: times;
  tiPowerOn: times;

implementation

uses SysUtils, soutput, support, box;

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

  tiStart := PopTimes;
  AddInfo('Дата запуска:                       '+Times2Str(tiStart));

  tiPowerOff := PopTimes;
  AddInfo('Дата последнего выключения питания: '+Times2Str(tiPowerOff));

  tiPowerOn := PopTimes;
  AddInfo('Дата последнего включения питания:  '+Times2Str(tiPowerOn));

  AddInfo('Количество выключений питания:      '+IntToStr(Pop));

  BoxRun;
end;

end.
