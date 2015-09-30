unit get_gaps3;

interface

procedure BoxGetGaps3;
procedure ShowGetGaps3;

implementation

uses SysUtils, soutput, support, progress, box, timez;

const
  quGetGaps3:  querys = (Action: acGetGaps3; cwOut: 7+2; cwIn: 15+48*2+2; bNumber: 150);

var
  mpGapsE,mpGapsP:     array[0..48-1] of byte;

procedure QueryGetGaps3;
begin
  Query(quGetGaps3);
end;

procedure BoxGetGaps3;
begin
  AddInfo('');
  AddInfo('*Тарифы на текущие сутки');

  QueryGetGaps3;
end;

procedure ShowGetGaps3;
var
  i:  byte;
  s:string;
begin
  Stop;
  InitPop(15);

  for i := 0 to 48-1 do mpGapsP[i] := Pop;
  for i := 0 to 48-1 do mpGapsE[i] := Pop;

  AddInfo(PackStrR('',GetColWidth) + PackStrR('мощность',GetColWidth) + PackStrR('энергия',GetColWidth));
  for i := 0 to 48-1 do begin
    s := PackStrR(Int2Str(i div 2)+':'+Int2Str((i mod 2)*30),GetColWidth);
    s := s + PackStrR(IntToStr(mpGapsP[i]+1),GetColWidth);
    s := s + PackStrR(IntToStr(mpGapsE[i]+1),GetColWidth);
    AddInfo(s);
  end;

  RunBox;
end;

end.
