unit get_records;

interface

procedure InitGetRecords;

procedure BoxGetRecords0;
procedure BoxGetRecords1;
procedure BoxGetRecords2;
procedure BoxGetRecords3;
procedure BoxGetRecords4;
procedure BoxGetRecords5;
procedure ShowGetRecords;

procedure BoxGetRecordsX0;
procedure ShowGetRecordsX;

const
  wFREEPAGE_SIZE  = 1040;
  wRECORDS        = 500;
  wRECORDS2       = 20000;
  bRECORD_BUFF    = 8;
  bRECORD_SIZE    = 6+4+1+bRECORD_BUFF;
  bRECORD_BLOCK   = wFREEPAGE_SIZE div bRECORD_SIZE;
  bRECORD_PAGES   = (wRECORDS div bRECORD_BLOCK)+1;
  wRECORD2_PAGES  = (wRECORDS2 div bRECORD_BLOCK)+1;

implementation

uses SysUtils, kernel, support, soutput, main, timez, realz, box, progress;

const
  quGetRecords:   querys = (Action: acGetRecords0;  cwOut: 7+3; cwIn: 5+6+1040+2; bNumber: $FF);
  quGetRecordsX:  querys = (Action: acGetRecordsX0; cwOut: 7+4; cwIn: 5+6+1040+2; bNumber: $FF);

var
  bClass:       byte;

  bPage:        byte;
  wPage:        word;

  cwRec:        word;
  bRecCode:     byte;
  mpbRec:       array[0..bRECORD_BUFF-1] of byte;

procedure InitGetRecords;
begin
  frmMain.lblRecordRange.Caption := '0..'+IntToStr(wRECORD2_PAGES-1);
end;

procedure QueryGetRecords;
begin  
  InitPushCRC;
  Push(20);
  Push(bClass);
  Push(bPage);
  Query(quGetRecords);      
end;

procedure QueryGetRecordsX;
begin
  InitPushCRC;
  Push(99);
  Push(bClass);
  Push(wPage div $100);
  Push(wPage mod $100);
  Query(quGetRecordsX);
end;

procedure QueryGetRecordsRun(bT: byte);
begin
  with frmMain.prbMain do begin
    Min := 0;
    Position := 0;
    Max := bRECORD_PAGES-1;
  end;

  cwRec := 0;
  bPage := 0;
  bClass := bT;

  QueryGetRecords;
end;

procedure QueryGetRecordsRunX(bT: byte);
begin

  cwRec := 0;
  wPage := frmMain.updRecordMin.Position;
  bClass := bT;
{
  with frmMain.prbMain do begin
    Min := wPage;
    Position := wPage;
    Max := frmMain.updRecordMax.Position-1;
  end;
}
  QueryGetRecordsX;
end;

procedure BoxGetRecords0;
begin
  AddInfo('');
  AddInfo('������ ��������� �������:');
  AddInfo('');

  QueryGetRecordsRun(0);
end;

procedure BoxGetRecords1;
begin  
  AddInfo('');    
  AddInfo('������ ��������� �������:');
  AddInfo('');    
  
  QueryGetRecordsRun(1);
end;

procedure BoxGetRecords2;
begin  
  AddInfo('');    
  AddInfo('������ ��������� ���������:');
  AddInfo('');    
  
  QueryGetRecordsRun(2);
end;

procedure BoxGetRecords3;
begin  
  AddInfo('');    
  AddInfo('������ ������� �������:');
  AddInfo('');    
  
  QueryGetRecordsRun(3);
end;

procedure BoxGetRecords4;
begin  
  AddInfo('');    
  AddInfo('������ ��������� �������:');
  AddInfo('');    

  QueryGetRecordsRun(4);
end;  

procedure BoxGetRecords5;
begin  
  AddInfo('');    
  AddInfo('������ ���-��������:');
  AddInfo('');    
  
  QueryGetRecordsRun(5);
end;  

procedure BoxGetRecordsX0;
begin
  AddInfo('');
  AddInfo('������ ��������� ��������� (�����������):');
  AddInfo('');

  QueryGetRecordsRunX(0);
end;

function GetRecTime(i: byte): string;
var
  timT: times;
