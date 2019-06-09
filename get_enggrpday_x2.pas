unit get_enggrpday_x2;

interface

uses kernel;

procedure BoxGetEngGrpDayX2;
procedure ShowGetEngGrpDayX2;

var
  mpEngGrpDayX2:  array[0..GROUPS-1,0..DAYS-1,0..TARIFFS-1] of extended;
  
implementation

uses SysUtils, soutput, support, borders, progress, realz, timez, calendar, box, main, get_enggrphou;

const
  quGetEngGrpDayX2: querys = (Action: acGetEngGrpDayX2; cwOut: 7+6; cwIn: 0; bNumber: $FF-2);
                            
var
  bDay: byte;

procedure QueryGetEngGrpDayX2;
begin
  InitPushCRC;
  Push(217);
  Push(bDay);
  if PushGrpMask then Query(quGetEngGrpDayX2);
end;

procedure BoxGetEngGrpDayX2;
begin
  TestVersion4;
  if TestDays then begin
    bDay := ibMinDay;
    QueryGetEngGrpDayX2;
  end;
end;

procedure ShowGetEngGrpDayX2;
var
  Grp,Tar,x:  word;
  e:  extended;
  s:  string;
  z:    extended;
  a,b:  extended;
begin
  Stop;
  InitPop(15);

  for Grp := 0 to GROUPS-1 do if GroupChecked(Grp) then 
    for Tar := 0 to TARIFFS-1 do mpEngGrpDayX2[Grp,bDay,Tar] := PopDouble;

  ShowProgress(bDay-ibMinDay, ibMaxDay-ibMinDay+1);  

  Inc(bDay);
  if bDay <= ibMaxDay then 
    QueryGetEngGrpDayX2
  else begin
    AddInfo('');
    AddInfo('Ёнерги€ по группам за сутки (двойна€ точность)');

    s := PackStrR('',GetColWidth);
    for x := ibMinDay to ibMaxDay do s := s + PackStrR(Times2StrDay(DayIndexToDate(DateToDayIndex(tiCurr)-x)),GetColWidth);
    AddInfo(s);
    s := PackStrR('',GetColWidth);
    for x := ibMinDay to ibMaxDay do s := s + PackStrR('сутки -'+IntToStr(x),GetColWidth);
    AddInfo(s);

    for Grp := 0 to GROUPS-1 do if GroupChecked(Grp) then begin 
      s := PackStrR('группа ' + IntToStr(Grp+1),GetColWidth);
      for x := ibMinDay to ibMaxDay do begin
        e := 0;
        for Tar := 0 to TARIFFS-1 do e := e + mpEngGrpDayX2[Grp,x,Tar];
        s := s + Double2StrR(e);
      end;
      AddInfo(s);

      if UseTariffs then begin
        for Tar := 0 to TARIFFS-1 do begin
          s := PackStrR(' тариф '+IntToStr(Tar+1),GetColWidth);
          for x := ibMinDay to ibMaxDay do s := s + PackStrR(Double2StrR(mpEngGrpDayX2[Grp,x,Tar]),GetColWidth);
          AddInfo(s);
        end;
      end;
    end;
    
    if frmMain.clbMain.Checked[Ord(acGetEngGrpHou)] then begin    
      AddInfo('');
      AddInfo('—равнение энергии по группам за сутки (интегральные и расчетные)');
      for x := ibMinDay to ibMaxDay do begin
        AddInfo(PackStrR('сутки -'+IntToStr(x),GetColWidth) + PackStrR(Times2StrDay(DayIndexToDate(DateToDayIndex(tiCurr)-x)),GetColWidth));
        for Grp := 0 to GROUPS-1 do if GroupChecked(Grp) then begin
          s := PackStrR('группа ' + IntToStr(Grp+1),GetColWidth);
            z := 0;
            for Tar := 0 to TARIFFS-1 do z := z + mpEngGrpDayX2[Grp,x,Tar];
            a := mpeEngGD[Grp,x];
            b := z;
            s := s + PackStrR(Double2Str(b),GetColWidth) + PackStrR(Double2Str(a),GetColWidth);
            s := s + PackStrR(Double2Str(b-a),GetColWidth);
            if a <> 0 then s := s + Double2Str(100*(b-a)/a) + ' %' else s := s + '?';
          AddInfo(s);
        end;
      end;
    end;
    
    BoxRun;
  end;
end;

end.
