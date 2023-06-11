unit get_correct;

interface

procedure BoxGetCorrect;
procedure ShowGetCorrect;

implementation

uses SysUtils, soutput, kernel, support, timez, box;

const
  quGetCorrect:   querys = (Action: acGetCorrect;   
                            cwOut: 7+1;   
                            cwIn: 5+347+2;  
                            bNumber: $FF);  
  
  CORRECT_SIZE  = 15;
  
var
  mpcwPos,
  mpcwNeg,
  mpcwPosCount,
  mpcwNegCount:   array[0..CORRECT_SIZE-1] of word;

procedure QueryGetCorrect;
begin
  InitPushCRC;
  Push(31);
  Query(quGetCorrect);
end;

procedure BoxGetCorrect;
begin
  AddInfo('');
  AddInfo('���������� ��������� �������');
  
  QueryGetCorrect;
end;
  
procedure ShowCorrectMonth;
var
  i:  byte;
  s:  string;    
begin
  for i := 0 to CORRECT_SIZE-1 do mpcwPos[i] := PopIntBig;
  for i := 0 to CORRECT_SIZE-1 do mpcwNeg[i] := PopIntBig;
  for i := 0 to CORRECT_SIZE-1 do mpcwPosCount[i] := PopIntBig;
  for i := 0 to CORRECT_SIZE-1 do mpcwNegCount[i] := PopIntBig;

  for i := 0 to CORRECT_SIZE-1 do begin
    case i of
      0: s := '�����';
      1: s := '���� GPS';
      2: s := '����������';
      3: s := '������ 0xFF 0x0B';
      4: s := '������ Esc K';
      5: s := '������ Esc k';
      6: s := '������ 0x0B';
      7: s := '������ 0x0C';
      8: s := '������ 0xEE';
      9: s := '���� �����-48';
      else break;
    end;
      
    s := PackStrR(s,20);
    s := s + PackStrR('+'+Int2Str(mpcwPos[i] div 60)+':'+ Int2Str(mpcwPos[i] mod 60),8)+
             PackStrR('+'+IntToStr(mpcwPos[i]),8);
               
    s := s + PackStrR(IntToStr(mpcwPosCount[i]),6);
      
    s := s + PackStrR('-'+Int2Str(mpcwNeg[i] div 60)+':'+ Int2Str(mpcwNeg[i] mod 60),8)+
             PackStrR('-'+IntToStr(mpcwNeg[i]),8);
               
    s := s + PackStrR(IntToStr(mpcwNegCount[i]),6);
    AddInfo(s);  
  end;
end;

procedure ShowGetCorrect;
var
  i:  byte;
begin
  Stop;
    
  InitPopCRC;
  AddInfo('');    
  AddInfo('��������� GPS');
  AddInfo('����: '+IntToStr(Pop));
  AddInfo('��������� ����������� ������: '+IntToStr(Pop));
  AddInfo('��������� ����������� ������: '+IntToStr(Pop)+'.'+IntToStr(Pop));
  AddInfo('������� ����: '+IntToStr(Pop));

  AddInfo('');
  AddInfo('������ ��������� GPS:');
  for i := 1 to 48 do
    AddInfo(PackStrR(IntToStr(i),5)+Int2Str((i div 2))+'.'+Int2Str((i mod 2)*30)+'   '+PopBool2Str);

  AddInfo('');
  AddInfo('���������� GPS:');
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
  AddInfo('����� �� ��������� ��������� GPS:    '+PopTimes2Str);
  AddInfo('����� ����� ��������� ��������� GPS: '+PopTimes2Str);
    
  AddInfo('');
  AddInfo('��������� �� ������� �����:');
  ShowCorrectMonth;
  AddInfo('');
  AddInfo('��������� �� ���������� �����:');
  ShowCorrectMonth;

  AddInfo('');
  AddInfo('�������� ����� GPS (1: ������ �����, 0: ������ �����): '+IntToStr(Pop));
  AddInfo('������� ���������� ������ ���� � ������ ����� GPS:     '+PopBool2Str);
    
  RunBox;
end;

end.
