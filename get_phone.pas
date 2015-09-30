unit get_phone;

interface

uses kernel;

procedure BoxGetPhone;
procedure ShowGetPhone;

var
  mpPhones:     array[0..CANALS-1] of String;

implementation

uses SysUtils, soutput, support, borders, progress, box;

const  
  quGetPhone:   querys = (Action: acGetPhone;     
                          cwOut: 7+2;   
                          cwIn: 5+NUMBERS+2;    
                          bNumber: $FF);
var
  bCan:      byte;
    
procedure QueryGetPhone;
begin
  InitPushCRC;
  Push(1);
  Push(bCan);
  Query(quGetPhone);
end;

procedure BoxGetPhone;
begin
  if TestCanals then begin
    AddInfo('');    
    AddInfo('Телефоны');
    
    bCan := MinCan;
    QueryGetPhone;
  end;
end;

procedure ShowGetPhone;
var
  Can,x,i:  word;
  s:      string;
begin
  Stop;
  InitPopCRC;

  s := ' ';
  for x := 1 to NUMBERS do begin
    i := Pop;
    if Chr(i) in ['0'..'9','a'..'z','A'..'Z'] then
      s := s + Chr(i)
    else
      s := s + ' ';
  end;
  mpPhones[bCan] := s;

  ShowProgress(bCan-MinCan, MaxCan-MinCan+1);  
  
  Inc(bCan);
  while (bCan <= MaxCan) and (not CanalChecked(bCan)) do begin
    Inc(bCan);
    if bCan >= MaxCan then break;
  end;
  
  if bCan <= MaxCan then begin
    QueryGetPhone
  end  
  else begin
    for Can := 0 to CANALS-1 do if CanalChecked(Can) then begin
      s := PackStrR('телефон '+IntToStr(Can+1),GetColWidth) + mpPhones[Can];
      AddInfo(s);
    end;

    RunBox;
  end;
end;

end.
