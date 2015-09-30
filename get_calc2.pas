unit get_calc2;

interface

procedure BoxCalc2;

implementation

uses SysUtils, main,soutput, kernel, support, borders, timez, realz, get_esc, get_impcanday, get_pulse_hou; // ??

procedure BoxCalc2;
{var
  s:      string;
  e:      extended;
  y,z:    word;}
begin {
  AddInfo('');
  AddInfo('Расчёт №1');
  for y := 0 to CANALS-1 do begin
    if y+1 in [bMinCan..bMaxCan] then begin
      s := 'канал ' + PackStrR(IntToStr(y+1),4);
        
      s := s + GetReal(mpEscS[y]) + ' - ';

      e := 0;
      for z := 0 to 3 do e := e + mpImpCanDay[y,0,z]/mpePulse[y];
      s := s + GetReal(e) + ' = ';
        
      s := s + GetReal(mpEscS[y]-e) + ' ? ' + GetReal(mpEscV[y]);

      if Abs(mpEscS[y]-e) > 0.001 then
        s := s + FloatToStrF(100*(mpEscS[y]-e - mpEscV[y])/(mpEscS[y]-e),ffFixed,8,frmMain.updDigits.Position) + ' %';

      AddInfo(s);
    end;
  end;

  BoxGetTime2; }
end;

end.
