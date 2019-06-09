unit get_echo_n_to_1;

interface

procedure BoxGetEchoNto1;
procedure ShowGetEchoNto1;

var
  wEchoNto1: word;

implementation

uses SysUtils, soutput, support, borders, progress, box, main, terminal;

const
  quGetEchoNto1: querys = (Action: acGetEchoNto1; cwOut: 0; cwIn: 7+2; bNumber: 252);

procedure QueryGetEchoNto1;
var
  i: word;
begin
  InitPushCRC;
  Push(29);

  for i := 1 to wEchoNto1 do
    Push($55);

  Query(quGetEchoNto1);
end;

procedure BoxGetEchoNto1;
begin
  with frmMain do begin
    AddInfo('');
    AddInfo('Проверка канала связи N к 1');

    wEchoNto1 := updEchoFrom.Position;
    QueryGetEchoNto1;
  end;
end;

procedure ShowGetEchoNto1;
begin
  with frmMain do begin
    Stop;

    ShowProgress(wEchoNto1, updEchoTo.Position);
    AddInfo(PackStrL(IntToStr(wEchoNto1),4)+ ' байт ' + PackStrL(IntToStr(dwTerminalTimeout),8) + ' мсек');

    wEchoNto1 := wEchoNto1 + updEchoStep.Position;

    if wEchoNto1 <= updEchoTo.Position then begin
      if updEchoDelay.Position > 0 then
        Delay(updEchoDelay.Position);

      QueryGetEchoNto1
    end
    else
      BoxRun;
  end;
end;

end.
