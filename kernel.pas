unit kernel;

interface

uses timez;

function GetDeviceName(i: byte): string;

const
  CANALS        = 64;
  GROUPS        = 32;
  
  NUMBERS       = 13+1;
  TARIFFS       = 4;
  MONTHS        = 12;
  DAYS          = 14;
  HOURS_IN_DAY  = 48;
  DAYS2         = 62;
  HALFS         = 62*48;

  PARAMS_COUNT  = 500;
  DEVICES_LINES = 1+28;

  bHEADER         = 15;
{
  wPAGE_SIZE      = 1056; // размер одной страницы
  wFREEPAGE_SIZE  = 1040; // размер доступной информации внутри одной страницы

  wPAGE_SIZE2     = 528;  // размер одной страницы
  wFREEPAGE_SIZE2 = 512;  // размер доступной информации внутри одной страницы
}
type
  node = record
    ibCanal:    byte;
  end;

  group = record
    bSize:      byte;
    mpnoNodes:  array[0..CANALS-1] of node;
  end;

  digit = record
    ibPort:     byte;
    ibPhone:    byte;
    bDevice:    byte;
    bAddress:   byte;
    ibLine:     byte;
    boActive:   boolean;
  end;

  maximum = record
    extValue:   extended;
    timValue:   times;
  end;
  
  device_ = record
    stName:     string;
  end;

  value4 = record
    bStatus:    byte;
    cwPos:      word;
    cwNeg:      word;
    eValue:     extended;
    tiValue:    times;
    sResult:    string;
  end;

  value6 = record
    bStatus:    byte;
    eValue:     extended;
    tiValue:    times;
  end;

  diagram = record
    eValue:     extended;
    tiValue:    times;
  end;

const
  panCOMPORT    = 0;
  panREPEATS    = 1;
  panCONNECT    = 2;
  panTIMEOUT    = 3;
  panNOW        = 4;
  panPROGRESS   = 5;

  SETTING:    string  = 'Настройки';
  COM_PORT:   string  = 'COM_порт';
  MODEM:      string  = 'Модем';
  SOCKET:     string  = 'Сокет';
  PARAMS:     string  = 'Параметры';

  NUMBER:     string  = 'Порт';
  BAUD:       string  = 'Скорость';
  PARITY:     string  = 'Чётность';
  TIMEOUT:    string  = 'Таймаут';
  DIAL:       string  = 'Номер';
  DEVICE:     string  = 'Устройство';
  HOST:       string  = 'Хост';
  PORT:       string  = 'Порт';
  ADDRESS:    string  = 'Адрес';
  PACKET:     string  = 'Пакет';
  PASSWORD:   string  = 'Пароль';
  MODE:       string  = 'Режим';
  VERSION:    string  = 'Версия';

  DAYS_MIN:     string  = 'Сутки_от';
  DAYS_MAX:     string  = 'Сутки_до';
  DAYS2_MIN:    string  = 'Сутки2_от';
  DAYS2_MAX:    string  = 'Сутки2_до';
  MONTHS_MIN:   string  = 'Месяцы_от';
  MONTHS_MAX:   string  = 'Месяцы_до';
  F_INDEX_MIN:  string  = 'Индекс3_от';
  F_INDEX_MAX:  string  = 'Индекс3_до';
  F_DAYS_MIN:   string  = 'Сутки3_от';
  F_DAYS_MAX:   string  = 'Сутки3_до';
  PARAMS_MIN:   string  = 'Параметры_от';
  PARAMS_MAX:   string  = 'Параметры_до';
  SHIFT_MIN:    string  = 'Интервал_от';
  SHIFT_MAX:    string  = 'Интервал_до';
  RECORD_MIN:   string  = 'События_от';
  RECORD_MAX:   string  = 'События_до';

  DIGITS:       string  = 'Знаков_после_запятой';
  COLWIDTH:     string  = 'Ширина_столбца';
  TUNNEL:       string  = 'Туннель';

  OPTIONS:      string  = 'Опции';
  INQUIRY:      string  = 'Запрос_';
  
  stCANALS:     string  = 'Каналы';
  stCANAL_ITEM: string  = 'Канал_';

  stGROUPS:     string  = 'Группы';
  stGROUP_ITEM: string  = 'Группа_';

  stPHONES:     string  = 'Телефоны';
  PHONES_COUNT1: string = 'Количество_элементов';
  PHONES_COUNT2: string = 'Количество_элементов2';
  PHONE_ITEM:   string  = 'Телефон_';
  PHONE_PHONE:  string  = 'Номер';
  PHONE_PLACE:  string  = 'Объект';
  PHONE_WORDS:  string  = 'Примечания';
  
  LOGS_DIR:     string  = 'log';
    
implementation

uses SysUtils;

function GetDeviceName(i: byte): string;
const
  DEVICES     = 1+40;
  mpDevices:  array[0..DEVICES-1] of device_ =
  (
    (stName: 'нет'            ),
    (stName: 'СЭТ-4ТМ'        ),
    (stName: 'Меркурий-230'   ),
    (stName: 'CC-301'         ),
    (stName: 'АВВ ЕвроАльфа'  ),
    (stName: 'СЭМ+2 Esc'      ),
    (stName: 'СЭМ+2 CRC'      ),
    (stName: 'ПРТ-1'          ),
    (stName: 'ПРТ-М230'       ),
    (stName: 'СТК3-xxQxxx'    ),
    (stName: 'СТК3-10Axxx'    ),
    (stName: 'СЭБ-2А.07'      ),
    (stName: 'Меркурий-230 +' ),
    (stName: 'ЦЭ6850М'        ),
    (stName: 'ЦЭ6823М'        ),
    (stName: 'ПРТ-C4'         ),
    (stName: 'ЦЭ6850М +'      ),
    (stName: 'ЦЭ6823М +'      ),
    (stName: 'Меркурий-200 +' ),
    (stName: 'ПИ-1.4'         ),
    (stName: 'ПСЧ-4ТА.04'     ),
    (stName: 'Elster A1140'   ),
    (stName: 'CE304'          ),
    (stName: 'РСВУ-1400'      ),
    (stName: 'CE102'          ),
    (stName: 'ПСЧ-3АРТ.07 v3' ),
    (stName: 'CE301'          ),
    (stName: 'Миртек'         ),
    (stName: 'CE303'          ),
    (stName: 'МЭС-1'          ),
    (stName: 'МЭС-3'          ),
    (stName: 'СТК3 v48-49'    ),
    (stName: 'СТК3/1 v51-54'  ),
    (stName: 'СТК3 v16-18'    ),
    (stName: 'ESM'            ),
    (stName: 'СЕ102 NNCL2'    ),
    (stName: 'СЕ301 NNCL2'    ),
    (stName: 'СЕ303 NNCL2'    ),
    (stName: 'СЕ318'          ),
    (stName: 'СЕ318 S39'      ),
    (stName: 'Меркурий-234 СПОДЭС')
  );
  
begin
  if i < DEVICES then
    Result := mpDevices[i].stName
  else
    Result := 'устройство ' + IntToStr(i);
end;

end.
