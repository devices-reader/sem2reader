unit get_correct20;

interface

procedure BoxGetCorrect20;
procedure ShowGetCorrect20;

implementation

uses SysUtils, soutput, kernel, support, timez, box;

const
  quGetCorrect20:   querys = (Action: acGetCorrect20;   
                            cwOut: 7+1;   
                            cwIn: 5+101+2;  
                            bNumber: $FF);  

procedure QueryGetCorrect20;
begin
  InitPushCRC;
  Push(51);
  Query(quGetCorrect20);
end;

procedure BoxGetCorrect20;
begin
  AddInfo('');
  AddInfo('���������� ��������� ������� �����-48');
  
  QueryGetCorrect20;
end;  

procedure ShowGetCorrect20;
var
  i:  byte;
begin
  Stop;
    
  InitPopCRC;
  AddInfo('');    
  AddInfo('��������� �����-48');
  AddInfo('����: '+IntToStr(Pop));

  AddInfo('');
  AddInfo('������ ��������� �����-48:');
  for i := 1 to 48 do
    AddInfo(PackStrR(IntToStr(i),5)+Int2Str((i div 2))+'.'+Int2Str((i mod 2)*30)+'   '+PopBool2Str);

  AddInfo('');
  AddInfo('���������� �����-48:');
  AddInfo(PackStrR(IntToStr(PopIntBig),6) + '���������� ���������� ���������');
  AddInfo(PackStrR(IntToStr(PopIntBig),6) + '���������� ��������� ��������');
  AddInfo(PackStrR(IntToStr(PopIntBig),6) + '���������� �������� ��������');
  AddInfo(PackStrR(IntToStr(PopIntBig),6) + '���������� ���������: ������');
  AddInfo(PackStrR(IntToStr(PopIntBig),6) + '���������� ���������: ��');
  AddInfo(PackStrR(IntToStr(PopIntBig),6) + '���������� ������: ������ ������� �������');
  AddInfo(PackStrR(IntToStr(PopIntBig),6) + '���������� ������: ���� ��������');
  AddInfo(PackStrR(IntToStr(PopIntBig),6) + '���������� ������: �������� ��������');
  AddInfo(PackStrR(IntToStr(PopIntBig),6) + '���������� �������� ���������: �����');
  AddInfo(PackStrR(IntToStr(PopIntBig),6) + '���������� �������� ���������: � �������� ����� 2 ������');
  AddInfo(PackStrR(IntToStr(PopIntBig),6) + '���������� �������� ���������: � �������� ����� 5 ������');
  AddInfo(PackStrR(IntToStr(PopIntBig),6) + '���������� �������� ���������: � �������� ����� 5 ������');
  AddInfo(PackStrR(IntToStr(PopIntBig),6) + '���������� �������� ���������: � �������� ����� 1 ������');
  AddInfo(PackStrR(IntToStr(PopIntBig),6) + '���������� �������� ���������: � �������� ����� 10 �����');

  PopIntBig;
  PopIntBig;
  PopIntBig;
  PopIntBig;
  PopIntBig;
  PopIntBig;

  AddInfo('');
  AddInfo('����� �� ��������� ��������� �����-48:    '+PopTimes2Str);
  AddInfo('����� ����� ��������� ��������� �����-48: '+PopTimes2Str);
    
  RunBox;
end;

end.
