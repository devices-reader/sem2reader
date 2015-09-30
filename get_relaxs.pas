unit get_relaxs;

interface

procedure BoxGetRelaxs;
procedure ShowGetRelaxs;

implementation

uses SysUtils, soutput, support, progress, box, timez;

const  
  quGetRelaxs:  querys = (Action: acGetRelaxs; cwOut: 7+2; cwIn: 5+2+1+40*6+2; bNumber: $FF);
  
var
  mpRelaxs:     array[0..40-1] of times;
    
procedure QueryGetRelaxs;
begin
  InitPushCRC;
  Push(45);
  Query(quGetRelaxs);
end;

procedure BoxGetRelaxs;
begin
  AddInfo('');    
  AddInfo('������ ����������');
    
  QueryGetRelaxs;
end;

function Relaxs2Str(tiT: times): string;
begin
  case tiT.bSecond of
    1:  Result := '��������';
    2:  Result := '�������';
    else  Result := '?';
  end;
  Result :=  ' ' + Int2Str(tiT.bDay)   +
             '.' + Int2Str(tiT.bMonth) + ' - ' + Result;
end;

procedure ShowGetRelaxs;
var
  i,j:  byte;
  s:    string;
begin
  Stop;
  InitPop(5);

  AddInfo('');
  AddInfo('������� ������������� ����������: '+PopBool2Str);
  AddInfo('����������� ����� (1..4): '+IntToStr(Pop+1));

  j := Pop;
  AddInfo('');
  AddInfo('���������� ����������: '+IntToStr(j));
  
  for i := 1 to j do begin
    mpRelaxs[i] := PopTimes;
    s := PackStrR('���� '+IntToStr(i),GetColWidth);
    s := s + Relaxs2Str(mpRelaxs[i]);
    AddInfo(s);
  end;

  RunBox;
end;

end.
