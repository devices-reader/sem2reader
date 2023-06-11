unit box;

interface

uses SysUtils, AdTapi, timez;

var
  wPageSize, wFreePageSize: word;

type
  actions =
  (
    acGetTime1 = 0,
    acGetVersion,
    acGetVersion2,
    acGetTransEng,
    acGetPulseHou,

    acGetDecret,
    acGetPublic,
    acGetPubTariffs,
    acGetPowTariffs,
    acGetEngTariffs,
    acGetRelaxs,
    acGetGaps1,
    acGetGaps2,
    acGetGaps3,

    acGetImpCanMnt,
    acGetPowCanMnt,
    
    acGetDiagram,
    acGetImpCanHou,
    acGetImpCanDay,
    acGetImpCanMon,

    acGetEngGrpHou,
    acGetEngGrpDay,
    acGetEngGrpMon,

    acGetMaxGrpDay,
    acGetMaxGrpMon,

    acGetGroup,
    acGetDigit,
    acGetDigit2,
    acGetDigitEnbl,
    acGetHouCheck,
    acGetPort,
    acGetOutputDelay,
    acGetCorrectLimit,

    acGetControl,
    acGetSchedule0,
    acGetSchedule1,
    acGetSchedule2,
    acGetSchedule3,
    acGetRecalc,
    acGetBorder,
    acGetBorder2,
    acGetBorder3,
    acGetPhone,
    acGetInfoGPS,
    acGetInfoSMK,
    acGetCorrect,
    acGetCorrect21,
    acGetCorrect3,
    acGetCorrect20,
    acGetCurrent1,
    acGetCurrent4,
    acGetLinkErrors,
    acGetOverflowHou,
    acGetP79Errors,
    acGetPhone2,
    acGetDevice23,
    acGetAnswerDisable,
    acGetStart,
    acGetBulk,
    acGetEngFrac1a,
    acGetEngFrac1b,
    acGetEngFrac2,
    acGetErrorLink,
    acGetExt0,
    acGetReview,

    acGetAnswerEnable,
    acGetRecordsMap,
    acGetRecords0,
    acGetRecords1,
    acGetRecords2,
    acGetRecordsX0,
    acGetRecords4,
    acGetRecords3,
    acGetRecords5,
    acGetEvents1,
    acGetEvents2,
    acGetParams,
    acGetParams2,
    acGetParams3,
    acGetContacts3,

    acGetExt43,
    acGetExt40,
    acGetExt44,
    acGetExt41,
    acGetExt42,

    acGetExt6,
    acGetExt7,
    acGetCntCanMon,
    acGetEscS,

    acGetExt50,
    acGetExt51,

    acGetExt40T,

    acGetCalc1,
//    acGetCalc2,
    acGetCalc3,
    acGetPowCanHou,
    acGetPowGrpHou,

    acGetTransEng_,
    acGetTransCnt_,
    acGetPulseHou_,
    acGetPulseMnt_,
    acGetValueEngHou_,
    acGetValueCntHou_,
    acGetValueEngMnt_,
    acGetValueCntMnt_,
    acGetCount_,
    acGetLosse_,
    acGetLevel_,

    acGetQueryCF,
    acGetQueryFF19,
    acGetAce,
    acGetBorder1,
    acGetEngCanDay,
    acGetEngCanMon,

    acGetCheckup,
    acGetCheckupEventsDay,
    acGetCheckupEventsMon,
    acGetCheckupHou,
    acGetCheckupDefectsDay,
    acGetCheckupDefectsMon,
    acGetCheckupDays,

    acGetMemory0,
    acGetRealtime2,
    acGetMemory2,
    acGetMemory21,
    acGetMemory22,
    acGetMemory23,
    acGetStat1,

    acGetXBYTE,
    acGetFVAR,
    acGetCBYTE,
    acGetFCVAR,

    acGetDefCanHou,
    acGetDefGrpHou,
    acGetDefCanDay,
    acGetDefCanMon,
    acGetDefGrpDay,
    acGetDefGrpMon,
    acGetDefCanDay2,
    acGetDefCanMon2,
    acGetDefGrpDay2,
    acGetDefGrpMon2,

    acGetEngGrpPrevHou_Def,
    acGetPowGrpPrevHou_Def,
    acGetEngGrpDay_Def,
    acGetEngGrpMon_Def,
    acGetMaxGrpDay_Def,
    acGetMaxGrpMon_Def,
    
    acGetEngGrpDayX2,
    acGetEngGrpMonX2,

    acGetExt40X2,
    acGetExt44X2,
    acGetExt41X2,
    acGetExt42X2,
    acGetExt6X2,
    acGetExt40TX2,
    acGetExt50X2,
    acGetExt51X2,
    acGetExt7X2,

    acGetEchoNtoN,
    acGetEchoNto1,
    acGetEcho1toN,

    acGetTimeoutHistogram35,
    acGetLogs35,
    acGetCounters35,
    acGetLogs40,
    acGetCounters40,
    acGetRealtimeIndices,

    acNone,
    acCtrlZ,

    acGetEscS_Time,
    acGetEscV,
    acGetEscV_Time,
    acGetEscU,

    acGetCurrent2,
    acGetCurrent3,

    acGetTime2,

    acGetMemory1,
    acGetMemory12
  );

  querys = record
    Action:     actions;
    cwOut:      word;
    cwIn:       word;
    bNumber:    byte;
    fLong:      boolean;
  end;

procedure BoxCreate;
procedure RunBox;
procedure BoxRun;
procedure BoxRead;
procedure BoxShow(Action: actions);

procedure TestVersion4;
procedure SetVersion(v: shortint);
function GetVersion: shortint;

var
  cwConnect:  longword;
  tiCurr:     times;

implementation

uses main, support, soutput, sinput, progress,
get_diagram, get_impcanhou, get_powcanhou, get_powgrphou,
get_impcanday, get_impcanmnt, get_impcanmon, get_records, get_records_map, get_version, get_version2,
get_digit, get_digit2, get_digit_enbl, get_hou_check, get_port, get_output_delay, get_correct_limit, get_ace,
get_control, get_schedule, get_recalc, get_link_errors, get_p79_errors, get_overflow_hou,
get_border, get_border1, get_border2, get_border3, get_phone,
get_trans_eng, get_pulse_hou, get_time, get_tariffs, get_relaxs, get_gaps1, get_gaps2, get_gaps3,
get_enggrphou, get_enggrpday, get_enggrpmon,
get_engcanday, get_engcanmon,
get_maxgrpday, get_maxgrpmon,
get_cntcanmon, get_esc, get_group,
get_params, get_params2, get_params3, get_device23,
get_infogps, get_infosmk, get_phone2, get_answer_disable, get_answer_enable,
get_correct, get_correct21, get_correct20, get_correct3, get_canal_spec,
get_extended0,
get_extended44, get_extended6, get_extended6_x2, get_extended4, get_extended43, get_extended5, get_extended5_x2, get_events, get_extended7, get_extended7_x2, get_extended4t, get_extended4t_x2,
get_extended44_x2, get_extended4_x2,
get_queryCF, get_queryFF19,
get_decret, get_start, get_bulk, get_engfrac1a, get_engfrac1b, get_engfrac2, get_errorlink,
get_checkup, get_checkup_events_day, get_checkup_events_mon, get_checkup_hou, get_checkup_defects_day, get_checkup_defects_mon, get_checkup_days,
get_realtime2,
get_memory0, get_memory1, get_memory12, get_memory2, get_memory21, get_memory22, get_memory23, get_memory3,
get_defcanhou, get_defgrphou, get_defcanday, get_defcanmon, get_defgrpday, get_defgrpmon, get_defcanday2, get_defcanmon2, get_defgrpday2, get_defgrpmon2,
get_enggrpprevhou_def, get_powgrpprevhou_def, get_enggrpday_def, get_enggrpmon_def, get_maxgrpday_def, get_maxgrpmon_def,
get_enggrpday_x2, get_enggrpmon_x2,
get_review,
get_current, get_current4, get_contacts3, get_calc1, get_calc2, get_calc3, get_stat1,
histograms, get_echo_n_to_n, get_echo_n_to_1, get_echo_1_to_n,
get_timeout_histogram35, get_logs35,get_counters35,
get_logs40, get_counters40,
get_realtime_indices;

