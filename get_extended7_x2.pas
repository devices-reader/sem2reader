unit get_extended7_x2;

interface

uses kernel;

procedure BoxGetExt7X2;
procedure ShowGetExt7X2;

implementation

uses SysUtils, soutput, support, realz, timez, borders, box, progress, calendar;

const
  quGetExt7X2: querys = (Action: acGetExt7X2; cwOut: 7+10; cwIn: 0; bNumber: $FF-2);

var
  mpValue7:  array[0..DAYS-1,0..CANALS-1] of value6;
  bDay:      byte;
  
function Status2Str(i: byte): string;
begin
  case i of
    0:    Result := 'пусто';
    1:    Result := 'ОК';
    else  Result := '?';
  end;
  Result := IntToHex(i,2) + ' - ' + Result;
end;

procedure QueryGetExt7X2;
begin
  InitPushCRC;
  Push(100);
  Push(bDay);
  if PushCanMask then Query(quGetExt7X2);
end;

procedure BoxGetExt7X2;
begin
  if TestCanals and TestDays then begin
    AddInfo('');
    AddInfo('Значения счетчиков на начало суток');

    bDay := ibMinDay;
    QueryGetExt7X2;
  end;
end;

procedure ShowGetExt7X2;
var
  Can:  word;
  s:    string;
  a:    word;
begin
  Stop;
  InitPop(15);

  a := PopInt;
  if bDay = ibMinDay then begin
    AddInfo('');
    AddInfo(PackStrR('Количество переходов через сутки: ' + IntToStr(a),GetColWidth*2));
  end;

  AddInfo('');
  AddInfo(PackStrR('сутки -'+IntToStr(bDay),GetColWidth) + Times2StrDay(DayIndexToDate(DateToDayIndex(tiCurr)-bDay)));
  for Can := 0 to CANALS-1 do if CanalChecked(Can) then begin
    s := PackStrR('канал ' + IntToStr(Can+1),GetColWidth);

    with mpValue7[bDay,Can] do begin
      bStatus := Pop;
      eValue := PopDouble;
      tiValue := PopTimes; 

      s := s + PackStrR(Status2Str(bStatus),GetColWidth*2);
      s := s + PackStrR(Double2StrR(eValue),GetColWidth);
      s := s + PackStrR(Times2Str(tiValue),GetColWidth);      
    end;
    
    AddInfo(s);
  end;
  
  ShowProgress(bDay-ibMinDay, ibMaxDay-ibMinDay+1);  
    
  Inc(bDay);
  if bDay <= ibMaxDay then 
    QueryGetExt7X2
  else 
    RunBox;
end;

end.
