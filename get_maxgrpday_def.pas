unit get_maxgrpday_def;

interface

uses kernel;

var
  mpMaxGrpDay_Def:  array[0..GROUPS-1,0..DAYS-1,0..TARIFFS-1] of maximum;

procedure BoxGetMaxGrpDay_Def;
procedure ShowGetMaxGrpDay_Def;

implementation

uses SysUtils, soutput, support, borders, progress, box, timez, realz, calendar;

const
  quGetMaxGrpDay_Def: querys = (Action: acGetMaxGrpDay_Def; cwOut: 7+6; cwIn: 0; bNumber: $FF);
  
var
  bDay:  byte;

procedure QueryGetMaxGrpDay_Def;
begin
  InitPushCRC;
  Push(87);
  Push(bDay);
  if PushGrpMask then Query(quGetMaxGrpDay_Def);
end;

procedure BoxGetMaxGrpDay_Def;
begin
  if TestDays then begin
    bDay := ibMinDay;
    QueryGetMaxGrpDay_Def;
  end;  
end;

procedure ShowGetMaxGrpDay_Def;
var
  x,
  Grp,Tar:  word;
  s:        string;
begin
  Stop; 
  InitPop(15);

  for Grp := 0 to GROUPS-1 do if GroupChecked(Grp) then
    for Tar := 0 to TARIFFS-1 do begin
      mpMaxGrpDay_Def[Grp,bDay,Tar].timValue := PopTimes;
      mpMaxGrpDay_Def[Grp,bDay,Tar].extValue := PopReals;
    end;  
            
  ShowProgress(bDay-ibMinDay, ibMaxDay-ibMinDay+1);  

  Inc(bDAY);
  if bDay <= ibMaxDay then 
    QueryGetMaxGrpDay_Def   
  else begin
    AddInfo('');
    AddInfo('Максимумы мощности по группам за сутки');
    
    for x := ibMinDay to ibMaxDay do begin
    
    AddInfo('');
    AddInfo('сутки -' + IntToStr(x) + ' ' + Times2StrDay(DayIndexToDate(DateToDayIndex(tiCurr)-x)));

    for Grp := 0 to GROUPS-1 do if GroupChecked(Grp) then begin
      s := PackStrR('группа '+IntToStr(Grp+1),GetColWidth);

      for Tar := 0 to TARIFFS-1 do begin
        s := s + Reals2StrL(mpMaxGrpDay_Def[Grp,x,Tar].extValue) + ' ';
        s := s + Times2Str(mpMaxGrpDay_Def[Grp,x,Tar].timValue);
        s := PackStrL(s,3*GetColWidth);
      end;
      AddInfo(s);
    end;
    end;
      
    RunBox;
  end;  
end;

end.
