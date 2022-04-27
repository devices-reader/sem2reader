unit calc_maxpow;

interface

uses t_tariff, timez;


procedure CalcMaxPow_Init;
procedure CalcMaxPow_SaveTariffs(ibMonAbs: byte; z: zones);
procedure CalcMaxPow_LogTariffs;
procedure CalcMaxPow_CalcMax(tiNow: times; g:byte; ibDay: byte; h: byte; e: extended);
procedure ShowMax(tiNow: times);

implementation

uses SysUtils, support, kernel, calendar, realz, borders;

var
  mpTariffsMH: array[0..MONTHS-1, 0..48-1] of byte;
  mpEnblM: array[0..MONTHS-1] of boolean;
  mpMonGMT: array[0..GROUPS-1, 0..MONTHS-1, 0..TARIFFS-1] of maximum;

procedure CalcMaxPow_Init;
var
  m,h,g,t: byte;
begin
  for m := 0 to MONTHS-1 do begin
    for h := 0 to 48-1 do begin
      mpTariffsMH[m, h] := 0;
    end;
  end;

  for m := 0 to 12-1 do begin
    mpEnblM[m] := false;
  end;

  for g := 0 to GROUPS-1 do begin
    for m := 0 to MONTHS-1 do begin
      for t := 0 to TARIFFS-1 do begin
        mpMonGMT[g,m,t].extValue := 0;
        mpMonGMT[g,m,t].timValue := tiZero
      end;
    end;
  end;
end;

procedure CalcMaxPow_SaveTariffs(ibMonAbs: byte; z: zones);
var
  h,b: byte;
  t: tariff;
begin

  t := z.mpTariffs[1];
  for h := 0 to 48-1 do
    mpTariffsMH[ibMonAbs, h] := t.bTariff;

  h := 0;
  for b := 1 to TARIFFS_BREAKS do begin
    t := z.mpTariffs[b];
    while (h < (t.bHour*2 + t.bMinute div 30)) do begin
      t := z.mpTariffs[b];
      mpTariffsMH[ibMonAbs, h] := t.bTariff;
      Inc(h);
    end;
  end;
end;

procedure CalcMaxPow_LogTariffs;
var
  s:    string;
  m,h:  byte;
begin
  AddInfo('');

  for m := 0 to TARIFFS_MONTHS-1 do begin
    s := PackStrR('мес€ц '+IntToStr(m+1),GetColWidth);

    for h := 0 to 48-1 do begin
      s := s + IntToStr(mpTariffsMH[m, h]);
    end;

    AddInfo(s);
  end;
      AddInfo('1');
end;

procedure CalcMaxPow_CalcMax(tiNow: times; g: byte; ibDay: byte; h: byte; e: extended);
var
 mOld,mNew: maximum;
 ti: times;
 ibMonAbsNow,ibMonAbsThen,ibMonRel: byte;
 t: byte;
begin
  ti := DayIndexToDate(DateToDayIndex(tiNow)-ibDay);

  ibMonAbsNow  := DateToMonIndex(tiNow);
  ibMonAbsThen := DateToMonIndex(ti);
  ibMonRel := ibMonAbsNow-ibMonAbsThen;

  mpEnblM[ibMonRel] := true;
  t := mpTariffsMH[ti.bMonth-1,h];
  mOld := mpMonGMT[g,ibMonRel,t-1];

  mNew.extValue := e*2;
  mNew.timValue := ti;
  mNew.timValue.bHour := h div 2;
  mNew.timValue.bMinute := (h mod 2)*30;

  if (mNew.extValue >= mOld.extValue) then
    mpMonGMT[g,ibMonRel,t-1] := mNew;
end;

procedure ShowMax(tiNow: times);
var
  m,g,t: byte;
  s: string;
begin
  AddInfo('');
  AddInfo('ћаксимумы мощности по группам за мес€ц (расчетные)');

  for m := 0{ibMinMon} to 12-1{ibMaxMon} do if mpEnblM[m] then begin

    AddInfo('');
    AddInfo('мес€ц -' + IntToStr(m) + ' ' + Times2StrMon(MonIndexToDate(DateToMonIndex(tiNow)-m)));

    for g := 0 to GROUPS-1 do if GroupChecked(g) then begin
      s := PackStrR('группа '+IntToStr(g+1),GetColWidth);

      for t := 0 to TARIFFS-1 do begin
        s := s + Reals2StrL(mpMonGMT[g,m,t].extValue) + ' ';
        s := s + Times2Str(mpMonGMT[g,m,t].timValue);
        s := PackStrL(s,3*GetColWidth);
      end;
      AddInfo(s);
    end;
  end;
end;

end.
