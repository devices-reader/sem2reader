unit get_maxgrpday;

interface

uses kernel;

var
  mpMaxGrpDay:  array[0..GROUPS-1,0..DAYS-1,0..TARIFFS-1] of maximum;

procedure BoxGetMaxGrpDay;
procedure ShowGetMaxGrpDay;

implementation

uses SysUtils, soutput, support, borders, progress, box, timez, realz, calendar;

const
  quGetMaxGrpDay: querys = (Action: acGetMaxGrpDay; cwOut: 7+6; cwIn: 0; bNumber: $FF);
  
var
  bDay:  byte;

procedure QueryGetMaxGrpDay;
begin
  InitPushCRC;
  Push(223);
  Push(bDay);
  if PushGrpMask then Query(quGetMaxGrpDay);
end;

procedure BoxGetMaxGrpDay;
begin
  if TestDays then begin
    bDay := ibMinDay;
    QueryGetMaxGrpDay;
  end;  
end;

procedure ShowGetMaxGrpDay;
var
  x,
  Grp,Tar:  word;
  s:        string;
begin
  Stop; 
  InitPop(15);

  for Grp := 0 to GROUPS-1 do if GroupChecked(Grp) then
    for Tar := 0 to TARIFFS-1 do begin
      mpMaxGrpDay[Grp,bDay,Tar].timValue := PopTimes;
      mpMaxGrpDay[Grp,bDay,Tar].extValue := PopReals;
    end;  
            
  ShowProgress(bDay-ibMinDay, ibMaxDay-ibMinDay+1);  

  Inc(bDAY);
  if bDay <= ibMaxDay then 
    QueryGetMaxGrpDay   
  else begin
    AddInfo('');
    AddInfo('Максимумы мощности по группам за сутки');
    
    for x := ibMinDay to ibMaxDay do begin
    
    AddInfo('');
    AddInfo('сутки -' + IntToStr(x) + ' ' + Times2StrDay(DayIndexToDate(DateToDayIndex(tiCurr)-x)));

    for Grp := 0 to GROUPS-1 do if GroupChecked(Grp) then begin
      s := PackStrR('группа '+IntToStr(Grp+1),GetColWidth);

      for Tar := 0 to TARIFFS-1 do begin
        s := s + Reals2StrL(mpMaxGrpDay[Grp,x,Tar].extValue) + ' ';
        s := s + Times2Str(mpMaxGrpDay[Grp,x,Tar].timValue);
        s := PackStrL(s,3*GetColWidth);
      end;
      AddInfo(s);
    end;
    end;
      
    RunBox;
  end;  
end;

end.
