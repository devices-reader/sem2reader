unit get_logs39;

interface

procedure BoxGetLogs39;
procedure ShowGetLogs39;

implementation

uses SysUtils, soutput, support, box, timez;

const
  quGetLogs39: querys = (Action: acGetLogs39; cwOut: 8; cwIn: 5 + 2 + (6+1+2)*100 + 2; bNumber: 252);

procedure QueryGetLogs39;
begin
  InitPushCRC;
  Push(37);
  Query(quGetLogs39);
end;

procedure BoxGetLogs39;
begin
  QueryGetLogs39;
end;

procedure ShowGetLogs39;
var
  i,x: word;
  s,z: string;
begin
  Stop;
  InitPopCRC;

  AddInfo('');
  AddInfo('*События счетчиков CC-301 DLMS');

  x := PopIntLtl;
  AddInfo('Количество: '+IntToStr(x));

  for i := 0 to 100-1 do begin
    z := IntToStr(i) + ' ';
    if (x mod 10) = i then z := z + '*' else z := z + ' ';
    s :=     PackStrR(z, GetColWidth);
    s := s + PackStrR(PopTimes2Str,GetColWidth*2);
    s := s + PackStrR(IntToStr(Pop),GetColWidth);
    s := s + PackStrR(IntToStr(PopIntLtl),GetColWidth);
    AddInfo(s);
  end;

  BoxRun;
end;

end.
