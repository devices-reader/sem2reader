unit get_echo_n_to_n;

interface

procedure BoxGetEchoNtoN;
procedure ShowGetEchoNtoN;

var
  wEchoNtoN: word;

implementation

uses SysUtils, soutput, support, borders, progress, box, main, terminal;

const
  quGetEchoNtoN: querys = (Action: acGetEchoNtoN; cwOut: 0; cwIn: 0; bNumber: 252);

procedure QueryGetEchoNtoN;
var
  i: word;
begin
  InitPushCRC;
  Push(28);

  for i := 1 to wEchoNtoN do
    Push($55);

  Query(quGetEchoNtoN);
end;

procedure BoxGetEchoNtoN;
begin
  with frmMain do begin
    AddInfo('');
    AddInfo('Проверка канала связи N к N');

    wEchoNtoN := updEchoFrom.Position;
    QueryGetEchoNtoN;
  end;
end;

procedure ShowGetEchoNtoN;
begin
  with frmMain do begin
    Stop;

    ShowProgress(wEchoNtoN, updEchoTo.Position);
    AddInfo(PackStrL(IntToStr(wEchoNtoN),4)+ ' байт ' + PackStrL(IntToStr(dwTerminalTimeout),8) + ' мсек');

    wEchoNtoN := wEchoNtoN + updEchoStep.Position;

    if wEchoNtoN <= updEchoTo.Position then begin
      if updEchoDelay.Position > 0 then
        Delay(updEchoDelay.Position);

      QueryGetEchoNtoN
    end
    else
      BoxRun;
  end;
end;

end.