var
  BoxStart:     TDateTime;
  iwBox:        word;

  bVersion:     shortint;

procedure BoxCreate;
var
  i:  word;
begin
  with frmMain.clbMain do begin
    for i := 1 to Ord(acNone) do Items.Add('?');

  Items[Ord(acGetTime1)]          := ('текущее время');
  Items[Ord(acGetTransEng)]       := ('коэффициенты трансформации');
  Items[Ord(acGetPulseHou)]       := ('коэффициенты преобразования');

  Items[Ord(acGetPublic)]         := ('тип учёта тарифов');
  Items[Ord(acGetPubTariffs)]     := ('совмещённые тарифы для мощности и энергии');
  Items[Ord(acGetPowTariffs)]     := ('раздельные тарифы для мощности');
  Items[Ord(acGetEngTariffs)]     := ('раздельные тарифы для энергии');
  Items[Ord(acGetRelaxs)]         := ('список праздников');
  Items[Ord(acGetDecret)]         := ('переход на летнее/зимнее время');
  Items[Ord(acGetStart)]          := ('статистика выключения/включения');
  Items[Ord(acGetBulk)]           := ('статистика пакетного режима');
  Items[Ord(acGetEngFrac1a)]      := ('статистика обработки чисел в формате с плавающей запятой 1');
  Items[Ord(acGetEngFrac1b)]      := ('статистика обработки чисел в формате с плавающей запятой 1 (двойная точность)');
  Items[Ord(acGetEngFrac2)]       := ('статистика обработки чисел в формате с плавающей запятой 2');
  Items[Ord(acGetErrorLink)]      := ('статистика распознанных ошибок связи');
  Items[Ord(acGetGaps1)]          := ('*тарифные периоды');
  Items[Ord(acGetGaps2)]          := ('*график тарифных периодов за год');
  Items[Ord(acGetGaps3)]          := ('*тарифы на текущие сутки');

  Items[Ord(acGetImpCanMnt)]      := ('импульсы по каналам за трехминуты');
  Items[Ord(acGetPowCanMnt)]      := ('мощность по каналам за трехминуты');

  Items[Ord(acGetDiagram)]        := ('значения счётчиков по каналам за сутки по получасам');
  Items[Ord(acGetImpCanHou)]      := ('энергия по каналам за сутки по получасам');
  Items[Ord(acGetPowCanHou)]      := ('мощность по каналам за сутки по получасам');
  Items[Ord(acGetPowGrpHou)]      := ('мощность по группам за сутки по получасам');
  Items[Ord(acGetImpCanDay)]      := ('энергия по каналам за сутки');
  Items[Ord(acGetImpCanMon)]      := ('энергия по каналам за месяц');

  Items[Ord(acGetDefCanHou)]      := ('достоверность по каналам за сутки по получасам');
  Items[Ord(acGetDefGrpHou)]      := ('достоверность по группам за сутки по получасам');
  Items[Ord(acGetDefCanDay)]      := ('полная достоверность по каналам за сутки');
  Items[Ord(acGetDefCanMon)]      := ('полная достоверность по каналам за месяц');
  Items[Ord(acGetDefGrpDay)]      := ('полная достоверность по группам за сутки');
  Items[Ord(acGetDefGrpMon)]      := ('полная достоверность по группам за месяц');
  Items[Ord(acGetDefCanDay2)]     := ('краткая достоверность по каналам за сутки');
  Items[Ord(acGetDefCanMon2)]     := ('краткая достоверность по каналам за месяц');
  Items[Ord(acGetDefGrpDay2)]     := ('краткая достоверность по группам за сутки');
  Items[Ord(acGetDefGrpMon2)]     := ('краткая достоверность по группам за месяц');

  Items[Ord(acGetEngGrpPrevHou_Def)] := ('энергия за предыдущий получас (с учетом достоверности)');
  Items[Ord(acGetPowGrpPrevHou_Def)] := ('мощность за предыдущий получас (с учетом достоверности)');
  Items[Ord(acGetEngGrpDay_Def)]  := ('энергия по группам за сутки (с учетом достоверности)');
  Items[Ord(acGetEngGrpMon_Def)]  := ('энергия по группам за месяц (с учетом достоверности)');
  Items[Ord(acGetMaxGrpDay_Def)]  := ('максимумы мощности по группам за сутки (с учетом достоверности)');
  Items[Ord(acGetMaxGrpMon_Def)]  := ('максимумы мощности по группам за месяц (с учетом достоверности)');

  Items[Ord(acGetEngGrpHou)]      := ('энергия по группам за сутки по получасам');
  Items[Ord(acGetEngGrpDay)]      := ('энергия по группам за сутки');
  Items[Ord(acGetEngGrpMon)]      := ('энергия по группам за месяц');
  Items[Ord(acGetEngGrpDayX2)]    := ('энергия по группам за сутки (двойная точность)');
  Items[Ord(acGetEngGrpMonX2)]    := ('энергия по группам за месяц (двойная точность)');
  Items[Ord(acGetEngCanDay)]      := ('энергия по каналам за сутки');
  Items[Ord(acGetEngCanMon)]      := ('энергия по каналам за месяц');

  Items[Ord(acGetMaxGrpDay)]      := ('максимумы мощности по группам за сутки');
  Items[Ord(acGetMaxGrpMon)]      := ('максимумы мощности по группам за месяц');

    Items[Ord(acGetGroup)]      := ('группы');
    Items[Ord(acGetDigit)]      := ('цифровые счётчики');
    Items[Ord(acGetDigit2)]     := ('дополнительные адреса цифровых счетчиков');
    Items[Ord(acGetDigitEnbl)]  := ('разрешенные цифровые счётчики');
    Items[Ord(acGetHouCheck)]   := ('количество повторов при опросе цифровых счетчиков');
    Items[Ord(acGetPort)]       := ('порты');
  Items[Ord(acGetOutputDelay)]  := ('задержки на переключение портов из режима приема в режим передачи');
  Items[Ord(acGetCorrectLimit)] := ('максимальная разница времени счетчиков и сумматора без коррекции');
  Items[Ord(acGetAce)]          := ('*настроки последовательных портов');

    Items[Ord(acGetControl)]    := ('график коррекции времени');
    Items[Ord(acGetSchedule0)]  := ('график опроса по порту 1');
    Items[Ord(acGetSchedule1)]  := ('график опроса по порту 2');
    Items[Ord(acGetSchedule2)]  := ('график опроса по порту 3');
    Items[Ord(acGetSchedule3)]  := ('график опроса по порту 4');
    Items[Ord(acGetRecalc)]     := ('график перерасчета');
    Items[Ord(acGetBorder)]     := ('границы опроса цифровых счетчиков 1');
    Items[Ord(acGetBorder1)]    := ('*границы опроса цифровых счетчиков');
    Items[Ord(acGetBorder2)]    := ('границы опроса цифровых счетчиков 2');
    Items[Ord(acGetBorder3)]    := ('границы опроса цифровых счетчиков 3');
    Items[Ord(acGetPhone)]      := ('телефоны');
    Items[Ord(acGetParams)]     := ('мгновенные параметры (туннель)');
    Items[Ord(acGetParams2)]    := ('список мгновенных параметров');
    Items[Ord(acGetParams3)]    := ('график мгновенных параметров');
    Items[Ord(acGetVersion)]    := ('версия');
    Items[Ord(acGetVersion2)]   := ('расширенная версия');
    Items[Ord(acGetInfoGPS)]    := ('часы GPS (туннель)');
    Items[Ord(acGetInfoSMK)]    := ('часы СИМЭК-48 (туннель)');
    Items[Ord(acGetCorrect)]    := ('статистика коррекции времени');
    Items[Ord(acGetCorrect21)]  := ('статистика запрета коррекции времени');
    Items[Ord(acGetCorrect3)]   := ('статистика ограничения коррекции времени при использовании часов GPS');
    Items[Ord(acGetCorrect20)]  := ('статистика коррекции времени СИМЭК-48');
    Items[Ord(acGetCurrent1)]      := ('статистика трехминутного опроса 1');
    Items[Ord(acGetCurrent4)]      := ('статистика трехминутного опроса 2');
    Items[Ord(acGetPhone2)]        := ('статистика СМС-контроля');
    Items[Ord(acGetAnswerDisable)] := ('cтатистика запрета ответа на запросы во время опроса цифровых счетчиков');
    Items[Ord(acGetAnswerEnable)]  := ('отмена запрета ответа на запросы во время опроса цифровых счетчиков');
    Items[Ord(acGetDevice23)]      := ('cтатистика РСВУ-1400');
    Items[Ord(acGetRecordsMap)]    := ('разрешенные события');
    Items[Ord(acGetRecords0)]      := ('журнал коррекции времени');
    Items[Ord(acGetRecords1)]      := ('журнал состояния системы');
    Items[Ord(acGetRecords2)]      := ('журнал состояния счетчиков');
    Items[Ord(acGetRecords3)]      := ('журнал внешних событий');
    Items[Ord(acGetRecords4)]      := ('журнал состояния модемов');
    Items[Ord(acGetRecords5)]      := ('журнал СМС-контроля');
    Items[Ord(acGetRecordsX0)]     := ('журнал состояния счётчиков (расширенный)');
    Items[Ord(acGetLinkErrors)]    := ('статистика получасового опроса');
    Items[Ord(acGetOverflowHou)]   := ('статистика переполнения получасовых графиков');
    Items[Ord(acGetP79Errors)]     := ('статистика опроса счетчиков на начало суток');
    Items[Ord(acGetEvents1)]       := ('статистика внешних событий 1');
    Items[Ord(acGetEvents2)]       := ('статистика внешних событий 2');
    Items[Ord(acGetContacts3)]     := ('статистика реле (режим 3)');

    Items[Ord(acGetTransEng_)]      := ('*коэффициенты трансформации (для энергии)');
    Items[Ord(acGetTransCnt_)]      := ('*коэффициенты трансформации (для счетчиков)');
    Items[Ord(acGetPulseHou_)]      := ('*коэффициенты преобразования (для получасов)');
    Items[Ord(acGetPulseMnt_)]      := ('*коэффициенты преобразования (для трехминут)');
    Items[Ord(acGetValueEngHou_)]   := ('*коэффициенты эквивалентности EH');
    Items[Ord(acGetValueCntHou_)]   := ('*коэффициенты эквивалентности CH');
    Items[Ord(acGetValueEngMnt_)]   := ('*коэффициенты эквивалентности EM');
    Items[Ord(acGetValueCntMnt_)]   := ('*коэффициенты эквивалентности CM');
    Items[Ord(acGetCount_)]         := ('*начальные показания счетчиков');
    Items[Ord(acGetLosse_)]         := ('*коэффициенты потерь');
    Items[Ord(acGetLevel_)]         := ('*коэффициенты отношения');

    Items[Ord(acGetQueryCF)]        := ('*запрос 0xCF (значения счётчиков из буфера)');
    Items[Ord(acGetQueryFF19)]      := ('*запрос 0xFF19 (значения времени опроса счётчиков из буфера)');

    Items[Ord(acGetExt0)]        := ('статистика качества связи');
    Items[Ord(acGetReview)]      := ('статистика проверки при чтении профилей');

    Items[Ord(acGetExt40)]       := ('значения счётчиков на конец месяца (из буфера с дозапросом) (по маске каналов) (вариант 1)');
    Items[Ord(acGetExt41)]       := ('значения счётчиков на конец месяца (из буфера с дозапросом) (по индексу канала)');
    Items[Ord(acGetExt42)]       := ('значения счётчиков на конец месяца (мгновенные)');
    Items[Ord(acGetExt43)]       := ('список разрешенных каналов при чтении значений счётчиков по месяцам');

    Items[Ord(acGetExt44)]       := ('значения счётчиков на конец месяца (из буфера с дозапросом) (по маске каналов) (вариант 2)');
    Items[Ord(acGetExt6)]        := ('значения счётчиков на конец месяца (из буфера прямого опроса)');
    Items[Ord(acGetExt7)]        := ('значения счётчиков на начало суток');
    Items[Ord(acGetCntCanMon)]   := ('значения счётчиков по месяцам (мгновенные)');
    Items[Ord(acGetEscS)]        := ('значения счётчиков из получасового буфера');

    Items[Ord(acGetExt50)]       := ('значения счетчиков текущие по тарифам 1');
    Items[Ord(acGetExt51)]       := ('значения счетчиков текущие по тарифам 2');

    Items[Ord(acGetExt50X2)]     := ('значения счетчиков текущие по тарифам 1 (двойная точность)');
    Items[Ord(acGetExt51X2)]     := ('значения счетчиков текущие по тарифам 2 (двойная точность)');

    Items[Ord(acGetExt40X2)]       := ('значения счётчиков на конец месяца (из буфера с дозапросом) (по маске каналов) (вариант 1) (двойная точность)');
    Items[Ord(acGetExt41X2)]       := ('значения счётчиков на конец месяца (из буфера с дозапросом) (по индексу канала) (двойная точность)');
    Items[Ord(acGetExt42X2)]       := ('значения счётчиков на конец месяца (мгновенные) (двойная точность)');
    Items[Ord(acGetExt44X2)]       := ('значения счётчиков на конец месяца (из буфера с дозапросом) (по маске каналов) (вариант 2) (двойная точность)');

    Items[Ord(acGetExt6X2)]      := ('значения счётчиков на конец месяца (из буфера прямого опроса)(двойная точность)');
    Items[Ord(acGetExt7X2)]      := ('значения счётчиков на начало суток (двойная точность)');

    Items[Ord(acGetExt40T)]      := ('значения счётчиков на начало месяца по тарифам (из буфера с дозапросом)');
    Items[Ord(acGetExt40TX2)]    := ('значения счётчиков на начало месяца по тарифам (из буфера с дозапросом) (двойная точность)');

    Items[Ord(acGetCalc1)]         := ('расчет №1');
