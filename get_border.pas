unit get_border;

interface

uses kernel;

procedure BoxGetBorder;
procedure ShowGetBorder;

implementation

uses SysUtils, soutput, support, borders, progress, box;

const  
  quGetBorder:   querys = (Action: acGetBorder; cwOut: 7+9; cwIn: 0; bNumber: $FF);
    
procedure QueryGetBorder;
begin
  InitPushCRC;
  Push(12);
  if PushCanMask then Query(quGetBorder);
end;

procedure BoxGetBorder;
begin
  if TestCanals then begin
    AddInfo('');    
    AddInfo('Границы опроса цифровых счетчиков 1');
    
    QueryGetBorder;
  end;
end;

procedure ShowGetBorder;
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
