unit get_overflow_hou;

interface

uses kernel;

procedure BoxGetOverflowHou;
procedure ShowGetOverflowHou;

var
  mpcwOveflowHou: array[0..CANALS-1] of word;

implementation

uses SysUtils, soutput, support, borders, box;

const
  quGetOverflowHou:   querys = (Action: acGetOverflowHou; cwOut: 7+1; cwIn: 5+2*64+2; bNumber: $FF);

procedure QueryGetOverflowHou;
begin
  InitPushCRC;
  Push(103);
  Query(quGetOverflowHou);
end;

procedure BoxGetOverflowHou;
begin
  if TestCanals then
    QueryGetOverflowHou;
end;

procedure ShowGetOverflowHou;
var
  Can:  word;
  s:    string;
begin
  Stop;

  InitPopCRC;

  for Can := 0 to CANALS-1 do mpcwOveflowHou[Can] := PopInt;

  AddInfo('');
  AddInfo('Cтатистика переполнения получасовых графиков');
  for Can := 0 to CANALS-1 do if CanalChecked(Can) then begin
    s := PackStrR('канал '+IntToStr(Can+1),GetColWidth);
    s := s + PackStrR(IntToStr(mpcwOveflowHou[Can]),GetColWidth);
    AddInfo(s);
  end;

  BoxRun;
end;

end.