//    Items[Ord(acGetCalc2)]      := ('расчет №2');
    Items[Ord(acGetCalc3)]         := ('расчет №3');

    Items[Ord(acGetCheckup)]      := InfoGetCheckup;
    Items[Ord(acGetCheckupEventsDay)]:= InfoGetCheckupEventsDay;
    Items[Ord(acGetCheckupEventsMon)]:= InfoGetCheckupEventsMon;
    Items[Ord(acGetCheckupHou)]   := InfoGetCheckupHou;
    Items[Ord(acGetCheckupDefectsDay)]:= InfoGetCheckupDefectsDay;
    Items[Ord(acGetCheckupDefectsMon)]:= InfoGetCheckupDefectsMon;
    Items[Ord(acGetCheckupDays)]:= InfoGetCheckupDays;

    Items[Ord(acGetMemory0)]      := ('*чтение состояния памяти (версия 1)');
    Items[Ord(acGetRealtime2)]    := ('*чтение состояния памяти (версия 2)');
    Items[Ord(acGetMemory2)]      := ('чтение памяти по заданным адресам');
    Items[Ord(acGetMemory21)]     := ('чтение памяти (энергия по каналам за сутки по получасам)');
    Items[Ord(acGetMemory22)]     := ('чтение памяти (энергия по каналам за сутки)');
    Items[Ord(acGetMemory23)]     := ('чтение памяти (энергия по каналам за месяцы)');

    Items[Ord(acGetStat1)]       := ('*статистика использования памяти 1');

    Items[Ord(acGetXBYTE)]       := ('*чтение памяти 1');
    Items[Ord(acGetFVAR)]        := ('*чтение памяти 2');
    Items[Ord(acGetCBYTE)]       := ('*чтение памяти 3');
    Items[Ord(acGetFCVAR)]       := ('*чтение памяти 4');

    Items[Ord(acGetEchoNtoN)]   := ('*проверка канала связи N к N');
    Items[Ord(acGetEchoNto1)]   := ('*проверка канала связи N к 1');
    Items[Ord(acGetEcho1toN)]   := ('*проверка канала связи 1 к N');

    Items[Ord(acGetTimeoutHistogram35)] := ('*таймауты счетчиков CExxx NNCL2');
    Items[Ord(acGetLogs35)]             := ('*события счетчиков CExxx NNCL2');
    Items[Ord(acGetCounters35)]         := ('*счетчики счетчиков CExxx NNCL2');

    Items[Ord(acGetLogs40)]             := ('*события счетчиков Меркурий-234 СПОДЭС');
    Items[Ord(acGetCounters40)]         := ('*счетчики счетчиков Меркурий-234 СПОДЭС');

    Items[Ord(acGetRealtimeIndices)] := ('*журнал календарных индексов');

    for i := 1 to Ord(acNone) do Items.Strings[i-1] := IntToStr(i) + '.  ' + Items.Strings[i-1];
  end;
