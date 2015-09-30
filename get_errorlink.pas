unit get_errorlink;

interface

procedure BoxGetErrorLink;
procedure ShowGetErrorLink;

implementation

uses SysUtils, soutput, support, box, realz;

const
  quGetErrorLink:   querys = (Action: acGetErrorLink; cwOut: 7+1; cwIn: 5+64*2+2; bNumber: $FF);

procedure QueryGetErrorLink;
begin
  InitPushCRC;
  Push(134);
  Query(quGetErrorLink);
end;

procedure BoxGetErrorLink;
begin
  QueryGetErrorLink;
end;

procedure ShowGetErrorLink;
var
  Dig: byte;
  s: string;
begin
  Stop;
  InitPop(5);

  AddInfo('');
  AddInfo('Cтатистика распознанных ошибок связи');

  AddInfo('');
  for Dig := 1 to 64 do begin
    s := PackStrR('канал ' + IntToStr(Dig),GetColWidth);
    s := s + PackStrR(IntToStr(PopInt),GetColWidth);
    AddInfo(s);
  end;

  BoxRun;
end;

end.
