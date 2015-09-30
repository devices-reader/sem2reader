unit get_border2;

interface

uses kernel;

procedure BoxGetBorder2;
procedure ShowGetBorder2;

implementation

uses SysUtils, soutput, support, borders, progress, box, timez;

const  
  quGetBorder2:   querys = (Action: acGetBorder2; cwOut: 7+9; cwIn: 0; bNumber: $FF);
    
procedure QueryGetBorder2;
begin
  InitPushCRC;
  Push(52);
  if PushCanMask then Query(quGetBorder2);
end;

procedure BoxGetBorder2;
begin
  if TestCanals then begin
    AddInfo('');    
    AddInfo('√раницы опроса цифровых счетчиков 2');
    
    QueryGetBorder2;
  end;
end;

procedure ShowGetBorder2;
var
  Can:  word;
  x:    word;
  y:    longword;
  s:  string;
begin
  Stop;
  InitPop(15);
  AddInfo('ѕризнак использовани€ нижних границ опроса: '+PopBool2Str);
  AddInfo('');
  AddInfo('(1) признак начала опроса        0/нет - начинаем опрос с текущего получаса, 255/да - начинаем опрос с прерванного получаса (нижней границы)');
  AddInfo('(2) верхн€€ граница');
  AddInfo('(3) нижн€€ граница относительна€ —Ёћ+2 CRC');
  AddInfo('(4) нижн€€ граница абсолютна€    —Ё“-4“ћ, ћеркурий-230');
  AddInfo('(5) нижн€€ граница абсолютна€    ћеркурий-233');
  AddInfo('');
  
  s := PackStrR('',GetColWidth);
  for x := 1 to 5 do
    s := s + PackStrR('('+IntToStr(x)+')',GetColWidth);
  AddInfo(s);    
  
  for Can := 0 to CANALS-1 do if CanalChecked(Can) then begin
    s := PackStrR('канал '+IntToStr(Can+1),GetColWidth);
    s := s + PackStrR(PopBool2Str,GetColWidth);
    x := PopInt;
    s := s + PackStrR(IntToStr(x)+' : '+IntToStr((x div 48)+1),GetColWidth);
    x := PopInt;
    s := s + PackStrR(IntToStr(x)+' : '+IntToStr((x div 48)+1),GetColWidth);
    x := PopInt;
    s := s + PackStrR(IntToHex(x,4),GetColWidth);
    y := PopLong;
    s := s + PackStrR(IntToHex(y,5),GetColWidth);
    AddInfo(s);

    Pop;
    Pop;
  end;

  RunBox;
end;

end.
