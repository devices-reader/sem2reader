unit get_counters39;

interface

procedure BoxGetCounters39;
procedure ShowGetCounters39;

implementation

uses SysUtils, soutput, support, box, timez;

const
  quGetCounters39: querys = (Action: acGetCounters39; cwOut: 8; cwIn: 5 + (6+2)*$100 + 2; bNumber: 252);

procedure QueryGetCounters39;
begin
  InitPushCRC;
  Push(38);
  Query(quGetCounters39);
end;

procedure BoxGetCounters39;
begin
  QueryGetCounters39;
end;

procedure ShowGetCounters39;
var
  i,x: word;
  s: string;
begin
  Stop;
  InitPopCRC;

  AddInfo('');
  AddInfo('*—четчики счетчиков CC-301 DLMS');

  for i := 0 to $100-1 do begin
    s :=     PackStrR(IntToStr(i),GetColWidth);
    s := s + PackStrR(PopTimes2Str,GetColWidth*2);
    s := s + PackStrR(IntToStr(PopIntLtl),GetColWidth);
    AddInfo(s);
  end;

  BoxRun;
end;

end.
