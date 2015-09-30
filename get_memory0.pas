unit get_memory0;

interface

procedure BoxGetMemory0;
procedure ShowGetMemory0;

var
  cbWaitQuery,
  ibHouIndex,
  ibEngTariff,
  ibPowTariff,
  ibMnt,
  ibDay,
  ibMon:        byte;

  iwHou:        word;

implementation

uses SysUtils, soutput, support, box, get_memory1;

const
  quGetMemory0: querys = (Action: acGetMemory0; cwOut: 7; cwIn: 15+16+2; bNumber: 248);

procedure QueryGetMemory0;
begin
  Query(quGetMemory0);
end;

procedure BoxGetMemory0;
begin
  QueryGetMemory0;
end;

function GetStatus(w: word): string;
begin
  if w = 0 then Result := '���' else Result := '��';
end;

procedure ShowGetMemory0;
var
  w:  word;
begin
  Stop;
  InitPopCRC;

  ibHouIndex  := Pop;
  ibEngTariff := Pop;
  ibPowTariff := Pop;

  ibMnt := Pop;
  iwHou := Pop*$100 + Pop;;
  ibDay := Pop;
  ibMon := Pop;

  cbWaitQuery := Pop;

  AddInfo('');
  AddInfo('');
  AddInfo('��������� �������');

  InitPop(15);

  AddInfo('');
  AddInfo(PackStrR(IntToStr(Pop),GetColWidth) + '���������� �������');
  AddInfo(PackStrR(IntToStr(Pop),GetColWidth) + '���������� �����');
  AddInfo(PackStrR(IntToStr(Pop),GetColWidth) + '���������� �������');

  AddInfo('');
  AddInfo(PackStrR(IntToStr(ibMnt) + ' - ' + IntToStr(Pop),GetColWidth)          + '������ �� ����������� �������');
  AddInfo(PackStrR(IntToStr(iwHou) + ' - ' + IntToStr(Pop*$100+Pop),GetColWidth) + '������ �� ����������� �������');
  AddInfo(PackStrR(IntToStr(ibDay) + ' - ' + IntToStr(Pop),GetColWidth)          + '������ �� ������� �������');
  AddInfo(PackStrR(IntToStr(ibMon) + ' - ' + IntToStr(Pop),GetColWidth)          + '������ �� �������� �������');

  AddInfo('');
  AddInfo(PackStrR(IntToStr(ibHouIndex),GetColWidth)  + '������ �������� ��������');
  AddInfo(PackStrR(IntToStr(ibEngTariff),GetColWidth) + '������ ������ �� �������');
  AddInfo(PackStrR(IntToStr(ibPowTariff),GetColWidth) + '������ ������ �� ��������');

  AddInfo('');
  AddInfo(PackStrR(IntToStr(Pop),GetColWidth)         + '������� �����');
  AddInfo(PackStrR(IntToStr(cbWaitQuery),GetColWidth) + '������ ������');

  InitPop(15+9);
  w := PopInt();
  
  AddInfo('');
  AddInfo('');
  AddInfo('��������� ������');
  AddInfo('');
  AddInfo(PackStrR('0x'+IntToHex(w,4),GetColWidth) + '��� ���������');
  AddInfo(PackStrR(GetStatus(w and $0001),GetColWidth) + '������ ��� ���������');
  AddInfo(PackStrR(GetStatus(w and $0002),GetColWidth) + '������ ��� ��������');
  AddInfo(PackStrR(GetStatus(w and $0004),GetColWidth) + '������ ��� ������');
  AddInfo(PackStrR(GetStatus(w and $0008),GetColWidth) + '������ ��� ������');

  BoxGetMemory1;
end;

end.
