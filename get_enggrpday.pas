unit get_enggrpday;

interface

uses kernel;

procedure BoxGetEngGrpDay;
procedure ShowGetEngGrpDay;

var
  mpEngGrpDay:  array[0..GROUPS-1,0..DAYS-1,0..TARIFFS-1] of extended;
  
implementation

uses SysUtils, soutput, support, borders, progress, realz, timez, calendar, box, main, get_enggrphou;

const
  quGetEngGrpDay: querys = (Action: acGetEngGrpDay; cwOut: 7+6; cwIn: 0; bNumber: $FF);
                            
var
  bDay: byte;

procedure QueryGetEngGrpDay;
begin
  InitPushCRC;
  Push(217);
  Push(bDay);
  if PushGrpMask then Query(quGetEngGrpDay);
end;

procedure BoxGetEngGrpDay;
begin
  if TestDays then begin
    bDay := ibMinDay;
    QueryGetEngGrpDay;
  end;
end;

procedure ShowGetEngGrpDay;
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
    for Tar := 0 to TARIFFS-1 do mpEngGrpDay[Grp,bDay,Tar] := PopReals;

  ShowProgress(bDay-ibMinDay, ibMaxDay-ibMinDay+1);  

  Inc(bDay);
  if bDay <= ibMaxDay then 
    QueryGetEngGrpDay
  else begin
    AddInfo('');
    AddInfo('Ёнерги€ по группам за сутки');

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
        for Tar := 0 to TARIFFS-1 do e := e + mpEngGrpDay[Grp,x,Tar];
        s := s + Reals2StrR(e);
      end;
      AddInfo(s);

      if UseTariffs then begin
        for Tar := 0 to TARIFFS-1 do begin
          s := PackStrR(' тариф '+IntToStr(Tar+1),GetColWidth);
          for x := ibMinDay to ibMaxDay do s := s + PackStrR(Reals2StrR(mpEngGrpDay[Grp,x,Tar]),GetColWidth);
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
            for Tar := 0 to TARIFFS-1 do z := z + mpEngGrpDay[Grp,x,Tar];
            a := mpeEngGD[Grp,x];
            b := z;
            s := s + PackStrR(Reals2Str(b),GetColWidth) + PackStrR(Reals2Str(a),GetColWidth);
            s := s + PackStrR(Reals2Str(b-a),GetColWidth);
            if a <> 0 then s := s + Reals2Str(100*(b-a)/a) + ' %' else s := s + '?';
          AddInfo(s);
        end;
      end;
    end;
    
    BoxRun;
  end;
end;

end.
