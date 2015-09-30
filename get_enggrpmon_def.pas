unit get_enggrpmon_def;

interface

uses kernel;

procedure BoxGetEngGrpMon_Def;
procedure ShowGetEngGrpMon_Def;

var
  mpEngGrpMon_Def:  array[0..GROUPS-1,0..MONTHS-1,0..TARIFFS-1] of extended;

implementation

uses SysUtils, soutput, support, borders, progress, realz, box, timez, calendar, main{, get_enggrphou};

const
  quGetEngGrpMon_Def: querys = (Action: acGetEngGrpMon_Def; cwOut: 7+6; cwIn: 0; bNumber: $FF);

var
  bMon:   byte;

procedure QueryGetEngGrpMon_Def;
begin
  InitPushCRC;
  Push(86);
  Push(bMon);
  if PushGrpMask then Query(quGetEngGrpMon_Def);
end;

procedure BoxGetEngGrpMon_Def;
begin
  if TestMonths then begin
    bMon := ibMinMon;
    QueryGetEngGrpMon_Def;
  end;  
end;

procedure ShowGetEngGrpMon_Def;
var
  Grp,Tar,x:  word;
  e:  extended;
  s:  string;
begin
  Stop;
  InitPop(15);

  for Grp := 0 to GROUPS-1 do if GroupChecked(Grp) then   
    for Tar := 0 to TARIFFS-1 do mpEngGrpMon_Def[Grp,bMon,Tar] := PopReals;

  ShowProgress(bMon-ibMinMon, ibMaxMon-ibMinMon+1);  

  Inc(bMon);
  if bMon <= ibMaxMon then 
    QueryGetEngGrpMon_Def
  else begin
    AddInfo('');
    AddInfo('Ёнерги€ по группам за мес€ц');

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
        for Tar := 0 to TARIFFS-1 do e := e + mpEngGrpMon_Def[Grp,x,Tar];
        s := s + Reals2StrR(e);
      end;
      AddInfo(s);

      if UseTariffs then begin
        for Tar := 0 to TARIFFS-1 do begin
          s := PackStrR(' тариф '+IntToStr(Tar+1),GetColWidth);
          for x := ibMinMon to ibMaxMon do s := s + PackStrR(Reals2StrR(mpEngGrpMon_Def[Grp,x,Tar]),GetColWidth);
          AddInfo(s);
        end;
      end;
    end;
{
    if frmMain.clbMain.Checked[Ord(acGetEngGrpHou)] then begin
      AddInfo('');
      AddInfo('—равнение энергии по группам за мес€ц (интегральные и расчетные)');
      for x := ibMinMon to ibMaxMon do begin
        AddInfo(PackStrR('мес€ц -'+IntToStr(x),GetColWidth) + PackStrR(Times2StrMon(MonIndexToDate(DateToMonIndex(tiCurr)-x)),GetColWidth));
        for Grp := 0 to GROUPS-1 do if GroupChecked(Grp) then begin
          s := PackStrR('группа ' + IntToStr(Grp+1),GetColWidth);
            z := 0;
            for Tar := 0 to TARIFFS-1 do z := z + mpEngGrpMon_Def[Grp,x,Tar];
            a := mpeEngGM[Grp, ((12 - 1 + tiCurr.bMonth - x) mod 12) + 1];
            b := z;
            s := s + PackStrR(Reals2Str(b),GetColWidth) + PackStrR(Reals2Str(a),GetColWidth);
            s := s + PackStrR(Reals2Str(b-a),GetColWidth);
            if a <> 0 then s := s + Reals2Str(100*(b-a)/a) + ' %' else s := s + '?';
          AddInfo(s);
        end;
      end;
    end;
}
    BoxRun;
  end;
end;

end.
