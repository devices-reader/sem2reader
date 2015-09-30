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
    0:  Result := 'нет';
    1:  Result := 'автоматический';
    2:  Result := 'специальный';
    else  Result := '?';
  end;
  Result := IntToStr(i) + ' - ' + Result;
end;

procedure ShowGetDecret;
begin
  Stop;
  InitPopCRC();

  AddInfo('');
  AddInfo('Переход на летнее/зимнее время');
  AddInfo('Тип перехода:                         '+GetDecret2Str);
  AddInfo('Дата перехода на летнее время:        '+PopTimes2Str);
  AddInfo('Количество переходов на летнее время: '+IntToStr(Pop));
  AddInfo('Дата перехода на зимнее время:        '+PopTimes2Str);
  AddInfo('Количество переходов на зимнее время: '+IntToStr(Pop));

  BoxRun;
end;

end.
