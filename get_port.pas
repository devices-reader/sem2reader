unit get_port;

interface

uses kernel;

procedure BoxGetPort;
procedure ShowGetPort;

implementation

uses SysUtils, soutput, support, box, timez;

const  
  quGetPort:   querys = (Action: acGetPort; cwOut: 7+1; cwIn: 100+7; bNumber: $FF);
    
procedure QueryGetPort;
begin
  InitPushCRC;
  Push(55);
  Query(quGetPort);
end;

procedure BoxGetPort;
begin
  QueryGetPort;
end;

function GetIOMode(b: byte): string;
begin
  if b = 0 then Result := 'in (�����)' else Result := 'out (��������)';
end;

function GetIOControl(b: byte): string;
begin
  if b = 0 then Result := '���' else Result := '����� ' + IntToStr(b) + ' �������(��)';
end;

procedure ShowGetPort;
var
  Prt:  byte;
  s:    string;
  Ver:  byte;
  a:    byte;
begin
  Stop;
  InitPopCRC;

  AddInfo('');    
  AddInfo('');    
  AddInfo('�����');

  AddInfo('');    
  AddInfo('��������� (��������/��������/�����)');
  for Prt := 1 to 4 do begin
    s := PackStrR('���� '+IntToStr(Prt),GetColWidth);
    s := s + IntToStr(Pop)+'.'+IntToStr(Pop)+'.'+IntToStr(Pop);
    AddInfo(s);
  end;  

  AddInfo('');    
  AddInfo('�������� P98 (�������/�����)');
  for Prt := 1 to 4 do begin
    s := PackStrR('���� '+IntToStr(Prt),GetColWidth);
    s := s + PackStrR(IntToStr(PopIntBig),GetColWidth);
    s := s + IntToStr(PopLong);
    AddInfo(s);
  end;

  AddInfo('');    
  AddInfo('�������� P97 (�������/�����)');
  for Prt := 1 to 4 do begin
    s := PackStrR('���� '+IntToStr(Prt),GetColWidth);
    s := s + PackStrR(IntToStr(PopIntBig),GetColWidth);
    s := s + IntToStr(PopLong);
    AddInfo(s);
  end;

  AddInfo('');    
  AddInfo('������� ���������');
  for Prt := 1 to 4 do begin
    s := PackStrR('���� '+IntToStr(Prt),GetColWidth) + IntToStr(Pop);
    AddInfo(s);
  end;  

  AddInfo('');    
  AddInfo('��������� ����� ������� ������');
  for Prt := 1 to 4 do begin
    s := PackStrR('���� '+IntToStr(Prt),GetColWidth) + PopBool2Str;
    AddInfo(s);
  end;  

  AddInfo('');    
  AddInfo('���������� ���������� ������ ������� ������');
  for Prt := 1 to 4 do begin
    s := PackStrR('���� '+IntToStr(Prt),GetColWidth) + PopBool2Str;
    AddInfo(s);
  end;

  AddInfo('');
  AddInfo('�������');
  AddInfo(PackStrR('������ 1',GetColWidth) + IntToStr(PopIntBig));
  AddInfo(PackStrR('������ 2',GetColWidth) + IntToStr(PopIntBig));
  AddInfo(PackStrR('������ 3',GetColWidth) + IntToStr(PopIntBig));

  Ver := Pop;
  if (Ver >= 1) then begin
    a := Pop;
    AddInfo('');
    AddInfo('�������������� ������������ �� ����� ������� ������ 3,4');
    AddInfo(PackStrR('���������',GetColWidth) + IntToHex(a,2));
    AddInfo(PackStrR('���� 3',GetColWidth) + GetIOMode(a and $01));
    AddInfo(PackStrR('���� 4',GetColWidth) + GetIOMode(a and $02));
    AddInfo('������ ������������            ' + GetIOControl(Pop));
    AddInfo('����� ���������� ������������  ' + PopTimes2Str);
    AddInfo('���������� ������������        ' + IntToStr(PopLong));
  end;

  RunBox;
end;

end.
