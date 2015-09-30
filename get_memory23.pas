unit get_memory23;

interface

procedure BoxGetMemory23;
procedure ShowGetMemory23;

implementation

uses SysUtils, Classes, soutput, support, progress, box, kernel, timez, calendar, main, t_memory, get_memory0;

const
  quGetMemory23: querys = (Action: acGetMemory23; cwOut: 7+2; cwIn: bHEADER+wPAGE_SIZE+2; bNumber: 249);

var
  wPage0,wPage1,wPage2: word;
  ibPtr:  byte;

procedure QueryGetMemory23;
begin
  AddInfo('');
  AddInfo('');
  AddInfo(PackStrR('страница', GetColWidth) + IntToStr(wPage1));

  InitPushCRC;
  Push(wPage1 div $100);
  Push(wPage1 mod $100);
  Query(quGetMemory23);
end;

procedure BoxGetMemory23;
begin
  InitPages;
  
  wPage0 := 2992;
  wPage1 := wPage0;
  wPage2 := 3004-1;
  ibPtr := 0;

  AddInfo('');
  AddInfo('');
  AddInfo('„тение пам€ти (энерги€ по каналам за мес€цы): от ' + IntToStr(wPage1) + ' до ' + IntToStr(wPage2) + ' (' + IntToStr(Abs(wPage0-wPage2)+1) + ' страниц)' );

  QueryGetMemory23;
end;

procedure ShowGetMemory23;
var
  i:    byte;
  c,t:  byte;
  s:    string;
  a,b:  longword;
  l:    TStringList;
begin
  Stop;
  InitPop(15);

  i := (12+ibMon-ibPtr) mod 12;
  s := PackStrR('мес€ц', GetColWidth) + '-' + IntToStr(i) + ', ' + Times2StrMon(MonIndexToDate(DateToMonIndex(tiCurr)-i));
  AddInfo(s);
  Inc(ibPtr);

  s := PackStrR(IntToStr(wPage1),8);
  s := s + PackStrR('мес€ц -' + IntToStr(i),15);
  s := s + PackStrR(Times2StrMon(MonIndexToDate(DateToMonIndex(tiCurr)-i)),25);
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
  if wPage1 <= wPage2 then QueryGetMemory23 else begin
    AddInfoAll(ResultPages);
    BoxRun;
  end;

end;

end.
