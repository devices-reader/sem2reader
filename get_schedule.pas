unit get_schedule;

interface

uses kernel;

procedure BoxGetSchedule(i: byte);
procedure ShowGetSchedule(i: byte);

var
  mpSchedules:     array[0..4-1,0..48-1] of byte;

implementation

uses SysUtils, soutput, support, progress, box;

const  
  quGetSchedule0:   querys = (Action: acGetSchedule0;   
                          cwOut: 7+2;   
                          cwIn: 5+48+2;    
                          bNumber: $FF);

  quGetSchedule1:   querys = (Action: acGetSchedule1;   
                          cwOut: 7+2;   
                          cwIn: 5+48+2;    
                          bNumber: $FF);

  quGetSchedule2:   querys = (Action: acGetSchedule2;   
                          cwOut: 7+2;   
                          cwIn: 5+48+2;    
                          bNumber: $FF);

  quGetSchedule3:   querys = (Action: acGetSchedule3;   
                          cwOut: 7+2;   
                          cwIn: 5+48+2;    
                          bNumber: $FF);
    
procedure QueryGetSchedule(i: byte);
begin
  InitPushCRC;
  Push(15);
  case i of
   0: begin Push(0); Query(quGetSchedule0); end;
   1: begin Push(1); Query(quGetSchedule1); end;
   2: begin Push(2); Query(quGetSchedule2); end;
   3: begin Push(3); Query(quGetSchedule3); end;
   else ErrBox('Неправильный номер порта');
  end
end;

procedure BoxGetSchedule(i: byte);
begin
  AddInfo('');    
  AddInfo('График опроса по порту '+IntToStr(i+1));
    
  QueryGetSchedule(i);
end;

procedure ShowGetSchedule(i: byte);
var
  Hou:  word;
  s:    string;
begin
  Stop;
  InitPopCrc();

  for Hou := 0 to 48-1 do begin
    mpSchedules[i,Hou] := Pop;
    s := PackStrR(Int2Str(Hou div 2)+':'+Int2Str((Hou mod 2)*30),GetColWidth);
    s := s + Bool2Str(mpSchedules[i,Hou]);
    AddInfo(s);
  end;

  RunBox;
end;

end.
