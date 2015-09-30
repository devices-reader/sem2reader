unit t_memoty;

interface

implementation

uses SysUtils, terminal, soutput, kernel, support, crc;

function GetPage: boolean;
var
  i,j:  word;
  s:    string;
begin
  for i := 0 to wPAGE_SIZE - 1 do begin
    if i mod 16 = 0 then s := IntToHex(i,4) + '    ';
    s := s + IntToHex(Pop,2) + ' ';
    if i mod 16 = 15 then begin AddInfo(s); s := ''; end;
  end;
  AddInfo(s);

  AddInfo('заводской номер   '  + IntToStr(mpbIn[bHEADER + wFREEPAGE_SIZE + 0]*$100 + mpbIn[bHEADER + wFREEPAGE_SIZE + 1]));
  AddInfo('номер страницы    '  + IntToStr(mpbIn[bHEADER + wFREEPAGE_SIZE + 2]*$100 + mpbIn[bHEADER + wFREEPAGE_SIZE + 3]));

  s := Int2Str(mpbIn[bHEADER + wFREEPAGE_SIZE + 6],2) + ':' +
       Int2Str(mpbIn[bHEADER + wFREEPAGE_SIZE + 5],2) + ':' +
       Int2Str(mpbIn[bHEADER + wFREEPAGE_SIZE + 4],2) + ' ' +
       Int2Str(mpbIn[bHEADER + wFREEPAGE_SIZE + 7],2) + '.' +
       Int2Str(mpbIn[bHEADER + wFREEPAGE_SIZE + 8],2) + '.' +
       Int2Str(mpbIn[bHEADER + wFREEPAGE_SIZE + 9],2);

  AddInfo('время             '  + s);

  j := CRC16_Offset(mpbIn,bHEADER,wPAGE_SIZE);
  AddInfo('CRC страницы      0x' + IntToHex(j, 4));

  if (j <> 0) and (j <> $3E83) and (j <> $707F) then begin
    Result := False;
  end
  else begin
    Result := True;
  end;
end;

end.
