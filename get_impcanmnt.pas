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

  AddTerminal('индекс получаса       '+IntToStr(ibHouIndex));
  AddTerminal('тариф для энергии     '+IntToStr(ibEngTariff));
  AddTerminal('тариф для мощности    '+IntToStr(ibPowTariff));
  AddTerminal('индекс по трехминутам '+IntToStr(ibMnt));
  AddTerminal('индекс по получасам   '+IntToStr(iwHou));
  AddTerminal('индекс по дням        '+IntToStr(ibDay));
  AddTerminal('индекс по месяцам     '+IntToStr(ibMon));
  AddTerminal('таймер опроса         '+IntToStr(cbWaitQuery));
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
  AddInfo('Импульсы по каналам за трехминуты');

  s := PackStrR('',GetColWidth);
  for Can := 0 to CANALS-1 do if CanalChecked(Can) then 
    s := s + PackStrR('канал '+IntToStr(Can+1),GetColWidth);
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
  AddInfo('Мощность по каналам за трехминуты');

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