begin
  with timT do begin
    bSecond := mpbRec[i+0];
    bMinute := mpbRec[i+1];
    bHour   := mpbRec[i+2];
    bDay    := mpbRec[i+3];
    bMonth  := mpbRec[i+4];
    bYear   := mpbRec[i+5];

    Result := Int2Str(bHour)   + ':' +
              Int2Str(bMinute) + ':' +
              Int2Str(bSecond) + ' ' +
              Int2Str(bDay)    + '.' +
              Int2Str(bMonth)  + '.' +
              Int2Str(bYear);
  end;
end;

function GetRecDate(i: byte): string;
begin
    Result := Int2Str(mpbRec[i+0])  + '.' +
              Int2Str(mpbRec[i+1])  + '.' +
              Int2Str(mpbRec[i+2]);
end;

function GetRecDay(i: byte): string;
begin
    Result := Int2Str(mpbRec[i+0])  + '.' +
              Int2Str(mpbRec[i+1])  + '.' +
              Int2Str(mpbRec[i+2]);
end;

function GetRecMon(i: byte): string;
begin
    Result := Int2Str(mpbRec[i+1])  + '.' +
              Int2Str(mpbRec[i+2]);
end;

function GetRecInt(i: byte): string;
begin
  Result := IntToStr(mpbRec[i]*$100+mpbRec[i+1]);
end;

function GetRecLong2(i: byte): string;
begin
  Result := IntToStr(mpbRec[i]*$1000000+mpbRec[i+1]*$10000+mpbRec[i+2]*$100+mpbRec[i+3]);
end;

function GetRecReal(j: byte): string;
var
  i:    byte;
  sreT: bytes4;
begin
  for i := 0 to 3 do sreT[i] := mpbRec[j + i];
  Result := FloatToStrF(FromReals(sreT),ffFixed,12,3);
end;

function GetRecContact(i: byte): string;
begin
  if i = 0 then begin
    case mpbRec[0] of
      0: Result := '1 ���.';
      1: Result := '1 ����.';
      2: Result := '2 ���.';
      3: Result := '2 ����.';
      else Result := '����������� �������';
    end;
  end
  else if i = 1 then begin
    case mpbRec[0] of
      0: Result := '1 ���. 2 ����.';
      1: Result := '2 ���. 1 ����.';
      else Result := '����������� �������';
    end;
  end
  else Result := '����������� �����';  
end;

function GetRecMode: string;
begin
  case mpbRec[0] of
    0: Result := '��� ����������';
    1: Result := '��������';
    2: Result := '����������� 1';
    3: Result := '����������� 2';
    4: Result := '����������� 3';
    else Result := '����������� �����';
  end;
end;

function GetRecValue(c: char): string;
begin
  Result := GetRecReal(0)+' '+c+' '+GetRecReal(4);
end;

function GetRecEvent(bT: byte): string;
var
  i:  byte;
begin
  i := bT and $0F;
  case i of
    1: Result := '������';
    2: Result := '���� 1';
    3: Result := '���� 2';
    4: Result := '���� 3';
    else Result := '����������� ������� '+IntToStr(i);
  end;

  if i in [1,2,3,4] then begin
  if (bT and $F0) > 0 
  then 
   Result := '  ������� - ����. '+ Result
  else
   Result := '  ������� - ���.  '+ Result;
  end; 
end;

function GetSMSStart: string;
begin
 Result := '�������� ' + IntToHex(mpbRec[0],2)+IntToHex(mpbRec[1],2)+IntToHex(mpbRec[2],2)+IntToHex(mpbRec[3],2);
end;

function GetSMSResult: string;
begin
 Result := IntToHex(mpbRec[7],2);
 if mpbRec[7] = 1 then
   Result := Result + ' - OK'
 else  
   Result := Result + ' - ������';
end;

function GetCurrentStat: string;
var
  i,a,b: byte;
begin
  Result := '';
  for i := 0 to 64-1 do begin
      a := i div 8;
      b := $80 shr (i mod 8);
      if (mpbRec[a] and b) <> 0 then begin
        Result := Result + IntToStr(i+1) + ' ';
      end;
  end;
  if Result = '' then Result := '��� ��������� �������' else Result := '��������� ������ - ' + Result;
end;

