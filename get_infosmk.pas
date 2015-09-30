unit get_infosmk;

interface

procedure BoxGetInfoSMK;
procedure ShowGetInfoSMK;

implementation

uses SysUtils, support, soutput, timez, box;

const
  quGetInfoSMK:   querys = (Action: acGetInfoSMK;   
                            cwOut: 7+3+19;  
                            cwIn: 5+11+2;   
                            bNumber: $AC);  

procedure BoxGetInfoSMK;
begin
  AddInfo('');    
  AddInfo('Информация с устройства СИМЭК-48');
  
  InitPushCRC;
  Push(GetTunnelIndex);
  Push((11) mod $100);
  Push((11) div $100);
  
  Push($16); 
  Push($16); 
  Push($04); 
  Push($16); 
  Push($16); 
  Push($01); 
  Push($07); 
  Push($00); 
  Push($00); 
  Push($00); 
  Push($00); 
  Push($00); 
  Push($00); 
  Push($00); 
  Push($00); 
  Push($10);
  Push($05); 
  Push($22);
  Push($0C);

  Query(quGetInfoSMK);
end;

function PopTimesSMK: times;
begin
  InitPop(5+1);
  with Result do begin    
    bYear   := FromBCD(Pop);
    bMonth  := FromBCD(Pop);
    bDay    := FromBCD(Pop);
               FromBCD(Pop);    
    bHour   := FromBCD(Pop);
    bMinute := FromBCD(Pop);
    bSecond := FromBCD(Pop);
  end;
end;

procedure ShowGetInfoSMK;
var
  i:  byte;
  s:  string;
begin
  Stop;
  InitPopCRC;

  s := 'Дамп:      ';
  for i := 0 to 11-1 do begin 
    s := s + IntToHex(Pop,2) + ' ';
  end;      
  AddInfo(s);
    
  AddInfo('Время:     '+Times2Str(PopTimesSMK));
    
  RunBox;
end;

end.
