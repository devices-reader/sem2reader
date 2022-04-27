unit get_logs35;

interface

procedure BoxGetLogs35;
procedure ShowGetLogs35;

implementation

uses SysUtils, soutput, support, box, timez;

const
  quGetLogs35: querys = (Action: acGetLogs35; cwOut: 8; cwIn: 5 + 2 + (6+2+2)*100 + 2; bNumber: 252);

procedure QueryGetLogs35;
begin
  InitPushCRC;
  Push(34);
  Query(quGetLogs35);
end;

procedure BoxGetLogs35;
begin
  QueryGetLogs35;
end;

procedure ShowGetLogs35;
var
  i,x: word;
  s,z: string;
begin
  Stop;
  InitPopCRC;

  AddInfo('');
  AddInfo('*События счетчиков CExxx NNCL2');

  x := PopIntLtl;
  AddInfo('Количество: '+IntToStr(x));

  for i := 0 to 100-1 do begin
    z := IntToStr(i) + ' ';
    if (x mod 10) = i then z := z + '*' else z := z + ' ';
    s :=     PackStrR(z, GetColWidth);
    s := s + PackStrR(PopTimes2Str,GetColWidth*2);
    s := s + PackStrR(IntToStr(PopIntLtl),GetColWidth);
    s := s + PackStrR(IntToStr(PopIntLtl),GetColWidth);
    AddInfo(s);
  end;

  BoxRun;
end;

end.
