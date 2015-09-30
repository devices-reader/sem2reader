unit get_queryFF19;

interface

procedure BoxGetQueryFF19;
procedure ShowGetQueryFF19;

implementation

uses SysUtils, soutput, support, realz, timez, borders, kernel, box;

const
  quGetQueryFF19:   querys = (Action: acGetQueryFF19; cwOut: 7+9; cwIn: 0; bNumber: $FF);

procedure QueryGetQueryFF19;
begin
  InitPushCRC;
  Push($19);
  if PushCanMask then Query(quGetQueryFF19);
end;

procedure BoxGetQueryFF19;
begin
  if TestCanals then
    QueryGetQueryFF19;
end;
                          
procedure ShowGetQueryFF19;
var
  Can:  byte;
  s:    string;
begin
  Stop;
  InitPop(15 + 10);

  AddInfo('');
  AddInfo('Запрос 0xFF19 (значения времени опроса счётчиков из буфера');
  for Can := 0 to CANALS-1 do if CanalChecked(Can) then begin
    s := PackStrR('канал '+IntToStr(Can+1),GetColWidth);
    s := s + PackStrR(PopTimes2Str,GetColWidth*2);
    s := s + PackStrR(PopTimes2Str,GetColWidth*2);
    AddInfo(s);
  end;

  BoxRun;    
end;

end.

