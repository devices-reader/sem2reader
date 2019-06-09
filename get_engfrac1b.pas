unit get_engfrac1b;

interface

procedure BoxGetEngFrac1b;
procedure ShowGetEngFrac1b;

implementation

uses SysUtils, soutput, support, box, realz;

const
  quGetEngFrac1b:   querys = (Action: acGetEngFrac1b; cwOut: 7+1; cwIn: 5+64*6*8+2; bNumber: $FF);

procedure QueryGetEngFrac1b;
begin
  InitPushCRC;
  Push(110);
  Query(quGetEngFrac1b);
end;

procedure BoxGetEngFrac1b;
begin
  QueryGetEngFrac1b;
end;

procedure ShowGetEngFrac1b;
var
  Dig,Can: byte;
  s: string;
begin
  Stop;
  InitPop(5);

  AddInfo('');
  AddInfo('Cтатистика обработки чисел в формате с плавающей запятой 1 (двойная точность)');

  AddInfo('');
  for Dig := 1 to 64 do begin
    s := PackStrR('канал ' + IntToStr(Dig),GetColWidth);
    for Can := 1 to 6 do begin
      s := s + Double2StrR(PopDouble);
    end;
    AddInfo(s);
  end;

  BoxRun;
end;

end.
