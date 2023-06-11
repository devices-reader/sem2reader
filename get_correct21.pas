unit get_correct21;

interface

procedure BoxGetCorrect21;
procedure ShowGetCorrect21;

implementation

uses SysUtils, soutput, kernel, support, timez, box;

const
  quGetCorrect21:   querys = (Action: acGetCorrect21;   
                            cwOut: 7+1;   
                            cwIn: 5+100+2;  
                            bNumber: $FF);  

procedure QueryGetCorrect21;
begin
  InitPushCRC;
  Push(57);
  Query(quGetCorrect21);
end;

procedure BoxGetCorrect21;
begin
  AddInfo('');
  AddInfo('���������� ������� ��������� �������');
  
  QueryGetCorrect21;
end;  

procedure ShowGetCorrect21;
var
  i:  byte;
  s:  string;
begin
  Stop;

  InitPopCRC;
  AddInfo('');      
  AddInfo(PackStrR('�����:',2*GetColWidth)+PopBool2Str);    

  s := '';
  for i := 1 to 10 do s := s + IntToHex(Pop,2) + ' ';
  AddInfo(PackStrR('�����:',2*GetColWidth)+s);

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
    s := s + IntToStr(PopIntBig);
    AddInfo(s);  
  end;  

  AddInfo('');      
  AddInfo('���������� ������� ��������� 0xFF 0x38');
  AddInfo(PackStrR('����� ��������:',3*GetColWidth)+IntToStr(PopLong));    
  AddInfo(PackStrR('���������� �� ������� ������:',3*GetColWidth)+IntToStr(PopLong));    
  AddInfo(PackStrR('���������� �� ������������ �������:',3*GetColWidth)+IntToStr(PopLong));    
  AddInfo(PackStrR('���������� �� ������:',3*GetColWidth)+IntToStr(PopLong));    
  AddInfo(PackStrR('���������� �� ������:',3*GetColWidth)+IntToStr(PopLong));    
    
  RunBox;
end;

end.
