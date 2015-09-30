unit get_memory22;

interface

procedure BoxGetMemory22;
procedure ShowGetMemory22;

implementation

uses SysUtils, Classes, soutput, support, progress, box, kernel, timez, calendar, t_memory, get_memory0;

const
  quGetMemory22: querys = (Action: acGetMemory22; cwOut: 7+2; cwIn: bHEADER+wPAGE_SIZE+2; bNumber: 249);

var
  wPage0,wPage1,wPage2: word;
  ibPtr:  byte;

procedure QueryGetMemory22;
begin
  AddInfo('');
  AddInfo('');
  AddInfo(PackStrR('страница', GetColWidth) + IntToStr(wPage1));
  
  InitPushCRC;
  Push(wPage1 div $100);
  Push(wPage1 mod $100);
  Query(quGetMemory22);
end;

procedure BoxGetMemory22;
begin
  InitPages;
  
  wPage0 := 2978;
  wPage1 := wPage0;
  wPage2 := 2992-1;
  ibPtr := 0;

  AddInfo('');
  AddInfo('');
  AddInfo('Чтение памяти (энергия по каналам за сутки): от ' + IntToStr(wPage1) + ' до ' + IntToStr(wPage2) + ' (' + IntToStr(Abs(wPage0-wPage2)+1) + ' страниц)' );

  QueryGetMemory22;
end;

procedure ShowGetMemory22;
var
  i:    byte;
  c,t:  byte;
  s:    string;
  a,b:  longword;
  l:    TStringList;
begin
  Stop;
  InitPop(15);

  i := (14+ibDay-ibPtr) mod 14;
  s := PackStrR('сутки', GetColWidth) + '-' + IntToStr(i) + ', ' + Times2StrDay(DayIndexToDate(DateToDayIndex(tiCurr)-i));
  AddInfo(s);
  Inc(ibPtr);

  s := PackStrR(IntToStr(wPage1),8);
  s := s + PackStrR('сутки -' + IntToStr(i),15);
  s := s + PackStrR(Times2StrDay(DayIndexToDate(DateToDayIndex(tiCurr)-i)),25);
  l := TestPages(s);

  InitPop(15);
  l.Add('');
  s := PackStrR('', GetColWidth);
  for t := 1 to 4 do s := s + PackStrR('тариф ' + IntToStr(t), GetColWidth);
  s := s + PackStrR('всего', GetColWidth);
  l.Add(s);
  for c := 1 to 64 do begin
    s := PackStrR('канал ' + IntToStr(c), GetColWidth);
    a := 0;
    for t := 1 to 4 do begin
      b := PopLong;
      a := a + b;
      s := s + PackStrR(IntToStr(b), GetColWidth);
    end;
    s := s + PackStrR(IntToStr(a), GetColWidth);
    l.Add(s);
  end;
  AddInfoAll(l);

  ShowProgress(Abs(wPage0 - wPage1), Abs(wPage0 - wPage2) + 1);

  Inc(wPage1);
  if wPage1 <= wPage2 then QueryGetMemory22 else begin
    AddInfoAll(ResultPages);
    BoxRun;
  end;

end;

end.
