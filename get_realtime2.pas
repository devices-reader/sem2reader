unit get_realtime2;

interface

procedure BoxGetRealtime2;
procedure ShowGetRealtime2;

implementation

uses SysUtils, soutput, support, box, timez, calendar2, get_start, t_realtime;

const
  quGetRealtime2:   querys = (Action: acGetRealtime2; cwOut: 8; cwIn: 5+1000+2; bNumber: 252);

procedure QueryGetRealtime2;
begin
  InitPushCRC;
  Push(27);
  Query(quGetRealtime2);
end;

procedure BoxGetRealtime2;
begin
  if GetVersion = 4 then
    QueryGetRealtime2
  else begin
    AddInfo('для данной версии сумматора следует использовать запрос: Чтение состояния памяти (версия 1)');
    BoxRun;
  end;
end;

procedure ShowGetRealtime2;
var
  ibSoftMnt, iwHardMnt: word;
  ibSoftHou, iwHardHou: word;
  ibSoftDay, iwHardDay: word;
  ibSoftMon, iwHardMon: word;
  cdwMinutes1: longword;
  cdwMinutes3: longword;
  cdwMinutes30: longword;
  cwDay: word;
  cwMon: word;
begin
  Stop;
  InitPopCRC;

  AddInfo('');
  AddInfo('');
  AddInfo('*Чтение состояния памяти (версия 2)');

  AddInfo('');
  AddInfo('ревизия           ' + IntToStr(Pop));

  AddInfo('');
  AddInfo('время             ' + Times2Str(PopTimes));
  AddInfo('время текущее     ' + Times2Str(PopTimes));
  AddInfo('время предыдущее  ' + Times2Str(PopTimes));

  AddInfo('');
  AddInfo('сезон 1           ' + IntToStr(Pop));
  AddInfo('сезон 2           ' + IntToStr(Pop));
  AddInfo('сезон 3           ' + IntToStr(Pop));

  AddInfo('');
  AddInfo('флаг              ' + IntToStr(Pop));

  AddInfo('');
  ibSoftMnt := PopIntBig;
  iwHardMnt := PopIntBig;
  AddInfo('указатель 3 мин.  ' + IntToStr(ibSoftMnt) + ' ' + IntToStr(iwHardMnt));
  ibSoftHou := PopIntBig;
  iwHardHou := PopIntBig;
  AddInfo('указатель 30 мин. ' + IntToStr(ibSoftHou) + ' ' + IntToStr(iwHardHou));
  ibSoftDay := PopIntBig;
  iwHardDay := PopIntBig;
  AddInfo('указатель сутки   ' + IntToStr(ibSoftDay) + ' ' + IntToStr(iwHardDay));
  ibSoftMon := PopIntBig;
  iwHardMon := PopIntBig;
  AddInfo('указатель месяцы  ' + IntToStr(ibSoftMon) + ' ' + IntToStr(iwHardMon));
  AddInfo('указатель times   ' + IntToStr(PopIntBig) + ' ' + IntToStr(PopIntBig));

  AddInfo('');
  AddInfo('счетчик 1 сек.    ' + IntToStr(PopLong));
  cdwMinutes1 := PopLong;
  AddInfo('счетчик 1 мин.    ' + IntToStr(cdwMinutes1));
  cdwMinutes3 := PopLong;
  AddInfo('счетчик 3 мин.    ' + IntToStr(cdwMinutes3));
  cdwMinutes30 := PopLong;
  AddInfo('счетчик 30 мин.   ' + IntToStr(cdwMinutes30));
  cwDay := PopIntBig;
  AddInfo('счетчик дни       ' + IntToStr(cwDay));
  AddInfo('счетчик месяцы    ' + IntToStr(PopIntBig));
  AddInfo('счетчик годы      ' + IntToStr(PopIntBig));

  AddInfo('');
  AddInfo('указатель diagram ' + IntToStr(PopIntBig) + ' ' + IntToStr(PopIntBig));

  AddInfo('');
{
  AddInfo(Times2Str(tiCurr));
  AddInfo(Times2Str(Min1IndexToDate(DateToMin1Index(tiCurr))));
  AddInfo(Times2Str(Min3IndexToDate(DateToMin3Index(tiCurr))));
  AddInfo(Times2Str(Min30IndexToDate(DateToMin30Index(tiCurr))));
  AddInfo(Times2Str(DayIndexToDate(DateToDayIndex(tiCurr))));
  AddInfo(Times2Str(MonIndexToDate(DateToMonIndex(tiCurr))));
}
  ShowMin1(cdwMinutes1);
  ShowMin3(cdwMinutes3,iwHardMnt);
  ShowMin30(cdwMinutes30,iwHardHou);
  ShowDay(cwDay,iwHardDay);
  ShowMon(cwMon,iwHardMon);

  BoxRun;
end;

end.
