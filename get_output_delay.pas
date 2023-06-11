unit get_output_delay; 

interface

uses kernel;

procedure BoxGetOutputDelay;
procedure ShowGetOutputDelay;

implementation

uses SysUtils, soutput, support, box;

const  
  quGetOutputDelay:   querys = (Action: acGetOutputDelay; cwOut: 7+1; cwIn: 8+7; bNumber: $FF);
    
procedure QueryGetOutputDelay;
begin
  InitPushCRC;
  Push(68);
  Query(quGetOutputDelay);
end;

procedure BoxGetOutputDelay;
begin
  QueryGetOutputDelay;
end;

procedure ShowGetOutputDelay;
var
  Prt:  byte;
  s:    string;
begin
  Stop;
  InitPopCRC;

  AddInfo('');    
  AddInfo('');    
  AddInfo('Задержки на переключение портов из режима приема в режим передачи, мс');
  AddInfo('');    
  for Prt := 1 to 4 do begin
    s := PackStrR('порт '+IntToStr(Prt),GetColWidth);
    s := s + IntToStr(PopIntBig);
    AddInfo(s);
  end;  
  
  RunBox;
end;

end.
