unit get_current4;

interface

procedure BoxGetCurrent4;
procedure ShowGetCurrent4;

implementation

uses SysUtils, soutput, support, box;

const
  quGetCurrent4:   querys = (Action: acGetCurrent4; cwOut: 7+1; cwIn: 5+1+64*2+64*2+2; bNumber: $FF);

var
  mpwCurrent40:  array[0..64-1] of word;
  mpwCurrent41:  array[0..64-1] of word;

procedure QueryGetCurrent4;
begin
  InitPushCRC;
  Push(108);
  Query(quGetCurrent4);
end;

procedure BoxGetCurrent4;
begin
  QueryGetCurrent4;
end;

procedure ShowGetCurrent4;
var
  s:  string;
  i:  byte;
begin
  Stop;
  InitPop(5);

  AddInfo('');
  AddInfo('Статистика трехминутного опроса 2');

  AddInfo('');
  AddInfo('Флаг перерасчета: ' + PopBool2Str());

  for i := 0 to 64-1 do mpwCurrent40[i] := PopInt;
  for i := 0 to 64-1 do mpwCurrent41[i] := PopInt;

  AddInfo('');
  AddInfo('Счетчики трехминутных переходов / Счетчики переполнения');
  for i := 0 to 64-1 do begin
    s := PackStrR('канал ' + IntToStr(i+1),GetColWidth);
    s := s + PackStrR(IntToStr(mpwCurrent40[i]),GetColWidth);;
    s := s + PackStrR(IntToStr(mpwCurrent41[i]),GetColWidth);;
    AddInfo(s);
  end;

  BoxRun;
end;

end.
