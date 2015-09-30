unit get_recalc;

interface

uses kernel;

procedure BoxGetRecalc;
procedure ShowGetRecalc;

var
  mpRecalcs:     array[0..48-1] of byte;

implementation

uses SysUtils, soutput, support, progress, box;

const  
  quGetRecalc:   querys = (Action: acGetRecalc;     
                          cwOut: 7+1;   
                          cwIn: 5+1+48+2;    
                          bNumber: $FF);
    
procedure QueryGetRecalc;
begin
  InitPushCRC;
  Push(41);
  Query(quGetRecalc);
end;

procedure BoxGetRecalc;
begin
  AddInfo('');    
  AddInfo('График перерасчета');
    
  QueryGetRecalc;
end;

procedure ShowGetRecalc;
var
  Hou:  word;
  s:    string;
begin
  Stop;
  InitPopCrc();
  AddInfo('Производить перерасчет всегда: '+PopBool2Str);

  for Hou := 0 to 48-1 do begin
    mpRecalcs[Hou] := Pop;
    s := PackStrR(Int2Str(Hou div 2)+':'+Int2Str((Hou mod 2)*30),GetColWidth);
    s := s + Bool2Str(mpRecalcs[Hou]);
    AddInfo(s);
  end;

  RunBox;
end;

end.
