unit get_infogps;

interface

procedure BoxGetInfoGPS;
procedure ShowGetInfoGPS;

implementation

uses SysUtils, support, soutput, timez, box;

const
  quGetInfoGPS:   querys = (Action: acGetInfoGPS;   
                            cwOut: 7+10;  
                            cwIn: 5+22+2;   
                            bNumber: $AC);  

procedure BoxGetInfoGPS;
begin
  AddInfo('');    
  AddInfo('���������� � ���������� GPS');
  
  InitPushCRC;
  Push(GetTunnelIndex);
  Push((5+15+2) mod $100);
  Push((5+15+2) div $100);
  
  Push($D0);
  Push($0D);
  Push(7);
  Push(0);
  Push(1);
  Push($97);
  Push($7F);

  Query(quGetInfoGPS);
end;
  
function GetStatus2Str: string;
var
  i:  byte;
begin
  i := Pop();
  case i of
    0:  Result := '���������� ������';
    1:  Result := '������� �� ���������� ��� �������� ��� ���� ���������';
    2:  Result := '������ GPS �� ����������������';
    3:  Result := '������������ ������ � ������ GPS';
    4:  Result := '������������ ������ ������ � ������ GPS';
    else  Result := '?';
  end;
  Result := IntToStr(i) + ' - ' + Result;
end;

procedure ShowGetInfoGPS;
var
  i:  byte;
  s:  string;
begin
  Stop;
  InitPopCRC;

  s := '����:      ';
  for i := 0 to 22-1 do begin 
    s := s + IntToHex(Pop,2) + ' ';
    if i in [4,19] then s := s + '- ';
  end;      
  AddInfo(s);
    
  InitPop(10);
  AddInfo('���������: '+GetStatus2Str);
  AddInfo('�����:     '+PopTimes2Str);
    
  RunBox;
end;

end.
