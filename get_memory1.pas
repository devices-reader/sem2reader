unit get_memory1;

interface

procedure BoxGetMemory1;
procedure ShowGetMemory1;

implementation

uses SysUtils, Classes, soutput, support, progress, box, kernel, terminal, crc, get_time, get_start, get_memory0, calendar2, t_realtime;

const
  quGetMemory1: querys = (Action: acGetMemory1; cwOut: 7+2; cwIn: 0; bNumber: 249);

var
  pwModems,
  pwMessages,
  pwCorrect,
  pwSystem,
  pwSensors,
  pwEvents:     word;

  cdwModems,
  cdwMessages,
  cdwCorrect,
  cdwSystem,
  cdwSensors,
  cdwEvents:    longword;

  cdwSecond,
  cdwMinute1,
  cdwMinute3,
  cdwMinute30:  longword;
  cwDay,
  cwMonth,
  cwYear:       word;

  pwPowDayGrp2,
  pwCntMonCan2: word;

  cwRecord:     word;
  bRecordBlock,
  bRecordSize:  byte;

  pwDefDayCan,
  pwDefMonCan,
  pwDiagram,
  pwCntDayCan7: word;

  cwRecord2:    word;
  wRecord2Size: word;

  pwAuxiliary:  word;
  cdwAuxiliary: longword;

  wPagesEnd,
  wPages:       word;

procedure QueryGetMemory1;
begin
  InitPushCRC;
  Push($FF);
  Push($FF);
  Query(quGetMemory1);
end;

procedure BoxGetMemory1;
begin
  QueryGetMemory1;
end;

procedure ShowGetMemory1;
var
  i:  byte;
  l:  TStringList;
