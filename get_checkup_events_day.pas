unit get_checkup_events_day;

interface

function InfoGetCheckupEventsDay: string;
procedure BoxGetCheckupEventsDay;
procedure ShowGetCheckupEventsDay;

implementation

uses SysUtils, kernel, soutput, support, borders, progress, box, timez;

const
  quGetCheckupEventsDay:   querys = (Action: acGetCheckupEventsDay; cwOut: 7+1; cwIn: 5+1+100*(1+6+3)+2; bNumber: $FF);

function InfoGetCheckupEventsDay: string;
begin
  Result := '������� �������� ������������� �� ������';
end;

procedure QueryGetCheckupEventsDay;
begin
  InitPushCRC;
  Push(121);
  Query(quGetCheckupEventsDay);
end;

procedure BoxGetCheckupEventsDay;
begin
  if TestCanals then begin
    AddInfo('');
    AddInfo('������� �������� ������������� �� ������');

    QueryGetCheckupEventsDay;
  end;
end;

procedure ShowGetCheckupEventsDay;
var
  i,a,b:  word;
  s,z:    string;
begin
  Stop;
  InitPop(5);

  a := Pop;
  AddInfo('�����: ' + IntToStr(a));

  s := PackStrR('�',GetColWidth);
  s := s + PackStrR('�����',GetColWidth);
  s := s + PackStrR('���� �������',GetColWidth*2);
  s := s + PackStrR('����� �����',GetColWidth);
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
