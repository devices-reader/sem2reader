unit get_version2;

interface

procedure BoxGetVersion2;
procedure ShowGetVersion2;

implementation

uses SysUtils, soutput, support, box, kernel, timez, get_memory12, get_records;

const
  quGetVersion2:   querys = (Action: acGetVersion2; cwOut: 7+1; cwIn: 5+100+2; bNumber: $FF);

procedure QueryGetVersion2;
begin
  InitPushCRC;
  Push(53);
  Query(quGetVersion2);
end;

procedure BoxGetVersion2;
begin
  QueryGetVersion2;
end;

procedure ShowGetVersion2;
var
  i,j: byte;
  k:   word;
begin
  Stop;
  InitPop(5);

  AddInfo('');
  AddInfo('����������� ������');
  AddInfo('');
  i := Pop;
    AddInfo('�������:              ' + IntToStr(i));
  if i = 0 then begin
    j := Pop;

    if j = 4 then begin
      wPageSize := 528;
      wFreePageSize := 512;
    end
    else begin
      wPageSize := 1056;
      wFreePageSize := 1040;
    end;
    InitGetRecords(wFreePageSize);

    AddInfo('������:               ' + IntToStr(j) +'.' + IntToStr(Pop) + '.' + IntToHex(PopInt,4));
    AddInfo('����� ������:         ' + IntToStr(PopInt));
    AddInfo('���� ������:          ' + PopTimes2Str);
    AddInfo('��������� �����:      ' + IntToStr(PopInt));
    AddInfo('���������� �����:     ' + IntToStr(Pop));

    if (j > 2) then begin
      AddInfo('');
      AddInfo('���������� �������:   ' + IntToStr(Pop));
      AddInfo('���������� �����:     ' + IntToStr(Pop));
      AddInfo('���������� ���������: ' + IntToStr(PopInt));
      k := PopInt;
      AddInfo('���������� ���������: ' + IntToStr(k)+' ('+IntToStr(k div 48)+' �����)');
      AddInfo('���������� �����:     ' + IntToStr(PopInt));
      AddInfo('���������� �������:   ' + IntToStr(PopInt));
    end;
  end
  else
    AddInfo('����������� ������� !');

  BoxGetMemory12;
end;

end.