begin
  Stop;
  InitPop(15);

  l := TStringList.Create;

  l.add('');
  l.add('');
  l.add('*Чтение состояния памяти (версия 1)');
  l.add('');
  l.add(PackStrR(IntToStr(PopInt),GetColWidth) + 'количество повторов при сигнале ''Занято''');
  l.add(PackStrR(IntToStr(PopInt),GetColWidth) + 'количество повторов при сравнении');
  l.add(PackStrR(IntToStr(PopInt),GetColWidth) + 'количество повторов при стирании страницы');
  l.add(PackStrR(IntToStr(PopInt),GetColWidth) + 'количество повторов при чтении страницы');
  l.add(PackStrR(IntToStr(PopInt),GetColWidth) + 'количество повторов при записи страницы');
  l.add(PackStrR(IntToStr(PopInt),GetColWidth) + 'количество ошибок при сравнении');
  l.add(PackStrR(IntToStr(PopInt),GetColWidth) + 'количество ошибок при стирании страницы');
  l.add(PackStrR(IntToStr(PopInt),GetColWidth) + 'количество ошибок при чтении страницы');
  l.add(PackStrR(IntToStr(PopInt),GetColWidth) + 'количество ошибок при записи страницы');

  l.add('');
  for i := 1 to 4 do Pop;

  l.add(PackStrR(IntToStr(PopInt),GetColWidth) + 'адрес начала памяти');
  l.add(PackStrR(IntToStr(PopInt),GetColWidth) + 'адрес служебной области');
  l.add(PackStrR(IntToStr(PopInt),GetColWidth) + 'адрес метки запуска');
  l.add(PackStrR(IntToStr(PopInt),GetColWidth) + 'адрес начала импульсов по получасам за сутки');
  l.add(PackStrR(IntToStr(PopInt),GetColWidth) + 'адрес начала импульсов по суткам');
  l.add(PackStrR(IntToStr(PopInt),GetColWidth) + 'адрес начала импульсов по месяцам');
  l.add(PackStrR(IntToStr(PopInt),GetColWidth) + 'адрес начала максимумов мощности по суткам');
  l.add(PackStrR(IntToStr(PopInt),GetColWidth) + 'адрес начала максимумов мощности по месяцам');
  l.add(PackStrR(IntToStr(PopInt),GetColWidth) + 'адрес начала счётчиков по месяцам');
  wPagesEnd := PopInt;
  l.add(PackStrR(IntToStr(wPagesEnd),GetColWidth) + 'адрес конца памяти');

  l.add('');
  for i := 1 to 6 do Pop;

  l.add(PackStrR(IntToStr(PopInt),GetColWidth) + 'количество срабатываний WDT');

  l.add('');
  l.add(PackStrR('0x' + IntToHex(PopInt,4),GetColWidth) + 'версия программы');
  l.add(PackStrR(IntToStr(PopInt),GetColWidth) + 'заводской номер');
  l.add(PackStrR(IntToStr(Pop),GetColWidth) + 'логический номер');

  pwCorrect     := PopInt;
  pwSystem      := PopInt;
  pwSensors     := PopInt;
  pwEvents      := PopInt;

  cwRecord      := PopInt;
  bRecordBlock  := Pop;
  bRecordSize   := Pop;

  cdwCorrect    := PopLong;
  cdwSystem     := PopLong;
  cdwSensors    := PopLong;
  cdwEvents     := PopLong;

  cdwSecond     := PopLong;
  cdwMinute1    := PopLong;
  cdwMinute3    := PopLong;
  cdwMinute30   := PopLong;
  cwDay         := PopInt;
  cwMonth       := PopInt;
  cwYear        := PopInt;

  for i := 1 to 4 do Pop;

  pwModems      := PopInt;
  cdwModems     := PopLong;

  pwPowDayGrp2  := PopInt;
  pwCntMonCan2  := PopInt;

  pwMessages  := PopInt;
  cdwMessages := PopLong;

  pwDefDayCan := PopInt;
  pwDefMonCan := PopInt;

  pwDiagram   := PopInt;
  pwCntDayCan7:= PopInt;

  cwRecord2    := PopInt;
  wRecord2Size := PopInt;

  pwAuxiliary  := PopInt;
  cdwAuxiliary := PopLong;
  wPages       := PopInt;

  l.add('');
  l.add(PackStrR(IntToStr(cwRecord),    GetColWidth) + 'журналы событий: количество записей общее');
  l.add(PackStrR(IntToStr(cwRecord2),   GetColWidth) + 'журналы событий: количество записей расширенное');
  l.add(PackStrR(IntToStr(bRecordBlock),GetColWidth) + 'журналы событий: количество записей на страницу');
  l.add(PackStrR(IntToStr(bRecordSize), GetColWidth) + 'журналы событий: количество страниц общее (+1)');
  l.add(PackStrR(IntToStr(wRecord2Size),GetColWidth) + 'журналы событий: количество страниц расширенное (+1)');

  l.add('');
  l.add(PackStrR(IntToStr(pwCorrect),   GetColWidth) + 'адрес журнала коррекции времени');
  l.add(PackStrR(IntToStr(pwSystem),    GetColWidth) + 'адрес журнала состояния системы');
  l.add(PackStrR(IntToStr(pwSensors),   GetColWidth) + 'адрес журнала состояния счётчиков');
  l.add(PackStrR(IntToStr(pwEvents),    GetColWidth) + 'адрес журнала внешних событий');
  l.add(PackStrR(IntToStr(pwModems),    GetColWidth) + 'адрес журнала состояния модемов');
  l.add(PackStrR(IntToStr(pwMessages),  GetColWidth) + 'адрес журнала СМС-контроля');
  l.add(PackStrR(IntToStr(pwAuxiliary), GetColWidth) + 'адрес журнала состояния счётчиков (расширенного)');

  l.add('');
  l.add(PackStrR(IntToStr(wPages), GetColWidth)           + 'количество страниц памяти (всего)');
  l.add(PackStrR(IntToStr(wPagesEnd), GetColWidth)        + 'количество страниц памяти (занятых)');
  l.add(PackStrR(IntToStr(wPages-wPagesEnd), GetColWidth) + 'количество страниц памяти (свободных)');

  l.add('');
  l.add(PackStrR(IntToStr(cdwCorrect),  GetColWidth) + 'счетчик журнала коррекции времени');
  l.add(PackStrR(IntToStr(cdwSystem),   GetColWidth) + 'счетчик журнала состояния системы');
  l.add(PackStrR(IntToStr(cdwSensors),  GetColWidth) + 'счетчик журнала состояния счётчиков');
  l.add(PackStrR(IntToStr(cdwEvents),   GetColWidth) + 'счетчик журнала внешних событий');
  l.add(PackStrR(IntToStr(cdwModems),   GetColWidth) + 'счетчик журнала состояния модемов');
  l.add(PackStrR(IntToStr(cdwMessages), GetColWidth) + 'счетчик журнала СМС-контроля');
  l.add(PackStrR(IntToStr(cdwAuxiliary),GetColWidth) + 'счетчик журнала состояния счётчиков (расширенного)');

  l.add('');
  l.add(PackStrR(IntToStr(cdwSecond),   GetColWidth) + 'количество переходов: секунда');
  l.add(PackStrR(IntToStr(cdwMinute1),  GetColWidth) + 'количество переходов: 1 мин');
  l.add(PackStrR(IntToStr(cdwMinute3),  GetColWidth) + 'количество переходов: 3 мин');
  l.add(PackStrR(IntToStr(cdwMinute30), GetColWidth) + 'количество переходов: 30 мин');
  l.add(PackStrR(IntToStr(cwDay),       GetColWidth) + 'количество переходов: день');
  l.add(PackStrR(IntToStr(cwMonth),     GetColWidth) + 'количество переходов: месяц');
  l.add(PackStrR(IntToStr(cwYear),      GetColWidth) + 'количество переходов: год');

  l.add('');
  l.add(PackStrR(IntToStr(pwPowDayGrp2),GetColWidth) + 'адрес начала максимумов мощности по суткам (специальный)');
  l.add(PackStrR(IntToStr(pwCntMonCan2),GetColWidth) + 'адрес начала счётчиков по месяцам (специальный)');
  l.add(PackStrR(IntToStr(pwDefDayCan), GetColWidth) + 'адрес начала достоверности по суткам');
  l.add(PackStrR(IntToStr(pwDefMonCan), GetColWidth) + 'адрес начала достоверности по месяцам');
  l.add(PackStrR(IntToStr(pwDiagram),   GetColWidth) + 'адрес начала значений счетчиков по получасам за сутки');
  l.add(PackStrR(IntToStr(pwCntDayCan7),GetColWidth) + 'адрес начала значений счетчиков на начало суток');

  AddInfoAll(l);
{
  AddInfo(Times2Str(tiCurr));
  AddInfo(Times2Str(Min1IndexToDate(DateToMin1Index(tiCurr))));
  AddInfo(Times2Str(Min3IndexToDate(DateToMin3Index(tiCurr))));
  AddInfo(Times2Str(Min30IndexToDate(DateToMin30Index(tiCurr))));
  AddInfo(Times2Str(DayIndexToDate(DateToDayIndex(tiCurr))));
  AddInfo(Times2Str(MonIndexToDate(DateToMonIndex(tiCurr))));
}
  if GetVersion = 2 then begin
    AddInfo('');
    AddInfo('');
    AddInfo('*Чтение состояния памяти (версия 1)');
    AddInfo('');
    ShowMin1(cdwMinute1);
    ShowMin3(cdwMinute3,ibMnt);
    ShowMin30(cdwMinute30,iwHou);
    ShowDay(cwDay,ibDay);
    ShowMon(cwMonth,ibMon);
  end
  else begin
    AddInfo('');
    AddInfo('для данной версии сумматора следует использовать запрос: Чтение состояния памяти (версия 2)');
    AddInfo('');
  end;

  BoxRun;
end;

end.
