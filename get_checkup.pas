unit get_checkup;

interface

function InfoGetCheckup: string;
procedure BoxGetCheckup;
procedure ShowGetCheckup;

implementation

uses SysUtils, kernel, soutput, support, borders, box;

const
  quGetCheckup:   querys = (Action: acGetCheckup; cwOut: 7+1; cwIn: 5+1+64+64+2; bNumber: $FF);

function InfoGetCheckup: string;
begin
  Result := '�������� �������������';
end;

procedure QueryGetCheckup;
begin
  InitPushCRC;
  Push(120);
  Query(quGetCheckup);
end;

procedure BoxGetCheckup;
begin
  if TestCanals then begin
    AddInfo('');    
    AddInfo('�������� �������������');
    
    QueryGetCheckup;
  end;
end;

procedure ShowGetCheckup;
var
  Can:  byte;
  s:    string;
begin
  Stop;
  InitPop(5);

  AddInfo('������� ���������� ������: '+PopBool2Str);

  AddInfo('���������� ����� ��� �������� �������������');
  for Can := 0 to CANALS-1 do  begin
    s := PackStrR('����� '+IntToStr(Can+1),GetColWidth);
    s := s + IntToStr(Pop);
    AddInfo(s);
  end;

  AddInfo('���������� ������� ��� �������� �������������');
  for Can := 0 to CANALS-1 do  begin
    s := PackStrR('����� '+IntToStr(Can+1),GetColWidth);
    s := s + IntToStr(Pop);
    AddInfo(s);
  end;

  RunBox;
end;

end.
