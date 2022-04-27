unit get_enggrphou;

interface

uses kernel;
procedure BoxGetEngGrpHou;
procedure ShowGetEngGrpHou;

var
  mpeEngGD:    array[0..GROUPS-1,0..DAYS2-1] of extended;
  mpeEngGM:    array[0..GROUPS-1,1..12] of extended;

implementation

uses SysUtils, Classes, soutput, support, borders, progress, box, timez, realz, calendar, main, calc_maxpow;

const
  quGetEngGrpHou: querys = (Action: acGetEngGrpHou; cwOut: 7+6; cwIn: 0; bNumber: $FF;);

var
  mpeEngGDH:    array[0..GROUPS-1,0..DAYS2-1,0..HOURS_IN_DAY-1] of extended;
  mpeEngG:      array[0..GROUPS-1] of extended;
  mpstEngD:     array[0..DAYS2-1] of string;

  mpboEngGM:    array[0..GROUPS-1,1..12] of boolean;
  
  ibDay:        byte;

procedure QueryGetEngGrpHou;
begin
  InitPushCRC;
  Push(157);
  Push(ibDay);
  if PushGrpMask then Query(quGetEngGrpHou);
end;

procedure BoxGetEngGrpHou;
begin 
  if TestDays2 then begin
    ibDay := ibMinDay;
    QueryGetEngGrpHou;
  end;
end;

procedure ShowGetEngGrpHou;
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
      mpeEngGD[Grp,ibDay] := 0;

    for Hou := 0 to HOURS_IN_DAY-1 do begin
      for Grp := 0 to GROUPS-1 do if GroupChecked(Grp) then begin
        eT := PopReals/2;
        begin
          mpeEngGDH[Grp,ibDay,Hou] := eT;
          mpeEngGD[Grp,ibDay] := mpeEngGD[Grp,ibDay] + eT;
          //CalcMaxPow_CalcMax(tiCurr, Grp,ibDay,Hou,eT);
        end;
      end;
    end;

    AddInfo('');
    s := '-' + Int2Str(ibDay) + '  ' + Times2StrDay(DayIndexToDate(DateToDayIndex(tiCurr)-ibDay));
    mpstEngD[ibDay] := s;
    AddInfo('Ёнерги€ по группам за сутки: '+s);

    s := PackStrR('',GetColWidth);
    for Grp := 0 to GROUPS-1 do if GroupChecked(Grp) then
      s := s + PackStrR('группа '+IntToStr(Grp+1),GetColWidth);
    AddInfo(s);

    for Hou := 0 to HOURS_IN_DAY-1 do begin
      s := PackStrR(Int2Str(Hou div 2)+':'+Int2Str((Hou mod 2)*30),GetColWidth);
      for Grp := 0 to GROUPS-1 do if GroupChecked(Grp) then
        s := s + PackStrR(Reals2Str(mpeEngGDH[Grp,ibDay,Hou]),GetColWidth);
      AddInfo(s);
    end;

    AddInfo(PackLine((cbGrpMask+2)*GetColWidth));
    s := PackStrR('всего:',GetColWidth);
    for Grp := 0 to GROUPS-1 do if GroupChecked(Grp) then
      s := s + PackStrR(Reals2Str(mpeEngGD[Grp,ibDay]),GetColWidth);
    AddInfo(s);

    ShowProgress(ibDay-ibMinDay, ibMaxDay-ibMinDay+1);

    Inc(ibDay);
    if ibDay <= ibMaxDay then
      QueryGetEngGrpHou
    else begin
      l := TStringList.Create;
      
      AddInfo('');
      for Grp := 0 to GROUPS-1 do if GroupChecked(Grp) then begin
        mpeEngG[Grp] := 0;
        for z := 1 to 12 do begin
          mpeEngGM[Grp,z] := 0;
          mpboEngGM[Grp,z] := False;
        end;
      end; 
      
      for ibDay := ibMinDay to ibMaxDay do begin
        s := PackStrR('',GetColWidth);
        r := PackStrR('',GetColWidth);
        for Grp := 0 to GROUPS-1 do if GroupChecked(Grp) then begin
          s := s + PackStrR(Reals2Str(mpeEngGD[Grp,ibDay]),GetColWidth);
          r := r + Reals2StrR(mpeEngGD[Grp,ibDay]);
          
          mpeEngG[Grp] := mpeEngG[Grp] + mpeEngGD[Grp,ibDay];
          
          tiT := DayIndexToDate(DateToDayIndex(tiCurr)-ibDay);
          z := tiT.bMonth;
          mpeEngGM[Grp,z] := mpeEngGM[Grp,z] + mpeEngGD[Grp,ibDay];
          mpboEngGM[Grp,z] := True;
        end;
        AddInfo(s + mpstEngD[ibDay]);
        l.Add(r + mpstEngD[ibDay]);
      end;
      AddInfo(PackLine((cbGrpMask+4)*GetColWidth));
      l.Add(PackLine((cbGrpMask+4)*GetColWidth));

      s := PackStrR('всего:',GetColWidth);
      r := PackStrR('всего:',GetColWidth);
      for Grp := 0 to GROUPS-1 do if GroupChecked(Grp) then begin
        s := s + PackStrR(Reals2StrR(mpeEngG[Grp]),GetColWidth);
        r := r + Reals2StrR(mpeEngG[Grp]);
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
          if mpboEngGM[Grp,z] then begin
            s := s + PackStrR(Reals2StrR(mpeEngGM[Grp,z]),GetColWidth);
            r := r + Reals2StrR(mpeEngGM[Grp,z]);
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
      
      BoxRun;
    end;
end;

end.
