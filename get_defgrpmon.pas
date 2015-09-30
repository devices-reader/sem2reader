unit get_defgrpmon;

interface

uses kernel;

procedure BoxGetDefGrpMon;
procedure ShowGetDefGrpMon;

var
  mpDefGrpMon:  array[0..GROUPS-1,0..MONTHS-1,0..TARIFFS-1] of longword;
  mpReqGrpMon:  array[0..GROUPS-1,0..MONTHS-1] of longword;
  
implementation

uses SysUtils, soutput, support, borders, progress, realz, timez, calendar, box, main, get_defcanhou;

const
  quGetDefGrpMon: querys = (Action: acGetDefGrpMon; cwOut: 7+6; cwIn: 0; bNumber: $FF);
                            
var
  bMon: byte;

procedure QueryGetDefGrpMon;
begin
  InitPushCRC;
  Push(80);
  Push(bMon);
  if PushGrpMask then Query(quGetDefGrpMon);
end;

procedure BoxGetDefGrpMon;
begin
  if TestMonths then begin
    bMon := ibMinMon;
    QueryGetDefGrpMon;
  end;
end;

procedure ShowGetDefGrpMon;
var
  Grp,Tar,x:  word;
  s:  string;
  z:    longword;
  a,b:  longint;
begin
  Stop;
  InitPop(15);

  for Grp := 0 to GROUPS-1 do if GroupChecked(Grp) then begin
    mpReqGrpMon[Grp,bMon] := PopLong;
    for Tar := 0 to TARIFFS-1 do mpDefGrpMon[Grp,bMon,Tar] := PopLong;
  end;  

  ShowProgress(bMon-ibMinMon, ibMaxMon-ibMinMon+1);  

  Inc(bMon);
  if bMon <= ibMaxMon then 
    QueryGetDefGrpMon
  else begin
    AddInfo('');
    AddInfo('ѕолна€ достоверность по группам за мес€ц');

    s := PackStrR('',GetColWidth);
    for x := ibMinMon to ibMaxMon do s := s + PackStrR(Times2Strmon(monIndexToDate(DateTomonIndex(tiCurr)-x)),GetColWidth);
    AddInfo(s);
    s := PackStrR('',GetColWidth);
    for x := ibMinMon to ibMaxMon do s := s + PackStrR('мес€ц -'+IntToStr(x),GetColWidth);
    AddInfo(s);

    for Grp := 0 to GROUPS-1 do if GroupChecked(Grp) then begin 
      s := PackStrR('группа ' + IntToStr(Grp+1),GetColWidth);
      for x := ibMinMon to ibMaxMon do begin
        z := 0;
        for Tar := 0 to TARIFFS-1 do z := z + mpDefGrpMon[Grp,x,Tar];
        s := s + PackStrR(IntToStr(mpReqGrpMon[Grp,x]) + ' ~ ' + IntToStr(z),GetColWidth);
      end;
      AddInfo(s);
    end;


    if UseTariffs then begin
      AddInfo('');
      AddInfo('ѕолна€ достоверность по группам за мес€ц по тарифам');

      s := PackStrR('',GetColWidth);
      for x := ibMinMon to ibMaxMon do s := s + PackStrR(Times2StrMon(MonIndexToDate(DateToMonIndex(tiCurr)-x)),GetColWidth);
      AddInfo(s);
      s := PackStrR('',GetColWidth);
      for x := ibMinMon to ibMaxMon do s := s + PackStrR('мес€ц -'+IntToStr(x),GetColWidth);
      AddInfo(s);

      for Grp := 0 to GROUPS-1 do if GroupChecked(Grp) then begin
        s := PackStrR('группа ' + IntToStr(Grp+1),GetColWidth);
        for x := ibMinMon to ibMaxMon do begin
          z := 0;
          for Tar := 0 to TARIFFS-1 do z := z + mpDefGrpMon[Grp,x,Tar];
          s := s + PackStrR(IntToStr(mpReqGrpMon[Grp,x]) + ' ~ ' + IntToStr(z),GetColWidth);
        end;
        AddInfo(s);

        for Tar := 0 to TARIFFS-1 do begin
          s := PackStrR(' тариф '+IntToStr(Tar+1),GetColWidth);
          for x := ibMinMon to ibMaxMon do s := s + PackStrR(' '+IntToStr(mpDefGrpMon[Grp,x,Tar]),GetColWidth);
          AddInfo(s);
        end;
      end;
    end;


    if frmMain.clbMain.Checked[Ord(acGetDefCanHou)] then begin    
      AddInfo('');
      AddInfo('—равнение достоверности по группам за мес€ц (интегральные и расчетные)');
      for x := ibMinMon to ibMaxMon do begin
        AddInfo(PackStrR('мес€ц -'+IntToStr(x),GetColWidth) + PackStrR(Times2Strmon(monIndexToDate(DateTomonIndex(tiCurr)-x)),GetColWidth));
        for Grp := 0 to GROUPS-1 do if GroupChecked(Grp) then begin
          s := PackStrR('группа ' + IntToStr(Grp+1),GetColWidth);
            z := 0;
            for Tar := 0 to TARIFFS-1 do z := z + mpDefGrpMon[Grp,x,Tar];
            a := mpdwDefGM[Grp, ((12 - 1 + tiCurr.bMonth - x) mod 12) + 1];
            b := z;
            s := s + PackStrR(IntToStr(mpReqGrpMon[Grp,x]) + ' ~ ' + IntToStr(b),GetColWidth);
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
