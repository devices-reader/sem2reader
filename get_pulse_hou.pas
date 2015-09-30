unit get_pulse_hou;

interface

uses kernel;

procedure BoxGetPulseHou;
procedure ShowGetPulseHou;

var
  mpePulseHou:     array[0..CANALS-1] of extended;

implementation

uses SysUtils, soutput, support, realz, borders, box;

const
  quGetPulseHou:   querys = (Action: acGetPulseHou; cwOut: 7; cwIn: 5+4*64+2; bNumber: 34);

procedure QueryGetPulseHou;
begin
  Query(quGetPulseHou);
end;

procedure BoxGetPulseHou;
begin
  if TestCanals then 
    QueryGetPulseHou;
end;
                          
procedure ShowGetPulseHou;
var
  Can:  word;
begin
  Stop;

  InitPopCRC;
  for Can := 0 to CANALS-1 do mpePulseHou[Can] := PopReals;

  AddInfo('');
  AddInfo('К. преобразования для получасов');
  for Can := 0 to CANALS-1 do if CanalChecked(Can) then
    AddInfo(PackStrR('канал '+IntToStr(Can+1),GetColWidth)+Reals2StrR(mpePulseHou[Can]));

  BoxRun;    
end;

end.
