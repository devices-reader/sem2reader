unit get_checkup_defects_mon;

interface

function InfoGetCheckupDefectsMon: string;
procedure BoxGetCheckupDefectsMon;
procedure ShowGetCheckupDefectsMon;

implementation

uses SysUtils, kernel, soutput, support, borders, progress, box, timez;

const
  quGetCheckupDefectsMon:   querys = (Action: acGetCheckupDefectsMon; cwOut: 7+1; cwIn: 5+1+100*(1+1+3)+2; bNumber: $FF);

function InfoGetCheckupDefectsMon: string;
begin
  Result := 'брак проверки достоверности по мес€цам';
end;

procedure QueryGetCheckupDefectsMon;
begin
  InitPushCRC;
  Push(125);
  Query(quGetCheckupDefectsMon);
end;

procedure BoxGetCheckupDefectsMon;
begin
  if TestCanals then begin
    AddInfo('');
    AddInfo('Ѕрак проверки достоверности по мес€цам');

    QueryGetCheckupDefectsMon;
  end;
end;

procedure ShowGetCheckupDefectsMon;
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
  s := s + PackStrR('счетчик брака',GetColWidth);
  s := s + PackStrR('мес€ц брака',GetColWidth);
  AddInfo(s);
  AddInfo(PackLine(4*GetColWidth));

  for i := 0 to 100-1 do  begin
    if (i < (a mod 100)) then b := i + 100*(a div 100) else b := i;
    z := IntToStr(b);
    if (i+1 = (a mod 100)) then z := z + ' *';
    s := PackStrR(z,GetColWidth);

    s := s + PackStrR(IntToStr(Pop+1),GetColWidth);
    s := s + PackStrR(IntToStr(Pop),GetColWidth);
    s := s + PackStrR(Int2Str(Pop)+'.'+Int2Str(Pop)+'.'+Int2Str(Pop),GetColWidth);
    AddInfo(s);
  end;

  RunBox;
end;

end.
