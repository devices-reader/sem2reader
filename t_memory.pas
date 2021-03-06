unit t_memory;

interface

uses Classes;

procedure InitPages;
function TestPages(z: string; wPageSize: word; wFreePageSize: word): TStringList;
function ResultPages: TStringList;

implementation

uses SysUtils, terminal, soutput, kernel, support, crc, timez;

var
  List: TStringList;

procedure InitPages;
begin
  List := TStringList.Create;
  List.Add('');
  List.Add('');
end;

function TestPages(z: string; wPageSize: word; wFreePageSize: word): TStringList;
var
  i:    word;
  a,b:  word;
  ti:   times;
  s:    string;
begin
  Result := TStringList.Create;

  for i := 0 to wPageSize-1 do begin
    if i mod 16 = 0 then s := IntToHex(i,4) + '    ';
    s := s + IntToHex(Pop,2) + ' ';
    if i mod 16 = 15 then begin Result.Add(s); s := ''; end;
  end;
  Result.Add(s);

  i := mpbIn[bHEADER + wFreePageSize + 0]*$100 + mpbIn[bHEADER + wFreePageSize + 1];
  Result.Add(PackStrR('������', GetColWidth) + IntToStr(i));
  a := mpbIn[bHEADER + wFreePageSize + 2]*$100 + mpbIn[bHEADER + wFreePageSize + 3];
  Result.Add(PackStrR('��������', GetColWidth) + IntToStr(a));

  with ti do begin
    bSecond := mpbIn[bHEADER + wFreePageSize + 4];
    bMinute := mpbIn[bHEADER + wFreePageSize + 5];
    bHour   := mpbIn[bHEADER + wFreePageSize + 6];
    bDay    := mpbIn[bHEADER + wFreePageSize + 7];
    bMonth  := mpbIn[bHEADER + wFreePageSize + 8];
    bYear   := mpbIn[bHEADER + wFreePageSize + 9];
  end;
  Result.Add(PackStrR('�����', GetColWidth) + Times2Str(ti));

  b := CRC16_Offset(mpbIn,bHEADER,wPageSize);
  Result.Add(PackStrR('CRC', GetColWidth) + '0x' + IntToHex(b,4));

  if (b <> 0) and (b <> $3E83) and (b <> $707F) then s := '������' else s := '��';
  Result.Add(PackStrR('������', GetColWidth) + s);

  s := z + PackStrR(IntToStr(a),8) + PackStrR(Times2Str(ti),25) + PackStrR('0x' + IntToHex(b,4),8) + ' ' + s;
  List.Add(s);
end;

function ResultPages: TStringList;
begin
  Result := List;
end;

end.
