unit get_control;

interface

uses kernel;

procedure BoxGetControl;
procedure ShowGetControl;

var
  mpControls:     array[0..48-1] of byte;

implementation

uses SysUtils, soutput, support, progress, box;

const  
  quGetControl:   querys = (Action: acGetControl;     
                          cwOut: 7+1;   
                          cwIn: 5+48+2;    
                          bNumber: $FF);
    
procedure QueryGetControl;
begin
  InitPushCRC;
  Push(14);
  Query(quGetControl);
end;

procedure BoxGetControl;
begin
  AddInfo('');    
  AddInfo('График коррекции времени');
    
  QueryGetControl;
end;

procedure ShowGetControl;
var
  Hou:  word;
  s:    string;
begin
  Stop;
  InitPopCrc();

  for Hou := 0 to 48-1 do begin
    mpControls[Hou] := Pop;
    s := PackStrR(Int2Str(Hou div 2)+':'+Int2Str((Hou mod 2)*30),GetColWidth);
    s := s + Bool2Str(mpControls[Hou]);
    AddInfo(s);
  end;

  RunBox;
end;

end.
