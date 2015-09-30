unit get_time;

interface

uses timez;

procedure BoxGetTime1;
procedure BoxGetTime2;
procedure ShowGetTime1;
procedure ShowGetTime2;

implementation

uses SysUtils, soutput, support, box, calendar;

const
  quGetTime1:   querys = (Action: acGetTime1; cwOut: 7; cwIn: 5+6+2; bNumber: 1);
  quGetTime2:   querys = (Action: acGetTime2; cwOut: 7; cwIn: 5+6+2; bNumber: 1);
  
procedure QueryGetTime1;
begin
  Query(quGetTime1);
end;

procedure QueryGetTime2;
begin
  Query(quGetTime2);
end;

procedure BoxGetTime1;
begin
  QueryGetTime1;
end;

procedure BoxGetTime2;
begin
  QueryGetTime2;
end;

procedure ShowGetTime1;

begin
  Stop;
  InitPopCRC;

  AddInfo('');
  AddInfo('Текущее время');

  tiCurr := PopTimes;
  AddInfo('Время сумматора:       ' + Times2Str(tiCurr));
  AddInfo('');
  AddInfo('Время компьютера:      ' + Times2Str(ToTimes(Now)));
  AddInfo('Разница:               ' + DeltaTimes2Str(tiCurr,ToTimes(Now)));
  
  BoxRun;
end;

procedure ShowGetTime2;
var
  tiCurr: times;
begin
  Stop;
  InitPopCRC;

  AddInfo('');
  AddInfo('Текущее время');

  tiCurr := PopTimes;
  AddInfo('Время сумматора:       ' + Times2Str(tiCurr));
  AddInfo('');
  AddInfo('Время компьютера:      ' + Times2Str(ToTimes(Now)));
  AddInfo('Разница:               ' + DeltaTimes2Str(tiCurr,ToTimes(Now)));

  BoxRun;
end;

end.
