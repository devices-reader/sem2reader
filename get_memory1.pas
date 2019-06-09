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
  l.add('*������ ��������� ������ (������ 1)');
  l.add('');
  l.add(PackStrR(IntToStr(PopInt),GetColWidth) + '���������� �������� ��� ������� ''������''');
  l.add(PackStrR(IntToStr(PopInt),GetColWidth) + '���������� �������� ��� ���������');
  l.add(PackStrR(IntToStr(PopInt),GetColWidth) + '���������� �������� ��� �������� ��������');
  l.add(PackStrR(IntToStr(PopInt),GetColWidth) + '���������� �������� ��� ������ ��������');
  l.add(PackStrR(IntToStr(PopInt),GetColWidth) + '���������� �������� ��� ������ ��������');
  l.add(PackStrR(IntToStr(PopInt),GetColWidth) + '���������� ������ ��� ���������');
  l.add(PackStrR(IntToStr(PopInt),GetColWidth) + '���������� ������ ��� �������� ��������');
  l.add(PackStrR(IntToStr(PopInt),GetColWidth) + '���������� ������ ��� ������ ��������');
  l.add(PackStrR(IntToStr(PopInt),GetColWidth) + '���������� ������ ��� ������ ��������');

  l.add('');
  for i := 1 to 4 do Pop;

  l.add(PackStrR(IntToStr(PopInt),GetColWidth) + '����� ������ ������');
  l.add(PackStrR(IntToStr(PopInt),GetColWidth) + '����� ��������� �������');
  l.add(PackStrR(IntToStr(PopInt),GetColWidth) + '����� ����� �������');
  l.add(PackStrR(IntToStr(PopInt),GetColWidth) + '����� ������ ��������� �� ��������� �� �����');
  l.add(PackStrR(IntToStr(PopInt),GetColWidth) + '����� ������ ��������� �� ������');
  l.add(PackStrR(IntToStr(PopInt),GetColWidth) + '����� ������ ��������� �� �������');
  l.add(PackStrR(IntToStr(PopInt),GetColWidth) + '����� ������ ���������� �������� �� ������');
  l.add(PackStrR(IntToStr(PopInt),GetColWidth) + '����� ������ ���������� �������� �� �������');
  l.add(PackStrR(IntToStr(PopInt),GetColWidth) + '����� ������ ��������� �� �������');
  wPagesEnd := PopInt;
  l.add(PackStrR(IntToStr(wPagesEnd),GetColWidth) + '����� ����� ������');

  l.add('');
  for i := 1 to 6 do Pop;

  l.add(PackStrR(IntToStr(PopInt),GetColWidth) + '���������� ������������ WDT');

  l.add('');
  l.add(PackStrR('0x' + IntToHex(PopInt,4),GetColWidth) + '������ ���������');
  l.add(PackStrR(IntToStr(PopInt),GetColWidth) + '��������� �����');
  l.add(PackStrR(IntToStr(Pop),GetColWidth) + '���������� �����');

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
  l.add(PackStrR(IntToStr(cwRecord),    GetColWidth) + '������� �������: ���������� ������� �����');
  l.add(PackStrR(IntToStr(cwRecord2),   GetColWidth) + '������� �������: ���������� ������� �����������');
  l.add(PackStrR(IntToStr(bRecordBlock),GetColWidth) + '������� �������: ���������� ������� �� ��������');
  l.add(PackStrR(IntToStr(bRecordSize), GetColWidth) + '������� �������: ���������� ������� ����� (+1)');
  l.add(PackStrR(IntToStr(wRecord2Size),GetColWidth) + '������� �������: ���������� ������� ����������� (+1)');

  l.add('');
  l.add(PackStrR(IntToStr(pwCorrect),   GetColWidth) + '����� ������� ��������� �������');
  l.add(PackStrR(IntToStr(pwSystem),    GetColWidth) + '����� ������� ��������� �������');
  l.add(PackStrR(IntToStr(pwSensors),   GetColWidth) + '����� ������� ��������� ���������');
  l.add(PackStrR(IntToStr(pwEvents),    GetColWidth) + '����� ������� ������� �������');
  l.add(PackStrR(IntToStr(pwModems),    GetColWidth) + '����� ������� ��������� �������');
  l.add(PackStrR(IntToStr(pwMessages),  GetColWidth) + '����� ������� ���-��������');
  l.add(PackStrR(IntToStr(pwAuxiliary), GetColWidth) + '����� ������� ��������� ��������� (������������)');

  l.add('');
  l.add(PackStrR(IntToStr(wPages), GetColWidth)           + '���������� ������� ������ (�����)');
  l.add(PackStrR(IntToStr(wPagesEnd), GetColWidth)        + '���������� ������� ������ (�������)');
  l.add(PackStrR(IntToStr(wPages-wPagesEnd), GetColWidth) + '���������� ������� ������ (���������)');

  l.add('');
  l.add(PackStrR(IntToStr(cdwCorrect),  GetColWidth) + '������� ������� ��������� �������');
  l.add(PackStrR(IntToStr(cdwSystem),   GetColWidth) + '������� ������� ��������� �������');
  l.add(PackStrR(IntToStr(cdwSensors),  GetColWidth) + '������� ������� ��������� ���������');
  l.add(PackStrR(IntToStr(cdwEvents),   GetColWidth) + '������� ������� ������� �������');
  l.add(PackStrR(IntToStr(cdwModems),   GetColWidth) + '������� ������� ��������� �������');
  l.add(PackStrR(IntToStr(cdwMessages), GetColWidth) + '������� ������� ���-��������');
  l.add(PackStrR(IntToStr(cdwAuxiliary),GetColWidth) + '������� ������� ��������� ��������� (������������)');

  l.add('');
  l.add(PackStrR(IntToStr(cdwSecond),   GetColWidth) + '���������� ���������: �������');
  l.add(PackStrR(IntToStr(cdwMinute1),  GetColWidth) + '���������� ���������: 1 ���');
  l.add(PackStrR(IntToStr(cdwMinute3),  GetColWidth) + '���������� ���������: 3 ���');
  l.add(PackStrR(IntToStr(cdwMinute30), GetColWidth) + '���������� ���������: 30 ���');
  l.add(PackStrR(IntToStr(cwDay),       GetColWidth) + '���������� ���������: ����');
  l.add(PackStrR(IntToStr(cwMonth),     GetColWidth) + '���������� ���������: �����');
  l.add(PackStrR(IntToStr(cwYear),      GetColWidth) + '���������� ���������: ���');

  l.add('');
  l.add(PackStrR(IntToStr(pwPowDayGrp2),GetColWidth) + '����� ������ ���������� �������� �� ������ (�����������)');
  l.add(PackStrR(IntToStr(pwCntMonCan2),GetColWidth) + '����� ������ ��������� �� ������� (�����������)');
  l.add(PackStrR(IntToStr(pwDefDayCan), GetColWidth) + '����� ������ ������������� �� ������');
  l.add(PackStrR(IntToStr(pwDefMonCan), GetColWidth) + '����� ������ ������������� �� �������');
  l.add(PackStrR(IntToStr(pwDiagram),   GetColWidth) + '����� ������ �������� ��������� �� ��������� �� �����');
  l.add(PackStrR(IntToStr(pwCntDayCan7),GetColWidth) + '����� ������ �������� ��������� �� ������ �����');

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
    AddInfo('*������ ��������� ������ (������ 1)');
    AddInfo('');
    ShowMin1(cdwMinute1);
    ShowMin3(cdwMinute3,ibMnt);
    ShowMin30(cdwMinute30,iwHou);
    ShowDay(cwDay,ibDay);
    ShowMon(cwMonth,ibMon);
  end
  else begin
    AddInfo('');
    AddInfo('��� ������ ������ ��������� ������� ������������ ������: ������ ��������� ������ (������ 2)');
    AddInfo('');
  end;

  BoxRun;
end;

end.
