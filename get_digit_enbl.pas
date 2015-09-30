unit get_digit_enbl;

interface

uses kernel;

procedure BoxGetDigitEnbl;
procedure ShowGetDigitEnbl;

var
  mpDigitsEnbl: array[0..CANALS-1] of word;

implementation

uses SysUtils, soutput, support, progress, box, borders;

const  
  quGetDigitEnbl:   querys = (Action: acGetDigitEnbl;     
                          cwOut: 7+9;   
                          cwIn: 0;    
                          bNumber: $FF);
    
procedure QueryGetDigitEnbl;
begin
  InitPushCRC;
  Push(13);
  if PushCanMask then Query(quGetDigitEnbl);
end;

procedure BoxGetDigitEnbl;
begin
  if TestCanals then begin
    AddInfo('');    
    AddInfo('Разрешенные цифровые счетчики');
    
    QueryGetDigitEnbl;
  end;
end;

procedure ShowGetDigitEnbl;
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
