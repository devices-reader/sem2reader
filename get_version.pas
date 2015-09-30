unit get_version;

interface

procedure BoxGetVersion;
procedure ShowGetVersion;

implementation

uses SysUtils, soutput, support, box;

const
  quGetVersion:   querys = (Action: acGetVersion; cwOut: 7+2; cwIn: 1073; bNumber: $F9);

procedure QueryGetVersion;
begin
  InitPushCRC;
  Push($FF);
  Push($FF);
  Query(quGetVersion);
end;

procedure BoxGetVersion;
begin
  QueryGetVersion;
end;

procedure ShowGetVersion;
begin
  Stop;

  InitPop(15);

  AddTerminal('');
  AddTerminal('����������');
  AddTerminal(PackStrR(IntToStr(PopInt),GetColWidth) + '���������� �������� ��� ������� ''������''');
  AddTerminal(PackStrR(IntToStr(PopInt),GetColWidth) + '���������� �������� ��� ���������');
  AddTerminal(PackStrR(IntToStr(PopInt),GetColWidth) + '���������� �������� ��� �������� ��������');
  AddTerminal(PackStrR(IntToStr(PopInt),GetColWidth) + '���������� �������� ��� ������ ��������');
  AddTerminal(PackStrR(IntToStr(PopInt),GetColWidth) + '���������� �������� ��� ������ ��������');
  AddTerminal(PackStrR(IntToStr(PopInt),GetColWidth) + '���������� ������ ��� ���������');
  AddTerminal(PackStrR(IntToStr(PopInt),GetColWidth) + '���������� ������ ��� �������� ��������');
  AddTerminal(PackStrR(IntToStr(PopInt),GetColWidth) + '���������� ������ ��� ������ ��������');
  AddTerminal(PackStrR(IntToStr(PopInt),GetColWidth) + '���������� ������ ��� ������ ��������');

  InitPop(65);

  AddInfo('');
  AddInfo('������');
  AddInfo('����������� �����: '+IntToHex(PopInt,4));
  AddInfo('��������� �����:   '+IntToStr(PopInt));
  AddInfo('���������� �����:  '+IntToStr(Pop));

  BoxRun;
end;

end.
