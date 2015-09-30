unit get_correct3;

interface

procedure BoxGetCorrect3;
procedure ShowGetCorrect3;

implementation

uses SysUtils, soutput, kernel, support, timez, box;

const
  quGetCorrect3:   querys = (Action: acGetCorrect3; cwOut: 7+1; cwIn: 5+100+2; bNumber: $FF);  

procedure QueryGetCorrect3;
begin
  InitPushCRC;
  Push(59);
  Query(quGetCorrect3);
end;

procedure BoxGetCorrect3;
begin
  AddInfo('');
  AddInfo('���������� ����������� ��������� ������� ��� ������������� ����� GPS');
  
  QueryGetCorrect3;
end;  

procedure ShowGetCorrect3;
var
  i:  byte;
  s:  string;
begin
  Stop;

  InitPopCRC;
  AddInfo('');      
  AddInfo(PackStrR('����� GPS:',GetColWidth*5)+PopBool2Str);    
  AddInfo(PackStrR('����� ��������� ������� � ������ ��������� GPS:',GetColWidth*5)+PopBool2Str);    

  AddInfo(PackStrR('����� ���������� ������� ���������:',GetColWidth*5)+IntToStr(PopLong));    
  AddInfo(PackStrR('���������� ���������������� ������������� ���������:',GetColWidth*5)+IntToStr(PopLong));    
  AddInfo(PackStrR('���������� ���������� ������������� ���������:',GetColWidth*5)+IntToStr(Pop));    

  AddInfo(PackStrR('����� ��������� �������� ��������� GPS:',GetColWidth*5)+PopTimes2Str);    
  AddInfo(PackStrR('����� ��������� ��������� ��������� GPS:',GetColWidth*5)+PopTimes2Str);    
  
  AddInfo(PackStrR('������ ��������� �������:',GetColWidth*5)+PopBool2Str);    

  AddInfo('');      
  AddInfo('���������� ������� ���������');
  for i := 0 to 15-1 do begin
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
      else s := '-'
    end;
      
    s := PackStrR(s,2*GetColWidth);
    s := s + IntToStr(PopInt);
    AddInfo(s);  
  end;  
    
  RunBox;
end;

end.