end;

procedure BoxRun;
begin
  RunBox;
end;

procedure RunBox;
var
  b:  boolean;
begin
 with frmMain do begin
  with clbMain do  while (iwBox < Items.Count) do begin
    if Checked[iwBox] then begin
      case iwBox of
        Ord(acGetTIME1):       begin BoxGetTime1;       Inc(iwBox); exit; end;
        Ord(acGetTRANSEng):    begin BoxGetTransEng;    Inc(iwBox); exit; end;
        Ord(acGetPULSEHou):    begin BoxGetPulseHou;    Inc(iwBox); exit; end;
        Ord(acGetPublic):      begin BoxGetPublic;      Inc(iwBox); exit; end;
        Ord(acGetPubTariffs):  begin BoxGetPubTariffs;  Inc(iwBox); exit; end;
        Ord(acGetPowTariffs):  begin BoxGetPowTariffs;  Inc(iwBox); exit; end;
        Ord(acGetEngTariffs):  begin BoxGetEngTariffs;  Inc(iwBox); exit; end;
        Ord(acGetRelaxs):      begin BoxGetRelaxs;      Inc(iwBox); exit; end;
        Ord(acGetDecret):      begin BoxGetDecret;      Inc(iwBox); exit; end;
        Ord(acGetStart):       begin BoxGetStart;       Inc(iwBox); exit; end;
        Ord(acGetBulk):        begin BoxGetBulk;        Inc(iwBox); exit; end;
        Ord(acGetEngFrac1a):   begin BoxGetEngFrac1a;   Inc(iwBox); exit; end;
        Ord(acGetEngFrac1b):   begin BoxGetEngFrac1b;   Inc(iwBox); exit; end;
        Ord(acGetEngFrac2):    begin BoxGetEngFrac2;    Inc(iwBox); exit; end;
        Ord(acGetErrorLink):   begin BoxGetErrorLink;   Inc(iwBox); exit; end;
        Ord(acGetGaps1):       begin BoxGetGaps1;       Inc(iwBox); exit; end;
        Ord(acGetGaps2):       begin BoxGetGaps2;       Inc(iwBox); exit; end;
        Ord(acGetGaps3):       begin BoxGetGaps3;       Inc(iwBox); exit; end;

        Ord(acGetIMPCANMNT):   begin BoxGetImpCanMnt;   Inc(iwBox); exit; end;
        Ord(acGetPowCANMNT):   begin BoxGetPowCanMnt;   Inc(iwBox); exit; end;
        Ord(acGetDiagram):     begin BoxGetDiagram;     Inc(iwBox); exit; end;
        Ord(acGetIMPCANHOU):   begin BoxGetImpCanHou;   Inc(iwBox); exit; end;
        Ord(acGetPowCANHOU):   begin BoxGetPowCanHou;   Inc(iwBox); exit; end;
        Ord(acGetPowGrpHOU):   begin BoxGetPowGrpHou;   Inc(iwBox); exit; end;
        Ord(acGetIMPCANDAY):   begin BoxGetImpCanDay;   Inc(iwBox); exit; end;
        Ord(acGetIMPCANMON):   begin BoxGetImpCanMon;   Inc(iwBox); exit; end;

        Ord(acGetENGGRPHOU):   begin BoxGetEngGrpHou;   Inc(iwBox); exit; end;
        Ord(acGetENGGRPDAY):   begin BoxGetEngGrpDay;   Inc(iwBox); exit; end;
        Ord(acGetENGGRPMON):   begin BoxGetEngGrpMon;   Inc(iwBox); exit; end;
        Ord(acGetENGGRPDAYX2): begin BoxGetEngGrpDayX2; Inc(iwBox); exit; end;
        Ord(acGetENGGRPMONX2): begin BoxGetEngGrpMonX2; Inc(iwBox); exit; end;
        Ord(acGetENGCanDAY):   begin BoxGetEngCanDay;   Inc(iwBox); exit; end;
        Ord(acGetENGCanMON):   begin BoxGetEngCanMon;   Inc(iwBox); exit; end;

        Ord(acGetMaxGRPDAY):   begin BoxGetMaxGrpDay;   Inc(iwBox); exit; end;
        Ord(acGetMaxGRPMon):   begin BoxGetMaxGrpMon;   Inc(iwBox); exit; end;

        Ord(acGetExt7):       begin BoxGetExt7;        Inc(iwBox); exit; end;
        Ord(acGetExt7X2):     begin BoxGetExt7X2;      Inc(iwBox); exit; end;
        Ord(acGetExt6):       begin BoxGetExt6;        Inc(iwBox); exit; end;
        Ord(acGetExt6X2):     begin BoxGetExt6X2;      Inc(iwBox); exit; end;
        Ord(acGetCNTCANMON):  begin BoxGetCntCanMon;   Inc(iwBox); exit; end;
        Ord(acGetESCS)      : begin BoxGetEsc;         Inc(iwBox); exit; end;
        Ord(acGetGROUP):      begin BoxGetGroup;       Inc(iwBox); exit; end;
        Ord(acGetDIGIT):      begin BoxGetDigit;       Inc(iwBox); exit; end;
        Ord(acGetDigit2):     begin BoxGetDigit2;      Inc(iwBox); exit; end;
        Ord(acGetDIGITEnbl):  begin BoxGetDigitEnbl;   Inc(iwBox); exit; end;
        Ord(acGetHouCheck):   begin BoxGetHouCheck;    Inc(iwBox); exit; end;
        Ord(acGetPort):       begin BoxGetPort;        Inc(iwBox); exit; end;
        Ord(acGetOutputDelay):begin BoxGetOutputDelay; Inc(iwBox); exit; end;
        Ord(acGetCorrectLimit):begin BoxGetCorrectLimit; Inc(iwBox); exit; end;
        Ord(acGetAce):        begin BoxGetAce;         Inc(iwBox); exit; end;

        Ord(acGetControl):    begin BoxGetControl;       Inc(iwBox); exit; end;
        Ord(acGetSchedule0):  begin BoxGetSchedule(0);       Inc(iwBox); exit; end;
        Ord(acGetSchedule1):  begin BoxGetSchedule(1);       Inc(iwBox); exit; end;
        Ord(acGetSchedule2):  begin BoxGetSchedule(2);       Inc(iwBox); exit; end;
        Ord(acGetSchedule3):  begin BoxGetSchedule(3);       Inc(iwBox); exit; end;
        Ord(acGetRecalc):     begin BoxGetRecalc;       Inc(iwBox); exit; end;
        Ord(acGetBorder):     begin BoxGetBorder;       Inc(iwBox); exit; end;
        Ord(acGetBorder1):    begin BoxGetBorder1;      Inc(iwBox); exit; end;
        Ord(acGetBorder2):    begin BoxGetBorder2;      Inc(iwBox); exit; end;
        Ord(acGetBorder3):    begin BoxGetBorder3;      Inc(iwBox); exit; end;
        Ord(acGetPhone):      begin BoxGetPhone;        Inc(iwBox); exit; end;
        Ord(acGetPARAMS):     begin BoxGetParams;       Inc(iwBox); exit; end;
        Ord(acGetPARAMS2):    begin BoxGetParams2;      Inc(iwBox); exit; end;
        Ord(acGetPARAMS3):    begin BoxGetParams3;      Inc(iwBox); exit; end;
        Ord(acGetVERSION):    begin BoxGetVersion;      Inc(iwBox); exit; end;
        Ord(acGetVersion2):   begin BoxGetVersion2;     Inc(iwBox); exit; end;
        Ord(acGetInfoGPS):    begin BoxGetInfoGPS;      Inc(iwBox); exit; end;
        Ord(acGetInfoSMK):    begin BoxGetInfoSMK;      Inc(iwBox); exit; end;
        Ord(acGetCORRECT):    begin BoxGetCorrect;      Inc(iwBox); exit; end;
        Ord(acGetCorrect21):  begin BoxGetCorrect21;    Inc(iwBox); exit; end;
        Ord(acGetCorrect3):   begin BoxGetCorrect3;     Inc(iwBox); exit; end;
        Ord(acGetCORRECT20):  begin BoxGetCorrect20;    Inc(iwBox); exit; end;
        Ord(acGetCURRENT1):   begin BoxGetCurrent1;     Inc(iwBox); exit; end;
        Ord(acGetCURRENT4):   begin BoxGetCurrent4;     Inc(iwBox); exit; end;
        Ord(acGetPhone2):     begin BoxGetPhone2;       Inc(iwBox); exit; end;
        Ord(acGetAnswerDisable):begin BoxGetAnswerDisable;  Inc(iwBox); exit; end;
        Ord(acGetAnswerEnable):begin BoxGetAnswerEnable;  Inc(iwBox); exit; end;
        Ord(acGetDevice23):  begin BoxGetDevice23;    Inc(iwBox); exit; end;
        Ord(acGetRecordsMap):begin BoxGetRecordsMap;  Inc(iwBox); exit; end;
        Ord(acGetRECORDS0):  begin BoxGetRecords0;    Inc(iwBox); exit; end;
        Ord(acGetRECORDS1):  begin BoxGetRecords1;    Inc(iwBox); exit; end;
        Ord(acGetRECORDS2):  begin BoxGetRecords2;    Inc(iwBox); exit; end;
        Ord(acGetRECORDS3):  begin BoxGetRecords3;    Inc(iwBox); exit; end;
        Ord(acGetRECORDS4):  begin BoxGetRecords4;    Inc(iwBox); exit; end;
        Ord(acGetRECORDS5):  begin BoxGetRecords5;    Inc(iwBox); exit; end;
        Ord(acGetRecordsX0): begin BoxGetRecordsX0;   Inc(iwBox); exit; end;
        Ord(acGetLinkErrors):begin BoxGetLinkErrors;  Inc(iwBox); exit; end;
        Ord(acGetOverflowHou):begin BoxGetOverflowHou;  Inc(iwBox); exit; end;
        Ord(acGetP79Errors): begin BoxGetP79Errors;   Inc(iwBox); exit; end;
        Ord(acGetEvents1):   begin BoxGetEvents1;     Inc(iwBox); exit; end;
        Ord(acGetEvents2):   begin BoxGetEvents2;     Inc(iwBox); exit; end;
        Ord(acGetCONTACTS3): begin BoxGetContacts3;   Inc(iwBox); exit; end;

    Ord(acGetTransEng_):      begin BoxGetTransEng_;     Inc(iwBox); exit; end;
    Ord(acGetTransCnt_):      begin BoxGetTransCnt_;     Inc(iwBox); exit; end;
    Ord(acGetPulseHou_):      begin BoxGetPulseHou_;     Inc(iwBox); exit; end;
    Ord(acGetPulseMnt_):      begin BoxGetPulseMnt_;     Inc(iwBox); exit; end;
    Ord(acGetValueEngHou_):   begin BoxGetValueEngHou_;  Inc(iwBox); exit; end;
    Ord(acGetValueCntHou_):   begin BoxGetValueCntHou_;  Inc(iwBox); exit; end;
    Ord(acGetValueEngMnt_):   begin BoxGetValueEngMnt_;  Inc(iwBox); exit; end;
    Ord(acGetValueCntMnt_):   begin BoxGetValueCntMnt_;  Inc(iwBox); exit; end;
    Ord(acGetCount_):         begin BoxGetCount_;        Inc(iwBox); exit; end;
    Ord(acGetLosse_):         begin BoxGetLosse_;        Inc(iwBox); exit; end;
    Ord(acGetLevel_):         begin BoxGetLevel_;        Inc(iwBox); exit; end;

    Ord(acGetQueryCF):        begin BoxGetQueryCF;       Inc(iwBox); exit; end;
    Ord(acGetQueryFF19):      begin BoxGetQueryFF19;     Inc(iwBox); exit; end;

    Ord(acGetExt0):        begin BoxGetExt0;       Inc(iwBox); exit; end;
    Ord(acGetReview):      begin BoxGetReview;     Inc(iwBox); exit; end;

    Ord(acGetExt40):       begin BoxGetExt40;      Inc(iwBox); exit; end;
    Ord(acGetExt41):       begin BoxGetExt41;      Inc(iwBox); exit; end;
    Ord(acGetExt42):       begin BoxGetExt42;      Inc(iwBox); exit; end;
    Ord(acGetExt43):       begin BoxGetExt43;      Inc(iwBox); exit; end;
    Ord(acGetExt44):       begin BoxGetExt44;      Inc(iwBox); exit; end;

    Ord(acGetExt40X2):     begin BoxGetExt40X2;    Inc(iwBox); exit; end;
    Ord(acGetExt41X2):     begin BoxGetExt41X2;    Inc(iwBox); exit; end;
    Ord(acGetExt42X2):     begin BoxGetExt42X2;    Inc(iwBox); exit; end;
    Ord(acGetExt44X2):     begin BoxGetExt44X2;    Inc(iwBox); exit; end;

    Ord(acGetExt50):       begin BoxGetExt50;      Inc(iwBox); exit; end;
    Ord(acGetExt51):       begin BoxGetExt51;      Inc(iwBox); exit; end;

    Ord(acGetExt50X2):     begin BoxGetExt50X2;    Inc(iwBox); exit; end;
    Ord(acGetExt51X2):     begin BoxGetExt51X2;    Inc(iwBox); exit; end;

    Ord(acGetExt40T):      begin BoxGetExt40T;     Inc(iwBox); exit; end;
    Ord(acGetExt40TX2):    begin BoxGetExt40TX2;   Inc(iwBox); exit; end;

        Ord(acGetCALC1):     begin BoxCalc1;          Inc(iwBox); exit; end;
