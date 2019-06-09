unit get_calc3;

interface

procedure BoxCalc3;

implementation

uses SysUtils, main,soutput, kernel, support, borders, box, timez, realz, get_impcanmon, get_pulse_hou, get_trans_eng, get_extended4, get_time;

function ValueA(c: byte): extended;
var
  t: byte;
begin
  result := 0;
  for t := 0 to TARIFFS-1 do result := result + mpImpCanMon[c,1,t];
  result := result/mpePulseHou[c];
  if UseTrans then result := result*mpeTransEng[c];
end;

function ValueB(c: byte): extended;
begin
  result := mpExt42CntCanMon[c,1] - mpExt42CntCanMon[c,2];
end;

procedure BoxCalc3;
var
  c: byte;
  s: string;
  a,b: extended;
begin
  AddInfo('');
  AddInfo('Расчёт №3');
  for c := 0 to CANALS-1 do begin
    if CanalChecked(c) then begin
      s := 'канал ' + PackStrR(IntToStr(c+1),4);

      a := ValueA(c);
      b := ValueB(c);
      s := s + Reals2StrR(a) + ' - ' + Reals2StrR(b) + ' = ' + Reals2StrR(a-b) + ' ';

      if a > 0 then s := s + Reals2Str(100*(a - b)/a) + ' %';
      AddInfo(s);
    end;
  end;

  BoxGetTime2;
end;

end.
