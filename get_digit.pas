unit get_digit;

interface

uses kernel;

procedure BoxGetDigit;
procedure ShowGetDigit;

var
  mpDigits:     array[0..CANALS-1] of digit;

implementation

uses SysUtils, soutput, support, borders, progress, box;

const  
  quGetDigit:   querys = (Action: acGetDigit;     
                          cwOut: 7+1;   
                          cwIn: 5+5+2;    
                          bNumber: 42);
var
  bCan:      byte;
    
procedure QueryGetDigit;
begin
  InitPushCRC;
  Push(bCan);
  if PushCanMask then Query(quGetDigit);  // ???
end;

procedure BoxGetDigit;
begin
  if TestCanals then begin
    AddInfo('');    
    AddInfo('Цифровые счетчики');
    
    bCan := MinCan;
    QueryGetDigit;
  end;
end;

procedure ShowGetDigit;
var
  Can:  word;
  s:    string;
begin
  Stop;
  InitPopCRC;

  with mpDigits[bCan] do begin
    ibPort   := Pop;
    ibPhone  := Pop;
    bDevice  := Pop;
    bAddress := Pop;
    ibLine   := Pop;
    boActive := not((ibPhone > 0) or (bDevice = 0));
  end;

  ShowProgress(bCan-MinCan, MaxCan-MinCan+1);  
  
  Inc(bCan);
  while (bCan <= MaxCan) and (not CanalChecked(bCan)) do begin
    Inc(bCan);
    if bCan >= MaxCan then break;
  end;
  
  if bCan <= MaxCan then begin
    QueryGetDigit;
  end
  else begin
    for Can := 0 to CANALS-1 do if CanalChecked(Can) then with mpDigits[Can] do begin
      s := PackStrR('канал '+IntToStr(Can+1),GetColWidth);
      if (ibPort = 0) and (ibPhone = 0) and (bDevice = 0) and (bAddress = 0) and (ibLine = 0) then
        s := s + 'нет'
      else
        s := s + Int2Str(ibPort+1)+'.'+
                 Int2Str(ibPhone)+'.'+
                 Int2Str(bDevice)+'.'+
                 Int2Str(bAddress,3)+'.'+
                 Int2Str(ibLine+1)+'  '+
                 GetDeviceName(bDevice);
      AddInfo(s);
    end;

    RunBox;
  end;
end;

end.