//        Ord(acGetCALC2):     begin BoxCalc2;          Inc(iwBox); exit; end;
        Ord(acGetCalc3):     begin BoxCalc3;          Inc(iwBox); exit; end;

        Ord(acGetCheckup):       begin BoxGetCheckup;       Inc(iwBox); exit; end;
        Ord(acGetCheckupEventsDay): begin BoxGetCheckupEventsDay; Inc(iwBox); exit; end;
        Ord(acGetCheckupEventsMon): begin BoxGetCheckupEventsMon; Inc(iwBox); exit; end;
        Ord(acGetCheckupHou):    begin BoxGetCheckupHou;    Inc(iwBox); exit; end;
        Ord(acGetCheckupDefectsDay): begin BoxGetCheckupDefectsDay; Inc(iwBox); exit; end;
        Ord(acGetCheckupDefectsMon): begin BoxGetCheckupDefectsMon; Inc(iwBox); exit; end;
        Ord(acGetCheckupDays): begin BoxGetCheckupDays; Inc(iwBox); exit; end;

        Ord(acGetMemory0):    begin BoxGetMemory0;          Inc(iwBox); exit; end;
        Ord(acGetRealtime2):  begin BoxGetRealtime2;        Inc(iwBox); exit; end;
        Ord(acGetMemory2):    begin BoxGetMemory2;          Inc(iwBox); exit; end;
        Ord(acGetMemory21):   begin BoxGetMemory21;         Inc(iwBox); exit; end;
        Ord(acGetMemory22):   begin BoxGetMemory22;         Inc(iwBox); exit; end;
        Ord(acGetMemory23):   begin BoxGetMemory23;         Inc(iwBox); exit; end;

        Ord(acGetDefCanHou):  begin BoxGetDefCanHou;        Inc(iwBox); exit; end;
        Ord(acGetDefGrpHou):  begin BoxGetDefGrpHou;        Inc(iwBox); exit; end;
        Ord(acGetDefCanDay):  begin BoxGetDefCanDay;        Inc(iwBox); exit; end;
        Ord(acGetDefCanMon):  begin BoxGetDefCanMon;        Inc(iwBox); exit; end;
        Ord(acGetDefGrpDay):  begin BoxGetDefGrpDay;        Inc(iwBox); exit; end;
        Ord(acGetDefGrpMon):  begin BoxGetDefGrpMon;        Inc(iwBox); exit; end;
        Ord(acGetDefCanDay2): begin BoxGetDefCanDay2;       Inc(iwBox); exit; end;
        Ord(acGetDefCanMon2): begin BoxGetDefCanMon2;       Inc(iwBox); exit; end;
        Ord(acGetDefGrpDay2): begin BoxGetDefGrpDay2;       Inc(iwBox); exit; end;
        Ord(acGetDefGrpMon2): begin BoxGetDefGrpMon2;       Inc(iwBox); exit; end;

        Ord(acGetEngGrpPrevHou_Def): begin BoxGetEngGrpPrevHou_Def; Inc(iwBox); exit; end;
        Ord(acGetPowGrpPrevHou_Def): begin BoxGetPowGrpPrevHou_Def; Inc(iwBox); exit; end;
        Ord(acGetEngGrpDay_Def): begin BoxGetEngGrpDay_Def; Inc(iwBox); exit; end;
        Ord(acGetEngGrpMon_Def): begin BoxGetEngGrpMon_Def; Inc(iwBox); exit; end;
        Ord(acGetMaxGrpDay_Def): begin BoxGetMaxGrpDay_Def; Inc(iwBox); exit; end;
        Ord(acGetMaxGrpMon_Def): begin BoxGetMaxGrpMon_Def; Inc(iwBox); exit; end;

        Ord(acGetStat1): begin BoxGetStat1; Inc(iwBox); exit; end;

        Ord(acGetXBYTE): begin BoxGetXBYTE; Inc(iwBox); exit; end;
        Ord(acGetFVAR):  begin BoxGetFVAR;  Inc(iwBox); exit; end;
        Ord(acGetCBYTE): begin BoxGetCBYTE; Inc(iwBox); exit; end;
        Ord(acGetFCVAR): begin BoxGetFCVAR; Inc(iwBox); exit; end;

        Ord(acGetEchoNtoN): begin BoxGetEchoNtoN; Inc(iwBox); exit; end;
        Ord(acGetEchoNto1): begin BoxGetEchoNto1; Inc(iwBox); exit; end;
        Ord(acGetEcho1toN): begin BoxGetEcho1toN; Inc(iwBox); exit; end;

        Ord(acGetTimeoutHistogram35): begin BoxGetTimeoutHistogram35; Inc(iwBox); exit; end;
        Ord(acGetLogs35): begin BoxGetLogs35; Inc(iwBox); exit; end;
        Ord(acGetCounters35): begin BoxGetCounters35; Inc(iwBox); exit; end;

        Ord(acGetLogs40): begin BoxGetLogs40; Inc(iwBox); exit; end;
        Ord(acGetCounters40): begin BoxGetCounters40; Inc(iwBox); exit; end;

        Ord(acGetRealtimeIndices): begin BoxGetRealtimeIndices; Inc(iwBox); exit; end;

        else ErrBox('Ошибка при задании списка запросов !');
      end;
    end;
    Inc(iwBox);
  end;

    AddInfo(' ');
    AddInfo('начало опроса: '+Times2Str(ToTimes(BoxStart)));
    AddInfo('конец опроса:  '+Times2Str(ToTimes(Now)));
    AddInfo(DeltaTimes2Str(ToTimes(BoxStart),ToTimes(Now)));
{
    b := False;
    if TapiDevice.TapiState = tsConnected then begin
      b := True;
      btbCancelCallClick(nil);
    end;

    if b then begin
      AddInfo(' ');
      AddInfo('Cоединение: ' + IntToStr(timNow.Interval * cwConnect div 1000) + ' секунд');
    end;
}
    AddInfo(' ');
    AddInfo('Опрос успешно завершен: '+mitVersion.Caption);

    HistogramsReport;

    ShowProgress(-1, 1);  
  end;
