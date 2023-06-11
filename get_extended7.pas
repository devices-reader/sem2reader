unit get_extended7;

interface

uses kernel;

procedure BoxGetExt7;
procedure ShowGetExt7;

implementation

uses SysUtils, soutput, support, realz, timez, borders, box, progress, calendar;

const
  quGetExt7: querys = (Action: acGetExt7; cwOut: 7+10; cwIn: 0; bNumber: $FF);

var
  mpValue7:  array[0..DAYS-1,0..CANALS-1] of value6;
  bDay:      byte;
  
function Status2Str(i: byte): string;
begin
  case i of
    0:    Result := '�����';
    1:    Result := '��';
    else  Result := '?';
  end;
  Result := IntToHex(i,2) + ' - ' + Result;
end;

procedure QueryGetExt7;
begin
  InitPushCRC;
  Push(100);
  Push(bDay);
  if PushCanMask then Query(quGetExt7);
end;

procedure BoxGetExt7;
begin
  if TestCanals and TestDays then begin
    AddInfo('');
    AddInfo('�������� ��������� �� ������ �����');

    bDay := ibMinDay;
    QueryGetExt7;
  end;
end;

procedure ShowGetExt7;
var
  Can:  word;
  s:    string;
  a:    word;
begin
  Stop;
  InitPop(15);

  a := PopIntBig;
  if bDay = ibMinDay then begin
    AddInfo('');
    AddInfo(PackStrR('���������� ��������� ����� �����: ' + IntToStr(a),GetColWidth*2));
  end;

  AddInfo('');
  AddInfo(PackStrR('����� -'+IntToStr(bDay),GetColWidth) + Times2StrDay(DayIndexToDate(DateToDayIndex(tiCurr)-bDay)));
  for Can := 0 to CANALS-1 do if CanalChecked(Can) then begin
    s := PackStrR('����� ' + IntToStr(Can+1),GetColWidth);

    with mpValue7[bDay,Can] do begin
      bStatus := Pop;
      eValue := PopReals;
      tiValue := PopTimes; 

      s := s + PackStrR(Status2Str(bStatus),GetColWidth*2);
      s := s + PackStrR(Reals2StrR(eValue),GetColWidth);
      s := s + PackStrR(Times2Str(tiValue),GetColWidth);      
    end;
    
    AddInfo(s);
  end;
  
  ShowProgress(bDay-ibMinDay, ibMaxDay-ibMinDay+1);  
    
  Inc(bDay);
  if bDay <= ibMaxDay then 
    QueryGetExt7
  else 
    RunBox;
end;

end.