function GetRecDigital: string;
begin
  Result := '����� '+IntToStr(mpbRec[0]+1)+'  '
   +Int2Str(mpbRec[1]+1)+'.'+Int2Str(mpbRec[2])+'.'+Int2Str(mpbRec[3])+'.'+Int2Str(mpbRec[4],3)+'.'+Int2Str(mpbRec[5]+1)+'  '+GetDeviceName(mpbRec[3]);
end;

function GetRecKey1: string;
var
  i: byte;
begin
  Result := '����� '+IntToStr(mpbRec[0]+1)+'  ';
  for i := 1 to 7 do Result := Result + Chr(mpbRec[i])
end;

function GetRecKey2: string;
var
  i: byte;
begin
  Result := '                ';
  for i := 0 to 5 do Result := Result + Chr(mpbRec[i])
end;

function GetRecLong: string;
begin
  Result := '����� '+IntToStr(mpbRec[0]+1)+'  ';
  Result := Result + IntToStr(mpbRec[1]*$1000000+mpbRec[2]*$10000+mpbRec[3]*$100+mpbRec[4])
end;

function GetRecCheckupMode: string;
begin
  if (mpbRec[0] = 0) then
    Result := '������� �����'
  else
    Result := '����������� �����';
end;

function GetRecord: string;
var
  i:    byte;
  stT:  string;
  w1:   word;
