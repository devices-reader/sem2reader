unit get_events;

interface

uses kernel;

procedure BoxGetEvents1;
procedure ShowGetEvents1;

procedure BoxGetEvents2;
procedure ShowGetEvents2;

implementation

uses SysUtils, soutput, support, realz, timez, borders, box;

const
  quGetEvents1: querys = (Action: acGetEvents1; cwOut: 7+1; cwIn:  5+129+2; bNumber: $FF);
  quGetEvents2: querys = (Action: acGetEvents2; cwOut: 7+2; cwIn: 15+640+2; bNumber: $FF);

var
  ibEvent:  byte;

function GetEventName(i: byte): string;
begin
  case i of 
    1: Result := '�������';
    2: Result := '���� 1';
    3: Result := '���� 2';
    4: Result := '���� 3';
    else Result := '? '+IntToStr(i);
  end;  
end;
    
procedure QueryGetEvents1;
begin
  InitPushCRC;
  Push(47);
  Query(quGetEvents1);
end;

procedure QueryGetEvents2;
begin
  InitPushCRC;
  Push(48);
  Push(ibEvent);
  Query(quGetEvents2);
end;

procedure BoxGetEvents1;
begin
  if TestCanals then begin
    AddInfo('');    
    AddInfo('���������� ������� ������� 1');
    
    QueryGetEvents1;
  end;
end;

procedure BoxGetEvents2;
begin
  if TestCanals then begin
    AddInfo('');    
    AddInfo('���������� ������� ������� 2');
    ibEvent := 0;
    QueryGetEvents2;
  end;
end;
                          
procedure ShowGetEvents1;
var
  i:  byte;
  s:  string;
begin
  Stop;
  InitPopCRC;
  
  AddInfo('');
  AddInfo('������� ������������� ������� �������: '+PopBool2Str);
  AddInfo('');
  AddInfo('�������� ���������� ������ ���������');
  for i := 0 to CANALS-1 do begin
    s := PackStrR('����� '+IntToStr(i+1),GetColWidth)+PopBool2Str;
    if CanalChecked(i) then
      AddInfo(s);
  end;    

  AddInfo('');
  AddInfo('�������� ������� ������� ��� �������� '+GetDeviceName(1));
  for i := 0 to 32-1 do
    AddInfo(PackStrR('������� '+IntToStr(i+1),GetColWidth)+PackStrR(PopBool2Str,GetColWidth)+GetEventName(i+1));

  AddInfo('');
  AddInfo('�������� ������� ������� ��� �������� '+GetDeviceName(2));
  for i := 0 to 32-1 do
    AddInfo(PackStrR('������� '+IntToStr(i+1),GetColWidth)+PackStrR(PopBool2Str,GetColWidth)+GetEventName(i+1));
    
  RunBox;
end;

procedure ShowGetEvents2;
var
  i:  byte;
  s:  string;
begin
  Stop;
  InitPop(15);

  AddInfo('');
  AddInfo('�������: ' +GetEventName(ibEvent+1));
  for i := 0 to CANALS-1 do begin
    s := PackStrR('����� '+IntToStr(i+1),GetColWidth)+PackStrR(IntToStr(PopLong),GetColWidth)+PopTimes2Str;
    if CanalChecked(i) then  
      AddInfo(s);
  end;
  
  Inc(ibEvent);  
  if ibEvent < 4 then
    QueryGetEvents2
  else  
    RunBox;
end;

end.
