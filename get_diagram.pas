unit get_diagram;

interface

procedure BoxGetDiagram;
procedure ShowGetDiagram;

implementation

uses SysUtils, Classes, soutput, support, kernel, borders, progress, box, timez, realz, calendar;

const
  quGetDiagram: querys = (Action: acGetDiagram; cwOut: 7+10; cwIn: 0; bNumber: $FF;);

var
  mpDiagramCDH: array[0..CANALS-1,0..DAYS2-1,0..HOURS_IN_DAY-1] of diagram;
  ibDay:        byte;

procedure QueryGetDiagram;
begin
  InitPushCRC;
  Push(95);
  Push(ibDay);
  if PushCanMask then Query(quGetDiagram);
end;

procedure BoxGetDiagram;
begin 
  if TestDays2 then begin
    ibDay := ibMinDay;
    QueryGetDiagram;
  end;
end;

procedure ShowGetDiagram;
var
  d:    diagram;
  Can:  byte;
  Hou:  word;
  s:    string;
begin
    Stop;
    InitPop(15);

    for Hou := 0 to HOURS_IN_DAY-1 do begin
      for Can := 0 to CANALS-1 do if CanalChecked(Can) then begin
        d.eValue := PopReals;
        d.tiValue.bSecond := Pop;
        d.tiValue.bMinute := Pop;
        d.tiValue.bHour := Pop;
        d.tiValue.bDay := 0;
        d.tiValue.bMonth := 0;
        d.tiValue.bYear := 0;

        mpDiagramCDH[Can,ibDay,Hou] := d;
      end;
    end;


    AddInfo('');
    s := '-' + Int2Str(ibDay) + '  ' + Times2StrDay(DayIndexToDate(DateToDayIndex(tiCurr)-ibDay));
    AddInfo('Значения счётчиков по каналам за сутки: '+s);

    s := PackStrR('',GetColWidth);
    for Can := 0 to CANALS-1 do if CanalChecked(Can) then
      s := s + PackStrR('канал '+IntToStr(Can+1),3*GetColWidth div 2);
    AddInfo(s);

    for Hou := 0 to HOURS_IN_DAY-1 do begin
      s := PackStrR(Int2Str(Hou div 2)+':'+Int2Str((Hou mod 2)*30),GetColWidth);
      for Can := 0 to CANALS-1 do if CanalChecked(Can) then  begin
        d := mpDiagramCDH[Can,ibDay,Hou];
        s := s + PackStrR(Reals2Str(d.eValue) + ' ' + Times2StrHour(d.tiValue),3*GetColWidth div 2);
      end;
      AddInfo(s);
    end;

    ShowProgress(ibDay-ibMinDay, ibMaxDay-ibMinDay+1);

    Inc(ibDay);
    if ibDay <= ibMaxDay then
      QueryGetDiagram
    else begin
      BoxRun;
    end;
end;

end.
