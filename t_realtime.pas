unit t_realtime;

interface

procedure ShowMin1(cdwMinutes1: longword);
procedure ShowMin3(cdwMinutes3: longword; iwHardMnt: word);
procedure ShowMin30(cdwMinutes30: longword; iwHardHou: word);
procedure ShowDay(cwDay: word; iwHardDay: word);
procedure ShowMon(cwMon: word; iwHardMon: word);

implementation

uses SysUtils, soutput, support, box, timez, calendar2, get_start;

procedure ShowMin1(cdwMinutes1: longword);
var
dwC,dwS,dwV: longint;
begin
  AddInfo('');
  AddInfo('1 ���.');
  dwC := DateToMin1Index(tiCurr);
  AddInfo('������ ������� �������� ' + IntToStr(dwC));
  dwS := DateToMin1Index(tiStart);
  AddInfo('������ ������� �������  ' + IntToStr(dwS));
  dwV := dwC - dwS;
  AddInfo('������: ����������      ' + IntToStr(dwV));
  AddInfo('������: �������         ' + IntToStr(cdwMinutes1));
  AddInfo('������: �������         ' + IntToStr(dwV - cdwMinutes1));
end;

procedure ShowMin3(cdwMinutes3: longword; iwHardMnt: word);
var
dwC,dwS,dwV: longint;
begin
  AddInfo('');
  AddInfo('3 ���.');
  dwC := DateToMin3Index(tiCurr);
  AddInfo('������ ������� �������� ' + IntToStr(dwC));
  dwS := DateToMin3Index(tiStart);
  AddInfo('������ ������� �������  ' + IntToStr(dwS));
  dwV := dwC - dwS;
  AddInfo('������: ����������      ' + IntToStr(dwV));
  AddInfo('������: �������         ' + IntToStr(cdwMinutes3));
  AddInfo('������: �������         ' + IntToStr(dwV - cdwMinutes3));
  AddInfo('��������� �������       ' + IntToStr(iwHardMnt));
  AddInfo('��������� ���������     ' + IntToStr(dwV mod 40));
end;

procedure ShowMin30(cdwMinutes30: longword; iwHardHou: word);
var
dwC,dwS,dwV: longint;
begin
  AddInfo('');
  AddInfo('30 ���.');
  dwC := DateToMin30Index(tiCurr);
  AddInfo('������ ������� �������� ' + IntToStr(dwC));
  dwS := DateToMin30Index(tiStart);
  AddInfo('������ ������� �������  ' + IntToStr(dwS));
  dwV := dwC - dwS;
  AddInfo('������: ����������      ' + IntToStr(dwV));
  AddInfo('������: �������         ' + IntToStr(cdwMinutes30));
  AddInfo('������: �������         ' + IntToStr(dwV - cdwMinutes30));
  AddInfo('��������� �������       ' + IntToStr(iwHardHou));
  AddInfo('��������� ���������     ' + IntToStr(dwV mod (48*62)));
end;

procedure ShowDay(cwDay: word; iwHardDay: word);
var
dwC,dwS,dwV: longint;
begin
  AddInfo('');
  AddInfo('�����');
  dwC := DateToDayIndex(tiCurr);
  AddInfo('������ ������� �������� ' + IntToStr(dwC));
  dwS := DateToDayIndex(tiStart);
  AddInfo('������ ������� �������  ' + IntToStr(dwS));
  dwV := dwC - dwS;
  AddInfo('������: ����������      ' + IntToStr(dwV));
  AddInfo('������: �������         ' + IntToStr(cwDay));
  AddInfo('������: �������         ' + IntToStr(dwV - cwDay));
  AddInfo('��������� �������       ' + IntToStr(iwHardDay));
  AddInfo('��������� ���������     ' + IntToStr(dwV mod 14));
end;

procedure ShowMon(cwMon: word; iwHardMon: word);
var
dwC,dwS,dwV: longint;
begin
  AddInfo('');
  AddInfo('�����');
  dwC := DateToMonIndex(tiCurr);
  AddInfo('������ ������� �������� ' + IntToStr(dwC));
  dwS := DateToMonIndex(tiStart);
  AddInfo('������ ������� �������  ' + IntToStr(dwS));
  dwV := dwC - dwS;
  AddInfo('������: ����������      ' + IntToStr(dwV));
  AddInfo('������: �������         ' + IntToStr(cwMon));
  AddInfo('������: �������         ' + IntToStr(dwV - cwMon));
  AddInfo('��������� �������       ' + IntToStr(iwHardMon));
  AddInfo('��������� ���������     ' + IntToStr(tiCurr.bMonth-1));
end;

end.
