unit get_calc1;

interface

procedure BoxCalc1;

implementation

uses SysUtils, main,soutput, kernel, support, borders, timez, realz, get_esc, get_impcanday, get_pulse_hou, get_time; // ??

procedure BoxCalc1;
var
  s:      string;
  e:      extended;
  y,z:    word;
begin
  AddInfo('');
  AddInfo('Расчёт №1');
  for y := 0 to CANALS-1 do begin
    if CanalChecked(y) then begin
      s := 'канал ' + PackStrR(IntToStr(y+1),4);
        
      s := s + Reals2StrR(mpEscS[y]) + ' - ';

      e := 0;
      for z := 0 to 3 do e := e + mpImpCanDay[y,0,z]/mpePulseHou[y];
      s := s + Reals2StrR(e) + ' = ';
        
      s := s + Reals2StrR(mpEscS[y]-e) + ' ? ' + Reals2StrR(mpEscV[y]);

      if Abs(mpEscS[y]-e) > 0.001 then
        s := s + Reals2Str(100*(mpEscS[y]-e - mpEscV[y])/(mpEscS[y]-e)) + ' %';

      AddInfo(s);
    end;
  end;

  BoxGetTime2;
end;

end.
