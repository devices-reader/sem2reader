unit get_correct_limit; 

interface

uses kernel;

procedure BoxGetCorrectLimit;
procedure ShowGetCorrectLimit;

implementation

uses SysUtils, soutput, support, box;

const  
  quGetCorrectLimit:   querys = (Action: acGetCorrectLimit; cwOut: 7+1; cwIn: 8+3; bNumber: $FF);
    
procedure QueryGetCorrectLimit;
begin
  InitPushCRC;
  Push(69);
  Query(quGetCorrectLimit);
end;

procedure BoxGetCorrectLimit;
begin
  QueryGetCorrectLimit;
end;

procedure ShowGetCorrectLimit;
var
  Prt:  byte;
  s:    string;
begin
  Stop;
  InitPopCRC;

  AddInfo('');    
  AddInfo('');    
  AddInfo('Максимальная разница времени счетчиков и сумматора без коррекции, с');
  AddInfo('');    
  for Prt := 1 to 4 do begin
    s := PackStrR('порт '+IntToStr(Prt),GetColWidth);
    s := s + IntToStr(Pop);
    AddInfo(s);
  end;  
  
  RunBox;
end;

end.
