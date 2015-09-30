unit get_memory21;

interface

procedure BoxGetMemory21;
procedure ShowGetMemory21;

implementation

uses SysUtils, Classes, soutput, support, progress, box, kernel, timez, calendar, main, t_memory, get_memory0;

const
  quGetMemory21: querys = (Action: acGetMemory21; cwOut: 7+2; cwIn: 0; bNumber: 249);

var
  wPage0,wPage1,wPage2: word;
  wPtr,wMax:  word;

function TestDays3: boolean;
begin
  with frmMain do begin
    Result := False;

    if (updFlashDayMin.Position > 62-1) then begin ErrBox('Начальный номер суток должен быть задан в диапазоне 0..61 !'); exit; end;
    if (updFlashDayMax.Position > 62-1) then begin ErrBox('Конечный номер суток должен быть задан в диапазоне 0..61 !'); exit; end;
    if (updFlashDayMax.Position <= updFlashDayMin.Position) then begin ErrBox('Конечный номер суток должен быть больше начального !'); exit; end;

    Result := True;
  end;
end;

procedure QueryGetMemory21;
begin
  AddInfo('');
  AddInfo('');
  AddInfo(PackStrR('страница', GetColWidth) + IntToStr(wPage1));

  InitPushCRC;
  Push(wPage1 div $100);
  Push(wPage1 mod $100);
  Query(quGetMemory21);
end;

procedure BoxGetMemory21;
var
  i:  word;
  j:  byte;
begin
  if TestDays3 then with frmMain do begin
    InitPages;

    i := (HALFS+iwHou-ibHouIndex+48) mod HALFS;
    if updFlashDayMin.Position > 0 then for j := 1 to updFlashDayMin.Position do i := (HALFS+i-48) mod HALFS;

    wPage0 := 2 + i;
    wPage1 := wPage0;

    i := (HALFS+iwHou-ibHouIndex+48) mod HALFS;
    if updFlashDayMax.Position > 0 then for j := 1 to updFlashDayMax.Position do i := (HALFS+i-48) mod HALFS;

    wPage2 := 2 + i - 1;

    wPtr := 0;
    wMax := (updFlashDayMax.Position - updFlashDayMin.Position)*48;

    AddInfo('');
    AddInfo('');
    AddInfo('Чтение памяти (энергия по каналам за сутки по получасам): от ' + IntToStr(wPage1) + ' до ' + IntToStr(wPage2) + ' (' + IntToStr(Abs(wPage0-wPage2)+1) + ' страниц)' );

    QueryGetMemory21;
  end;
end;

procedure ShowGetMemory21;
var
  i:  word;
  s:  string;
  c:  byte;
  l:  TStringList;
begin
  Stop;
  InitPop(15);

  i := (HALFS+iwHou-wPage1+2) mod HALFS;
  s := PackStrR('получас', GetColWidth) + '-' + IntToStr(i) + ', ' + Times2Str(HalfIndexToDate(DateToHalfIndex(tiCurr)-i));
  AddInfo(s);

  s := PackStrR(IntToStr(wPage1),8);
  s := s + PackStrR('получас -' + IntToStr(i),15);
  s := s + PackStrR(Times2StrDay(HalfIndexToDate(DateToHalfIndex(tiCurr)-i)),25);

  l := TestPages(s,wPageSize,wFreePageSize);

  InitPop(15);
  l.Add('');
  l.Add('');
  for c := 1 to 64 do begin
    s := PackStrR('канал ' + IntToStr(c), GetColWidth);
    s := s + PackStrR(IntToStr(PopInt), GetColWidth);
    l.Add(s);
  end;
  AddInfoAll(l);

  ShowProgress(wPtr, wMax+1);

  if wPage1 > 2 then Dec(wPage1) else wPage1 := 2 + HALFS - 1;

  Inc(wPtr);
  if wPtr <= wMax then QueryGetMemory21 else begin
    frmMain.AddInfoAll(ResultPages);
    BoxRun;
  end;

end;

end.
