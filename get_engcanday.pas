unit get_engcanday;

interface

uses kernel;

procedure BoxGetEngCanDay;
procedure ShowGetEngCanDay;
  
implementation

uses SysUtils, soutput, support, borders, progress, realz, timez, calendar, box;

const
  quGetEngCanDay: querys = (Action: acGetEngCanDay; cwOut: 7+10; cwIn: 0; bNumber: $FF);

var
  mpEngCanDay:  array[0..CANALS-1,0..DAYS-1,0..TARIFFS-1] of extended;
                            
var
  bDay: byte;

procedure QueryGetEngCanDay;
begin
  InitPushCRC;
  Push(65);
  Push(bDay);
  if PushCanMask then Query(quGetEngCanDay);
end;

procedure BoxGetEngCanDay;
begin
  if TestDays then begin
    bDay := ibMinDay;
    QueryGetEngCanDay;
  end;
end;

procedure ShowGetEngCanDay;
var
  Can,Tar,x:  word;
  e:  extended;
  s:  string;
begin
  Stop;
  InitPop(15);

  for Can := 0 to CANALS-1 do if CanalChecked(Can) then 
    for Tar := 0 to TARIFFS-1 do mpEngCanDay[Can,bDay,Tar] := PopReals;

  ShowProgress(bDay-ibMinDay, ibMaxDay-ibMinDay+1);  

  Inc(bDay);
  if bDay <= ibMaxDay then 
    QueryGetEngCanDay
  else begin
    AddInfo('');
    AddInfo('Ёнерги€ по каналам за сутки');

    s := PackStrR('',GetColWidth);
    for x := ibMinDay to ibMaxDay do s := s + PackStrR(Times2StrDay(DayIndexToDate(DateToDayIndex(tiCurr)-x)),GetColWidth);
    AddInfo(s);
    s := PackStrR('',GetColWidth);
    for x := ibMinDay to ibMaxDay do s := s + PackStrR('сутки -'+IntToStr(x),GetColWidth);
    AddInfo(s);

    for Can := 0 to CANALS-1 do if CanalChecked(Can) then begin 
      s := PackStrR('канал ' + IntToStr(Can+1),GetColWidth);
      for x := ibMinDay to ibMaxDay do begin
        e := 0;
        for Tar := 0 to TARIFFS-1 do e := e + mpEngCanDay[Can,x,Tar];
        s := s + Reals2StrR(e);
      end;
      AddInfo(s);

      for Tar := 0 to TARIFFS-1 do begin
        s := PackStrR(' тариф '+IntToStr(Tar+1),GetColWidth);
        for x := ibMinDay to ibMaxDay do s := s + PackStrR(Reals2StrR(mpEngCanDay[Can,x,Tar]),GetColWidth);
        AddInfo(s);      
      end;      
    end;
    
    BoxRun;
  end;
end;

end. 
