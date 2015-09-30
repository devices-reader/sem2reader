unit get_maxgrpmon_def;

interface

uses kernel;

var
  mpMaxGrpMon_Def:  array[0..GROUPS-1,0..MONTHS-1,0..TARIFFS-1] of maximum;

procedure BoxGetMaxGrpMon_Def;
procedure ShowGetMaxGrpMon_Def;

implementation

uses SysUtils, soutput, support, borders, progress, box, timez, realz, calendar;

const
  quGetMaxGrpMon_Def: querys = (Action: acGetMaxGrpMon_Def; cwOut: 7+6; cwIn: 0; bNumber: $FF);
  
var
  bMon:  byte;

procedure QueryGetMaxGrpMon_Def;
begin
  InitPushCRC;
  Push(88);
  Push(bMon);
  if PushGrpMask then Query(quGetMaxGrpMon_Def);
end;

procedure BoxGetMaxGrpMon_Def;
begin
  if TestMonths then begin
    bMon := ibMinMon;
    QueryGetMaxGrpMon_Def;
  end;  
end;

procedure ShowGetMaxGrpMon_Def;
var
  x,
  Grp,Tar:  word;
  s:        string;
begin
  Stop; 
  InitPop(15);

  for Grp := 0 to GROUPS-1 do if GroupChecked(Grp) then
    for Tar := 0 to TARIFFS-1 do begin
      mpMaxGrpMon_Def[Grp,bMon,Tar].timValue := PopTimes;
      mpMaxGrpMon_Def[Grp,bMon,Tar].extValue := PopReals;
    end;  
    
  ShowProgress(bMon-ibMinMon, ibMaxMon-ibMinMon+1);  
            
  Inc(bMon);
  if bMon <= ibMaxMon then 
    QueryGetMaxGrpMon_Def
  else begin
    AddInfo('');
    AddInfo('ћаксимумы мощности по группам за мес€ц');
    
    for x := ibMinMon to ibMaxMon do begin
    
    AddInfo('');
    AddInfo('мес€ц -' + IntToStr(x) + ' ' + Times2StrMon(MonIndexToDate(DateToMonIndex(tiCurr)-x)));

    for Grp := 0 to GROUPS-1 do if GroupChecked(Grp) then begin
      s := PackStrR('группа '+IntToStr(Grp+1),GetColWidth);

      for Tar := 0 to TARIFFS-1 do begin
        s := s + Reals2StrL(mpMaxGrpMon_Def[Grp,x,Tar].extValue) + ' ';
        s := s + Times2Str(mpMaxGrpMon_Def[Grp,x,Tar].timValue);
        s := PackStrL(s,3*GetColWidth);
      end;
      AddInfo(s);
    end;
    end;
      
    RunBox;
  end;  
end;

end.
