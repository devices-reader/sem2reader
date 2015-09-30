unit get_extended4t_x2;

interface

uses kernel;

procedure BoxGetExt40TX2;
procedure ShowGetExt40TX2;

implementation

uses SysUtils, soutput, support, realz, timez, borders, box, progress;

const
  quGetExt40TX2: querys = (Action: acGetExt40TX2; cwOut: 7+10; cwIn: 0;       bNumber: $FF-2);

var
  bMon:   byte;
  bFirst: boolean;

function PopStatus2Str: string;
var
  i:  byte;
begin
  i := Pop;
  case i of
    0:    Result := 'пусто';
    1:    Result := 'ОК';
    2:    Result := 'не поддерживается';
    3:    Result := 'данные отсутствуют';
    $80:  Result := 'счетчик не отвечает !';
    $81:  Result := 'флэш-память !';
    $82:  Result := 'модемный канал !';
    $83:  Result := 'канал запрещен !';
    else  Result := '?';
  end;
  Result := IntToHex(i,2) + ' - ' + Result;
end;

procedure ShowStatus;
begin
  AddInfo('');
  AddInfo('пусто               - ожидается опрос');
  AddInfo('ОК                  - опрос завершен успешно');
  AddInfo('не поддерживается   - счетчик не поддерживается, опрос завершен');
  AddInfo('данные отсутствуют  - данные отсутствуют в счетчике, опрос завершен');
  AddInfo('счетчик не отвечает - счетчик не отвечает, опрос продолжается');
end;

procedure QueryGetExt40TX2;
begin
  InitPushCRC;
  Push(119);
  Push(bMon);
  if PushCanMask then Query(quGetExt40TX2);
end;

procedure BoxGetExt40TX2;
begin
  if TestCanals and TestMonths then begin
    AddInfo('');
    AddInfo('Значения счётчиков на начало месяца по тарифам (из буфера с дозапросом) (двойная точность)');

    bFirst := true;
    bMon := ibMinMon;
    QueryGetExt40TX2;
  end;
end;

procedure ShowGetExt40TX2;
var
  Can:  word;
  Tar:  byte;
  s:    string;
  a,b:  byte;
begin
  Stop;
  InitPop(15);

  a := Pop;
  b := Pop;
  if (bFirst) then begin
    bFirst := false;
    AddInfo('');
    AddInfo('Признак включения режима: '+Bool2Str(a));
    AddInfo('Глубина опроса в месяцах: '+IntToStr(b));
  end;

  AddInfo('');
  AddInfo(' месяц '+IntToStr(bMon+1) + ' ' +LongMonthNames[bMon+1]);
  for Can := 0 to CANALS-1 do if CanalChecked(Can) then begin
    s := PackStrR('канал ' + IntToStr(Can+1),GetColWidth);
    s := s + PackStrR(PopStatus2Str,GetColWidth*2);
    for Tar := 1 to 4 do s := s + PackStrR(Double2StrR(PopDouble),GetColWidth);
    s := s + PackStrR(PopTimes2Str,GetColWidth);
    AddInfo(s);
  end;

  ShowProgress(bMon-ibMinMon, ibMaxMon-ibMinMon+1);

  Inc(bMon);
  if bMon <= ibMaxMon then
    QueryGetExt40TX2
  else begin
    ShowStatus;
    RunBox;
  end;
end;

end.
