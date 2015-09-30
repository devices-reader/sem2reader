unit get_extended44;

interface

uses kernel;

procedure BoxGetExt44;
procedure ShowGetExt44;

var
  mpValue44:  array[0..12-1,0..64-1] of value4;

implementation

uses SysUtils, soutput, support, realz, timez, borders, box, progress;

const
  quGetExt44: querys = (Action: acGetExt44; cwOut: 7+10; cwIn: 0;       bNumber: $FF);

var
  bMon:  byte;  
  
function Status2Str(i: byte): string;
begin
  case i of
    0:    Result := 'пусто';
    1:    Result := 'ОК';
    $80:  Result := 'счетчик не отвечает !';
    $81:  Result := 'флэш-память !';
    $82:  Result := 'модемный канал !';
    $83:  Result := 'канал запрещен !';
    else  Result := '?';
  end;
  Result := IntToHex(i,2) + ' - ' + Result;
end;
  
procedure QueryGetExt44;
begin
  InitPushCRC;
  Push(60);
  Push(bMon);
  if PushCanMask then Query(quGetExt44);
end;

procedure BoxGetExt44;
begin
  if TestCanals and TestMonths then begin
    AddInfo('');
    AddInfo('Значения счётчиков на конец месяца (из буфера с дозапросом) (по маске каналов) (вариант 2)');

    bMon := ibMinMon;
    QueryGetExt44;
  end;
end;
                          
procedure ShowGetExt44;
var
  Can:  word;
  s:    string;
  a,b:  word;
  c,d:  byte;  
begin
  Stop;
  InitPop(15);

  c := Pop;
  d := Pop;
  a := PopInt;
  b := PopInt;
  if bMon = ibMinMon then begin
    AddInfo('');
    AddInfo(PackStrR('Признак включения режима: ' + Bool2Str(c),GetColWidth*2));
    AddInfo(PackStrR('Количество месяцев для обработки: ' + IntToStr(d),GetColWidth*2));
    AddInfo(PackStrR('Количество переходов через сутки: ' + IntToStr(a),GetColWidth*2));
    AddInfo(PackStrR('Количество переходов через месяц: ' + IntToStr(b),GetColWidth*2));
  end;
  
  AddInfo('');
  AddInfo(' месяц '+IntToStr(bMon+1) + ' ' +LongMonthNames[bMon+1]);
  for Can := 0 to CANALS-1 do if CanalChecked(Can) then begin
    s := PackStrR('канал ' + IntToStr(Can+1),GetColWidth);

    with mpValue44[bMon,Can] do begin
      bStatus := Pop;
      cwPos := PopInt;
      cwNeg := PopInt;
      eValue := PopReals;
      tiValue := PopTimes; 

      s := s + PackStrR(Status2Str(bStatus),GetColWidth*2);
//      s := s + PackStrR(IntToStr(cwPos)+' - '+IntToStr(cwNeg),GetColWidth);
      s := s + PackStrR(Reals2StrR(eValue),GetColWidth);
      s := s + PackStrR(Times2Str(tiValue),GetColWidth);
      sResult := s;
    end;
    
    AddInfo(s);
  end;
  
  ShowProgress(bMon-ibMinMon, ibMaxMon-ibMinMon+1);  
    
  Inc(bMon);
  if bMon <= ibMaxMon then 
    QueryGetExt44
  else 
    RunBox;
end;

end.
