unit get_correct20;

interface

procedure BoxGetCorrect20;
procedure ShowGetCorrect20;

implementation

uses SysUtils, soutput, kernel, support, timez, box;

const
  quGetCorrect20:   querys = (Action: acGetCorrect20;   
                            cwOut: 7+1;   
                            cwIn: 5+101+2;  
                            bNumber: $FF);  

procedure QueryGetCorrect20;
begin
  InitPushCRC;
  Push(51);
  Query(quGetCorrect20);
end;

procedure BoxGetCorrect20;
begin
  AddInfo('');
  AddInfo('Статистика коррекции времени СИМЭК-48');
  
  QueryGetCorrect20;
end;  

procedure ShowGetCorrect20;
var
  i:  byte;
begin
  Stop;
    
  InitPopCRC;
  AddInfo('');    
  AddInfo('Параметры СИМЭК-48');
  AddInfo('Порт: '+IntToStr(Pop));

  AddInfo('');
  AddInfo('График коррекции СИМЭК-48:');
  for i := 1 to 48 do
    AddInfo(PackStrR(IntToStr(i),5)+Int2Str((i div 2))+'.'+Int2Str((i mod 2)*30)+'   '+PopBool2Str);

  AddInfo('');
  AddInfo('Статистика СИМЭК-48:');
  AddInfo(PackStrR(IntToStr(PopIntBig),6) + 'количество требований коррекции');
  AddInfo(PackStrR(IntToStr(PopIntBig),6) + 'количество ошибочных запросов');
  AddInfo(PackStrR(IntToStr(PopIntBig),6) + 'количество успешных запросов');
  AddInfo(PackStrR(IntToStr(PopIntBig),6) + 'количество состояний: ошибка');
  AddInfo(PackStrR(IntToStr(PopIntBig),6) + 'количество состояний: ОК');
  AddInfo(PackStrR(IntToStr(PopIntBig),6) + 'количество ошибок: ошибка формата времени');
  AddInfo(PackStrR(IntToStr(PopIntBig),6) + 'количество ошибок: даты различны');
  AddInfo(PackStrR(IntToStr(PopIntBig),6) + 'количество ошибок: получасы различны');
  AddInfo(PackStrR(IntToStr(PopIntBig),6) + 'количество успешных коррекций: всего');
  AddInfo(PackStrR(IntToStr(PopIntBig),6) + 'количество успешных коррекций: с разницей менее 2 секунд');
  AddInfo(PackStrR(IntToStr(PopIntBig),6) + 'количество успешных коррекций: с разницей менее 5 секунд');
  AddInfo(PackStrR(IntToStr(PopIntBig),6) + 'количество успешных коррекций: с разницей более 5 секунд');
  AddInfo(PackStrR(IntToStr(PopIntBig),6) + 'количество успешных коррекций: с разницей более 1 минуты');
  AddInfo(PackStrR(IntToStr(PopIntBig),6) + 'количество успешных коррекций: с разницей более 10 минут');

  PopIntBig;
  PopIntBig;
  PopIntBig;
  PopIntBig;
  PopIntBig;
  PopIntBig;

  AddInfo('');
  AddInfo('Время до последней коррекции СИМЭК-48:    '+PopTimes2Str);
  AddInfo('Время после последней коррекции СИМЭК-48: '+PopTimes2Str);
    
  RunBox;
end;

end.
