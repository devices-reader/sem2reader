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
  AddInfo('���������� 3-� ��������� ������ 1');
    
  AddInfo('');    
  AddInfo('(1) �������� ���������� ������');    
  AddInfo('(2) ������� �������� �������������');    
  AddInfo('(3) ������� �������� �������');    
  AddInfo('(4) ����� ���������� ������');    
  AddInfo('(5) ����� ���������� ������ (��������������)');    

  s := PackStrR('',GetColWidth);
  for y := 1 to 5 do begin
    s := s + PackStrR('('+IntToStr(y)+')',GetColWidth);
    if y in [4,5] then s := s + PackStrR('',GetColWidth);
  end;
      
  AddInfo(s);    
    
  for Can := 0 to CANALS-1 do if CanalChecked(Can) then begin
    s := PackStrR('����� '+IntToStr(Can+1),GetColWidth);
    s := s + PackStrR(PopBool2Str,GetColWidth);
    s := s + PackStrR(IntToStr(PopLong),GetColWidth);
    s := s + PackStrR(Reals2Str(PopReals),GetColWidth);
    s := s + PopTimes2Str + '  ';
    s := s + PopTimes2Str;
    AddInfo(s);
  end;
      
  AddInfo('');    
  AddInfo('(1) ������� �������� ��������');    
  AddInfo('(2) ����� ������� ��� �������� �������� ��������');    
  AddInfo('(3) ����������� ���������');    
  AddInfo('(4) ��������� �������� ��������');    

  s := PackStrR('',GetColWidth);
  for y := 1 to 4 do begin
    s := s + PackStrR('('+IntToStr(y)+')',GetColWidth);
    if y in [2] then s := s + PackStrR('',GetColWidth);
  end;  
  AddInfo(s);    
    
  for Can := 0 to CANALS-1 do if CanalChecked(Can) then begin
    s := PackStrR('����� '+IntToStr(Can+1),GetColWidth);
    s := s + PackStrR(Reals2Str(PopReals),GetColWidth);
    s := s + PopTimes2Str + '  ';
    s := s + PackStrR(Reals2Str(PopReals),GetColWidth);
    s := s + PackStrR(Reals2Str(PopReals),GetColWidth);
    AddInfo(s);
  end;
      
  AddInfo('');    
  AddInfo('(1) ���������� �������� �������');    
  AddInfo('(2) ���������� ��������� �������');    
  AddInfo('(3) ���������� ������������ 100');    
  AddInfo('(4) ���������� ������������ 1000');    
  AddInfo('(5) ���������� ������������ 10000');    
  AddInfo('(6) ���������� ������������ 0xFFFF');    
  AddInfo('(7) ���������� ������');    
  AddInfo('(8) ���������� ��������');    

  s := PackStrR('',GetColWidth);
  for y := 1 to 8 do
    s := s + PackStrR('('+IntToStr(y)+')',GetColWidth);
  AddInfo(s);    
    
  for Can := 0 to CANALS-1 do if CanalChecked(Can) then begin
    s := PackStrR('����� '+IntToStr(Can+1),GetColWidth);
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
  AddInfo('(1) ���� ���������� ��������� ������');    
  AddInfo('(2) ���� ���������� ���������� ������');    

  s := PackStrR('',GetColWidth);
  for y := 1 to 2 do begin
    s := s + PackStrR('('+IntToStr(y)+')',GetColWidth);
    if y in [1,2] then s := s + PackStrR('',GetColWidth);
  end;      
  AddInfo(s);    
    
  for Can := 0 to CANALS-1 do if CanalChecked(Can) then begin
    s := PackStrR('����� '+IntToStr(Can+1),GetColWidth);
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
  AddInfo('�������� �� ������� �� ������������� �������');

  s := PackStrR('',GetColWidth);
  for Can := 0 to CANALS-1 do if CanalChecked(Can) then
    s := s + PackStrR('����� '+IntToStr(Can+1),GetColWidth);
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
  AddInfo('�������� �� ������� �� ������������� �������');

  s := PackStrR('',GetColWidth);
  for Can := 0 to CANALS-1 do if CanalChecked(Can) then
    s := s + PackStrR('����� '+IntToStr(Can+1),GetColWidth);
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
