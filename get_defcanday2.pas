unit get_defcanday2;

interface

uses kernel;

var
  mpDefCanDay2:  array[0..CANALS-1,0..DAYS-1] of byte;

procedure BoxGetDefCanDay2;
procedure ShowGetDefCanDay2;

implementation

uses SysUtils, soutput, support, borders, progress, realz, timez, calendar, box, main, get_defcanhou;

const
  quGetDefCanDay2: querys = (Action: acGetDefCanDay2; cwOut: 7+10; cwIn: 15+CANALS+2; bNumber: $FF);

var
  bDay:   byte;

procedure QueryGetDefCanDay2;
begin
  InitPushCRC;
  Push(81);
  Push(bDay);
  if PushCanMask then Query(quGetDefCanDay2);
end;

procedure BoxGetDefCanDay2;
begin
  if TestDays then begin
    bDay := ibMinDay;
    QueryGetDefCanDay2;
  end;
end;

procedure ShowGetDefCanDay2;
var
  Can,x:word;
  s:    string;
begin
  Stop;
  InitPop(15);

  for Can := 0 to CANALS-1 do begin
    mpDefCanDay2[Can,bDay] := Pop;
  end;

  ShowProgress(bDay-ibMinDay, ibMaxDay-ibMinDay+1);  

  Inc(bDay);
  if bDay <= ibMaxDay then
    QueryGetDefCanDay2
  else begin

    AddInfo('');
    AddInfo('Краткая достоверность по каналам за сутки');

    s := PackStrR('',GetColWidth);
    for x := ibMinDay to ibMaxDay do s := s + PackStrR(Times2StrDay(DayIndexToDate(DateToDayIndex(tiCurr)-x)),GetColWidth);
    AddInfo(s);
    s := PackStrR('',GetColWidth);
    for x := ibMinDay to ibMaxDay do s := s + PackStrR('сутки -'+IntToStr(x),GetColWidth);
    AddInfo(s);

    for Can := 0 to CANALS-1 do if CanalChecked(Can) then begin
      s := PackStrR('канал ' + IntToStr(Can+1),GetColWidth);
      for x := ibMinDay to ibMaxDay do begin
        s := s + PackStrR(Bool2Str(mpDefCanDay2[Can,x]),GetColWidth);
      end;
      AddInfo(s);
    end;

    BoxRun;
  end;
end;

end.
 