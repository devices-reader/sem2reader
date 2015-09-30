unit get_contacts3;

interface

procedure BoxGetContacts3;
procedure ShowGetContacts3;

implementation

uses SysUtils, support, soutput, realz, box;

const
  quGetContacts3: querys = (Action: acGetContacts3; 
                            cwOut: 7+1;   
                            cwIn: 5+22+2;   
                            bNumber: $FF);

procedure QueryGetContacts3;
begin
  InitPushCRC;
  Push(39);
  Query(quGetContacts3);
end;

procedure BoxGetContacts3;
begin
  QueryGetContacts3;
end;

procedure ShowGetContacts3;
begin
  Stop;
  InitPopCRC;

  AddInfo('');    
  AddInfo('Статистика реле (режим 3)');
    
  AddInfo('Уровнень включения реле 1: '+Reals2Str(PopReals));
  AddInfo('Текущее значение:          '+Reals2Str(PopReals));
  AddInfo('Последнее значение:        '+Reals2Str(PopReals));
  AddInfo('Уровнень включения реле 2: '+Reals2Str(PopReals));
  AddInfo('Величина таймаута (*3 мин.): ' + IntToStr(Pop) + ' - ' + IntToStr(Pop));
  AddInfo('Состояние реле 1: ' + PopSwitch2Str);
  AddInfo('Состояние реле 2: ' + PopSwitch2Str);
  AddInfo('Дополнительные параметры: ' + IntToStr(Pop) + ' - ' + IntToStr(Pop));
    
  RunBox;
end;

end.
