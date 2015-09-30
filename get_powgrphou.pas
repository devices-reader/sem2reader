unit get_powgrphou;

interface

uses kernel;
procedure BoxGetPowGrpHou;
procedure ShowGetPowGrpHou;

var
  mpePowCD:    array[0..GROUPS-1,0..DAYS2-1] of extended;
  mpePowCM:    array[0..GROUPS-1,1..12] of extended;

implementation

uses SysUtils, Classes, soutput, support, {kernel,} borders, progress, box, timez, realz, calendar, main;

const
  quGetPowGrpHou: querys = (Action: acGetPowGrpHou; cwOut: 7+10; cwIn: 0; bNumber: $FF;);

var
  mpePowCDH:    array[0..GROUPS-1,0..DAYS2-1,0..HOURS_IN_DAY-1] of extended;
//  mpePowCD:    array[0..GROUPS-1,0..DAYS2-1] of longword;
  mpePowC:     array[0..GROUPS-1] of extended;
  mpstPowD:     array[0..DAYS2-1] of string;

//  mpePowCM:    array[0..GROUPS-1,1..12] of longword;
  mpboPowCM:    array[0..GROUPS-1,1..12] of boolean;
  
  ibDay:        byte;

procedure QueryGetPowGrpHou;
begin
  InitPushCRC;
  Push(157);
  Push(ibDay);
  if PushGrpMask then Query(quGetPowGrpHou);
end;

procedure BoxGetPowGrpHou;
begin 
  if TestDays2 then begin
    ibDay := ibMinDay;
    QueryGetPowGrpHou;
  end;
end;

procedure ShowGetPowGrpHou;
var
  tiT:      times;
  x:        word;
  z:        byte;
  Grp,Hou:  word;
  eT:       extended;
  r,s:      string;
  e:        extended;
  l:        TStringList;
begin
    Stop;
    InitPop(15);

    for Grp := 0 to GROUPS-1 do if GroupChecked(Grp) then
      mpePowCD[Grp,ibDay] := 0;

    for Hou := 0 to HOURS_IN_DAY-1 do begin
      for Grp := 0 to GROUPS-1 do if GroupChecked(Grp) then begin
        eT := PopReals;
       (*
       if ((ibDay > ibMinDay) and (ibDay < ibMaxDay)) or
          ((ibDay = ibMinDay) and (Hou < 18{frmMain.updMinHou.Position})) or
          ((ibDay = ibMaxDay) and (Hou > 20{frmMain.updMaxHou.Position})) then*) 
        begin
        
          mpePowCDH[Grp,ibDay,Hou] := eT;
//          if wT <> $FFFF then Inc(mpePowCD[Grp,ibDay], wT);
        
        end;
      end;
    end;

    AddInfo('');
    s := '-' + Int2Str(ibDay) + '  ' + Times2StrDay(DayIndexToDate(DateToDayIndex(tiCurr)-ibDay));
    mpstPowD[ibDay] := s;
    AddInfo('ћощность по группам за сутки: '+s);

    s := PackStrR('',GetColWidth);
    for Grp := 0 to GROUPS-1 do if GroupChecked(Grp) then
      s := s + PackStrR('группа '+IntToStr(Grp+1),GetColWidth);
    AddInfo(s);

    for Hou := 0 to HOURS_IN_DAY-1 do begin
      s := PackStrR(Int2Str(Hou div 2)+':'+Int2Str((Hou mod 2)*30),GetColWidth);
      for Grp := 0 to GROUPS-1 do if GroupChecked(Grp) then
        s := s + PackStrR(Reals2Str(mpePowCDH[Grp,ibDay,Hou]),GetColWidth);
      AddInfo(s);
    end;
{
    AddInfo(PackLine((cbGrpMask+2)*GetColWidth));
    s := PackStrR('всего:',GetColWidth);
    for Grp := 0 to GROUPS-1 do if GroupChecked(Grp) then
      s := s + PackStrR(IntToStr(mpePowCD[Grp,ibDay]),GetColWidth);
    AddInfo(s);
}
    ShowProgress(ibDay-ibMinDay, ibMaxDay-ibMinDay+1);

    Inc(ibDay);
    if ibDay <= ibMaxDay then
      QueryGetPowGrpHou
    else begin
{      l := TStringList.Create;
      
      AddInfo('');
      for Grp := 0 to GROUPS-1 do if GroupChecked(Grp) then begin
        mpePowC[Grp] := 0;
        for z := 1 to 12 do begin
          mpePowCM[Grp,z] := 0;
          mpboPowCM[Grp,z] := False;
        end;
      end; 
      
      for ibDay := ibMinDay to ibMaxDay do begin
        s := PackStrR('',GetColWidth);
        r := PackStrR('',GetColWidth);
        for Grp := 0 to GROUPS-1 do if GroupChecked(Grp) then begin
          s := s + PackStrR(IntToStr(mpePowCD[Grp,ibDay]),GetColWidth);
          r := r + Reals2StrR(mpeTransEng[Grp]*mpePowCD[Grp,ibDay]/mpePulseHou[Grp]);
          
          Inc(mpePowC[Grp],mpePowCD[Grp,ibDay]);
          
          tiT := DayIndexToDate(DateToDayIndex(tiCurr)-ibDay);
          z := tiT.bMonth;
          Inc(mpePowCM[Grp,z],mpePowCD[Grp,ibDay]);
          mpboPowCM[Grp,z] := True;
        end;
        AddInfo(s + mpstPowD[ibDay]);
        l.Add(r + mpstPowD[ibDay]);
      end;
      AddInfo(PackLine((cbGrpMask+4)*GetColWidth));
      l.Add(PackLine((cbGrpMask+4)*GetColWidth));

      s := PackStrR('всего:',GetColWidth);
      r := PackStrR('всего:',GetColWidth);
      for Grp := 0 to GROUPS-1 do if GroupChecked(Grp) then begin
        s := s + PackStrR(IntToStr(mpePowC[Grp]),GetColWidth);
        r := r + Reals2StrR(mpeTransEng[Grp]*mpePowC[Grp]/mpePulseHou[Grp]);
      end;  
      AddInfo(s + 'суток: ' + IntToStr(ibMaxDay-ibMinDay+1));
      l.Add(r + 'суток: ' + IntToStr(ibMaxDay-ibMinDay+1));

      AddInfo('');
      for x := 1 to l.Count do AddInfo(l.Strings[x-1]);
      l.Clear;
      
      AddInfo('');
      for z := 1 to 12 do begin
        s := PackStrR('',GetColWidth);
        r := PackStrR('',GetColWidth);
        for Grp := 0 to GROUPS-1 do if GroupChecked(Grp) then begin
          if mpboPowCM[Grp,z] then begin
            s := s + PackStrR(IntToStr(mpePowCM[Grp,z]),GetColWidth);
            r := r + Reals2StrR(mpeTransEng[Grp]*mpePowCM[Grp,z]/mpePulseHou[Grp]);
          end  
          else begin
            s := s + PackStrR('-',GetColWidth);
            r := r + PackStrR('-',GetColWidth);
          end;  
        end;
        AddInfo(s + 'мес€ц '+IntToStr(z));
        l.Add(r + 'мес€ц '+IntToStr(z));
      end;
      AddInfo(PackLine((cbGrpMask+4)*GetColWidth));
      l.Add(PackLine((cbGrpMask+4)*GetColWidth));

      AddInfo('');
      for x := 1 to l.Count do AddInfo(l.Strings[x-1]);
      l.Free;
}      
      BoxRun;
    end;
end;

end.
