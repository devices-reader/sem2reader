unit get_memory12;

interface

procedure BoxGetMemory12;
procedure ShowGetMemory12;

implementation

uses SysUtils, soutput, support, progress, box, kernel, terminal;

const
  quGetMemory12: querys = (Action: acGetMemory12; cwOut: 7+2; cwIn: 0; bNumber: 249);

procedure QueryGetMemory12;
begin
  InitPushCRC;
  Push($FF);
  Push($FF);
  Query(quGetMemory12);
end;

procedure BoxGetMemory12;
begin
  QueryGetMemory12;
end;

procedure ShowGetMemory12;
begin
  Stop;
  InitPop(15);

  AddTerminal('');
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

  BoxRun;
end;

end.
