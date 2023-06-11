unit get_current;

interface

procedure BoxGetCurrent1;
procedure ShowGetCurrent1;
procedure ShowGetCurrent2;
procedure ShowGetCurrent3;

implementation

uses SysUtils, soutput, kernel, support, borders, timez, realz, box;

const
  quGetCurrent1:  querys = (Action: acGetCurrent1; cwOut: 7+9; cwIn: 0; bNumber: $FF);  
  quGetCurrent2:  querys = (Action: acGetCurrent2; cwOut: 7+9; cwIn: 0; bNumber: $FF);  
  quGetCurrent3:  querys = (Action: acGetCurrent3; cwOut: 7+9; cwIn: 0; bNumber: $FF);  

procedure QueryGetCurrent1;
begin
  InitPushCRC;
  Push(35);
  if PushCanMask then Query(quGetCurrent1);
end;
  
procedure QueryGetCurrent2;
begin
  InitPushCRC;
  Push(200);
  if PushCanMask then Query(quGetCurrent2);
end;

procedure QueryGetCurrent3;
begin
  InitPushCRC;
  Push(206);
  if PushCanMask then Query(quGetCurrent3);
end;
    
procedure BoxGetCurrent1;
begin
  QueryGetCurrent1;
end;

procedure ShowGetCurrent1;
var
  y,Can:  byte;
  s:      string;    
begin
  Stop;
    
  InitPop(15);
  AddInfo('');    
  AddInfo('—татистика 3-х минутного опроса 1');
    
  AddInfo('');    
  AddInfo('(1) признаки первичного опроса');    
  AddInfo('(2) базовые значени€ целочисленные');    
  AddInfo('(3) базовые значени€ дробные');    
  AddInfo('(4) врем€ последнего опроса');    
  AddInfo('(5) врем€ последнего опроса (дополнительное)');    

  s := PackStrR('',GetColWidth);
  for y := 1 to 5 do begin
    s := s + PackStrR('('+IntToStr(y)+')',GetColWidth);
    if y in [4,5] then s := s + PackStrR('',GetColWidth);
  end;
      
  AddInfo(s);    
    
  for Can := 0 to CANALS-1 do if CanalChecked(Can) then begin
    s := PackStrR('канал '+IntToStr(Can+1),GetColWidth);
    s := s + PackStrR(PopBool2Str,GetColWidth);
    s := s + PackStrR(IntToStr(PopLong),GetColWidth);
    s := s + PackStrR(Reals2Str(PopReals),GetColWidth);
    s := s + PopTimes2Str + '  ';
    s := s + PopTimes2Str;
    AddInfo(s);
  end;
      
  AddInfo('');    
  AddInfo('(1) текущее значени€ счетчика');    
  AddInfo('(2) штамп времени дл€ текущего значени€ счетчика');    
  AddInfo('(3) коэффициент отношений');    
  AddInfo('(4) начальное значение счетчика');    

  s := PackStrR('',GetColWidth);
  for y := 1 to 4 do begin
    s := s + PackStrR('('+IntToStr(y)+')',GetColWidth);
    if y in [2] then s := s + PackStrR('',GetColWidth);
  end;  
  AddInfo(s);    
    
  for Can := 0 to CANALS-1 do if CanalChecked(Can) then begin
    s := PackStrR('канал '+IntToStr(Can+1),GetColWidth);
    s := s + PackStrR(Reals2Str(PopReals),GetColWidth);
    s := s + PopTimes2Str + '  ';
    s := s + PackStrR(Reals2Str(PopReals),GetColWidth);
    s := s + PackStrR(Reals2Str(PopReals),GetColWidth);
    AddInfo(s);
  end;
      
  AddInfo('');    
  AddInfo('(1) количество успешных опросов');    
  AddInfo('(2) количество ошибочных опросов');    
  AddInfo('(3) количество переполнений 100');    
  AddInfo('(4) количество переполнений 1000');    
  AddInfo('(5) количество переполнений 10000');    
  AddInfo('(6) количество переполнений 0xFFFF');    
  AddInfo('(7) количество заемов');    
  AddInfo('(8) количество повторов');    

  s := PackStrR('',GetColWidth);
  for y := 1 to 8 do
    s := s + PackStrR('('+IntToStr(y)+')',GetColWidth);
  AddInfo(s);    
    
  for Can := 0 to CANALS-1 do if CanalChecked(Can) then begin
    s := PackStrR('канал '+IntToStr(Can+1),GetColWidth);
    s := s + PackStrR(IntToStr(PopIntBig),GetColWidth);
    s := s + PackStrR(IntToStr(PopIntBig),GetColWidth);
    s := s + PackStrR(IntToStr(PopIntBig),GetColWidth);
    s := s + PackStrR(IntToStr(PopIntBig),GetColWidth);
    s := s + PackStrR(IntToStr(PopIntBig),GetColWidth);
    s := s + PackStrR(IntToStr(PopIntBig),GetColWidth);
    s := s + PackStrR(IntToStr(PopIntBig),GetColWidth);
    s := s + PackStrR(IntToStr(PopIntBig),GetColWidth);
    AddInfo(s);
  end;

  AddInfo('');    
  AddInfo('(1) дата последнего успешного опроса');    
  AddInfo('(2) дата последнего ошибочного опроса');    

  s := PackStrR('',GetColWidth);
  for y := 1 to 2 do begin
    s := s + PackStrR('('+IntToStr(y)+')',GetColWidth);
    if y in [1,2] then s := s + PackStrR('',GetColWidth);
  end;      
  AddInfo(s);    
    
  for Can := 0 to CANALS-1 do if CanalChecked(Can) then begin
    s := PackStrR('канал '+IntToStr(Can+1),GetColWidth);
    s := s + PopTimes2Str + '  ';
    s := s + PopTimes2Str;
    AddInfo(s);
  end;
      
  QueryGetCurrent2;
