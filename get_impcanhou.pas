unit get_impcanhou;

interface

uses kernel;
procedure BoxGetImpCanHou;
procedure ShowGetImpCanHou;

var
  mpdwImpCD:    array[0..CANALS-1,0..DAYS2-1] of longword;
  mpdwErrCD:    array[0..CANALS-1,0..DAYS2-1] of longword;
  mpdwDefCD:    array[0..CANALS-1,0..DAYS2-1] of longword;
  mpdwImpCM:    array[0..CANALS-1,1..12] of longword;
  mpdwDefCM:    array[0..CANALS-1,1..12] of longword;

implementation

uses SysUtils, Classes, soutput, support, {kernel,} borders, progress, box, timez, realz, calendar, get_trans_eng, get_pulse_hou, main;

const
  quGetImpCanHou: querys = (Action: acGetImpCanHou; cwOut: 7+10; cwIn: 0; bNumber: $FF;);

var
  mpwImpCDH:    array[0..CANALS-1,0..DAYS2-1,0..HOURS_IN_DAY-1] of word;
  mpdwImpC:     array[0..CANALS-1] of longword;
  mpstImpD:     array[0..DAYS2-1] of string;

  mpboImpCM:    array[0..CANALS-1,1..12] of boolean;

  ibDay:        byte;

procedure QueryGetImpCanHou;
begin
  InitPushCRC;
  Push(158);
  Push(ibDay);
  if PushCanMask then Query(quGetImpCanHou);
end;

procedure BoxGetImpCanHou;
begin 
  if TestDays2 then begin
    ibDay := ibMinDay;
    QueryGetImpCanHou;
  end;
end;

procedure ShowGetImpCanHou;
var
  tiT:      times;
  x:        word;
  z:        byte;
  Can,Hou:  word;
  wT:       word;
  r,s:      string;
  e:        extended;
  l:        TStringList;
begin
    Stop;
    InitPop(15);

    for Can := 0 to CANALS-1 do if CanalChecked(Can) then begin
      mpdwImpCD[Can,ibDay] := 0;
      mpdwErrCD[Can,ibDay] := 0;
    end;

    for Hou := 0 to HOURS_IN_DAY-1 do begin
      for Can := 0 to CANALS-1 do if CanalChecked(Can) then begin
        wT := PopInt;

        mpwImpCDH[Can,ibDay,Hou] := wT;
        if wT <> $FFFF then begin
          Inc(mpdwImpCD[Can,ibDay], wT);
          Inc(mpdwDefCD[Can,ibDay], 1);
        end
        else Inc(mpdwErrCD[Can,ibDay], 1);
      end;
    end;

    AddInfo('');
    s := '-' + Int2Str(ibDay) + '  ' + Times2StrDay(DayIndexToDate(DateToDayIndex(tiCurr)-ibDay));
    mpstImpD[ibDay] := s;
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
//      if (Hou mod 6 = 0) then AddInfo('');
      
      s := PackStrR(Int2Str(Hou div 2)+':'+Int2Str((Hou mod 2)*30),GetColWidth);
      for Can := 0 to CANALS-1 do if CanalChecked(Can) then
        s := s + PackStrR(IntToStr(mpwImpCDH[Can,ibDay,Hou]),GetColWidth);
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
      s := s + PackStrR(IntToStr(mpdwImpCD[Can,ibDay]),GetColWidth);
{
    s := s + PackStrR('',GetColWidth);
    for Can := 0 to CANALS-1 do if CanalChecked(Can) then
      s := s + Reals2StrR(mpeTransEng[Can]*mpdwImpCD[Can,ibDay]/mpePulseHou[Can]);
}
    AddInfo(s);

    ShowProgress(ibDay-ibMinDay, ibMaxDay-ibMinDay+1);

    Inc(ibDay);
    if ibDay <= ibMaxDay then
      QueryGetImpCanHou
    else begin
      l := TStringList.Create;
      
      AddInfo('');
      for Can := 0 to CANALS-1 do if CanalChecked(Can) then begin
        mpdwImpC[Can] := 0;
        for z := 1 to 12 do begin
          mpdwImpCM[Can,z] := 0;
          mpdwDefCM[Can,z] := 0;
          mpboImpCM[Can,z] := False;
        end;
      end; 
      
      for ibDay := ibMinDay to ibMaxDay do begin
        s := PackStrR('',GetColWidth);
        r := PackStrR('',GetColWidth);
        for Can := 0 to CANALS-1 do if CanalChecked(Can) then begin
          s := s + PackStrR(IntToStr(mpdwImpCD[Can,ibDay]),GetColWidth);
          r := r + Reals2StrR(mpeTransEng[Can]*mpdwImpCD[Can,ibDay]/mpePulseHou[Can]);
          
          Inc(mpdwImpC[Can],mpdwImpCD[Can,ibDay]);
          
          tiT := DayIndexToDate(DateToDayIndex(tiCurr)-ibDay);
          z := tiT.bMonth;
          Inc(mpdwImpCM[Can,z],mpdwImpCD[Can,ibDay]);
          Inc(mpdwDefCM[Can,z],mpdwDefCD[Can,ibDay]);
          mpboImpCM[Can,z] := True;
        end;
        AddInfo(s + mpstImpD[ibDay]);
        l.Add(r + mpstImpD[ibDay]);
      end;
      AddInfo(PackLine((cbCanMask+4)*GetColWidth));
      l.Add(PackLine((cbCanMask+4)*GetColWidth));


      s := PackStrR('всего:',GetColWidth);
      r := PackStrR('всего:',GetColWidth);
      for Can := 0 to CANALS-1 do if CanalChecked(Can) then begin
        s := s + PackStrR(IntToStr(mpdwImpC[Can]),GetColWidth);
        r := r + Reals2StrR(mpeTransEng[Can]*mpdwImpC[Can]/mpePulseHou[Can]);
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
          s := s + PackStrR('(-)'+IntToStr(mpdwErrCD[Can,ibDay]),GetColWidth);
        end;
        AddInfo(s + mpstImpD[ibDay]);
      end;
      AddInfo(PackLine((cbCanMask+4)*GetColWidth));


      AddInfo('');
      for z := 1 to 12 do begin
        s := PackStrR('',GetColWidth);
        r := PackStrR('',GetColWidth);
        for Can := 0 to CANALS-1 do if CanalChecked(Can) then begin
          if mpboImpCM[Can,z] then begin
            s := s + PackStrR(IntToStr(mpdwImpCM[Can,z]),GetColWidth);
            r := r + Reals2StrR(mpeTransEng[Can]*mpdwImpCM[Can,z]/mpePulseHou[Can]);
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
{
      if Checked[Ord(acGetGroups)] then begin
        AddInfo('');
        for Grp := 0 to GROUPS-1 do if GroupChecked(Grp) then begin
          s := PackStrR('группа '+IntToStr(Grp+1),GetColWidth);
        end;
      end;
      
      s := '';
      e := 0;
      for Can := 0 to CANALS-1 do if CanalChecked(Can) then begin
        s := s + ' + ' + IntToStr(Can+1);
        for z := 1 to 12 do begin
            if mpboImpCM[Can,z] then begin
               e := e + mpeTransEng[Can]*mpdwImpCM[Can,z]/mpePulseHou[Can];
            end;
        end;    
      end;
      AddInfo(' аналы:   '+s);
      AddInfo('«начение: '+Reals2StrR(e));
}      
      BoxRun;
    end;
end;

end.
