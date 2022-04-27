unit get_counters35;

interface

procedure BoxGetCounters35;
procedure ShowGetCounters35;

implementation

uses SysUtils, soutput, support, box, timez;

const
  quGetCounters35: querys = (Action: acGetCounters35; cwOut: 8; cwIn: 5 + (6+2)*10 + 2; bNumber: 252);

procedure QueryGetCounters35;
begin
  InitPushCRC;
  Push(35);
  Query(quGetCounters35);
end;

procedure BoxGetCounters35;
begin
  QueryGetCounters35;
end;

procedure ShowGetCounters35;
var
  i,x: word;
  s: string;
begin
  Stop;
  InitPopCRC;

  AddInfo('');
  AddInfo('*—четчики счетчиков CExxx NNCL2');

  for i := 0 to 10-1 do begin
    s :=     PackStrR(IntToStr(i),GetColWidth);
    s := s + PackStrR(PopTimes2Str,GetColWidth*2);
    s := s + PackStrR(IntToStr(PopIntLtl),GetColWidth);
    AddInfo(s);
  end;

  BoxRun;
end;

end.
