unit get_extended4_x2;

interface

uses kernel;

procedure BoxGetExt40X2;
procedure BoxGetExt41X2;
procedure BoxGetExt42X2;
procedure ShowGetExt40X2;
procedure ShowGetExt41X2;
procedure ShowGetExt42X2;

implementation

uses SysUtils, soutput, support, realz, timez, borders, box, progress;

const
  quGetExt40X2: querys = (Action: acGetExt40X2; cwOut: 7+10; cwIn: 0;       bNumber: $FF-2);
  quGetExt41X2: querys = (Action: acGetExt41X2; cwOut: 7+3;  cwIn: 15+19+2; bNumber: $FF-2);
  quGetExt42X2: querys = (Action: acGetExt42X2; cwOut: 7+3;  cwIn: 15+19+2; bNumber: $FF-2; fLong: true);

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
  
procedure QueryGetExt40X2;
begin
  InitPushCRC;
  Push(42);
  Push(bMon);
  if PushCanMask then Query(quGetExt40X2);
end;

procedure QueryGetExt41X2;
begin
  InitPushCRC;
  Push(43);
  Push(bMon);
  Push(bCan);
  Query(quGetExt41X2);
end;

procedure QueryGetExt42X2;
begin
  InitPushCRC;
  Push(44);
  Push(bMon);
  Push(bCan);
  Query(quGetExt42X2);
end;

procedure BoxGetExt40X2;
begin
  TestVersion4;
  if TestCanals and TestMonths then begin
    AddInfo('');
    AddInfo('«начени€ счЄтчиков на конец мес€ца (из буфера с дозапросом) (по маске каналов) (вариант 1) (двойна€ точность)');

    bMon := ibMinMon;
    QueryGetExt40X2;
  end;
end;

procedure BoxGetExt41X2;
begin
  TestVersion4;
  if TestCanals and TestMonths then begin
    AddInfo('');
    AddInfo('«начени€ счЄтчиков на конец мес€ца (из буфера с дозапросом) (по индексу канала) (двойна€ точность)');

    bCan := MinCan;
    bMon := ibMinMon;
    QueryGetExt41X2;
  end;
end;

procedure BoxGetExt42X2;
begin
  TestVersion4;
  if TestCanals and TestMonths then begin
    AddInfo('');
    AddInfo('«начени€ счЄтчиков на конец мес€ца (мгновенные) (двойна€ точность)');

    bCan := MinCan;
    bMon := ibMinMon;
    QueryGetExt42X2;
  end;
end;
                          
procedure ShowGetExt40X2;
var
  Can:  word;
  s:    string;
begin
  Stop;
  InitPop(15);

  AddInfo('');
  AddInfo(' мес€ц '+IntToStr(bMon+1) + ' ' +LongMonthNames[bMon+1]);
  for Can := 0 to CANALS-1 do if CanalChecked(Can) then begin
    s := PackStrR('канал ' + IntToStr(Can+1),GetColWidth);
    s := s + PackStrR(PopStatus2Str,GetColWidth*2);
    s := s + PackStrR(IntToStr(PopIntBig)+' - '+IntToStr(PopIntBig),GetColWidth);
    s := s + PackStrR(Double2StrR(PopDouble),GetColWidth);
    s := s + PackStrR(PopTimes2Str,GetColWidth);
    AddInfo(s);
  end;
  
  ShowProgress(bMon-ibMinMon, ibMaxMon-ibMinMon+1);  
    
  Inc(bMon);
  if bMon <= ibMaxMon then 
    QueryGetExt40X2
  else 
    RunBox;
end;

procedure ShowGetExt41X2;
var
  s:    string;
begin
  Stop;
  InitPop(15);

  if (bCan = MinCan) then begin
    AddInfo('');
    AddInfo(' мес€ц '+IntToStr(bMon+1) + ' ' +LongMonthNames[bMon+1]);
  end;  
  
  s := PackStrR('канал ' + IntToStr(bCan+1),GetColWidth);
  s := s + PackStrR(PopStatus2Str,GetColWidth*2);
  s := s + PackStrR(IntToStr(PopIntBig)+' - '+IntToStr(PopIntBig),GetColWidth);
  s := s + PackStrR(Double2StrR(PopDouble),GetColWidth);
  s := s + PackStrR(PopTimes2Str,GetColWidth);
  AddInfo(s);
  
  ShowProgress(bMon-ibMinMon, ibMaxMon-ibMinMon+1);  

  Inc(bCan);
  while (bCan <= MaxCan) and (not CanalChecked(bCan)) do begin
    Inc(bCan);
    if bCan >= MaxCan then break;
  end;
  
  if bCan <= MaxCan then
    QueryGetExt41X2
  else begin
    bCan := MinCan;
    Inc(bMon);
    if bMon <= ibMaxMon then 
      QueryGetExt41X2
    else 
      RunBox;
  end;    
end;

procedure ShowGetExt42X2;
var
  s:    string;
begin
  Stop;
  InitPop(15);

  if (bCan = 0{bMinCan-1}) then begin
    AddInfo('');
    AddInfo(' мес€ц '+IntToStr(bMon+1) + ' ' +LongMonthNames[bMon+1]);
  end;  
  
  s := PackStrR('канал ' + IntToStr(bCan+1),GetColWidth);
  s := s + PackStrR(PopStatus2Str,GetColWidth*2);
  s := s + PackStrR(IntToStr(PopIntBig)+' - '+IntToStr(PopIntBig),GetColWidth);
  s := s + PackStrR(Double2StrR(PopDouble),GetColWidth);
  s := s + PackStrR(PopTimes2Str,GetColWidth);
  AddInfo(s);
  
  ShowProgress(bMon-ibMinMon, ibMaxMon-ibMinMon+1);  

  Inc(bCan);
  while (bCan <= MaxCan) and (not CanalChecked(bCan)) do begin
    Inc(bCan);
    if bCan >= MaxCan then break;
  end;
  
  if bCan <= MaxCan then
    QueryGetExt42X2
  else begin
    bCan := MinCan;
    Inc(bMon);
    if bMon <= ibMaxMon then 
      QueryGetExt42X2
    else 
      RunBox;
  end;    
end;

end.
