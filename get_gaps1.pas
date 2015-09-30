unit get_gaps1;

interface

procedure BoxGetGaps1;
procedure ShowGetGaps1;

implementation

uses SysUtils, soutput, support, progress, box, timez;

const  
  quGetGaps1:  querys = (Action: acGetGaps1; cwOut: 7+2; cwIn: 5+1+1+11*6+2; bNumber: $FF);
  
var
  mpGaps:     array[0..11-1] of times;
    
procedure QueryGetGaps1;
begin
  InitPushCRC;
  Push(96);
  Query(quGetGaps1);
end;

procedure BoxGetGaps1;
begin
  AddInfo('');
  AddInfo('*Тарифные периоды');
    
  QueryGetGaps1;
end;

function Gaps2Str(tiT: times): string;
begin
  Result :=  ' ' + Int2Str(tiT.bDay)   +
             '.' + Int2Str(tiT.bMonth) + ' - ' + Int2Str(tiT.bSecond+1);
end;

procedure ShowGetGaps1;
var
  i,j:  byte;
  s:    string;
begin
  Stop;
  InitPop(5);

  AddInfo('');
  AddInfo('Признак использования тарифных периодов: '+PopBool2Str);
  AddInfo('');

  j := Pop;
  AddInfo('Количество тарифных периодов: '+IntToStr(j));
  
  for i := 1 to j do begin
    mpGaps[i] := PopTimes;
    s := PackStrR('дата '+IntToStr(i),GetColWidth);
    s := s + Gaps2Str(mpGaps[i]);
    AddInfo(s);
  end;

  RunBox;
end;

end.
