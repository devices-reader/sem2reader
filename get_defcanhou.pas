unit get_defcanhou;

interface

uses kernel;
procedure BoxGetDefCanHou;
procedure ShowGetDefCanHou;

var
  mpdwImpCD_:    array[0..CANALS-1,0..DAYS2-1] of longword;
//  mpdwErrCD:    array[0..CANALS-1,0..DAYS2-1] of longword;
  mpdwImpCM_:    array[0..CANALS-1,1..12] of longword;

  mpdwDefCD:    array[0..CANALS-1,0..DAYS2-1] of longword;
  mpdwDefCM:    array[0..CANALS-1,1..12] of longword;

  mpdwDefGD:   array[0..GROUPS-1,0..DAYS2-1] of longword;
  mpdwDefGM:   array[0..GROUPS-1,1..12] of longword;

implementation

uses SysUtils, Classes, soutput, support, {kernel,} borders, progress, box, timez, realz, calendar, get_trans_eng, get_pulse_hou, main, get_group;

const
  quGetDefCanHou: querys = (Action: acGetDefCanHou; cwOut: 7+10; cwIn: 0; bNumber: $FF;);

var
  mpwImpCDH_:    array[0..CANALS-1,0..DAYS2-1,0..HOURS_IN_DAY-1] of word;
  mpdwImpC_:     array[0..CANALS-1] of longword;
  mpstImpD_:     array[0..DAYS2-1] of string;

  mpboImpCM_:    array[0..CANALS-1,1..12] of boolean;
  
  ibDay:        byte;

procedure QueryGetDefCanHou;
begin
  InitPushCRC;
  Push(76);
  Push(ibDay);
  if PushCanMask then Query(quGetDefCanHou);
end;

procedure BoxGetDefCanHou;
begin 
  if TestDays2 then begin
    ibDay := ibMinDay;
    QueryGetDefCanHou;
  end;
end;

procedure ShowGetDefCanHou;
var
  tiT:      times;
  x:        word;
  z,n:      byte;
  Can,Grp:  byte;
  Hou:      word;
  wT:       word;
  r,s:      string;
  e:        extended;
  l:        TStringList;
begin
    Stop;
    InitPop(15);

    for Can := 0 to CANALS-1 do if CanalChecked(Can) then begin
      mpdwImpCD_[Can,ibDay] := 0;
//      mpdwErrCD_[Can,ibDay] := 0;
      mpdwDefCD[Can,ibDay] := 0;
    end;
    for Grp := 0 to GROUPS-1 do if GroupChecked(Grp) then begin
      mpdwDefGD[Grp,ibDay] := 0;
    end;

    for Hou := 0 to HOURS_IN_DAY-1 do begin
      for Can := 0 to CANALS-1 do if CanalChecked(Can) then begin
        wT := PopInt;

        mpwImpCDH_[Can,ibDay,Hou] := wT;
        if wT <> $FFFF then begin
          Inc(mpdwImpCD_[Can,ibDay], wT);
          Inc(mpdwDefCD[Can,ibDay], 1);
        end;
