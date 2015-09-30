unit get_checkup_defects_day;

interface

function InfoGetCheckupDefectsDay: string;
procedure BoxGetCheckupDefectsDay;
procedure ShowGetCheckupDefectsDay;

implementation

uses SysUtils, kernel, soutput, support, borders, progress, box, timez;

const
  quGetCheckupDefectsDay:   querys = (Action: acGetCheckupDefectsDay; cwOut: 7+1; cwIn: 5+1+100*(1+1+3)+2; bNumber: $FF);

function InfoGetCheckupDefectsDay: string;
begin
  Result := 'брак проверки достоверности по суткам';
end;

procedure QueryGetCheckupDefectsDay;
begin
  InitPushCRC;
  Push(124);
  Query(quGetCheckupDefectsDay);
end;

procedure BoxGetCheckupDefectsDay;
begin
  if TestCanals then begin
    AddInfo('');
    AddInfo('Брак проверки достоверности по суткам');

    QueryGetCheckupDefectsDay;
  end;
end;

procedure ShowGetCheckupDefectsDay;
var
  i,a,b:  word;
  s,z:    string;
begin
  Stop;
  InitPop(5);

  a := Pop;
  AddInfo('Всего: ' + IntToStr(a));

  s := PackStrR('№',GetColWidth);
  s := s + PackStrR('канал',GetColWidth);
  s := s + PackStrR('счетчик брака',GetColWidth);
  s := s + PackStrR('сутки брака',GetColWidth);
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
