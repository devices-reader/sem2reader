unit get_defgrpday;

interface

uses kernel;

procedure BoxGetDefGrpDay;
procedure ShowGetDefGrpDay;

var
  mpDefGrpDay:  array[0..GROUPS-1,0..DAYS-1,0..TARIFFS-1] of longword;
  mpReqGrpDay:  array[0..GROUPS-1,0..DAYS-1] of longword;

implementation

uses SysUtils, soutput, support, borders, progress, realz, timez, calendar, box, main, get_defcanhou;

const
  quGetDefGrpDay: querys = (Action: acGetDefGrpDay; cwOut: 7+6; cwIn: 0; bNumber: $FF);
                            
var
  bDay: byte;

procedure QueryGetDefGrpDay;
begin
  InitPushCRC;
  Push(79);
  Push(bDay);
  if PushGrpMask then Query(quGetDefGrpDay);
end;

procedure BoxGetDefGrpDay;
begin
  if TestDays then begin
    bDay := ibMinDay;
    QueryGetDefGrpDay;
  end;
end;

procedure ShowGetDefGrpDay;
var
  Grp,Tar,x:  word;
  s:  string;
  z:    longword;
  a,b:  longint;
begin
  Stop;
  InitPop(15);

  for Grp := 0 to GROUPS-1 do if GroupChecked(Grp) then begin
    mpReqGrpDay[Grp,bDay] := PopLong;
    for Tar := 0 to TARIFFS-1 do mpDefGrpDay[Grp,bDay,Tar] := PopLong;
  end;

  ShowProgress(bDay-ibMinDay, ibMaxDay-ibMinDay+1);  

  Inc(bDay);
  if bDay <= ibMaxDay then 
    QueryGetDefGrpDay
  else begin
    AddInfo('');
    AddInfo('Полная достоверность по группам за сутки');

    s := PackStrR('',GetColWidth);
    for x := ibMinDay to ibMaxDay do s := s + PackStrR(Times2StrDay(DayIndexToDate(DateToDayIndex(tiCurr)-x)),GetColWidth);
    AddInfo(s);
    s := PackStrR('',GetColWidth);
    for x := ibMinDay to ibMaxDay do s := s + PackStrR('сутки -'+IntToStr(x),GetColWidth);
    AddInfo(s);

    for Grp := 0 to GROUPS-1 do if GroupChecked(Grp) then begin 
      s := PackStrR('группа ' + IntToStr(Grp+1),GetColWidth);
      for x := ibMinDay to ibMaxDay do begin
        z := 0;
        for Tar := 0 to TARIFFS-1 do z := z + mpDefGrpDay[Grp,x,Tar];
        s := s + PackStrR(IntToStr(mpReqGrpDay[Grp,x]) + ' ~ ' + IntToStr(z),GetColWidth);
      end;
      AddInfo(s);
    end;


    if UseTariffs then begin
      AddInfo('');
      AddInfo('Полная достоверность по группам за сутки по тарифам');

      s := PackStrR('',GetColWidth);
      for x := ibMinDay to ibMaxDay do s := s + PackStrR(Times2StrDay(DayIndexToDate(DateToDayIndex(tiCurr)-x)),GetColWidth);
      AddInfo(s);
      s := PackStrR('',GetColWidth);
      for x := ibMinDay to ibMaxDay do s := s + PackStrR('сутки -'+IntToStr(x),GetColWidth);
      AddInfo(s);

      for Grp := 0 to GROUPS-1 do if GroupChecked(Grp) then begin
        s := PackStrR('группа ' + IntToStr(Grp+1),GetColWidth);
        for x := ibMinDay to ibMaxDay do begin
          z := 0;
          for Tar := 0 to TARIFFS-1 do z := z + mpDefGrpDay[Grp,x,Tar];
          s := s + PackStrR(IntToStr(mpReqGrpDay[Grp,x]) + ' ~ ' + IntToStr(z),GetColWidth);
        end;
        AddInfo(s);

        for Tar := 0 to TARIFFS-1 do begin
          s := PackStrR(' тариф '+IntToStr(Tar+1),GetColWidth);
          for x := ibMinDay to ibMaxDay do s := s + PackStrR(' '+IntToStr(mpDefGrpDay[Grp,x,Tar]),GetColWidth);
          AddInfo(s);
        end;
      end;
    end;


    if frmMain.clbMain.Checked[Ord(acGetDefCanHou)] then begin
      AddInfo('');
      AddInfo('Сравнение достоверности по группам за сутки (интегральные и расчетные)');
      for x := ibMinDay to ibMaxDay do begin
        AddInfo(PackStrR('сутки -'+IntToStr(x),GetColWidth) + PackStrR(Times2StrDay(DayIndexToDate(DateToDayIndex(tiCurr)-x)),GetColWidth));
        for Grp := 0 to GROUPS-1 do if GroupChecked(Grp) then begin
          s := PackStrR('группа ' + IntToStr(Grp+1),GetColWidth);
            z := 0;
            for Tar := 0 to TARIFFS-1 do z := z + mpDefGrpDay[Grp,x,Tar];
            a := mpdwDefGD[Grp,x];
            b := z;
            s := s + PackStrR(IntToStr(mpReqGrpDay[Grp,x]) + ' ~ ' + IntToStr(b),GetColWidth);
            s := s + PackStrR('? ~ ' + IntToStr(a),GetColWidth);
            s := s + PackStrR(IntToStr(b-a),GetColWidth);
            if a <> 0 then s := s + Reals2Str(100*(b-a)/a) + ' %' else s := s + '?';
          AddInfo(s);
        end;
      end;
    end;
    
    BoxRun;
  end;
end;

end.
