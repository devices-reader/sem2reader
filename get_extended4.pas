unit get_extended4;

interface

uses kernel;

procedure BoxGetExt40;
procedure BoxGetExt41;
procedure BoxGetExt42;
procedure ShowGetExt40;
procedure ShowGetExt41;
procedure ShowGetExt42;

var
  mpExt42CntCanMon: array[0..CANALS-1,0..MONTHS-1] of extended;

implementation

uses SysUtils, soutput, support, realz, timez, borders, box, progress, calendar;

const
  quGetExt40: querys = (Action: acGetExt40; cwOut: 7+10; cwIn: 0;       bNumber: $FF);
  quGetExt41: querys = (Action: acGetExt41; cwOut: 7+3;  cwIn: 15+15+2; bNumber: $FF);
  quGetExt42: querys = (Action: acGetExt42; cwOut: 7+3;  cwIn: 15+15+2; bNumber: $FF; fLong: true);

var
  bCan,
  bMon:  byte;  
  
function PopStatus2Str: string;
var
  i:  byte;
begin
  i := Pop;
  case i of
    0:    Result := 'пусто';
    1:    Result := 'ќ ';
    $80:  Result := 'счетчик не отвечает !';
    $81:  Result := 'флэш-пам€ть !';
    $82:  Result := 'модемный канал !';
    $83:  Result := 'канал запрещен !';
    else  Result := '?';
  end;
  Result := IntToHex(i,2) + ' - ' + Result;
end;
  
procedure QueryGetExt40;
begin
  InitPushCRC;
  Push(42);
  Push((12+(tiCurr.bMonth-1)-bMon) mod 12);
  if PushCanMask then Query(quGetExt40);
end;

procedure QueryGetExt41;
begin
  InitPushCRC;
  Push(43);
  Push((12+(tiCurr.bMonth-1)-bMon) mod 12);
  Push(bCan);
  Query(quGetExt41);
end;

procedure QueryGetExt42;
begin
  InitPushCRC;
  Push(44);
  Push((12+(tiCurr.bMonth-1)-bMon) mod 12);
  Push(bCan);
  Query(quGetExt42);
end;

procedure BoxGetExt40;
begin
  if TestCanals and TestMonths then begin
    AddInfo('');
    AddInfo('«начени€ счЄтчиков на конец мес€ца (из буфера с дозапросом) (по маске каналов) (вариант 1)');

    bMon := ibMinMon;
    QueryGetExt40;
  end;
end;

procedure BoxGetExt41;
begin
  if TestCanals and TestMonths then begin
    AddInfo('');
    AddInfo('«начени€ счЄтчиков на конец мес€ца (из буфера с дозапросом) (по индексу канала)');

    bCan := MinCan;
    bMon := ibMinMon;
    QueryGetExt41;
  end;
end;

procedure BoxGetExt42;
begin
  if TestCanals and TestMonths then begin
    AddInfo('');
    AddInfo('«начени€ счЄтчиков на конец мес€ца (мгновенные)');

    bCan := MinCan;
    bMon := ibMinMon;
    QueryGetExt42;
  end;
end;
                          
procedure ShowGetExt40;
var
  Can:  word;
  s:    string;
begin
  Stop;
  InitPop(15);

  AddInfo('');
  AddInfo(' мес€ц -'+IntToStr(bMon) + ' ' + Times2StrMon(MonIndexToDate(DateToMonIndex(tiCurr)-bMon)));

  for Can := 0 to CANALS-1 do if CanalChecked(Can) then begin
    s := PackStrR('канал ' + IntToStr(Can+1),GetColWidth);
    s := s + PackStrR(PopStatus2Str,GetColWidth*2);
    s := s + PackStrR(IntToStr(PopIntBig)+' - '+IntToStr(PopIntBig),GetColWidth);
    s := s + PackStrR(Reals2StrR(PopReals),GetColWidth);
    s := s + PackStrR(PopTimes2Str,GetColWidth);
    AddInfo(s);
  end;
  
  ShowProgress(bMon-ibMinMon, ibMaxMon-ibMinMon+1);  
    
  Inc(bMon);
  if bMon <= ibMaxMon then 
    QueryGetExt40
  else 
    RunBox;
end;

procedure ShowGetExt41;
var
  s:    string;
begin
  Stop;
  InitPop(15);

  if (bCan = MinCan) then begin
    AddInfo('');
    AddInfo(' мес€ц -'+IntToStr(bMon) + ' ' + Times2StrMon(MonIndexToDate(DateToMonIndex(tiCurr)-bMon)));
  end;

  s := PackStrR('канал ' + IntToStr(bCan+1),GetColWidth);
  s := s + PackStrR(PopStatus2Str,GetColWidth*2);
  s := s + PackStrR(IntToStr(PopIntBig)+' - '+IntToStr(PopIntBig),GetColWidth);
  s := s + PackStrR(Reals2StrR(PopReals),GetColWidth);
  s := s + PackStrR(PopTimes2Str,GetColWidth);
  AddInfo(s);

  ShowProgress(bMon-ibMinMon, ibMaxMon-ibMinMon+1);

  Inc(bCan);
  while (bCan <= MaxCan) and (not CanalChecked(bCan)) do begin
    Inc(bCan);
    if bCan >= MaxCan then break;
  end;
  
  if bCan <= MaxCan then
    QueryGetExt41
  else begin
    bCan := MinCan;
    Inc(bMon);
    if bMon <= ibMaxMon then 
      QueryGetExt41
    else 
      RunBox;
  end;    
end;

procedure ShowGetExt42;
var
  s:    string;
  e:    extended;
begin
  Stop;
  InitPop(15);

  if (bCan = 0{bMinCan-1}) then begin
    AddInfo('');
    AddInfo(' мес€ц -'+IntToStr(bMon) + ' ' + Times2StrMon(MonIndexToDate(DateToMonIndex(tiCurr)-bMon)));
  end;

  s := PackStrR('канал ' + IntToStr(bCan+1),GetColWidth);
  s := s + PackStrR(PopStatus2Str,GetColWidth*2);
  s := s + PackStrR(IntToStr(PopIntBig)+' - '+IntToStr(PopIntBig),GetColWidth);
  e := PopReals;
  mpExt42CntCanMon[bCan,bMon] := e;
  s := s + PackStrR(Reals2StrR(e),GetColWidth);
  s := s + PackStrR(PopTimes2Str,GetColWidth);
  AddInfo(s);
  
  ShowProgress(bMon-ibMinMon, ibMaxMon-ibMinMon+1);  

  Inc(bCan);
  while (bCan <= MaxCan) and (not CanalChecked(bCan)) do begin
    Inc(bCan);
    if bCan >= MaxCan then break;
  end;
  
  if bCan <= MaxCan then
    QueryGetExt42
  else begin
    bCan := MinCan;
    Inc(bMon);
    if bMon <= ibMaxMon then 
      QueryGetExt42
    else 
      RunBox;
  end;    
end;

end.
