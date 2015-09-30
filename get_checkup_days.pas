unit get_checkup_days;

interface

function InfoGetCheckupDays: string;
procedure BoxGetCheckupDays;
procedure ShowGetCheckupDays;

implementation

uses SysUtils, kernel, soutput, support, borders, progress, box, timez;

const
  quGetCheckupDays:   querys = (Action: acGetCheckupDays; cwOut: 7+1; cwIn: 5+1+62*(3)+2; bNumber: $FF);

function InfoGetCheckupDays: string;
begin
  Result := 'буфер достоверности по суткам';
end;

procedure QueryGetCheckupDays;
begin
  InitPushCRC;
  Push(127);
  Query(quGetCheckupDays);
end;

procedure BoxGetCheckupDays;
begin
  if TestCanals then begin
    AddInfo('');
    AddInfo('Буфер достоверности по суткам');

    QueryGetCheckupDays;
  end;
end;

procedure ShowGetCheckupDays;
var
  i,a:  word;
  s:    string;
begin
  Stop;
  InitPop(5);

  a := Pop;
  AddInfo('Всего: ' + IntToStr(a));
  for i := 0 to 62-1 do  begin
    s := PackStrR(IntToStr(i),GetColWidth);
    s := s + PackStrR(Int2Str(Pop)+'.'+Int2Str(Pop)+'.'+Int2Str(Pop),GetColWidth);
    AddInfo(s);
  end;

  RunBox;
end;

end.
