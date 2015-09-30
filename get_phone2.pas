unit get_phone2;

interface

uses kernel;

procedure BoxGetPhone2;
procedure ShowGetPhone2;

implementation

uses SysUtils, soutput, support, progress, realz, timez, box;

const  
  quGetPhone2:   querys = (Action: acGetPhone2; cwOut: 7+2; cwIn: 5+400+2; bNumber: $FF);

  mpCode:        array[1..10] of string =
  (
    '������',
    '�������',
    '����� � ����������',
    '���� ������',
    '���� ��������� ������',
    '���� ���������� ���������',
    '���� �������� ��������� ',
    '������',
    '������',
    '����������� ����'
  );
  
procedure QueryGetPhone2;
begin
  InitPushCRC;
  Push(54);
  Query(quGetPhone2);
end;

procedure BoxGetPhone2;
begin
  QueryGetPhone2;
end;

function PopPhone2(bSize: byte): string;
var
  i,j:  byte;
  s:  string;
begin
  Result := ''; s:='';
  for  i := 1 to bSize do begin
    j := Pop;
    s := s + IntToHex(j,2) + ' ';
    if j > $20 then
      Result := Result + Chr(j)
    else if j > 0 then
      Result := Result + '_'
    else  
      Result := Result + ' ';
  end;
  Result := '"' + Result + '"  ' + s;
end;
  
procedure ShowGetPhone2;
var
  i:  byte;
begin
  Stop;
  InitPopCRC;

  AddInfo('');    
  AddInfo('');    
  AddInfo('���������� ���-��������');
  
  AddInfo('');    
  AddInfo(PackStrR('������ ���������:', 3*GetColWidth) + PopBool2Str);
  AddInfo(PackStrR('��������� ������:', 3*GetColWidth) + IntToStr(Pop) + ' (1 - ��, 0 - ���)');
  
  AddInfo('');    
  AddInfo(PackStrR('����:', 3*GetColWidth) + IntToStr(Pop));
  AddInfo(PackStrR('�������� ��������:', 3*GetColWidth) + Reals2Str(PopReals));
  AddInfo(PackStrR('����� ��������:', 3*GetColWidth) + Reals2Str(PopReals));
  AddInfo(PackStrR('������� 1:', 3*GetColWidth) + PopPhone2(NUMBERS));
  AddInfo(PackStrR('������� 2:', 3*GetColWidth) + PopPhone2(NUMBERS));
  AddInfo(PackStrR('������� 3:', 3*GetColWidth) + PopPhone2(NUMBERS));
  AddInfo(PackStrR('������� 4:', 3*GetColWidth) + PopPhone2(NUMBERS));
  AddInfo(PackStrR('���� ������:', 3*GetColWidth) + IntToStr(Pop));
  AddInfo(PackStrR('�������:', 3*GetColWidth) + IntToStr(Pop));

  AddInfo('');      
  AddInfo(PackStrR('����� ��� ���������� ���������:',3*GetColWidth) + PopPhone2(50));
  AddInfo(PackStrR('����� ��� �������� ���������:',3*GetColWidth) + PopPhone2(50));

  AddInfo('');      
  for i := 1 to 10 do
    AddInfo(PackStrR(mpCode[i],3*GetColWidth) + PackStrR(IntToStr(PopInt),GetColWidth) + PopTimes2Str);

  AddInfo('');      
  AddInfo(PackStrR('����� ���������� �������:',3*GetColWidth) + PopPhone2(8));

  AddInfo('');      
  AddInfo(PackStrR('������� ��������� ������',3*GetColWidth) + IntToStr(PopLong));
  AddInfo(PackStrR('������� ������� �������',3*GetColWidth) + IntToStr(PopLong));
  AddInfo(PackStrR('������� ��������� �������',3*GetColWidth) + IntToStr(PopLong));
  AddInfo(PackStrR('������� ���������� ��������',3*GetColWidth) + IntToStr(PopLong));
  AddInfo(PackStrR('������� ������������ ��������',3*GetColWidth) + IntToStr(PopLong));
  AddInfo(PackStrR('������� �������� ��������',3*GetColWidth) + IntToStr(PopLong));
       
  RunBox;
end;

end.
