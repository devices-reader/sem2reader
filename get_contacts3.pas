unit get_contacts3;

interface

procedure BoxGetContacts3;
procedure ShowGetContacts3;

implementation

uses SysUtils, support, soutput, realz, box;

const
  quGetContacts3: querys = (Action: acGetContacts3; 
                            cwOut: 7+1;   
                            cwIn: 5+22+2;   
                            bNumber: $FF);

procedure QueryGetContacts3;
begin
  InitPushCRC;
  Push(39);
  Query(quGetContacts3);
end;

procedure BoxGetContacts3;
begin
  QueryGetContacts3;
end;

procedure ShowGetContacts3;
begin
  Stop;
  InitPopCRC;

  AddInfo('');    
  AddInfo('���������� ���� (����� 3)');
    
  AddInfo('�������� ��������� ���� 1: '+Reals2Str(PopReals));
  AddInfo('������� ��������:          '+Reals2Str(PopReals));
  AddInfo('��������� ��������:        '+Reals2Str(PopReals));
  AddInfo('�������� ��������� ���� 2: '+Reals2Str(PopReals));
  AddInfo('�������� �������� (*3 ���.): ' + IntToStr(Pop) + ' - ' + IntToStr(Pop));
  AddInfo('��������� ���� 1: ' + PopSwitch2Str);
  AddInfo('��������� ���� 2: ' + PopSwitch2Str);
  AddInfo('�������������� ���������: ' + IntToStr(Pop) + ' - ' + IntToStr(Pop));
    
  RunBox;
end;

end.
