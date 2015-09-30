unit get_checkup_events_mon;

interface

function InfoGetCheckupEventsMon: string;
procedure BoxGetCheckupEventsMon;
procedure ShowGetCheckupEventsMon;

implementation

uses SysUtils, kernel, soutput, support, borders, progress, box, timez;

const
  quGetCheckupEventsMon:   querys = (Action: acGetCheckupEventsMon; cwOut: 7+1; cwIn: 5+1+100*(1+6+3)+2; bNumber: $FF);

function InfoGetCheckupEventsMon: string;
begin
  Result := 'событи€ проверки достоверности по мес€цам';
end;

procedure QueryGetCheckupEventsMon;
begin
  InitPushCRC;
  Push(126);
  Query(quGetCheckupEventsMon);
end;

procedure BoxGetCheckupEventsMon;
begin
  if TestCanals then begin
    AddInfo('');
    AddInfo('—обыти€ проверки достоверности по мес€цам');
    
    QueryGetCheckupEventsMon;
  end;
end;

procedure ShowGetCheckupEventsMon;
var
  i,a,b:  word;
  s,z:    string;
begin
  Stop;
  InitPop(5);

  a := Pop;
  AddInfo('¬сего: ' + IntToStr(a));

  s := PackStrR('є',GetColWidth);
  s := s + PackStrR('канал',GetColWidth);
  s := s + PackStrR('дата событи€',GetColWidth*2);
  s := s + PackStrR('мес€ц брака',GetColWidth);
  AddInfo(s);
  AddInfo(PackLine(5*GetColWidth));

  for i := 0 to 100-1 do  begin
    if (i < (a mod 100)) then b := i + 100*(a div 100) else b := i;
    z := IntToStr(b);
    if (i+1 = (a mod 100)) then z := z + ' *';
    s := PackStrR(z,GetColWidth);
    
    s := s + PackStrR(IntToStr(Pop+1),GetColWidth);
    s := s + PackStrR(PopTimes2Str,GetColWidth*2);
    s := s + PackStrR(Int2Str(Pop)+'.'+Int2Str(Pop)+'.'+Int2Str(Pop),GetColWidth);
    AddInfo(s);
  end;

  RunBox;
end;

end.
