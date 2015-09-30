unit get_engfrac2;

interface

procedure BoxGetEngFrac2;
procedure ShowGetEngFrac2;

implementation

uses SysUtils, soutput, support, box, realz;

const
  quGetEngFrac2:   querys = (Action: acGetEngFrac2; cwOut: 7+1; cwIn: 5+64*4+2; bNumber: $FF);

procedure QueryGetEngFrac2;
begin
  InitPushCRC;
  Push(133);
  Query(quGetEngFrac2);
end;

procedure BoxGetEngFrac2;
begin
  QueryGetEngFrac2;
end;

procedure ShowGetEngFrac2;
var
  Dig: byte;
  s: string;
begin
  Stop;
  InitPop(5);

  AddInfo('');
  AddInfo('Cтатистика обработки чисел в формате с плавающей запятой 2');

  AddInfo('');
  for Dig := 1 to 64 do begin
    s := PackStrR('канал ' + IntToStr(Dig),GetColWidth);
    s := s + Reals2StrR(PopReals);
    AddInfo(s);
  end;

  BoxRun;
end;

end.
