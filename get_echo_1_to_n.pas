unit get_echo_1_to_n;

interface

procedure BoxGetEcho1toN;
procedure ShowGetEcho1toN;

var
  wEcho1toN: word;

implementation

uses SysUtils, soutput, support, borders, progress, box, main, terminal;

const
  quGetEcho1toN: querys = (Action: acGetEcho1toN; cwOut: 7+4; cwIn: 0; bNumber: 252);

procedure QueryGetEcho1toN;
begin
  InitPushCRC;
  Push(30);
  Push($55);
  PushInt(wEcho1toN);
  Query(quGetEcho1toN);
end;

procedure BoxGetEcho1toN;
begin
  with frmMain do begin
    AddInfo('');
    AddInfo('Проверка канала связи 1 к N');

    wEcho1toN := updEchoFrom.Position;
    QueryGetEcho1toN;
  end;
end;

procedure ShowGetEcho1toN;
begin
  with frmMain do begin
    Stop;

    ShowProgress(wEcho1toN, updEchoTo.Position);
    AddInfo(PackStrL(IntToStr(wEcho1toN),4)+ ' байт ' + PackStrL(IntToStr(dwTerminalTimeout),8) + ' мсек');

    wEcho1toN := wEcho1toN + updEchoStep.Position;

    if wEcho1toN <= updEchoTo.Position then begin
      if updEchoDelay.Position > 0 then
        Delay(updEchoDelay.Position);

      QueryGetEcho1toN
    end
    else
      BoxRun;
  end;
end;

end.