end;

procedure BoxRead;
begin
  with frmMain do begin
  with clbMain do begin

    if Checked[Ord(acGetParams3)] then begin
      Checked[Ord(acGetParams2)] := True;
    end;

    if Checked[Ord(acGetDefCanDay)] or
       Checked[Ord(acGetDefCanMon)] then begin
      Checked[Ord(acGetDefCanHou)] := True;
    end;

    if Checked[Ord(acGetDefGrpDay)] or
       Checked[Ord(acGetDefGrpMon)] or
       Checked[Ord(acGetDefGrpDay2)] or
       Checked[Ord(acGetDefGrpMon2)] then begin
      Checked[Ord(acGetGroup)] := True;
      Checked[Ord(acGetDefCanHou)] := True;
    end;

    if Checked[Ord(acGetIMPCANHou)] or
       Checked[Ord(acGetDefCanHou)] or
       Checked[Ord(acGetIMPCANDay)] or
       Checked[Ord(acGetIMPCANMon)] then begin
      Checked[Ord(acGetTRANSEng)] := True;
      Checked[Ord(acGetPULSEHou)] := True;
    end;

    if Checked[Ord(acGetPARAMS)] then begin
      Checked[Ord(acGetDIGIT)] := True;
    end;

    if Checked[Ord(acGetMaxGrpDay)] or
       Checked[Ord(acGetMaxGrpMon)] or
       Checked[Ord(acGetEngGrpHou)] or

       Checked[Ord(acGetEngGrpDay)] or
       Checked[Ord(acGetEngGrpMon)] or

       Checked[Ord(acGetEngGrpDayX2)] or
       Checked[Ord(acGetEngGrpMonX2)] or

       Checked[Ord(acGetEngCanDay)] or
       Checked[Ord(acGetEngCanMon)] or
       Checked[Ord(acGetImpCanDay)] or
       Checked[Ord(acGetImpCanMon)] or
       Checked[Ord(acGetImpCanHou)] or
       Checked[Ord(acGetDiagram)] or

       Checked[Ord(acGetDefCanHou)] or
       Checked[Ord(acGetDefGrpHou)] or
       Checked[Ord(acGetDefCanDay)] or
       Checked[Ord(acGetDefCanMon)] or
       Checked[Ord(acGetDefGrpDay)] or
       Checked[Ord(acGetDefGrpMon)] or
       Checked[Ord(acGetDefCanDay2)] or
       Checked[Ord(acGetDefCanMon2)] or
       Checked[Ord(acGetDefGrpDay2)] or
       Checked[Ord(acGetDefGrpMon2)] or

       Checked[Ord(acGetEngGrpDay_Def)] or
       Checked[Ord(acGetEngGrpMon_Def)] or
       Checked[Ord(acGetMaxGrpDay_Def)] or
       Checked[Ord(acGetMaxGrpMon_Def)] or

       Checked[Ord(acGetPowCanHou)] or
       Checked[Ord(acGetPowGrpHou)] or
       Checked[Ord(acGetImpCanMnt)] or
       Checked[Ord(acGetPowCanMnt)] or
       Checked[Ord(acGetCurrent1)] or
       Checked[Ord(acGetCurrent4)] or
       Checked[Ord(acGetExt40)] or
       Checked[Ord(acGetExt41)] or
       Checked[Ord(acGetExt42)] or
       Checked[Ord(acGetExt7)] or
       Checked[Ord(acGetExt7X2)] or

       Checked[Ord(acGetParams3)]
       then begin
      Checked[Ord(acGetTime1)] := True;
    end;

   if Checked[Ord(acGetMemory2)] or
      Checked[Ord(acGetMemory21)] or
      Checked[Ord(acGetMemory22)] or
      Checked[Ord(acGetMemory23)]
    then begin
      Checked[Ord(acGetTime1)] := True;
      Checked[Ord(acGetMemory0)] := True;
    end;  

    if Checked[Ord(acGetStat1)] then begin
      Checked[Ord(acGetMemory0)]  := True;
    end;

   if Checked[Ord(acGetMemory0)] or
      Checked[Ord(acGetMemory2)] or
      Checked[Ord(acGetMemory21)] or
      Checked[Ord(acGetMemory22)] or
      Checked[Ord(acGetMemory23)] or
      Checked[Ord(acGetRecords0)] or
      Checked[Ord(acGetRecords1)] or
      Checked[Ord(acGetRecords2)] or
      Checked[Ord(acGetRecords3)] or
      Checked[Ord(acGetRecords4)] or
      Checked[Ord(acGetRecords5)] or
      Checked[Ord(acGetRecordsX0)]
    then begin
      Checked[Ord(acGetVersion2)] := True;
    end;

   if Checked[Ord(acGetEngGrpDayX2)] or
      Checked[Ord(acGetEngGrpMonX2)] or
      Checked[Ord(acGetExt40X2)] or
      Checked[Ord(acGetExt41X2)] or
      Checked[Ord(acGetExt42X2)] or
      Checked[Ord(acGetExt44X2)] or
      Checked[Ord(acGetExt40TX2)] or
      Checked[Ord(acGetExt50X2)] or
      Checked[Ord(acGetExt51X2)] or
      Checked[Ord(acGetExt6X2)] or
      Checked[Ord(acGetExt7X2)] or
      Checked[Ord(acGetReview)]
    then begin
      Checked[Ord(acGetVersion2)] := True;
    end;

    if Checked[Ord(acGetCALC1)] then begin
      Checked[Ord(acGetTIME1)]  := True;
      Checked[Ord(acGetTRANSEng)]  := True;
      Checked[Ord(acGetPULSEHou)]  := True;
      Checked[Ord(acGetIMPCANDAY)] := True;
      Checked[Ord(acGetESCS)]  := True;
      Checked[Ord(acGetDIGIT)] := True;
    end;

    if Checked[Ord(acGetCalc3)] then begin
      Checked[Ord(acGetTime1)]  := True;
      Checked[Ord(acGetVersion2)]  := True;
      Checked[Ord(acGetTransEng)]  := True;
      Checked[Ord(acGetPulseHou)]  := True;
      Checked[Ord(acGetImpCanMon)] := True;
      Checked[Ord(acGetExt42)] := True;
      Checked[Ord(acGetDigit)] := True;
    end;

   if Checked[Ord(acGetMemory0)] then begin
      Checked[Ord(acGetTime1)] := True;
      Checked[Ord(acGetVersion2)] := True;
      Checked[Ord(acGetStart)] := True;
    end;
    if Checked[Ord(acGetRealtime2)] then begin
      Checked[Ord(acGetTime1)] := True;
      Checked[Ord(acGetVersion2)] := True;
      Checked[Ord(acGetStart)] := True;
    end;

  end;

  BoxStart := Now;
  NormalMode;

  cbCurRepeat := 0;
  SetVersion(-1);

  iwBox := 0;
  RunBox;
  end;