begin
  Result := PackStrL(PopTimes2Str,20) + ' ' +
            PackStrL(IntToStr((PopInt shl 16)+PopInt),4) + ' ';

  bRecCode := Pop;

  Result := Result + PackStrL(IntToStr(bRecCode),3) + '  ';

  for i := 0 to bRECORD_BUFF-1 do begin
    mpbRec[i] := Pop;
    Result := Result + ' ' +IntToHex(mpbRec[i],2);
  end;

  w1 := mpbRec[1]*$100+mpbRec[2];

  case bRecCode of
    0: stT := '������ �������';
    26: stT := '������ ������� ����� ���������� ' + GetRecTime(0);
    1: stT := '�����  �������';
    2: stT := 'watchdog reset';
    3: stT := '������';
    4: stT := '����������';
    5: stT := '��������������';
    6: stT := '������ �������';
    7: stT := '������ �������';
    8: stT := '����� ���� 1: '+GetRecContact(0);
    9: stT := '����� ���� 2: '+GetRecContact(1);
    10: stT := '��������� ������ ����: '+GetRecMode;    
    11: stT := '����. 3: ����  - ���� 1 ���.  '+GetRecValue('>');
    12: stT := '����. 3: ����  - ���� 1 ����. '+GetRecValue('<');
    13: stT := '����. 3: ����  - ���� 2 ���.  '+GetRecValue('<');
    14: stT := '����. 3: ����  - ���� 2 ����. '+GetRecValue('>');
    15: stT := '����. 3: ����. - ���� 1 ���.  ';
    16: stT := '����. 3: ����. - ���� 1 ����. ';
    17: stT := '����. 3: ����. - ���� 2 ���.  ';
    18: stT := '����. 3: ����. - ���� 2 ����. ';
    19: stT := '����. 3: ������� ������� ���. ���� 1: '+GetRecReal(0);
    20: stT := '����. 3: ������� ������� ���. ���� 2: '+GetRecReal(0);
    21: stT := '����. 3: ������� �������� (*3 ���.): '+IntToStr(mpbRec[0]);
    22: stT := '����. 3: ������ �������� (*3 ���.) '+IntToStr(mpbRec[0])+'-'+IntToStr(mpbRec[1]);
    23: stT := '����. 3: �����  �������� (*3 ���.) '+IntToStr(mpbRec[0])+'-'+IntToStr(mpbRec[1]);
    24: stT := '������ ���������� �������';
    25: stT := '�����  ���������� �������';

    32: stT := '��� ����� �� ���������: ��� '+IntToStr(mpbRec[0])+'.'+IntToStr(mpbRec[1]);
    33: stT := '��� ������� � ������� �������� !';
    34: stT := '��������� ������� ����� ���������� ������:'+GetRecEvent(mpbRec[1]);
    35: stT := '����� - '+GetRecTime(1)+GetRecEvent(mpbRec[7]);   // ���-4��.02
    36: stT := '����� - '+GetRecTime(1)+GetRecEvent(mpbRec[7]);   // ��������-230

    40: stT := '�������������� �������: ��     '+GetRecDigital;
    41: stT := '�������������� �������: �����  '+GetRecDigital;
    42: stT := '�������������� ������� �������: ��     '+GetRecKey1;
    43: stT := '                                       '+GetRecKey2;
    44: stT := '�������������� ������� �������: �����  '+GetRecKey1;
    45: stT := '                                       '+GetRecKey2;
    46: stT := '�������������� ������� �������: ��     '+GetRecLong;
    47: stT := '�������������� ������� �������: �����  '+GetRecLong;
    48: stT := '�������������� ������� �������: ��     '+GetRecLong;
    49: stT := '�������������� ������� �������: �����  '+GetRecLong;

    62: stT := '����� �������� !';
    63: stT := '������� �������� !';
    64: stT := '�����. �����: '+IntToStr(mpbRec[1]+1)+'.'+IntToStr(mpbRec[2])+'.'+IntToStr(mpbRec[3])+'.'+IntToStr(mpbRec[4])+'.'+IntToStr(mpbRec[5]+1);
    65: stT := '������ �����: '+IntToStr(mpbRec[1]+1)+'.'+IntToStr(mpbRec[2])+'.'+IntToStr(mpbRec[3])+'.'+IntToStr(mpbRec[4])+'.'+IntToStr(mpbRec[5]+1);
    66: stT := '����������: '+IntToStr(mpbRec[1]*$100+mpbRec[2])+' ========';
    99: stT := '����������: '+GetRecInt(0)+'-'+GetRecInt(2)+' ========';
    67: stT := '����������: ����� ���������';
    68: stT := '����� ���������';
    69: stT := 'Esc V: OK';
    70: stT := 'Esc V: ������';
    71: stT := '������: '+GetRecReal(1);
    72: stT := 'Esc S: OK';
    73: stT := 'Esc S: ������';
    74: stT := '������: '+GetRecReal(1);
    75: stT := 'Esc U: OK';
    76: stT := 'Esc U: ������';
    77: stT := '������: '+GetRecTime(1);
    78: stT := '����������: ����� ���������';
    79: stT := '����������: '+IntToStr(mpbRec[3]*$100+mpbRec[4])+'/'+IntToStr(mpbRec[1]*$100+mpbRec[2]);
    97: stT := '����������: '+GetRecInt(2)+'-'+GetRecInt(4)+'; ������� '+GetRecInt(0);
    80: stT := '������ '+IntToHex(mpbRec[1],2)+'.'+IntToHex(mpbRec[2],2);
    81: stT := '������ �������';
    82: stT := '�����  �������';
    83: stT := '������ �����';
    84: stT := '�����  �����';
    85: stT := '����� �������� ==========';
    86: stT := '����� �������� ! ========';
    87: stT := '����� ������� ===========';
    88: stT := '������ ������� 1';
    89: stT := '�����  ������� 1';
    90: stT := '��� �������';
    91: stT := '������ ������� 2';
    92: stT := '�����  ������� 2';
    93: stT := '������ '+IntToHex(mpbRec[1],2)+'.'+IntToHex(mpbRec[2],2)+'.'+IntToHex(mpbRec[3],2);
    94: stT := '����� �������� �� ' + Int2Str(w1 div 60)+':'+Int2Str(w1 mod 60);
    95: stT := '������ ������� ������ �������� '+GetRecInt(1)+' '+GetRecInt(3)+'/'+GetRecInt(5);
    96: stT := '�����  ������� ������ �������� ';
    98: stT := '����������� �����: 0x'+IntToHex(mpbRec[0]*$100+mpbRec[1], 4);

    100: stT := '��� ����������: '+GetRecValue('>');
    101: stT := '��� ��������: '+ GetSMSStart+'  '+GetSMSResult;
    102: stT := '��� ����';

    109: stT := '������������ �����: '+GetCurrentStat;
    110: stT := '������������ �����: ���������� '+GetRecLong2(1)+'/'+GetRecInt(5);
    111: stT := '������������ �����: ���������� ����������';
    112: stT := '������������ �����: ������������';

    113: stT := '������������� �������: ' + GetRecTime(0);

    114: stT := '������ �����: '+IntToStr(mpbRec[0])+' �� '+IntToStr(mpbRec[1])+' (����� '+IntToStr(mpbRec[2])+' �� '+IntToStr(mpbRec[1]) + ')';

    126: stT := '�����. �����: '+IntToStr(mpbRec[1]+1)+'.'+IntToStr(mpbRec[2])+'.'+IntToStr(mpbRec[3])+'.'+IntToStr(mpbRec[4])+'.'+IntToStr(mpbRec[5]+1);
    127: stT := '������ �����: '+IntToStr(mpbRec[1]+1)+'.'+IntToStr(mpbRec[2])+'.'+IntToStr(mpbRec[3])+'.'+IntToStr(mpbRec[4])+'.'+IntToStr(mpbRec[5]+1);
    128: stT := '����������: '+IntToStr(mpbRec[1]*$100+mpbRec[2])+' ========';
    129: stT := '������ ������������ !';
    130: stT := '����� ...';
    131: stT := '�����: OK';
    132: stT := '����� ... ������';
    133: stT := '��������� 1 ...';
    134: stT := '��������� 1: OK';
    135: stT := '��������� 1 ... ������';
    136: stT := '+++ ...                 ~��������� ����������';
    137: stT := '���������� ...          ~��������� ����������';
    138: stT := '���������� ... ������   ~��������� ����������';
    139: stT := '��������� 1 ...         ~��������� ����������';
    140: stT := '��������� 1 ... ������  ~��������� ����������';
    141: stT := '��������� 2 ...';
    142: stT := '��������� 2: OK';
    143: stT := '��������� 2 ... ������';
    144: stT := '���������� ...';
    145: stT := '����������: ��';
    146: stT := '���������� ... ������';
    147: stT := '����� � ���������� ======';
    148: stT := '����������: '+IntToStr(mpbRec[3]*$100+mpbRec[4])+'/'+IntToStr(mpbRec[1]*$100+mpbRec[2]);
    149: stT := '������ '+IntToHex(mpbRec[1],2)+'.'+IntToHex(mpbRec[2],2);
    150: stT := '����� �������� A';
    151: stT := '����� �������� B';
    152: stT := '+++ ...';
    153: stT := '+++: OK';
    154: stT := '���������� ... ������   ~��������� ������������';
    155: stT := '����������: OK          ~��������� ������������';
    156: stT := '+++ ... ������          ~��������� ������������';
    157: stT := '���������� ...';
    158: stT := '����������: OK';
    159: stT := '���������� ... ������';
    160: stT := '����� �� DTR';
    161: stT := '������ '+IntToHex(mpbRec[1],2)+'.'+IntToHex(mpbRec[2],2)+'.'+IntToHex(mpbRec[3],2);

    192: stT := 'GPS ������ ���������� ���������';
    193: stT := 'GPS ����. ���������� ���������';
    194: stT := 'GPS ��������� ������';
    195: stT := 'GPS �����: '+GetRecTime(0);
    196: stT := 'GPS ������ ���������: '+IntToStr(mpbRec[0]);
    197: stT := 'GPS �����: '+GetRecTime(0) + ' ���� ' +IntToStr(mpbRec[6]);
    198: stT := 'GPS ������ ������� �������';
    199: stT := 'GPS ������: ���� ��������';
    200: stT := 'GPS ������: �������� ��������';
    201: stT := 'GPS ���������: ��';

    210: stT := '��������� c ����������: '+GetRecTime(0);
    211: stT := '��������� - ������ 0xFF 0x0B: '+GetRecTime(0);
    212: stT := '��������� - ������ Esc K: '+GetRecTime(0);
    213: stT := '��������� - ������ Esc k: '+GetRecTime(0);
    214: stT := '��������� 1: '+GetRecTime(0);
    215: stT := '��������� 2: '+GetRecTime(0);
    216: stT := '��������� 3: '+GetRecTime(0);
    217: stT := '���������: ��';

    218: begin
           stT := 'GPS �����: ' + IntToStr(mpbRec[0]) + ' - ';
           case mpbRec[0] of
             0:   stT := stT +'����';
             1:   stT := stT +'����';
             else stT := stT +'?';
           end;
           stT := stT + ', ����: ' + IntToStr(mpbRec[1]) + ' - ';
           case mpbRec[1] of
             0:    stT := stT + '���';
             255:  stT := stT + '��';
             else  stT := stT + '?';
           end;           
         end;

    220: stT := '�����-48 ������ ���������� ���������';
    221: stT := '�����-48 ����. ���������� ���������';
    222: stT := '�����-48 ��������� ������';
    223: stT := '�����-48 �����: '+GetRecTime(0);
    224: stT := '�����-48 ������ ���������: ?';
    225: stT := '�����-48 �����: '+GetRecTime(0);
    226: stT := '�����-48 ������ ������� �������';
    227: stT := '�����-48 ������: ���� ��������';
    228: stT := '�����-48 ������: �������� ��������';
    229: stT := '�����-48 ���������: ��';

    230: stT := '�������������: ����� - '+GetRecCheckupMode+'; ������� ������ - �����: '+IntToStr(mpbRec[1])+', ������: '+IntToStr(mpbRec[2]);
    231: stT := '�������������: ����� - ������� '+GetRecInt(0)+' ���������';
    232: stT := '�������������:   ������� ������ - �������� '+GetRecLong2(0)+', ������� '+GetRecLong2(4);
    233: stT := '�������������:   ����� '+GetRecDay(0)+' - ������� ����������';
    234: stT := '�������������:   ����� '+GetRecMon(0)+' - ������� ����������';
    235: stT := '�������������:  '+GetRecDigital;
    236: stT := '�������������:   ����� '+GetRecDay(0)+' - ��� ��������� ��� ����������';
    237: stT := '�������������:   ����� '+GetRecMon(0)+' - ��� �������� ��� ����������';
    238: stT := '�������������:   ����� '+GetRecDay(0)+' - ������ '+IntToStr(mpbRec[6]);
    239: stT := '�������������:   ����� '+GetRecMon(0)+' - ������ '+IntToStr(mpbRec[6]);
    240: stT := '�������������:   ����� '+GetRecDay(0)+' - ������� ����� ��������, ��������� ����������';
    241: stT := '�������������:   ����� '+GetRecMon(0)+' - ������� ����� ��������, ��������� ����������';
    242: stT := '�������������:  ������� ���������� '+IntToStr(mpbRec[0])+' �����'+'; ������� ������ - �����: '+IntToStr(mpbRec[1])+', ������: '+IntToStr(mpbRec[2]);

    else stT := '?';
  end;

  if bRecCode in [32..36,62..84,93,95,96,126..162] then stT := PackStrL(IntToStr(mpbRec[0]+1),2)+': '+stT;
  Result := Result + '   ' + stT;
