unit get_extended43;

interface

uses kernel;

procedure BoxGetExt43;
procedure ShowGetExt43;

var
  mpDigitsEnbl: array[0..CANALS-1] of word;

implementation

uses SysUtils, soutput, support, progress, box, borders;

const  
  quGetExt43:   querys = (Action: acGetExt43; cwOut: 7+9; cwIn: 0; bNumber: $FF);
    
procedure QueryGetExt43;
begin
  InitPushCRC;
  Push(61);
  if PushCanMask then Query(quGetExt43);
end;

procedure BoxGetExt43;
begin
  if TestCanals then begin
    AddInfo('');    
    AddInfo('—писок разрешенных каналов при чтении значений счЄтчиков по мес€цам');
    
    QueryGetExt43;
  end;
end;

procedure ShowGetExt43;
var
  Can:  word;
  s:    string;
begin
  Stop;
  InitPop(15);

  for Can := 0 to CANALS-1 do if CanalChecked(Can) then begin
    mpDigitsEnbl[Can] := Pop;
    s := PackStrR('канал '+IntToStr(Can+1),GetColWidth);
    s := s + Bool2Str(mpDigitsEnbl[Can]);
    AddInfo(s);
  end;

  RunBox;
end;

end.
