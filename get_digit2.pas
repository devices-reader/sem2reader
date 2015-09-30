unit get_digit2;

interface

uses kernel;

procedure BoxGetDigit2;
procedure ShowGetDigit2;

implementation

uses SysUtils, soutput, support, borders, progress, box;

const  
  quGetDigit2:   querys = (Action: acGetDigit2; cwOut: 7+9; cwIn: 0; bNumber: $FF);
    
procedure QueryGetDigit2;
begin
  InitPushCRC;
  Push(17);
  if PushCanMask then Query(quGetDigit2);
end;

procedure BoxGetDigit2;
begin
  if TestCanals then begin
    AddInfo('');    
    AddInfo('Дополнительные адреса цифровых счетчиков');
    
    QueryGetDigit2;
  end;
end;

procedure ShowGetDigit2;
var
  Can:  word;
  s:    string;
begin
  Stop;
  InitPop(15);

  for Can := 0 to CANALS-1 do if CanalChecked(Can) then begin
    s := PackStrR('канал '+IntToStr(Can+1),GetColWidth);
    s := s + PackStrR(IntToStr(PopLong),GetColWidth);
    s := s + PackStrR(IntToStr(PopLong),GetColWidth);
    AddInfo(s);
  end;

  RunBox;
end;

end.
