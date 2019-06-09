unit get_enggrpmon_x2;

interface

uses kernel;

procedure BoxGetEngGrpMonX2;
procedure ShowGetEngGrpMonX2;

var
  mpEngGrpMonX2:  array[0..GROUPS-1,0..MONTHS-1,0..TARIFFS-1] of extended;

implementation

uses SysUtils, soutput, support, borders, progress, realz, box, timez, calendar, main, get_enggrphou;

const
  quGetEngGrpMonX2: querys = (Action: acGetEngGrpMonX2; cwOut: 7+6; cwIn: 0; bNumber: $FF-2);

var
  bMon:   byte;

procedure QueryGetEngGrpMonX2;
begin
  InitPushCRC;
  Push(220);
  Push(bMon);
  if PushGrpMask then Query(quGetEngGrpMonX2);
end;

procedure BoxGetEngGrpMonX2;
begin
  TestVersion4;
  if TestMonths then begin
    bMon := ibMinMon;
    QueryGetEngGrpMonX2;
  end;  
end;

procedure ShowGetEngGrpMonX2;
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
    for Tar := 0 to TARIFFS-1 do mpEngGrpMonX2[Grp,bMon,Tar] := PopDouble;

  ShowProgress(bMon-ibMinMon, ibMaxMon-ibMinMon+1);  

  Inc(bMon);
  if bMon <= ibMaxMon then 
    QueryGetEngGrpMonX2
  else begin
    AddInfo('');
    AddInfo('Ёнерги€ по группам за мес€ц (двойна€ точность)');

    s := PackStrR('',GetColWidth);
    for x := ibMinMon to ibMaxMon do s := s + PackStrR(Times2StrMon(MonIndexToDate(DateToMonIndex(tiCurr)-x)),GetColWidth);
    AddInfo(s);    
    s := PackStrR('',GetColWidth);
    for x := ibMinMon to ibMaxMon do s := s + PackStrR('мес€ц -'+IntToStr(x),GetColWidth);
    AddInfo(s);

    for Grp := 0 to GROUPS-1 do if GroupChecked(Grp) then begin
      s := PackStrR('группа ' + IntToStr(Grp+1),GetColWidth);
      for x := ibMinMon to ibMaxMon do begin
        e := 0;
        for Tar := 0 to TARIFFS-1 do e := e + mpEngGrpMonX2[Grp,x,Tar];
        s := s + Double2StrR(e);
      end;
      AddInfo(s);

      if UseTariffs then begin
        for Tar := 0 to TARIFFS-1 do begin
          s := PackStrR(' тариф '+IntToStr(Tar+1),GetColWidth);
          for x := ibMinMon to ibMaxMon do s := s + PackStrR(Double2StrR(mpEngGrpMonX2[Grp,x,Tar]),GetColWidth);
          AddInfo(s);
        end;
      end;
    end;

    if frmMain.clbMain.Checked[Ord(acGetEngGrpHou)] then begin    
      AddInfo('');
      AddInfo('—равнение энергии по группам за мес€ц (интегральные и расчетные)');
      for x := ibMinMon to ibMaxMon do begin
        AddInfo(PackStrR('мес€ц -'+IntToStr(x),GetColWidth) + PackStrR(Times2StrMon(MonIndexToDate(DateToMonIndex(tiCurr)-x)),GetColWidth));
        for Grp := 0 to GROUPS-1 do if GroupChecked(Grp) then begin
          s := PackStrR('группа ' + IntToStr(Grp+1),GetColWidth);
            z := 0;
            for Tar := 0 to TARIFFS-1 do z := z + mpEngGrpMonX2[Grp,x,Tar];
            a := mpeEngGM[Grp, ((12 - 1 + tiCurr.bMonth - x) mod 12) + 1];
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
