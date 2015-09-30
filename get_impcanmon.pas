unit get_impcanmon;

interface

uses kernel;

procedure BoxGetImpCanMon;
procedure ShowGetImpCanMon;

var
  mpImpCanMon:  array[0..CANALS-1,0..MONTHS-1,0..TARIFFS-1] of longword;

implementation

uses SysUtils, soutput, borders, progress, support, realz, get_trans_eng, get_pulse_hou, box, timez, calendar,
main, get_impcanhou;


const
  quGetImpCanMon: querys = (Action: acGetImpCanMon; cwOut: 7+10; cwIn: 0; bNumber: $FF);

var
  bMon:   byte;
  
procedure QueryGetImpCanMon;
begin
  InitPushCRC;
  Push(203);
  Push(bMon);
  if PushCanMask then Query(quGetImpCanMon);
end;

procedure BoxGetImpCanMon;
begin  
  if TestMonths then begin
    bMon := ibMinMon;
    QueryGetImpCanMon;
  end;
end;

procedure ShowGetImpCanMon;
var
  Can,Tar,x:  word;
  k,e:  extended;
  z:    longword;
  a,b:  longint;
  s:    string;
begin
  Stop;
  InitPop(15);

  for Can := 0 to CANALS-1 do if CanalChecked(Can) then
    for Tar := 0 to TARIFFS-1 do mpImpCanMon[Can,bMon,Tar] := PopLong;

  ShowProgress(bMon-ibMinMon, ibMaxMon-ibMinMon+1);  

  Inc(bMon);
  if bMon <= ibMaxMon then 
    QueryGetImpCanMon
  else begin
  
    AddInfo('');
    AddInfo('»мпульсы по каналам за мес€ц');

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
        for Tar := 0 to TARIFFS-1 do z := z + mpImpCanMon[Can,x,Tar];
        s := s + PackStrR(IntToStr(z),GetColWidth);
      end;
      AddInfo(s);
    end;

    if UseTariffs then begin
      AddInfo('');
      AddInfo('»мпульсы по каналам за мес€ц по тарифам');

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
          for Tar := 0 to TARIFFS-1 do z := z + mpImpCanMon[Can,x,Tar];
          s := s + PackStrR(IntToStr(z),GetColWidth);
        end;
        AddInfo(s);

        for Tar := 0 to TARIFFS-1 do begin
          s := PackStrR(' тариф '+IntToStr(Tar+1),GetColWidth);
          for x := ibMinMon to ibMaxMon do s := s + PackStrR(' '+IntToStr(mpImpCanMon[Can,x,Tar]),GetColWidth);
          AddInfo(s);      
        end;
      end;
    end;
    
    AddInfo('');
    if UseTrans then
      AddInfo('Ёнерги€ по каналам за мес€ц')
    else  
      AddInfo('Ёнерги€ по каналам за мес€ц (без учета коэффициента трансформации)');

    s := PackStrR('',GetColWidth);
    for x := ibMinMon to ibMaxMon do s := s + PackStrR(Times2StrMon(MonIndexToDate(DateToMonIndex(tiCurr)-x)),GetColWidth);
    AddInfo(s);    
    s := PackStrR('',GetColWidth);
    for x := ibMinMon to ibMaxMon do s := s + PackStrR('мес€ц -'+IntToStr(x),GetColWidth);
    AddInfo(s);

    for Can := 0 to CANALS-1 do if CanalChecked(Can) then begin
      s := PackStrR('канал ' + IntToStr(Can+1),GetColWidth);
      for x := ibMinMon to ibMaxMon do begin
        if UseTrans then k := mpeTransEng[Can]/mpePulseHou[Can] else k := 1/mpePulseHou[Can];
        e := 0;
        for Tar := 0 to TARIFFS-1 do e := e + k*mpImpCanMon[Can,x,Tar];
        s := s + Reals2StrR(e);
      end;
      AddInfo(s);
    end;
    
    if UseTariffs then begin
      AddInfo('');
      if UseTrans then
        AddInfo('Ёнерги€ по каналам за мес€ц по тарифам')
      else  
        AddInfo('Ёнерги€ по каналам за мес€ц по тарифам (без учета коэффициента трансформации)');

      s := PackStrR('',GetColWidth);
      for x := ibMinMon to ibMaxMon do s := s + PackStrR(Times2StrMon(MonIndexToDate(DateToMonIndex(tiCurr)-x)),GetColWidth);
      AddInfo(s);    
      s := PackStrR('',GetColWidth);
      for x := ibMinMon to ibMaxMon do s := s + PackStrR('мес€ц -'+IntToStr(x),GetColWidth);
      AddInfo(s);

      for Can := 0 to CANALS-1 do if CanalChecked(Can) then begin
        s := PackStrR('канал ' + IntToStr(Can+1),GetColWidth);
        for x := ibMinMon to ibMaxMon do begin
          if UseTrans then k := mpeTransEng[Can]/mpePulseHou[Can] else k := 1/mpePulseHou[Can];
          e := 0;
          for Tar := 0 to TARIFFS-1 do e := e + k*mpImpCanMon[Can,x,Tar];
          s := s + Reals2StrR(e);
        end;
        AddInfo(s);

        for Tar := 0 to TARIFFS-1 do begin
          s := PackStrR(' тариф '+IntToStr(Tar+1),GetColWidth);
          for x := ibMinMon to ibMaxMon do begin
            e := mpeTransEng[Can]*mpImpCanMon[Can,x,Tar]/mpePulseHou[Can];
            s := s + PackStrR(' '+Reals2Str(e),GetColWidth);
          end;  
          AddInfo(s);      
        end;
      end;
    end;
    
    if frmMain.clbMain.Checked[Ord(acGetImpCanHou)] then begin    
      AddInfo('');
      AddInfo('—равнение импульсов по каналам за мес€ц (интегральные и расчетные)');
      for x := ibMinMon to ibMaxMon do begin
        AddInfo(PackStrR('мес€ц -'+IntToStr(x),GetColWidth) + PackStrR(Times2StrMon(MonIndexToDate(DateToMonIndex(tiCurr)-x)),GetColWidth));
        for Can := 0 to CANALS-1 do if CanalChecked(Can) then begin
          s := PackStrR('канал ' + IntToStr(Can+1),GetColWidth);
            z := 0;
            for Tar := 0 to TARIFFS-1 do z := z + mpImpCanMon[Can,x,Tar];
            a := mpdwImpCM[Can, ((12 - 1 + tiCurr.bMonth - x) mod 12) + 1];
            b := z;
            s := s + PackStrR(IntToStr(b),GetColWidth) + PackStrR(IntToStr(a),GetColWidth);
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