end;

procedure BoxShow(Action: actions);
begin
    case Action of

      acGetTime1:     ShowGetTime1;
      acGetTime2:     ShowGetTime2;

      acGetTransEng:  ShowGetTransEng;
      acGetPulseHou:  ShowGetPulseHou;
      
      acGetPublic:    ShowGetPublic;
      acGetPubTariffs:ShowGetPubTariffs;
      acGetPowTariffs:ShowGetPowTariffs;
      acGetEngTariffs:ShowGetEngTariffs;
      acGetRelaxs:    ShowGetRelaxs;
      acGetDecret:    ShowGetDecret;
      acGetStart:     ShowGetStart;
      acGetBulk:      ShowGetBulk;
      acGetEngFrac1a: ShowGetEngFrac1a;
      acGetEngFrac1b: ShowGetEngFrac1b;
      acGetEngFrac2:  ShowGetEngFrac2;
      acGetErrorLink: ShowGetErrorLink;
      acGetGaps1:     ShowGetGaps1;
      acGetGaps2:     ShowGetGaps2;
      acGetGaps3:     ShowGetGaps3;

      acGetImpCanMnt: ShowGetImpCanMnt;
      acGetPowCanMnt: ShowGetPowCanMnt;

      acGetDiagram:   ShowGetDiagram;
      acGetImpCanHou: ShowGetImpCanHou;
      acGetPowCanHou: ShowGetPowCanHou;
      acGetPowGrpHou: ShowGetPowGrpHou;
      acGetImpCanDay: ShowGetImpCanDay;
      acGetImpCanMon: ShowGetImpCanMon;

      acGetDefCanHou: ShowGetDefCanHou;
      acGetDefGrpHou: ShowGetDefGrpHou;
      acGetDefCanDay: ShowGetDefCanDay;
      acGetDefCanMon: ShowGetDefCanMon;
      acGetDefGrpDay: ShowGetDefGrpDay;
      acGetDefGrpMon: ShowGetDefGrpMon;
      acGetDefCanDay2: ShowGetDefCanDay2;
      acGetDefCanMon2: ShowGetDefCanMon2;
      acGetDefGrpDay2: ShowGetDefGrpDay2;
      acGetDefGrpMon2: ShowGetDefGrpMon2;

      acGetEngGrpPrevHou_Def: ShowGetEngGrpPrevHou_Def;
      acGetPowGrpPrevHou_Def: ShowGetPowGrpPrevHou_Def;
      acGetEngGrpDay_Def: ShowGetEngGrpDay_Def;
      acGetEngGrpMon_Def: ShowGetEngGrpMon_Def;
      acGetMaxGrpDay_Def: ShowGetMaxGrpDay_Def;
      acGetMaxGrpMon_Def: ShowGetMaxGrpMon_Def;

      acGetEngGrpHou: ShowGetEngGrpHou;
      acGetEngGrpDay: ShowGetEngGrpDay;
      acGetEngGrpMon: ShowGetEngGrpMon;
      acGetEngGrpDayX2: ShowGetEngGrpDayX2;
      acGetEngGrpMonX2: ShowGetEngGrpMonX2;
      acGetEngCanDay: ShowGetEngCanDay;
      acGetEngCanMon: ShowGetEngCanMon;

      acGetMaxGrpDay: ShowGetMaxGrpDay;
      acGetMaxGrpMon: ShowGetMaxGrpMon;

      acGetExt7:      ShowGetExt7;
      acGetExt7X2:    ShowGetExt7X2;
      acGetExt6:      ShowGetExt6;
      acGetExt6X2:    ShowGetExt6X2;
      acGetCntCanMon: ShowGetCntCanMon;

      acGetEscS:      ShowGetEscS;
      acGetEscS_Time: ShowGetEscS_Time;
      acGetEscV:      ShowGetEscV;
      acGetEscV_Time: ShowGetEscV_Time;
      acGetEscU:      ShowGetEscU;

      acGetGroup:     ShowGetGroup;
      acGetDigit:     ShowGetDigit;
      acGetDigit2:    ShowGetDigit2;
      acGetDigitEnbl: ShowGetDigitEnbl;
      acGetHouCheck:  ShowGetHouCheck;
      acGetPort:      ShowGetPort;
      acGetOutputDelay:ShowGetOutputDelay;
      acGetCorrectLimit:ShowGetCorrectLimit;
      acGetAce:       ShowGetAce;

      acGetControl:     ShowGetControl;
      acGetSchedule0:   ShowGetSchedule(0);
      acGetSchedule1:   ShowGetSchedule(1);
      acGetSchedule2:   ShowGetSchedule(2);
      acGetSchedule3:   ShowGetSchedule(3);
      acGetRecalc:    ShowGetRecalc;
      acGetBorder:    ShowGetBorder;
      acGetBorder1:   ShowGetBorder1;
      acGetBorder2:   ShowGetBorder2;
      acGetBorder3:   ShowGetBorder3;
      acGetPhone:     ShowGetPhone;
      acGetParams:    ShowGetParams;
      acGetParams2:   ShowGetParams2;
      acGetParams3:   ShowGetParams3;
      acGetVersion:   ShowGetVersion;
      acGetVersion2:  ShowGetVersion2;
      acGetInfoGPS:   ShowGetInfoGPS;
      acGetInfoSMK:   ShowGetInfoSMK;

      acGetCorrect:   ShowGetCorrect;
      acGetCorrect21: ShowGetCorrect21;
      acGetCorrect3:  ShowGetCorrect3;
      acGetCorrect20: ShowGetCorrect20;

      acGetCurrent1:  ShowGetCurrent1;
      acGetCurrent2:  ShowGetCurrent2;
      acGetCurrent3:  ShowGetCurrent3;
      acGetCurrent4:  ShowGetCurrent4;

      acGetPhone2:    ShowGetPhone2;
      acGetAnswerDisable: ShowGetAnswerDisable;
      acGetAnswerEnable: ShowGetAnswerEnable;
      acGetDevice23:   ShowGetDevice23;

      acGetRecordsMap: ShowGetRecordsMap;
      acGetRecords0:   ShowGetRecords;
      acGetRecords1:   ShowGetRecords;
      acGetRecords2:   ShowGetRecords;
      acGetRecords3:   ShowGetRecords;
      acGetRecords4:   ShowGetRecords;
      acGetRecords5:   ShowGetRecords;
      acGetRecordsX0:  ShowGetRecordsX;
      acGetLinkErrors: ShowGetLinkErrors;
      acGetOverflowHou:ShowGetOverflowHou;
      acGetP79Errors:  ShowGetP79Errors;
      acGetEvents1:    ShowGetEvents1;
      acGetEvents2:    ShowGetEvents2;

      acGetContacts3: ShowGetContacts3;

    acGetTransEng_,
    acGetTransCnt_,
    acGetPulseHou_,
    acGetPulseMnt_,
    acGetValueEngHou_,
    acGetValueCntHou_,
    acGetValueEngMnt_,
    acGetValueCntMnt_,
    acGetCount_,
    acGetLosse_,
    acGetLevel_:
      ShowGetCanalsSpec;

      acGetQueryCF:   ShowGetQueryCF;
      acGetQueryFF19: ShowGetQueryFF19;
      
      acGetExt0: ShowGetExt0;
      acGetReview: ShowGetReview;

      acGetExt40: ShowGetExt40;
      acGetExt41: ShowGetExt41;
      acGetExt42: ShowGetExt42;
      acGetExt43: ShowGetExt43;
      acGetExt44: ShowGetExt44;

      acGetExt40X2: ShowGetExt40X2;
      acGetExt41X2: ShowGetExt41X2;
      acGetExt42X2: ShowGetExt42X2;
      acGetExt44X2: ShowGetExt44X2;

      acGetExt50: ShowGetExt50;
      acGetExt51: ShowGetExt51;

      acGetExt50X2: ShowGetExt50X2;
      acGetExt51X2: ShowGetExt51X2;

      acGetExt40T: ShowGetExt40T;
      acGetExt40TX2: ShowGetExt40TX2;

      acGetCheckup: ShowGetCheckup;
      acGetCheckupEventsDay: ShowGetCheckupEventsDay;
      acGetCheckupEventsMon: ShowGetCheckupEventsMon;
      acGetCheckupHou: ShowGetCheckupHou;
      acGetCheckupDefectsDay: ShowGetCheckupDefectsDay;
      acGetCheckupDefectsMon: ShowGetCheckupDefectsMon;
      acGetCheckupDays: ShowGetCheckupDays;

      acGetMemory0: ShowGetMemory0;
      acGetRealtime2: ShowGetRealtime2;
      acGetMemory1: ShowGetMemory1;
      acGetMemory12: ShowGetMemory12;
      acGetMemory2: ShowGetMemory2;
      acGetMemory21: ShowGetMemory21;
      acGetMemory22: ShowGetMemory22;
      acGetMemory23: ShowGetMemory23;

      acGetStat1: ShowGetStat1;

      acGetXBYTE: ShowGetXBYTE;
      acGetFVAR:  ShowGetFVAR;
      acGetCBYTE: ShowGetCBYTE;
      acGetFCVAR: ShowGetFCVAR;

      acGetEchoNtoN: ShowGetEchoNtoN;
      acGetEchoNto1: ShowGetEchoNto1;
      acGetEcho1toN: ShowGetEcho1toN;

      acGetTimeoutHistogram35: ShowGetTimeoutHistogram35;
      acGetLogs35: ShowGetLogs35;
      acGetCounters35: ShowGetCounters35;

      acGetLogs40: ShowGetLogs40;
      acGetCounters40: ShowGetCounters40;

      acGetRealtimeIndices: ShowGetRealtimeIndices;
    end;
end;

procedure TestVersion4;
begin
  if bVersion = -1 then raise Exception.Create('Не выполнен запрос ''Расширенная версия'' !');
  if bVersion < 4 then raise Exception.Create('Данный запрос поддерживается сумматором начиная с версии 4 !');
end;

procedure SetVersion(v: shortint);
begin
  bVersion := v;
end;

function GetVersion: shortint;
begin
  Result := bVersion;
end;

end.
