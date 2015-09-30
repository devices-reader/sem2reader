unit get_defgrpday2;

interface

uses kernel;

procedure BoxGetDefGrpDay2;
procedure ShowGetDefGrpDay2;

var
  mpDefGrpDay2:  array[0..GROUPS-1,0..DAYS-1] of byte;

implementation

uses SysUtils, soutput, support, borders, progress, realz, timez, calendar, box, main, get_defcanhou;

const
  quGetDefGrpDay2: querys = (Action: acGetDefGrpDay2; cwOut: 7+6; cwIn: 15+GROUPS+2; bNumber: $FF);
                            
var
  bDay: byte;

procedure QueryGetDefGrpDay2;
begin
  InitPushCRC;
  Push(83);
  Push(bDay);
  if PushGrpMask then Query(quGetDefGrpDay2);
end;

procedure BoxGetDefGrpDay2;
begin
  if TestDays then begin
    bDay := ibMinDay;
    QueryGetDefGrpDay2;
  end;
end;

procedure ShowGetDefGrpDay2;
var
  Grp,x:word;
  s:    string;
begin
  Stop;
  InitPop(15);

  for Grp := 0 to GROUPS-1 do begin
    mpDefGrpDay2[Grp,bDay] := Pop;
  end;

  ShowProgress(bDay-ibMinDay, ibMaxDay-ibMinDay+1);  

  Inc(bDay);
  if bDay <= ibMaxDay then 
    QueryGetDefGrpDay2
  else begin
    AddInfo('');
    AddInfo('Краткая достоверность по группам за сутки');

    s := PackStrR('',GetColWidth);
    for x := ibMinDay to ibMaxDay do s := s + PackStrR(Times2StrDay(DayIndexToDate(DateToDayIndex(tiCurr)-x)),GetColWidth);
    AddInfo(s);
    s := PackStrR('',GetColWidth);
    for x := ibMinDay to ibMaxDay do s := s + PackStrR('сутки -'+IntToStr(x),GetColWidth);
    AddInfo(s);

    for Grp := 0 to GROUPS-1 do if GroupChecked(Grp) then begin 
      s := PackStrR('группа ' + IntToStr(Grp+1),GetColWidth);
      for x := ibMinDay to ibMaxDay do begin
        s := s + PackStrR(Bool2Str(mpDefGrpDay2[Grp,x]),GetColWidth);
      end;
      AddInfo(s);
    end;

    
    BoxRun;
  end;
end;

end.
