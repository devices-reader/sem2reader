unit get_impcanday;

interface

uses kernel;

var
  mpImpCanDay:  array[0..CANALS-1,0..DAYS-1,0..TARIFFS-1] of longword;

procedure BoxGetImpCanDay;
procedure ShowGetImpCanDay;

implementation

uses SysUtils, soutput, support, borders, progress, realz, get_trans_eng, get_pulse_hou, timez, calendar, box, main, get_impcanhou;

const
  quGetImpCanDay: querys = (Action: acGetImpCanDay; cwOut: 7+10; cwIn: 0; bNumber: $FF);
  
var
  bDay:   byte;
  
procedure QueryGetImpCanDay;
begin
  InitPushCRC;
  Push(202);
  Push(bDay);
  if PushCanMask then Query(quGetImpCanDay);
end;

procedure BoxGetImpCanDay;
begin
  if TestDays then begin
    bDay := ibMinDay;
    QueryGetImpCanDay;
  end;
end;

procedure ShowGetImpCanDay;
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
    for Tar := 0 to TARIFFS-1 do mpImpCanDay[Can,bDay,Tar] := PopLong;

  ShowProgress(bDay-ibMinDay, ibMaxDay-ibMinDay+1);  

  Inc(bDay);
  if bDay <= ibMaxDay then 
    QueryGetImpCanDay  
  else begin
  
    AddInfo('');
    AddInfo('»мпульсы по каналам за сутки');

    s := PackStrR('',GetColWidth);
    for x := ibMinDay to ibMaxDay do s := s + PackStrR(Times2StrDay(DayIndexToDate(DateToDayIndex(tiCurr)-x)),GetColWidth);
    AddInfo(s);
    s := PackStrR('',GetColWidth);
    for x := ibMinDay to ibMaxDay do s := s + PackStrR('сутки -'+IntToStr(x),GetColWidth);
    AddInfo(s);

    for Can := 0 to CANALS-1 do if CanalChecked(Can) then begin
      s := PackStrR('канал ' + IntToStr(Can+1),GetColWidth);
      for x := ibMinDay to ibMaxDay do begin
        z := 0;
        for Tar := 0 to TARIFFS-1 do z := z + mpImpCanDay[Can,x,Tar];
        s := s + PackStrR(IntToStr(z),GetColWidth);
      end;
      AddInfo(s);
    end;
  
    if UseTariffs then begin
      AddInfo('');
      AddInfo('»мпульсы по каналам за сутки по тарифам');

      s := PackStrR('',GetColWidth);
      for x := ibMinDay to ibMaxDay do s := s + PackStrR(Times2StrDay(DayIndexToDate(DateToDayIndex(tiCurr)-x)),GetColWidth);
      AddInfo(s);
      s := PackStrR('',GetColWidth);
      for x := ibMinDay to ibMaxDay do s := s + PackStrR('сутки -'+IntToStr(x),GetColWidth);
      AddInfo(s);

      for Can := 0 to CANALS-1 do if CanalChecked(Can) then begin
        s := PackStrR('канал ' + IntToStr(Can+1),GetColWidth);
        for x := ibMinDay to ibMaxDay do begin
          z := 0;
          for Tar := 0 to TARIFFS-1 do z := z + mpImpCanDay[Can,x,Tar];
          s := s + PackStrR(IntToStr(z),GetColWidth);
        end;
        AddInfo(s);

        for Tar := 0 to TARIFFS-1 do begin
          s := PackStrR(' тариф '+IntToStr(Tar+1),GetColWidth);
          for x := ibMinDay to ibMaxDay do s := s + PackStrR(' '+IntToStr(mpImpCanDay[Can,x,Tar]),GetColWidth);
          AddInfo(s);      
        end;
      end;
    end;
    
    AddInfo('');
    if UseTrans then
      AddInfo('Ёнерги€ по каналам за сутки')
    else  
      AddInfo('Ёнерги€ по каналам за сутки (без учета коэффициента трансформации)');

    s := PackStrR('',GetColWidth);
    for x := ibMinDay to ibMaxDay do s := s + PackStrR(Times2StrDay(DayIndexToDate(DateToDayIndex(tiCurr)-x)),GetColWidth);
    AddInfo(s);
    s := PackStrR('',GetColWidth);
    for x := ibMinDay to ibMaxDay do s := s + PackStrR('сутки -'+IntToStr(x),GetColWidth);
    AddInfo(s);

    for Can := 0 to CANALS-1 do if CanalChecked(Can) then begin   
      s := PackStrR('канал ' + IntToStr(Can+1),GetColWidth);
      for x := ibMinDay to ibMaxDay do begin
        if UseTrans then k := mpeTransEng[Can]/mpePulseHou[Can] else k := 1/mpePulseHou[Can];
        e := 0;
        for Tar := 0 to TARIFFS-1 do e := e + k*mpImpCanDay[Can,x,Tar];
        s := s + Reals2StrR(e);
      end;
      AddInfo(s);
    end;

    if UseTariffs then begin
      AddInfo('');
      if UseTrans then
        AddInfo('Ёнерги€ по каналам за сутки по тарифам')
      else  
        AddInfo('Ёнерги€ по каналам за сутки по тарифам (без учета коэффициента трансформации)');

      s := PackStrR('',GetColWidth);
      for x := ibMinDay to ibMaxDay do s := s + PackStrR(Times2StrDay(DayIndexToDate(DateToDayIndex(tiCurr)-x)),GetColWidth);
      AddInfo(s);    
      s := PackStrR('',GetColWidth);
      for x := ibMinDay to ibMaxDay do s := s + PackStrR('сутки -'+IntToStr(x),GetColWidth);
      AddInfo(s);

      for Can := 0 to CANALS-1 do if CanalChecked(Can) then begin   
        s := PackStrR('канал ' + IntToStr(Can+1),GetColWidth);
        for x := ibMinDay to ibMaxDay do begin
          if UseTrans then k := mpeTransEng[Can]/mpePulseHou[Can] else k := 1/mpePulseHou[Can];
          e := 0;
          for Tar := 0 to TARIFFS-1 do e := e + k*mpImpCanDay[Can,x,Tar];
          s := s + Reals2StrR(e);
        end;
        AddInfo(s);

        for Tar := 0 to TARIFFS-1 do begin
          s := PackStrR(' тариф '+IntToStr(Tar+1),GetColWidth);
          for x := ibMinDay to ibMaxDay do begin
            e := mpeTransEng[Can]*mpImpCanDay[Can,x,Tar]/mpePulseHou[Can];
            s := s + PackStrR(' '+Reals2Str(e),GetColWidth);
          end;  
          AddInfo(s);      
        end;
      end;
    end;

    
    if frmMain.clbMain.Checked[Ord(acGetImpCanHou)] then begin    
      AddInfo('');
      AddInfo('—равнение импульсов по каналам за сутки (интегральные и расчетные)');
      for x := ibMinDay to ibMaxDay do begin
        AddInfo(PackStrR('сутки -'+IntToStr(x),GetColWidth) + PackStrR(Times2StrDay(DayIndexToDate(DateToDayIndex(tiCurr)-x)),GetColWidth));
        for Can := 0 to CANALS-1 do if CanalChecked(Can) then begin
          s := PackStrR('канал ' + IntToStr(Can+1),GetColWidth);
            z := 0;
            for Tar := 0 to TARIFFS-1 do z := z + mpImpCanDay[Can,x,Tar];
            a := mpdwImpCD[Can,x];
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
 