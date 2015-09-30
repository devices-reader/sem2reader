unit get_enggrpprevhou_def;

interface

uses kernel;

procedure BoxGetEngGrpPrevHou_Def;
procedure ShowGetEngGrpPrevHou_Def;

var
  mpeEngGrpPrevHou_Def:   array[0..GROUPS-1] of extended;

implementation

uses SysUtils, soutput, support, realz, borders, box;

const
  quGetEngGrpPrevHou_Def:   querys = (Action: acGetEngGrpPrevHou_Def; cwOut: 7+5; cwIn: 0; bNumber: $FF);

procedure QueryGetEngGrpPrevHou_Def;
begin
  InitPushCRC;
  Push(89);
  if PushGrpMask then Query(quGetEngGrpPrevHou_Def);
end;

procedure BoxGetEngGrpPrevHou_Def;
begin
  if TestGroups then
    QueryGetEngGrpPrevHou_Def;
end;
                          
procedure ShowGetEngGrpPrevHou_Def;
var
  Grp:  word;
begin
  Stop;

  InitPop(15);
  for Grp := 0 to GROUPS-1 do mpeEngGrpPrevHou_Def[Grp] := PopReals;

  AddInfo('');
  AddInfo('Ёнерги€ за предыдущий получас (с учетом достоверности)');
  for Grp := 0 to GROUPS-1 do if GroupChecked(Grp) then
    AddInfo(PackStrR('группа '+IntToStr(Grp+1),GetColWidth)+Reals2StrR(mpeEngGrpPrevHou_Def[Grp]));
    
  BoxRun;
end;

end.
