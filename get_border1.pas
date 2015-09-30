unit get_border1;

interface

uses kernel;

procedure BoxGetBorder1;
procedure ShowGetBorder1;

implementation

uses SysUtils, soutput, support, borders, progress, box;

const  
  quGetBorder1:   querys = (Action: acGetBorder1; cwOut: 7+9; cwIn: 0; bNumber: $FF);
    
procedure QueryGetBorder1;
begin
  InitPushCRC;
  Push(67);
  if PushCanMask then Query(quGetBorder1);
end;

procedure BoxGetBorder1;
begin
  if TestCanals then begin
    AddInfo('');    
    AddInfo('Границы опроса цифровых счетчиков 1');
    
    QueryGetBorder1;
  end;
end;

procedure ShowGetBorder1;
var
  Can:  word;
  a:    word;
  s:    string;
begin
  Stop;
  InitPop(15);

  for Can := 0 to CANALS-1 do if CanalChecked(Can) then begin
    a := PopInt;
    s := PackStrR('канал '+IntToStr(Can+1),GetColWidth);
    s := s + PackStrR(IntToStr(a)+' : '+IntToStr((a div 48)+1),GetColWidth);
    AddInfo(s);
  end;

  RunBox;
end;

end.
