unit get_bulk;

interface

procedure BoxGetBulk;
procedure ShowGetBulk;

implementation

uses SysUtils, soutput, support, box;

const
  quGetBulk:   querys = (Action: acGetBulk; cwOut: 7+1; cwIn: 5+1+1+4*1+2+4*2+4*1+4*1+2; bNumber: $FF);

procedure QueryGetBulk;
begin
  InitPushCRC;
  Push(107);
  Query(quGetBulk);
end;

procedure BoxGetBulk;
begin
  QueryGetBulk;
end;

procedure ShowGetBulk;
begin
  Stop;
  InitPop(5);

  AddInfo('');
  AddInfo('Cтатистика пакетного режима');
  AddInfo('флаг:                      ' + Bool2Str(Pop));
  AddInfo('размер пакета:             ' + IntToStr(Pop));
  AddInfo('счетчики размера пакета:   ' + IntToStr(Pop)+' '+IntToStr(Pop)+' '+IntToStr(Pop)+' '+IntToStr(Pop));
  AddInfo('таймаут пакета:            ' + IntToStr(PopIntBig));
  AddInfo('счетчики таймаута пакета:  ' + IntToStr(PopIntBig)+' '+IntToStr(PopIntBig)+' '+IntToStr(PopIntBig)+' '+IntToStr(PopIntBig));
  AddInfo('статус портов текущий:     ' + IntToStr(Pop)+' '+IntToStr(Pop)+' '+IntToStr(Pop)+' '+IntToStr(Pop));
  AddInfo('статус портов сохраненный: ' + IntToStr(Pop)+' '+IntToStr(Pop)+' '+IntToStr(Pop)+' '+IntToStr(Pop));

  BoxRun;
end;

end.
