unit get_gaps2;

interface

procedure BoxGetGaps2;
procedure ShowGetGaps2;

implementation

uses SysUtils, soutput, support, progress, box, timez;

const
  quGetGaps2:  querys = (Action: acGetGaps2; cwOut: 7+2; cwIn: 5+1+6+1+365+2; bNumber: $FF);

  mpG: array[0..12-1] of byte = ( 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 );
var
  mpGaps2:     array[0..365-1] of byte;

procedure QueryGetGaps2;
begin
  InitPushCRC;
  Push(97);
  Query(quGetGaps2);
end;

procedure BoxGetGaps2;
begin
  AddInfo('');
  AddInfo('*График тарифных периодов за год');

  QueryGetGaps2;
end;

procedure ShowGetGaps2;
var

  i:  word;
  m,d:byte;
  s:  string;
begin
  Stop;
  InitPop(5);

  AddInfo('');
  AddInfo('Признак использования тарифных периодов: '+PopBool2Str);
  AddInfo('');

  AddInfo(PackStrR('Текущее время:',GetColWidth*2) + PopTimes2Str);
  AddInfo(PackStrR('Текущий тарифный период:',GetColWidth*2) + IntToStr(Pop+1));
  AddInfo('');
  
  for i := 0 to 365-1 do mpGaps2[i] := Pop;


  s := PackStrR('',GetColWidth);
  for i := 1 to 31 do s := s + Int2Str(i) + ' ';
  AddInfo(s);

  m := 0; d := 1;
  s := PackStrR('месяц ' + IntToStr(m+1),GetColWidth);
  for i := 0 to 365-1 do begin
    Inc(d); s := s + PackStrR(IntToStr(mpGaps2[i]+1),3);
    if (d > mpG[m]) then begin
      Inc(m); d := 1;
      AddInfo(s);
      s := PackStrR('месяц ' + IntToStr(m+1),GetColWidth);
    end;
  end;

  RunBox;
end;

end.
