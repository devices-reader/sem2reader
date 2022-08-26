unit get_logs40;

interface

procedure BoxGetLogs40;
procedure ShowGetLogs40;

implementation

uses SysUtils, soutput, support, box, timez;

const
  quGetLogs40: querys = (Action: acGetLogs40; cwOut: 8; cwIn: 5 + 2 + (6+1+2)*100 + 2; bNumber: 252);

procedure QueryGetLogs40;
begin
  InitPushCRC;
  Push(37);
  Query(quGetLogs40);
end;

procedure BoxGetLogs40;
begin
  QueryGetLogs40;
end;

procedure ShowGetLogs40;
var
  i,x: word;
  s,z: string;
begin
  Stop;
  InitPopCRC;

  AddInfo('');
  AddInfo('*События счетчиков Меркурий-234 СПОДЭС');

  x := PopIntLtl;
  AddInfo('Количество: '+IntToStr(x));

  for i := 0 to 100-1 do begin
    z := IntToStr(i) + ' ';
    if (x mod 100) = i then z := z + '*' else z := z + ' ';
    s :=     PackStrR(z, GetColWidth);
    s := s + PackStrR(PopTimes2Str,GetColWidth*2);
    s := s + PackStrR(IntToStr(Pop),GetColWidth);
    s := s + PackStrR(IntToStr(PopIntLtl),GetColWidth);
    AddInfo(s);
  end;

  BoxRun;
end;

end.
