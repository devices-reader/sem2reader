unit get_maxgrpmon;

interface

uses kernel;

var
  mpMaxGrpMon:  array[0..GROUPS-1,0..MONTHS-1,0..TARIFFS-1] of maximum;

procedure BoxGetMaxGrpMon;
procedure ShowGetMaxGrpMon;

implementation

uses SysUtils, soutput, support, borders, progress, box, timez, realz, calendar;

const
  quGetMaxGrpMon: querys = (Action: acGetMaxGrpMon; cwOut: 7+6; cwIn: 0; bNumber: $FF);
  
var
  bMon:  byte;

procedure QueryGetMaxGrpMon;
begin
  InitPushCRC;
  Push(226);
  Push(bMon);
  if PushGrpMask then Query(quGetMaxGrpMon);
end;

procedure BoxGetMaxGrpMon;
begin
  if TestMonths then begin
    bMon := ibMinMon;
    QueryGetMaxGrpMon;
  end;  
end;

procedure ShowGetMaxGrpMon;
var
  x,
  Grp,Tar:  word;
  s:        string;
begin
  Stop; 
  InitPop(15);

  for Grp := 0 to GROUPS-1 do if GroupChecked(Grp) then
    for Tar := 0 to TARIFFS-1 do begin
      mpMaxGrpMon[Grp,bMon,Tar].timValue := PopTimes;
      mpMaxGrpMon[Grp,bMon,Tar].extValue := PopReals;
    end;  
    
  ShowProgress(bMon-ibMinMon, ibMaxMon-ibMinMon+1);  
            
  Inc(bMon);
  if bMon <= ibMaxMon then 
    QueryGetMaxGrpMon
  else begin
    AddInfo('');
    AddInfo('��������� �������� �� ������� �� �����');
    
    for x := ibMinMon to ibMaxMon do begin
    
    AddInfo('');
    AddInfo('����� -' + IntToStr(x) + ' ' + Times2StrMon(MonIndexToDate(DateToMonIndex(tiCurr)-x)));

    for Grp := 0 to GROUPS-1 do if GroupChecked(Grp) then begin
      s := PackStrR('������ '+IntToStr(Grp+1),GetColWidth);

      for Tar := 0 to TARIFFS-1 do begin
        s := s + Reals2StrL(mpMaxGrpMon[Grp,x,Tar].extValue) + ' ';
        s := s + Times2Str(mpMaxGrpMon[Grp,x,Tar].timValue);
        s := PackStrL(s,3*GetColWidth);
      end;
      AddInfo(s);
    end;
    end;
      
    RunBox;
  end;  
end;

end.
