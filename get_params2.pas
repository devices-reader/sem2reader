unit get_params2;

interface

uses kernel;

procedure BoxGetParams2;
function GetParams2(Can: word): string;
procedure ShowGetParams2;

var
  mpParams: array[0..PARAMS_COUNT-1] of digit;

implementation

uses SysUtils, Classes, soutput, support, realz, borders2, box, main, progress;

const
  quGetParams2: querys = (Action: acGetParams2; cwOut: 7+1; cwIn: 5+5*100+2; bNumber: 53);

var
  wMax,wMin: word;
  bMinPar,bMaxPar,bPar: byte;

procedure QueryGetParams2;
begin
  InitPushCRC;
  Push(bPar);
  Query(quGetParams2);
end;

procedure BoxGetParams2;
begin
  if TestParams then begin
    AddInfo('');
    AddInfo('Cписок мгновенных параметров');

    wMin := frmMain.updParamMin.Position;
    wMax := frmMain.updParamMax.Position;
    bMinPar := (wMin-1) div 100;
    bMaxPar := (wMax-1) div 100;
    bPar := bMinPar;

    QueryGetParams2;
  end;
end;

function GetParams2(Can: word): string;
var
  s,z: string;
begin
  with mpParams[Can] do begin
    s := PackStrR('параметр '+IntToStr(Can+1),GetColWidth);
    if (ibPort = 0) and (ibPhone = 0) and (bDevice = 0) and (bAddress = 0) and (ibLine = 0) then
      s := s + PackStrR('нет',GetColWidth)
    else begin
      z := Int2Str(ibPort+1)+'.'+
           Int2Str(ibPhone)+'.'+
           Int2Str(bDevice)+'.'+
           Int2Str(bAddress,3)+'.'+
           Int2Str(ibLine+1)+'  '+
           GetDeviceName(bDevice);

      s := s + PackStrR(z,GetColWidth*3);
      s := s + PackStrR(GetParamName(ibLine),GetColWidth);
    end;

    Result := s;
  end;
end;

procedure ShowGetParams2;
var
  Can:  word;
  r:    TStringList;
begin
  Stop;
  InitPopCRC;

  for Can := bPar*100 to (bPar+1)*100-1 do
    with mpParams[Can] do begin
      ibPort   := Pop;
      ibPhone  := Pop;
      bDevice  := Pop;
      bAddress := Pop;
      ibLine   := Pop;
      boActive := not((ibPhone > 0) or (bDevice = 0));
    end;

  ShowProgress(bPar-bMinPar, bMaxPar-bMinPar+1);

  Inc(bPar);
  if bPar <= bMaxPar then begin
    QueryGetParams2;
  end
  else begin
    r := TStringList.Create;
    for Can := wMin to wMax do begin
      r.Add(GetParams2(Can-1));
    end;
    AddInfoAll(r);

    RunBox;
  end;
end;

end.
