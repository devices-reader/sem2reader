unit get_memory3;

interface

procedure BoxGetXBYTE;
procedure BoxGetFVAR;
procedure BoxGetCBYTE;
procedure BoxGetFCVAR;

procedure ShowGetXBYTE;
procedure ShowGetFVAR;
procedure ShowGetCBYTE;
procedure ShowGetFCVAR;

var
  dwMemAddr: longword;
  wMemSize: word;

implementation

uses SysUtils, soutput, support, progress, box, kernel, main;

const
  quGetXBYTE: querys = (Action: acGetXBYTE; cwOut: 6+4+2+2; cwIn: 0; bNumber: $FF);
  quGetFVAR:  querys = (Action: acGetFVAR;  cwOut: 6+4+2+2; cwIn: 0; bNumber: $FF);
  quGetCBYTE: querys = (Action: acGetCBYTE; cwOut: 6+4+2+2; cwIn: 0; bNumber: $FF);
  quGetFCVAR: querys = (Action: acGetFCVAR; cwOut: 6+4+2+2; cwIn: 0; bNumber: $FF);

function GetMemAddr: longword;
begin
  dwMemAddr := StrToIntDef(frmMain.edtMemAddr.Text,-1);
  if dwMemAddr < 0 then begin ErrBox('Адрес задан неправильно'); Abort; end;
  AddInfo('адрес:      0x' + IntToHex(dwMemAddr, 8));
  Result := dwMemAddr;
end;

function GetMemSize: word;
begin
  wMemSize := StrToIntDef(frmMain.edtMemSize.Text,-1);
  if wMemSize < 0 then begin ErrBox('Длина задана неправильно'); Abort; end;
  AddInfo('длина:      ' + IntToStr(wMemSize));
  Result := wMemSize;
end;

procedure BoxGetXBYTE;
begin
  AddInfo('*Чтение памяти 1');
  AddInfo('');

  InitPushCRC;
  Push(129);
  PushLong(GetMemAddr);
  PushInt(GetMemSize);
  Query(quGetXBYTE);

  AddInfo('');
end;

procedure BoxGetFVAR;
begin
  AddInfo('*Чтение памяти 2');
  AddInfo('');

  InitPushCRC;
  Push(130);
  PushLong(GetMemAddr);
  PushInt(GetMemSize);
  Query(quGetFVAR);

  AddInfo('');
end;

procedure BoxGetCBYTE;
begin
  AddInfo('*Чтение памяти 3');
  AddInfo('');

  InitPushCRC;
  Push(131);
  PushLong(GetMemAddr);
  PushInt(GetMemSize);
  Query(quGetCBYTE);

  AddInfo('');
end;

procedure BoxGetFCVAR;
begin
  AddInfo('*Чтение памяти 4');
  AddInfo('');

  InitPushCRC;
  Push(132);
  PushLong(GetMemAddr);
  PushInt(GetMemSize);
  Query(quGetFCVAR);

  AddInfo('');
end;

procedure Show;
var
i: word;
s: string;
begin
  Stop;
  InitPop(5);

  s := '';
  for i := 0 to wMemSize-1 do begin
    if i mod 16 = 0 then s := IntToHex(dwMemAddr + i,8) + '    ';
    s := s + IntToHex(Pop,2) + ' ';
    if i mod 16 = 15 then begin AddInfo(s); s := ''; end;
  end;
  AddInfo(s);

  BoxRun;
end;

procedure ShowGetXBYTE;
begin
  Show;
end;

procedure ShowGetFVAR;
begin
  Show;
end;

procedure ShowGetCBYTE;
begin
  Show;
end;

procedure ShowGetFCVAR;
begin
  Show;
end;

end.
