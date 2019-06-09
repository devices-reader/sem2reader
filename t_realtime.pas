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
  AddInfo('1 мин.');
  dwC := DateToMin1Index(tiCurr);
  AddInfo('индекс времени текущего ' + IntToStr(dwC));
  dwS := DateToMin1Index(tiStart);
  AddInfo('индекс времени запуска  ' + IntToStr(dwS));
  dwV := dwC - dwS;
  AddInfo('индекс: приращение      ' + IntToStr(dwV));
  AddInfo('индекс: счетчик         ' + IntToStr(cdwMinutes1));
  AddInfo('индекс: разница         ' + IntToStr(dwV - cdwMinutes1));
end;

procedure ShowMin3(cdwMinutes3: longword; iwHardMnt: word);
var
dwC,dwS,dwV: longint;
begin
  AddInfo('');
  AddInfo('3 мин.');
  dwC := DateToMin3Index(tiCurr);
  AddInfo('индекс времени текущего ' + IntToStr(dwC));
  dwS := DateToMin3Index(tiStart);
  AddInfo('индекс времени запуска  ' + IntToStr(dwS));
  dwV := dwC - dwS;
  AddInfo('индекс: приращение      ' + IntToStr(dwV));
  AddInfo('индекс: счетчик         ' + IntToStr(cdwMinutes3));
  AddInfo('индекс: разница         ' + IntToStr(dwV - cdwMinutes3));
  AddInfo('указатель текущий       ' + IntToStr(iwHardMnt));
  AddInfo('указатель ожидаемый     ' + IntToStr(dwV mod 40));
end;

procedure ShowMin30(cdwMinutes30: longword; iwHardHou: word);
var
dwC,dwS,dwV: longint;
begin
  AddInfo('');
  AddInfo('30 мин.');
  dwC := DateToMin30Index(tiCurr);
  AddInfo('индекс времени текущего ' + IntToStr(dwC));
  dwS := DateToMin30Index(tiStart);
  AddInfo('индекс времени запуска  ' + IntToStr(dwS));
  dwV := dwC - dwS;
  AddInfo('индекс: приращение      ' + IntToStr(dwV));
  AddInfo('индекс: счетчик         ' + IntToStr(cdwMinutes30));
  AddInfo('индекс: разница         ' + IntToStr(dwV - cdwMinutes30));
  AddInfo('указатель текущий       ' + IntToStr(iwHardHou));
  AddInfo('указатель ожидаемый     ' + IntToStr(dwV mod (48*62)));
end;

procedure ShowDay(cwDay: word; iwHardDay: word);
var
dwC,dwS,dwV: longint;
begin
  AddInfo('');
  AddInfo('сутки');
  dwC := DateToDayIndex(tiCurr);
  AddInfo('индекс времени текущего ' + IntToStr(dwC));
  dwS := DateToDayIndex(tiStart);
  AddInfo('индекс времени запуска  ' + IntToStr(dwS));
  dwV := dwC - dwS;
  AddInfo('индекс: приращение      ' + IntToStr(dwV));
  AddInfo('индекс: счетчик         ' + IntToStr(cwDay));
  AddInfo('индекс: разница         ' + IntToStr(dwV - cwDay));
  AddInfo('указатель текущий       ' + IntToStr(iwHardDay));
  AddInfo('указатель ожидаемый     ' + IntToStr(dwV mod 14));
end;

procedure ShowMon(cwMon: word; iwHardMon: word);
var
dwC,dwS,dwV: longint;
begin
  AddInfo('');
  AddInfo('месяц');
  dwC := DateToMonIndex(tiCurr);
  AddInfo('индекс времени текущего ' + IntToStr(dwC));
  dwS := DateToMonIndex(tiStart);
  AddInfo('индекс времени запуска  ' + IntToStr(dwS));
  dwV := dwC - dwS;
  AddInfo('индекс: приращение      ' + IntToStr(dwV));
  AddInfo('индекс: счетчик         ' + IntToStr(cwMon));
  AddInfo('индекс: разница         ' + IntToStr(dwV - cwMon));
  AddInfo('указатель текущий       ' + IntToStr(iwHardMon));
  AddInfo('указатель ожидаемый     ' + IntToStr(tiCurr.bMonth-1));
end;

end.