end;

procedure ShowGetCurrent2;
var
  y:      word;
  x,Can:  byte;
  s:      string;    
begin
  Stop;
    
  InitPop(15);
  AddInfo('');    
  AddInfo('»мпульсы по каналам по трехминутному графику');

  s := PackStrR('',GetColWidth);
  for Can := 0 to CANALS-1 do if CanalChecked(Can) then
    s := s + PackStrR('канал '+IntToStr(Can+1),GetColWidth);
  AddInfo(s);    
         
  y := tiCurr.bHour*20 + tiCurr.bMinute div 3 + 1;
  
  for x := 0 to 40-1 do begin
    s := PackStrR(Int2Str(y div 20)+':'+Int2Str((y mod 20)*3)+'  -'+IntToStr(x),GetColWidth);
    for Can := 0 to CANALS-1 do if CanalChecked(Can) then
      s := s + PackStrR(IntToStr(PopIntBig),GetColWidth);
    AddInfo(s);    
    
    if y = 0 then y := 24*20 else  y := y-1;
  end;        
    
  QueryGetCurrent3;
end;

procedure ShowGetCurrent3;
var
  y:      word;
  x,Can:  byte;
  s:      string;    
begin
  Stop;
    
  InitPop(15);
  AddInfo('');    
  AddInfo('ћощность по каналам по трехминутному графику');

  s := PackStrR('',GetColWidth);
  for Can := 0 to CANALS-1 do if CanalChecked(Can) then
    s := s + PackStrR('канал '+IntToStr(Can+1),GetColWidth);
  AddInfo(s);    
         
  y := tiCurr.bHour*20 + tiCurr.bMinute div 3 + 1;
  
  for x := 0 to 40-1 do begin
    s := PackStrR(Int2Str(y div 20)+':'+Int2Str((y mod 20)*3)+'  -'+IntToStr(x),GetColWidth);
    for Can := 0 to CANALS-1 do if CanalChecked(Can) then
      s := s + PackStrR(Reals2Str(PopReals),GetColWidth);
    AddInfo(s);    
    
    if y = 0 then y := 24*20 else  y := y-1;
  end;        
    
  RunBox;
end;
  
end.