//        else Inc(mpdwErrCD_[Can,ibDay], 1);
      end;
    end;
    
    if frmMain.clbMain.Checked[Ord(acGetGroup)] then begin
      for Grp := 0 to GROUPS-1 do if GroupChecked(Grp) then begin
        if mpgrGroups[Grp].bSize > 0 then begin
          for Can := 0 to mpgrGroups[Grp].bSize-1 do begin
            n := mpgrGroups[Grp].mpnoNodes[Can].ibCanal and $7F;
            Inc(mpdwDefGD[Grp,ibDay], mpdwDefCD[n,ibDay]);
          end;
        end;
      end;
    end;

    AddInfo('');
    s := '-' + Int2Str(ibDay) + '  ' + Times2StrDay(DayIndexToDate(DateToDayIndex(tiCurr)-ibDay));
    mpstImpD_[ibDay] := s;
    AddInfo('»мпульсы по каналам за сутки: '+s);

    s := PackStrR('',GetColWidth);
    for Can := 0 to CANALS-1 do if CanalChecked(Can) then
      s := s + PackStrR('канал '+IntToStr(Can+1),GetColWidth);
{
    s := s + PackStrR('',GetColWidth);
    for Can := 0 to CANALS-1 do if CanalChecked(Can) then
      s := s + PackStrR('канал '+IntToStr(Can+1),GetColWidth);
}
    AddInfo(s);

    for Hou := 0 to HOURS_IN_DAY-1 do begin
      s := PackStrR(Int2Str(Hou div 2)+':'+Int2Str((Hou mod 2)*30),GetColWidth);
      for Can := 0 to CANALS-1 do if CanalChecked(Can) then
        s := s + PackStrR(IntToStr(mpwImpCDH_[Can,ibDay,Hou]),GetColWidth);
{
      s := s + PackStrR('',GetColWidth);
      for Can := 0 to CANALS-1 do if CanalChecked(Can) then
        s := s + Reals2StrR(mpeTransEng[Can]*mpwImpCDH[Can,ibDay,Hou]/mpePulseHou[Can]);
}
      AddInfo(s);
    end;

    AddInfo(PackLine((cbCanMask+2)*GetColWidth));
    s := PackStrR('всего:',GetColWidth);
    for Can := 0 to CANALS-1 do if CanalChecked(Can) then
      s := s + PackStrR(IntToStr(mpdwImpCD_[Can,ibDay]),GetColWidth);
{
    s := s + PackStrR('',GetColWidth);
    for Can := 0 to CANALS-1 do if CanalChecked(Can) then
      s := s + Reals2StrR(mpeTransEng[Can]*mpdwImpCD[Can,ibDay]/mpePulseHou[Can]);
}
    AddInfo(s);

    ShowProgress(ibDay-ibMinDay, ibMaxDay-ibMinDay+1);

    Inc(ibDay);
    if ibDay <= ibMaxDay then
      QueryGetDefCanHou
    else begin
      l := TStringList.Create;
      
      AddInfo('');
      for Can := 0 to CANALS-1 do if CanalChecked(Can) then begin
        mpdwImpC_[Can] := 0;
        for z := 1 to 12 do begin
          mpdwImpCM_[Can,z] := 0;
          mpdwDefCM[Can,z] := 0;
          mpboImpCM_[Can,z] := False;
        end;
      end;
      for Grp := 0 to GROUPS-1 do if GroupChecked(Grp) then begin
        for z := 1 to 12 do begin
          mpdwDefGM[Grp,z] := 0;
        end;
      end;

      for ibDay := ibMinDay to ibMaxDay do begin
        s := PackStrR('',GetColWidth);
        r := PackStrR('',GetColWidth);
        for Can := 0 to CANALS-1 do if CanalChecked(Can) then begin
          s := s + PackStrR(IntToStr(mpdwImpCD_[Can,ibDay]),GetColWidth);
          r := r + Reals2StrR(mpeTransEng[Can]*mpdwImpCD_[Can,ibDay]/mpePulseHou[Can]);
          
          Inc(mpdwImpC_[Can],mpdwImpCD_[Can,ibDay]);
          
          tiT := DayIndexToDate(DateToDayIndex(tiCurr)-ibDay);
          z := tiT.bMonth;
          Inc(mpdwImpCM_[Can,z],mpdwImpCD_[Can,ibDay]);
          Inc(mpdwDefCM[Can,z],mpdwDefCD[Can,ibDay]);
          mpboImpCM_[Can,z] := True;
        end;

        if frmMain.clbMain.Checked[Ord(acGetGroup)] then begin
          tiT := DayIndexToDate(DateToDayIndex(tiCurr)-ibDay);
          z := tiT.bMonth;
          for Grp := 0 to GROUPS-1 do if GroupChecked(Grp) then begin
            Inc(mpdwDefGM[Grp,z], mpdwDefGD[Grp,ibDay]);
          end;
        end;

        AddInfo(s + mpstImpD_[ibDay]);
        l.Add(r + mpstImpD_[ibDay]);
      end;
      AddInfo(PackLine((cbCanMask+4)*GetColWidth));
      l.Add(PackLine((cbCanMask+4)*GetColWidth));


      s := PackStrR('всего:',GetColWidth);
      r := PackStrR('всего:',GetColWidth);
      for Can := 0 to CANALS-1 do if CanalChecked(Can) then begin
        s := s + PackStrR(IntToStr(mpdwImpC_[Can]),GetColWidth);
        r := r + Reals2StrR(mpeTransEng[Can]*mpdwImpC_[Can]/mpePulseHou[Can]);
      end;
      AddInfo(s + 'суток: ' + IntToStr(ibMaxDay-ibMinDay+1));
      l.Add(r + 'суток: ' + IntToStr(ibMaxDay-ibMinDay+1));

      AddInfo('');
      for x := 1 to l.Count do AddInfo(l.Strings[x-1]);
      l.Clear;


      AddInfo('');
      for ibDay := ibMinDay to ibMaxDay do begin
        s := PackStrR('',GetColWidth);
        for Can := 0 to CANALS-1 do if CanalChecked(Can) then begin
          s := s + PackStrR('(+)'+IntToStr(mpdwDefCD[Can,ibDay]),GetColWidth);
        end;
        AddInfo(s + mpstImpD_[ibDay]);
      end;
      AddInfo(PackLine((cbCanMask+4)*GetColWidth));


      AddInfo('');
      for z := 1 to 12 do begin
        s := PackStrR('',GetColWidth);
        r := PackStrR('',GetColWidth);
        for Can := 0 to CANALS-1 do if CanalChecked(Can) then begin
          if mpboImpCM_[Can,z] then begin
            s := s + PackStrR(IntToStr(mpdwImpCM_[Can,z]),GetColWidth);
            r := r + Reals2StrR(mpeTransEng[Can]*mpdwImpCM_[Can,z]/mpePulseHou[Can]);
          end
          else begin
            s := s + PackStrR('-',GetColWidth);
            r := r + PackStrR('-',GetColWidth);
          end;
        end;
        AddInfo(s + 'мес€ц '+IntToStr(z));
        l.Add(r + 'мес€ц '+IntToStr(z));
      end;
      AddInfo(PackLine((cbCanMask+4)*GetColWidth));
      l.Add(PackLine((cbCanMask+4)*GetColWidth));

      AddInfo('');
      for x := 1 to l.Count do AddInfo(l.Strings[x-1]);
      l.Free;

      BoxRun;
    end;
end;

end.
