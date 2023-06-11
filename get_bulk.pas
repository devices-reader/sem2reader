unit get_bulk;

interface

procedure BoxGetBulk;
procedure ShowGetBulk;

implementation

uses SysUtils, soutput, support, box;

const
  quGetBulk:   querys = (Action: acGetBulk; cwOut: 7+1; cwIn: 5+1+1+4*1+2+4*2+4*1+4*1+2; bNumber: $FF);

procedure QueryGetBulk;
begin
  InitPushCRC;
  Push(107);
  Query(quGetBulk);
end;

procedure BoxGetBulk;
begin
  QueryGetBulk;
end;

procedure ShowGetBulk;
begin
  Stop;
  InitPop(5);

  AddInfo('');
  AddInfo('C��������� ��������� ������');
  AddInfo('����:                      ' + Bool2Str(Pop));
  AddInfo('������ ������:             ' + IntToStr(Pop));
  AddInfo('�������� ������� ������:   ' + IntToStr(Pop)+' '+IntToStr(Pop)+' '+IntToStr(Pop)+' '+IntToStr(Pop));
  AddInfo('������� ������:            ' + IntToStr(PopIntBig));
  AddInfo('�������� �������� ������:  ' + IntToStr(PopIntBig)+' '+IntToStr(PopIntBig)+' '+IntToStr(PopIntBig)+' '+IntToStr(PopIntBig));
  AddInfo('������ ������ �������:     ' + IntToStr(Pop)+' '+IntToStr(Pop)+' '+IntToStr(Pop)+' '+IntToStr(Pop));
  AddInfo('������ ������ �����������: ' + IntToStr(Pop)+' '+IntToStr(Pop)+' '+IntToStr(Pop)+' '+IntToStr(Pop));

  BoxRun;
end;

end.
