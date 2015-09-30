unit get_extended6_x2;

interface

uses kernel;

procedure BoxGetExt6X2;
procedure ShowGetExt6X2;

var
  mpValue6:   array[0..12-1,0..64-1] of value6;

implementation

uses SysUtils, soutput, support, realz, timez, borders, box, progress;

const
  quGetExt6X2: querys = (Action: acGetExt6X2; cwOut: 7+10; cwIn: 0; bNumber: $FF-2);

var
  bMon:  byte;  
  
function Status2Str(i: byte): string;
begin
  case i of
    0:    Result := 'пусто';
    1:    Result := 'ОК';
    else  Result := '?';
  end;
  Result := IntToHex(i,2) + ' - ' + Result;
end;
  
procedure QueryGetExt6X2;
begin
  InitPushCRC;
  Push(62);
  Push(bMon);
  if PushCanMask then Query(quGetExt6X2);
end;

procedure BoxGetExt6X2;
begin
  if TestCanals and TestMonths then begin
    AddInfo('');
    AddInfo('Значения счетчиков на конец месяца (из буфера прямого опроса)(двойная точность)');

    bMon := ibMinMon;
    QueryGetExt6X2;
  end;
end;
                          
procedure ShowGetExt6X2;
var
  Can:  word;
  s:    string;
  a,b:  word;
begin
  Stop;
  InitPop(15);

  a := PopInt;
  b := PopInt;
  if bMon = ibMinMon then begin
    AddInfo('');
    AddInfo(PackStrR('Количество переходов через сутки: ' + IntToStr(a),GetColWidth*2));
    AddInfo(PackStrR('Количество переходов через месяц: ' + IntToStr(b),GetColWidth*2));
  end;
  
  AddInfo('');
  AddInfo(' месяц '+IntToStr(bMon+1) + ' ' +LongMonthNames[bMon+1]);
  for Can := 0 to CANALS-1 do if CanalChecked(Can) then begin
    s := PackStrR('канал ' + IntToStr(Can+1),GetColWidth);

    with mpValue6[bMon,Can] do begin
      bStatus := Pop;
      eValue := PopDouble;
      tiValue := PopTimes; 

      s := s + PackStrR(Status2Str(bStatus),GetColWidth*2);
      s := s + PackStrR(Double2StrR(eValue),GetColWidth);
      s := s + PackStrR(Times2Str(tiValue),GetColWidth);      
    end;
    
    AddInfo(s);
  end;
  
  ShowProgress(bMon-ibMinMon, ibMaxMon-ibMinMon+1);  
    
  Inc(bMon);
  if bMon <= ibMaxMon then 
    QueryGetExt6X2
  else 
    RunBox;
end;

end.
