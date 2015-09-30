unit get_powgrpprevhou_def;

interface

uses kernel;

procedure BoxGetPowGrpPrevHou_Def;
procedure ShowGetPowGrpPrevHou_Def;

var
  mpePowGrpPrevHou_Def:   array[0..GROUPS-1] of extended;

implementation

uses SysUtils, soutput, support, realz, borders, box;

const
  quGetPowGrpPrevHou_Def:   querys = (Action: acGetPowGrpPrevHou_Def; cwOut: 7+5; cwIn: 0; bNumber: $FF);

procedure QueryGetPowGrpPrevHou_Def;
begin
  InitPushCRC;
  Push(90);
  if PushGrpMask then Query(quGetPowGrpPrevHou_Def);
end;

procedure BoxGetPowGrpPrevHou_Def;
begin
  if TestGroups then
    QueryGetPowGrpPrevHou_Def;
end;
                          
procedure ShowGetPowGrpPrevHou_Def;
var
  Grp:  word;
begin
  Stop;

  InitPop(15);
  for Grp := 0 to GROUPS-1 do mpePowGrpPrevHou_Def[Grp] := PopReals;

  AddInfo('');
  AddInfo('Мощность за предыдущий получас (с учетом достоверности)');
  for Grp := 0 to GROUPS-1 do if GroupChecked(Grp) then
    AddInfo(PackStrR('группа '+IntToStr(Grp+1),GetColWidth)+Reals2StrR(mpePowGrpPrevHou_Def[Grp]));
    
  BoxRun;
end;

end.
