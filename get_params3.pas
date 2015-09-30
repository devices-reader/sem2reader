unit get_params3;

interface

uses kernel;

procedure BoxGetParams3;
procedure ShowGetParams3;

implementation

uses SysUtils, Classes, soutput, support, realz, timez, calendar, borders2, box, main, progress, borders, get_params2;

const
  quGetParams3: querys = (Action: acGetParams3; cwOut: 7+4; cwIn: 0; bNumber: 50);

var
  ibPar,cbPar: byte;
  wShi,wMinShi,wMaxShi: word;
  bo: boolean;

procedure QueryGetParams3;
begin
  InitPushCRC;
  Push(ibPar);
  Push(cbPar);
  Push(wShi div $100);
  Push(wShi mod $100);
  Query(quGetParams3);
end;

procedure BoxGetParams3;
begin
  if TestParams then begin
    AddInfo('');

    ibPar := (frmMain.updParamMin.Position-1) div 10;
    cbPar := ((frmMain.updParamMax.Position-1) div 10) - ibPar + 1;
    cwPar := cbPar*10;

    wMinShi := frmMain.updShiftMin.Position;
    wMaxShi := frmMain.updShiftMax.Position;
    wShi := wMinShi;

    bo := False;

    QueryGetParams3;
  end;
end;

procedure ShowGetParams3;
var
  Can:  word;
  s:    string;
  e:    extended;
  x:    byte;
  ti:   times;
  r:    TStringList;
begin
  Stop;
  InitPop(5+4);
  x := Pop;
  ti := PopTimes;

  if not bo then begin
    if x = 0 then
      AddInfo('График мгновенных параметров (получасовой)')
    else
      AddInfo('График мгновенных параметров (трехминутный)');
      
    AddInfo('');
    bo := True;
  end;

  r := TStringList.Create;

  if x = 0 then
    r.Add(PackStrR('интервал', GetColWidth) + '-' + IntToStr(wShi) + ', ' + Times2Str(HalfIndexToDate(DateToHalfIndex(ti)-wShi)))
  else
    r.Add(PackStrR('интервал', GetColWidth) + '-' + IntToStr(wShi) + ', ' + Times2Str(ThreeIndexToDate(DateToThreeIndex(ti)-wShi)));

  for Can := ibPar*10 to (ibPar+cbPar)*10-1 do begin
    s := GetParams2(Can);
    e := PopReals;
    if mpParams[Can].boActive then s := s + Reals2StrR(e);
    r.Add(s);
  end;
  AddInfoAll(r);

  ShowProgress(wShi-wMinShi, wMaxShi-wMinShi+1);

  Inc(wShi);
  if wShi <= wMaxShi then begin
    QueryGetParams3;
  end
  else begin
    RunBox;
  end;
end;

end.
