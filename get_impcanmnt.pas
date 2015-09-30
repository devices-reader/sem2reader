unit get_impcanmnt;

interface

procedure BoxGetImpCanMnt;
procedure BoxGetPowCanMnt;
procedure ShowGetImpCanMnt;
procedure ShowGetPowCanMnt;

implementation

uses SysUtils, soutput, support, kernel, borders, box, realz;

const
  quGetImpCanMnt: querys = (Action: acGetImpCanMnt; cwOut: 7+9;  cwIn: 0;  bNumber: $FF;);
  quGetPowCanMnt: querys = (Action: acGetPowCanMnt; cwOut: 7+9;  cwIn: 0;  bNumber: $FF;);

procedure InitHeader;
var
  cbWaitQuery,
  ibHouIndex,
  ibEngTariff,
  ibPowTariff,
  ibMnt,
  ibDay,
  ibMon:        byte;

  iwHou:        word;

begin
  InitPop(5);

  ibHouIndex  := Pop;
  ibEngTariff := Pop;
  ibPowTariff := Pop;

  ibMnt := Pop;
  iwHou := Pop*$100 + Pop;;
  ibDay := Pop;
  ibMon := Pop;

  cbWaitQuery := Pop;
  Pop;

  AddTerminal('������ ��������       '+IntToStr(ibHouIndex));
  AddTerminal('����� ��� �������     '+IntToStr(ibEngTariff));
  AddTerminal('����� ��� ��������    '+IntToStr(ibPowTariff));
  AddTerminal('������ �� ����������� '+IntToStr(ibMnt));
  AddTerminal('������ �� ���������   '+IntToStr(iwHou));
  AddTerminal('������ �� ����        '+IntToStr(ibDay));
  AddTerminal('������ �� �������     '+IntToStr(ibMon));
  AddTerminal('������ ������         '+IntToStr(cbWaitQuery));
end;
    
procedure QueryGetImpCanMnt;
begin
  InitPushCRC;
  Push(200);
  if PushCanMask then Query(quGetImpCanMnt);
end;

procedure QueryGetPowCanMnt;
begin
  InitPushCRC;
  Push(206);
  if PushCanMask then Query(quGetPowCanMnt);
end;

procedure BoxGetImpCanMnt;
begin 
  QueryGetImpCanMnt;
end;

procedure BoxGetPowCanMnt;
begin 
  QueryGetPowCanMnt;
end;

procedure ShowGetImpCanMnt;
var
  y:      word;
  x,Can:  byte;
  s:      string;    
begin
  Stop;
  InitHeader;
    
  InitPop(15);
  AddInfo('');    
  AddInfo('�������� �� ������� �� ����������');

  s := PackStrR('',GetColWidth);
  for Can := 0 to CANALS-1 do if CanalChecked(Can) then 
    s := s + PackStrR('����� '+IntToStr(Can+1),GetColWidth);
  AddInfo(s);    
         
  y := tiCurr.bHour*20 + tiCurr.bMinute div 3 + 1;
  
  for x := 0 to 40-1 do begin
    s := PackStrR(Int2Str(y div 20)+':'+Int2Str((y mod 20)*3)+'  -'+IntToStr(x),GetColWidth);
    for Can := 0 to CANALS-1 do if CanalChecked(Can) then
      s := s + PackStrR(IntToStr(PopInt),GetColWidth);
    AddInfo(s);    
    
    if y = 0 then y := 24*20 else  y := y-1;
  end;        
    
  RunBox;
end;

procedure ShowGetPowCanMnt;
var
  y:      word;
  x,Can:  byte;
  s:      string;    
begin
  Stop;
    
  InitPop(15);
  AddInfo('');    
  AddInfo('�������� �� ������� �� ����������');

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
