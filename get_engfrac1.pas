unit get_engfrac1;

interface

procedure BoxGetEngFrac1;
procedure ShowGetEngFrac1;

implementation

uses SysUtils, soutput, support, box, realz;

const
  quGetEngFrac1:   querys = (Action: acGetEngFrac1; cwOut: 7+1; cwIn: 5+64*6*4+2; bNumber: $FF);

procedure QueryGetEngFrac1;
begin
  InitPushCRC;
  Push(110);
  Query(quGetEngFrac1);
end;

procedure BoxGetEngFrac1;
begin
  QueryGetEngFrac1;
end;

procedure ShowGetEngFrac1;
var
  Dig,Can: byte;
  s: string;
begin
  Stop;
  InitPop(5);

  AddInfo('');
  AddInfo('Cтатистика обработки чисел в формате с плавающей запятой 1');

  AddInfo('');
  for Dig := 1 to 64 do begin
    s := PackStrR('канал ' + IntToStr(Dig),GetColWidth);
    for Can := 1 to 6 do begin
      s := s + Reals2StrR(PopReals);
    end;
    AddInfo(s);
  end;

  BoxRun;
end;

end.
