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
  wPAGE_SIZE      = 1056; // ������ ����� ��������
  wFREEPAGE_SIZE  = 1040; // ������ ��������� ���������� ������ ����� ��������

  wPAGE_SIZE2     = 528;  // ������ ����� ��������
  wFREEPAGE_SIZE2 = 512;  // ������ ��������� ���������� ������ ����� ��������
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

  SETTING:    string  = '���������';
  COM_PORT:   string  = 'COM_����';
  MODEM:      string  = '�����';
  SOCKET:     string  = '�����';
  PARAMS:     string  = '���������';

  NUMBER:     string  = '����';
  BAUD:       string  = '��������';
  PARITY:     string  = '׸������';
  TIMEOUT:    string  = '�������';
  DIAL:       string  = '�����';
  DEVICE:     string  = '����������';
  HOST:       string  = '����';
  PORT:       string  = '����';
  ADDRESS:    string  = '�����';
  PACKET:     string  = '�����';
  PASSWORD:   string  = '������';
  MODE:       string  = '�����';
  VERSION:    string  = '������';

  DAYS_MIN:     string  = '�����_��';
  DAYS_MAX:     string  = '�����_��';
  DAYS2_MIN:    string  = '�����2_��';
  DAYS2_MAX:    string  = '�����2_��';
  MONTHS_MIN:   string  = '������_��';
  MONTHS_MAX:   string  = '������_��';
  F_INDEX_MIN:  string  = '������3_��';
  F_INDEX_MAX:  string  = '������3_��';
  F_DAYS_MIN:   string  = '�����3_��';
  F_DAYS_MAX:   string  = '�����3_��';
  PARAMS_MIN:   string  = '���������_��';
  PARAMS_MAX:   string  = '���������_��';
  SHIFT_MIN:    string  = '��������_��';
  SHIFT_MAX:    string  = '��������_��';
  RECORD_MIN:   string  = '�������_��';
  RECORD_MAX:   string  = '�������_��';

  DIGITS:       string  = '������_�����_�������';
  COLWIDTH:     string  = '������_�������';
  TUNNEL:       string  = '�������';

  OPTIONS:      string  = '�����';
  INQUIRY:      string  = '������_';
  
  stCANALS:     string  = '������';
  stCANAL_ITEM: string  = '�����_';

  stGROUPS:     string  = '������';
  stGROUP_ITEM: string  = '������_';

  stPHONES:     string  = '��������';
  PHONES_COUNT1: string = '����������_���������';
  PHONES_COUNT2: string = '����������_���������2';
  PHONE_ITEM:   string  = '�������_';
  PHONE_PHONE:  string  = '�����';
  PHONE_PLACE:  string  = '������';
  PHONE_WORDS:  string  = '����������';
  
  LOGS_DIR:     string  = 'log';
    
implementation

uses SysUtils;

function GetDeviceName(i: byte): string;
const
  DEVICES     = 1+40;
  mpDevices:  array[0..DEVICES-1] of device_ =
  (
    (stName: '���'            ),
    (stName: '���-4��'        ),
    (stName: '��������-230'   ),
    (stName: 'CC-301'         ),
    (stName: '��� ���������'  ),
    (stName: '���+2 Esc'      ),
    (stName: '���+2 CRC'      ),
    (stName: '���-1'          ),
    (stName: '���-�230'       ),
    (stName: '���3-xxQxxx'    ),
    (stName: '���3-10Axxx'    ),
    (stName: '���-2�.07'      ),
    (stName: '��������-230 +' ),
    (stName: '��6850�'        ),
    (stName: '��6823�'        ),
    (stName: '���-C4'         ),
    (stName: '��6850� +'      ),
    (stName: '��6823� +'      ),
    (stName: '��������-200 +' ),
    (stName: '��-1.4'         ),
    (stName: '���-4��.04'     ),
    (stName: 'Elster A1140'   ),
    (stName: 'CE304'          ),
    (stName: '����-1400'      ),
    (stName: 'CE102'          ),
    (stName: '���-3���.07 v3' ),
    (stName: 'CE301'          ),
    (stName: '������'         ),
    (stName: 'CE303'          ),
    (stName: '���-1'          ),
    (stName: '���-3'          ),
    (stName: '���3 v48-49'    ),
    (stName: '���3/1 v51-54'  ),
    (stName: '���3 v16-18'    ),
    (stName: 'ESM'            ),
    (stName: '��102 NNCL2'    ),
    (stName: '��301 NNCL2'    ),
    (stName: '��303 NNCL2'    ),
    (stName: '��318'          ),
    (stName: '��318 S39'      ),
    (stName: '��������-234 ������')
  );
  
begin
  if i < DEVICES then
    Result := mpDevices[i].stName
  else
    Result := '���������� ' + IntToStr(i);
end;

end.
