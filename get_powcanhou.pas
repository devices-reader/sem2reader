unit get_powcanhou;

interface

uses kernel;
procedure BoxGetPowCanHou;
procedure ShowGetPowCanHou;

var
  mpePowCD:    array[0..CANALS-1,0..DAYS2-1] of extended;
  mpePowCM:    array[0..CANALS-1,1..12] of extended;

implementation

uses SysUtils, Classes, soutput, support, {kernel,} borders, progress, box, timez, realz, calendar, main;

const
  quGetPowCanHou: querys = (Action: acGetPowCanHou; cwOut: 7+10; cwIn: 0; bNumber: $FF;);

var
  mpePowCDH:    array[0..CANALS-1,0..DAYS2-1,0..HOURS_IN_DAY-1] of extended;
//  mpePowCD:    array[0..CANALS-1,0..DAYS2-1] of longword;
  mpePowC:     array[0..CANALS-1] of extended;
  mpstPowD:     array[0..DAYS2-1] of string;

//  mpePowCM:    array[0..CANALS-1,1..12] of longword;
  mpboPowCM:    array[0..CANALS-1,1..12] of boolean;
  
  ibDay:        byte;

procedure QueryGetPowCanHou;
begin
  InitPushCRC;
  Push(159);
  Push(ibDay);
  if PushCanMask then Query(quGetPowCanHou);
end;

procedure BoxGetPowCanHou;
begin 
  if TestDays2 then begin
    ibDay := ibMinDay;
    QueryGetPowCanHou;
  end;
end;

procedure ShowGetPowCanHou;
var
  tiT:      times;
  x:        word;
  z:        byte;
  Can,Hou:  word;
  eT:       extended;
  r,s:      string;
  e:        extended;
  l:        TStringList;
begin
    Stop;
    InitPop(15);

    for Can := 0 to CANALS-1 do if CanalChecked(Can) then
      mpePowCD[Can,ibDay] := 0;

    for Hou := 0 to HOURS_IN_DAY-1 do begin
      for Can := 0 to CANALS-1 do if CanalChecked(Can) then begin
        eT := PopReals;
       (*
       if ((ibDay > ibMinDay) and (ibDay < ibMaxDay)) or
          ((ibDay = ibMinDay) and (Hou < 18{frmMain.updMinHou.Position})) or
          ((ibDay = ibMaxDay) and (Hou > 20{frmMain.updMaxHou.Position})) then*) 
        begin
        
          mpePowCDH[Can,ibDay,Hou] := eT;
//          if wT <> $FFFF then Inc(mpePowCD[Can,ibDay], wT);
        
        end;
      end;
    end;

    AddInfo('');
    s := '-' + Int2Str(ibDay) + '  ' + Times2StrDay(DayIndexToDate(DateToDayIndex(tiCurr)-ibDay));
    mpstPowD[ibDay] := s;
    AddInfo('ћощность по каналам за сутки: '+s);

    s := PackStrR('',GetColWidth);
    for Can := 0 to CANALS-1 do if CanalChecked(Can) then
      s := s + PackStrR('канал '+IntToStr(Can+1),GetColWidth);
    AddInfo(s);

    for Hou := 0 to HOURS_IN_DAY-1 do begin
      s := PackStrR(Int2Str(Hou div 2)+':'+Int2Str((Hou mod 2)*30),GetColWidth);
      for Can := 0 to CANALS-1 do if CanalChecked(Can) then
        s := s + PackStrR(Reals2Str(mpePowCDH[Can,ibDay,Hou]),GetColWidth);
      AddInfo(s);
    end;
{
    AddInfo(PackLine((cbCanMask+2)*GetColWidth));
    s := PackStrR('всего:',GetColWidth);
    for Can := 0 to CANALS-1 do if CanalChecked(Can) then
      s := s + PackStrR(IntToStr(mpePowCD[Can,ibDay]),GetColWidth);
    AddInfo(s);
}
    ShowProgress(ibDay-ibMinDay, ibMaxDay-ibMinDay+1);

    Inc(ibDay);
    if ibDay <= ibMaxDay then
      QueryGetPowCanHou
    else begin
{      l := TStringList.Create;
      
      AddInfo('');
      for Can := 0 to CANALS-1 do if CanalChecked(Can) then begin
        mpePowC[Can] := 0;
        for z := 1 to 12 do begin
          mpePowCM[Can,z] := 0;
          mpboPowCM[Can,z] := False;
        end;
      end; 
      
      for ibDay := ibMinDay to ibMaxDay do begin
        s := PackStrR('',GetColWidth);
        r := PackStrR('',GetColWidth);
        for Can := 0 to CANALS-1 do if CanalChecked(Can) then begin
          s := s + PackStrR(IntToStr(mpePowCD[Can,ibDay]),GetColWidth);
          r := r + Reals2StrR(mpeTransEng[Can]*mpePowCD[Can,ibDay]/mpePulseHou[Can]);
          
          Inc(mpePowC[Can],mpePowCD[Can,ibDay]);
          
          tiT := DayIndexToDate(DateToDayIndex(tiCurr)-ibDay);
          z := tiT.bMonth;
          Inc(mpePowCM[Can,z],mpePowCD[Can,ibDay]);
          mpboPowCM[Can,z] := True;
        end;
        AddInfo(s + mpstPowD[ibDay]);
        l.Add(r + mpstPowD[ibDay]);
      end;
      AddInfo(PackLine((cbCanMask+4)*GetColWidth));
      l.Add(PackLine((cbCanMask+4)*GetColWidth));

      s := PackStrR('всего:',GetColWidth);
      r := PackStrR('всего:',GetColWidth);
      for Can := 0 to CANALS-1 do if CanalChecked(Can) then begin
        s := s + PackStrR(IntToStr(mpePowC[Can]),GetColWidth);
        r := r + Reals2StrR(mpeTransEng[Can]*mpePowC[Can]/mpePulseHou[Can]);
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
        for Can := 0 to CANALS-1 do if CanalChecked(Can) then begin
          if mpboPowCM[Can,z] then begin
            s := s + PackStrR(IntToStr(mpePowCM[Can,z]),GetColWidth);
            r := r + Reals2StrR(mpeTransEng[Can]*mpePowCM[Can,z]/mpePulseHou[Can]);
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
}      
      BoxRun;
    end;
end;

end.
