unit get_counters40;

interface

procedure BoxGetCounters40;
procedure ShowGetCounters40;

implementation

uses SysUtils, soutput, support, box, timez;

const
  quGetCounters40: querys = (Action: acGetCounters40; cwOut: 8; cwIn: 5 + (6+2)*$100 + 2; bNumber: 252);

procedure QueryGetCounters40;
begin
  InitPushCRC;
  Push(38);
  Query(quGetCounters40);
end;

procedure BoxGetCounters40;
begin
  QueryGetCounters40;
end;

procedure ShowGetCounters40;
var
  i,x: word;
  s: string;
begin
  Stop;
  InitPopCRC;

  AddInfo('');
  AddInfo('*Счетчики счетчиков Меркурий-234 СПОДЭС');

  for i := 0 to $100-1 do begin
    s :=     PackStrR(IntToStr(i),GetColWidth);
    s := s + PackStrR(PopTimes2Str,GetColWidth*2);
    s := s + PackStrR(IntToStr(PopIntLtl),GetColWidth);
    AddInfo(s);
  end;

  BoxRun;
end;

end.
