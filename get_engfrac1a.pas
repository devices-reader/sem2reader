unit get_engfrac1a;

interface

procedure BoxGetEngFrac1a;
procedure ShowGetEngFrac1a;

implementation

uses SysUtils, soutput, support, box, realz;

const
  quGetEngFrac1a:   querys = (Action: acGetEngFrac1a; cwOut: 7+1; cwIn: 5+64*6*4+2; bNumber: $FF);

procedure QueryGetEngFrac1a;
begin
  InitPushCRC;
  Push(110);
  Query(quGetEngFrac1a);
end;

procedure BoxGetEngFrac1a;
begin
  QueryGetEngFrac1a;
end;

procedure ShowGetEngFrac1a;
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
