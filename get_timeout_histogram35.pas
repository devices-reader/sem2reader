unit get_timeout_histogram35;

interface

procedure BoxGetTimeoutHistogram35;
procedure ShowGetTimeoutHistogram35;

implementation

uses SysUtils, soutput, support, box, timez, calendar2, get_start;

const
  quGetTimeoutHistogram35:      querys = (Action: acGetTimeoutHistogram35; cwOut: 8; cwIn: 5+ 2+10+1 +2*2*256+2; bNumber: 252);

procedure QueryGetTimeoutHistogram35;
begin
  InitPushCRC;
  Push(31);
  Query(quGetTimeoutHistogram35);
end;

procedure BoxGetTimeoutHistogram35;
begin
  QueryGetTimeoutHistogram35;
end;

procedure ShowGetTimeoutHistogram35;
var
  mpHistogramAbs35,mpHistogramDay35: array[0..$100-1] of word;
  i,x: word;
  s: string;
begin
  Stop;
  InitPopCRC;

  AddInfo('');
  AddInfo('*Таймауты счетчиков CExxx NNCL2');

  x := PopIntLtl;
  AddInfo('Количество: '+IntToStr(x));

  for i := 0 to 10-1 do begin
    s := IntToStr(i) + ' ';
    if (x mod 10) = i then s := s + '*' else s := s + ' ';
    AddInfo(PackStrR(s,GetColWidth) + IntToStr(Pop));
  end;
  AddInfo('Среднее: '+IntToStr(Pop));

  for i := 0 to $100-1 do
    mpHistogramAbs35[i] := PopIntLtl;

  for i := 0 to $100-1 do
    mpHistogramDay35[i] := PopIntLtl;

  AddInfo('');
  s := PackStrR('Таймауты',GetColWidth);
  s := s + PackStrR('всего',GetColWidth);
  s := s + PackStrR('сутки',GetColWidth);
  AddInfo(s);

  for i := 0 to $100-1 do begin
    s := PackStrR(IntToStr(i),GetColWidth);
    s := s + PackStrR(IntToStr(mpHistogramAbs35[i]),GetColWidth);
    s := s + PackStrR(IntToStr(mpHistogramDay35[i]),GetColWidth);
    AddInfo(s);
  end;

  BoxRun;
end;

end.
