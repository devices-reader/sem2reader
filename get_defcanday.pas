unit get_defcanday;

interface

uses kernel;

var
  mpDefCanDay:  array[0..CANALS-1,0..DAYS-1,0..TARIFFS-1] of longword;
  mpReqCanDay:  array[0..CANALS-1,0..DAYS-1] of longword;

procedure BoxGetDefCanDay;
procedure ShowGetDefCanDay;

implementation

uses SysUtils, soutput, support, borders, progress, realz, timez, calendar, box, main, get_defcanhou;

const
  quGetDefCanDay: querys = (Action: acGetDefCanDay; cwOut: 7+10; cwIn: 0; bNumber: $FF);

var
  bDay:   byte;

procedure QueryGetDefCanDay;
begin
  InitPushCRC;
  Push(77);
  Push(bDay);
  if PushCanMask then Query(quGetDefCanDay);
end;

procedure BoxGetDefCanDay;
begin
  if TestDays then begin
    bDay := ibMinDay;
    QueryGetDefCanDay;
  end;
end;

procedure ShowGetDefCanDay;
var
  Can,Tar,x:  word;
  z:    longword;
  a,b:  longint;
  s:    string;
begin
  Stop;
  InitPop(15);

  for Can := 0 to CANALS-1 do if CanalChecked(Can) then begin
    mpReqCanDay[Can,bDay] := PopLong;
    for Tar := 0 to TARIFFS-1 do mpDefCanDay[Can,bDay,Tar] := PopLong;
  end;

  ShowProgress(bDay-ibMinDay, ibMaxDay-ibMinDay+1);  

  Inc(bDay);
  if bDay <= ibMaxDay then
    QueryGetDefCanDay
  else begin

    AddInfo('');
    AddInfo('ѕолна€ достоверность по каналам за сутки');

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
        for Tar := 0 to TARIFFS-1 do z := z + mpDefCanDay[Can,x,Tar];
        s := s + PackStrR(IntToStr(mpReqCanDay[Can,x]) + ' ~ ' + IntToStr(z),GetColWidth);
      end;
      AddInfo(s);
    end;


    if UseTariffs then begin
      AddInfo('');
      AddInfo('ѕолна€ достоверность по каналам за сутки по тарифам');

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
          for Tar := 0 to TARIFFS-1 do z := z + mpDefCanDay[Can,x,Tar];
          s := s + PackStrR(IntToStr(mpReqCanDay[Can,x]) + ' ~ ' + IntToStr(z),GetColWidth);
        end;
        AddInfo(s);

        for Tar := 0 to TARIFFS-1 do begin
          s := PackStrR(' тариф '+IntToStr(Tar+1),GetColWidth);
          for x := ibMinDay to ibMaxDay do s := s + PackStrR(' '+IntToStr(mpDefCanDay[Can,x,Tar]),GetColWidth);
          AddInfo(s);
        end;
      end;
    end;


    if frmMain.clbMain.Checked[Ord(acGetDefCanHou)] then begin
      AddInfo('');
      AddInfo('—равнение достоверности по каналам за сутки (интегральные и расчетные)');
      for x := ibMinDay to ibMaxDay do begin
        AddInfo(PackStrR('сутки -'+IntToStr(x),GetColWidth) + PackStrR(Times2StrDay(DayIndexToDate(DateToDayIndex(tiCurr)-x)),GetColWidth));
        for Can := 0 to CANALS-1 do if CanalChecked(Can) then begin
          s := PackStrR('канал ' + IntToStr(Can+1),GetColWidth);
            z := 0;
            for Tar := 0 to TARIFFS-1 do z := z + mpDefCanDay[Can,x,Tar];
            a := mpdwDefCD[Can,x];
            b := z;
            s := s + PackStrR(IntToStr(mpReqCanDay[Can,x]) + ' ~ ' + IntToStr(b),GetColWidth);
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
 