unit get_infogps;

interface

procedure BoxGetInfoGPS;
procedure ShowGetInfoGPS;

implementation

uses SysUtils, support, soutput, timez, box;

const
  quGetInfoGPS:   querys = (Action: acGetInfoGPS;   
                            cwOut: 7+10;  
                            cwIn: 5+22+2;   
                            bNumber: $AC);  

procedure BoxGetInfoGPS;
begin
  AddInfo('');    
  AddInfo('Информация с устройства GPS');
  
  InitPushCRC;
  Push(GetTunnelIndex);
  Push((5+15+2) mod $100);
  Push((5+15+2) div $100);
  
  Push($D0);
  Push($0D);
  Push(7);
  Push(0);
  Push(1);
  Push($97);
  Push($7F);

  Query(quGetInfoGPS);
end;
  
function GetStatus2Str: string;
var
  i:  byte;
begin
  i := Pop();
  case i of
    0:  Result := 'нормальная работа';
    1:  Result := 'антенна не подключена или спутники вне зоны видимости';
    2:  Result := 'модуль GPS не запрограммирован';
    3:  Result := 'некорректные данные с модуля GPS';
    4:  Result := 'недостаточно точные данные с модуля GPS';
    else  Result := '?';
  end;
  Result := IntToStr(i) + ' - ' + Result;
end;

procedure ShowGetInfoGPS;
var
  i:  byte;
  s:  string;
begin
  Stop;
  InitPopCRC;

  s := 'Дамп:      ';
  for i := 0 to 22-1 do begin 
    s := s + IntToHex(Pop,2) + ' ';
    if i in [4,19] then s := s + '- ';
  end;      
  AddInfo(s);
    
  InitPop(10);
  AddInfo('Состояние: '+GetStatus2Str);
  AddInfo('Время:     '+PopTimes2Str);
    
  RunBox;
end;

end.