end;

procedure ShowGetRecords;
var
  i:    word;
  stT:  string;
begin
  with frmMain do begin
    Stop;
    InitPopCRC;
    PopLong;
    PopInt;

    for i := 0 to bRECORD_BLOCK-1 do begin
     stT := GetRecord;
     if bRecCode = $FF then begin
//       AddInfo('-')
     end
     else begin
       Inc(cwRec);
       AddInfo(PackStrR(IntToStr(cwRec),4)+stT);
     end;
    end;

//    AddInfo('=');
    with prbMain do Position := bPage+1;

    if bPage < bRECORD_PAGES-1 then begin
      Inc(bPage);
      QueryGetRecords;
    end
    else RunBox;
  end;
end;

procedure ShowGetRecordsX;
var
  i:    word;
  stT:  string;
begin
  with frmMain do begin
    Stop;
    InitPopCRC;
    PopLong;
    PopInt;

    for i := 0 to bRECORD_BLOCK-1 do begin
     stT := GetRecord;
     if bRecCode = $FF then begin
//       AddInfo('-')
     end
     else begin
       Inc(cwRec);
       AddInfo(PackStrR(IntToStr(cwRec),4)+stT);
     end;
    end;

//    AddInfo('=');
    ShowProgress(wPage-updRecordMin.Position, updRecordMax.Position-updRecordMin.Position+1);

    if wPage < updRecordMax.Position then begin
      Inc(wPage);
      QueryGetRecordsX;
    end
    else RunBox;
  end;
end;

end.
