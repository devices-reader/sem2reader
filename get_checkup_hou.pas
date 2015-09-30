unit get_checkup_hou;

interface

function InfoGetCheckupHou: string;
procedure BoxGetCheckupHou;
procedure ShowGetCheckupHou;

implementation

uses SysUtils, kernel, soutput, support, borders, progress, box;

const
  quGetCheckupHou:   querys = (Action: acGetCheckupHou; cwOut: 7+1; cwIn: 5+48+2; bNumber: $FF);

function InfoGetCheckupHou: string;
begin
  Result := 'график проверки достоверности';
end;

procedure QueryGetCheckupHou;
begin
  InitPushCRC;
  Push(122);
  Query(quGetCheckupHou);
end;

procedure BoxGetCheckupHou;
begin
  if TestCanals then begin
    AddInfo('');
    AddInfo('График проверки достоверности');

    QueryGetCheckupHou;
  end;
end;

procedure ShowGetCheckupHou;
var
  Hou:  byte;
  s:    string;
begin
  Stop;
  InitPop(5);

  for Hou := 0 to 48-1 do begin
    s := PackStrR(Int2Str(Hou div 2)+':'+Int2Str((Hou mod 2)*30),GetColWidth);
    s := s + Bool2Str(Pop);
    AddInfo(s);
  end;

  RunBox;
end;

end.
