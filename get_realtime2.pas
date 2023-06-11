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
    AddInfo('��� ������ ������ ��������� ������� ������������ ������: ������ ��������� ������ (������ 1)');
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
  AddInfo('*������ ��������� ������ (������ 2)');

  AddInfo('');
  AddInfo('�������           ' + IntToStr(Pop));

  AddInfo('');
  AddInfo('�����             ' + Times2Str(PopTimes));
  AddInfo('����� �������     ' + Times2Str(PopTimes));
  AddInfo('����� ����������  ' + Times2Str(PopTimes));

  AddInfo('');
  AddInfo('����� 1           ' + IntToStr(Pop));
  AddInfo('����� 2           ' + IntToStr(Pop));
  AddInfo('����� 3           ' + IntToStr(Pop));

  AddInfo('');
  AddInfo('����              ' + IntToStr(Pop));

  AddInfo('');
  ibSoftMnt := PopIntBig;
  iwHardMnt := PopIntBig;
  AddInfo('��������� 3 ���.  ' + IntToStr(ibSoftMnt) + ' ' + IntToStr(iwHardMnt));
  ibSoftHou := PopIntBig;
  iwHardHou := PopIntBig;
  AddInfo('��������� 30 ���. ' + IntToStr(ibSoftHou) + ' ' + IntToStr(iwHardHou));
  ibSoftDay := PopIntBig;
  iwHardDay := PopIntBig;
  AddInfo('��������� �����   ' + IntToStr(ibSoftDay) + ' ' + IntToStr(iwHardDay));
  ibSoftMon := PopIntBig;
  iwHardMon := PopIntBig;
  AddInfo('��������� ������  ' + IntToStr(ibSoftMon) + ' ' + IntToStr(iwHardMon));
  AddInfo('��������� times   ' + IntToStr(PopIntBig) + ' ' + IntToStr(PopIntBig));

  AddInfo('');
  AddInfo('������� 1 ���.    ' + IntToStr(PopLong));
  cdwMinutes1 := PopLong;
  AddInfo('������� 1 ���.    ' + IntToStr(cdwMinutes1));
  cdwMinutes3 := PopLong;
  AddInfo('������� 3 ���.    ' + IntToStr(cdwMinutes3));
  cdwMinutes30 := PopLong;
  AddInfo('������� 30 ���.   ' + IntToStr(cdwMinutes30));
  cwDay := PopIntBig;
  AddInfo('������� ���       ' + IntToStr(cwDay));
  AddInfo('������� ������    ' + IntToStr(PopIntBig));
  AddInfo('������� ����      ' + IntToStr(PopIntBig));

  AddInfo('');
  AddInfo('��������� diagram ' + IntToStr(PopIntBig) + ' ' + IntToStr(PopIntBig));

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
