unit get_defcanmon;

interface

uses kernel;

procedure BoxGetDefCanMon;
procedure ShowGetDefCanMon;

var
  mpDefCanMon:  array[0..CANALS-1,0..MONTHS-1,0..TARIFFS-1] of longword;
  mpReqCanMon:  array[0..CANALS-1,0..MONTHS-1] of longword;

implementation

uses SysUtils, soutput, borders, progress, support, realz, box, timez, calendar, main, get_defcanhou;


const
  quGetDefCanMon: querys = (Action: acGetDefCanMon; cwOut: 7+10; cwIn: 0; bNumber: $FF);

var
  bMon:   byte;
  
procedure QueryGetDefCanMon;
begin
  InitPushCRC;
  Push(78);
  Push(bMon);
  if PushCanMask then Query(quGetDefCanMon);
end;

procedure BoxGetDefCanMon;
begin  
  if TestMonths then begin
    bMon := ibMinMon;
    QueryGetDefCanMon;
  end;
end;

procedure ShowGetDefCanMon;
var
  Can,Tar,x:  word;
  z:    longword;
  a,b:  longint;
  s:    string;
begin
  Stop;
  InitPop(15);

  for Can := 0 to CANALS-1 do if CanalChecked(Can) then begin
    mpReqCanMon[Can,bMon] := PopLong;
    for Tar := 0 to TARIFFS-1 do mpDefCanMon[Can,bMon,Tar] := PopLong;
  end;

  ShowProgress(bMon-ibMinMon, ibMaxMon-ibMinMon+1);

  Inc(bMon);
  if bMon <= ibMaxMon then 
    QueryGetDefCanMon
  else begin
  
    AddInfo('');
    AddInfo('ѕолна€ достоверность по каналам за мес€ц');

    s := PackStrR('',GetColWidth);
    for x := ibMinMon to ibMaxMon do s := s + PackStrR(Times2StrMon(MonIndexToDate(DateToMonIndex(tiCurr)-x)),GetColWidth);
    AddInfo(s);    
    s := PackStrR('',GetColWidth);
    for x := ibMinMon to ibMaxMon do s := s + PackStrR('мес€ц -'+IntToStr(x),GetColWidth);
    AddInfo(s);

    for Can := 0 to CANALS-1 do if CanalChecked(Can) then begin
      s := PackStrR('канал ' + IntToStr(Can+1),GetColWidth);
      for x := ibMinMon to ibMaxMon do begin
        z := 0;
        for Tar := 0 to TARIFFS-1 do z := z + mpDefCanMon[Can,x,Tar];
        s := s + PackStrR(IntToStr(mpReqCanMon[Can,x]) + ' ~ ' + IntToStr(z),GetColWidth);
      end;
      AddInfo(s);
    end;


    if UseTariffs then begin
      AddInfo('');
      AddInfo('ѕолна€ достоверность по каналам за мес€ц по тарифам');

      s := PackStrR('',GetColWidth);
      for x := ibMinMon to ibMaxMon do s := s + PackStrR(Times2StrMon(MonIndexToDate(DateToMonIndex(tiCurr)-x)),GetColWidth);
      AddInfo(s);
      s := PackStrR('',GetColWidth);
      for x := ibMinMon to ibMaxMon do s := s + PackStrR('мес€ц -'+IntToStr(x),GetColWidth);
      AddInfo(s);

      for Can := 0 to CANALS-1 do if CanalChecked(Can) then begin
        s := PackStrR('канал ' + IntToStr(Can+1),GetColWidth);
        for x := ibMinMon to ibMaxMon do begin
          z := 0;
          for Tar := 0 to TARIFFS-1 do z := z + mpDefCanMon[Can,x,Tar];
          s := s + PackStrR(IntToStr(mpReqCanMon[Can,x]) + ' ~ ' + IntToStr(z),GetColWidth);
        end;
        AddInfo(s);

        for Tar := 0 to TARIFFS-1 do begin
          s := PackStrR(' тариф '+IntToStr(Tar+1),GetColWidth);
          for x := ibMinMon to ibMaxMon do s := s + PackStrR(' '+IntToStr(mpDefCanMon[Can,x,Tar]),GetColWidth);
          AddInfo(s);
        end;
      end;
    end;


    if frmMain.clbMain.Checked[Ord(acGetDefCanHou)] then begin
      AddInfo('');
      AddInfo('—равнение достоверности по каналам за мес€ц (интегральные и расчетные)');
      for x := ibMinMon to ibMaxMon do begin
        AddInfo(PackStrR('мес€ц -'+IntToStr(x),GetColWidth) + PackStrR(Times2StrMon(MonIndexToDate(DateToMonIndex(tiCurr)-x)),GetColWidth));
        for Can := 0 to CANALS-1 do if CanalChecked(Can) then begin
          s := PackStrR('канал ' + IntToStr(Can+1),GetColWidth);
            z := 0;
            for Tar := 0 to TARIFFS-1 do z := z + mpDefCanMon[Can,x,Tar];
            a := mpdwDefCM[Can, ((12 - 1 + tiCurr.bMonth - x) mod 12) + 1];
            b := z;
            s := s + PackStrR(IntToStr(mpReqCanMon[Can,x]) + ' ~ ' + IntToStr(b),GetColWidth);
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
