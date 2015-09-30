unit get_p79_errors;

interface

uses kernel;

procedure BoxGetP79Errors;
procedure ShowGetP79Errors;

var
  mpeP79Errors: array[0..CANALS-1] of word;

implementation

uses SysUtils, soutput, support, realz, borders, box;

const
  quGetP79Errors:   querys = (Action: acGetP79Errors; cwOut: 8; cwIn: 5+64*2+2; bNumber: $FF);

procedure QueryGetP79Errors;
begin
  InitPushCRC;
  Push(98);
  Query(quGetP79Errors);
end;

procedure BoxGetP79Errors;
begin
  QueryGetP79Errors;
end;
                          
procedure ShowGetP79Errors;
var
  c:  word;
  s:  string;
begin
  Stop;

  InitPopCRC;
  for c := 0 to CANALS-1 do mpeP79Errors[c] := PopInt;

  AddInfo('');    
  AddInfo('Статистика опроса счетчиков на начало суток');

  for c := 0 to CANALS-1 do if CanalChecked(c) then begin
    s := PackStrR('канал '+IntToStr(c+1),GetColWidth);
    s := s + PackStrR(IntToStr(mpeP79Errors[c]),GetColWidth);
    AddInfo(s);
  end;

  BoxRun;
end;

end.
