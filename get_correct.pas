unit get_correct;

interface

procedure BoxGetCorrect;
procedure ShowGetCorrect;

implementation

uses SysUtils, soutput, kernel, support, timez, box;

const
  quGetCorrect:   querys = (Action: acGetCorrect;   
                            cwOut: 7+1;   
                            cwIn: 5+347+2;  
                            bNumber: $FF);  
  
  CORRECT_SIZE  = 15;
  
var
  mpcwPos,
  mpcwNeg,
  mpcwPosCount,
  mpcwNegCount:   array[0..CORRECT_SIZE-1] of word;

procedure QueryGetCorrect;
begin
  InitPushCRC;
  Push(31);
  Query(quGetCorrect);
end;

procedure BoxGetCorrect;
begin
  AddInfo('');
  AddInfo('Статистика коррекции времени');
  
  QueryGetCorrect;
end;
  
procedure ShowCorrectMonth;
var
  i:  byte;
  s:  string;    
begin
  for i := 0 to CORRECT_SIZE-1 do mpcwPos[i] := PopIntBig;
  for i := 0 to CORRECT_SIZE-1 do mpcwNeg[i] := PopIntBig;
  for i := 0 to CORRECT_SIZE-1 do mpcwPosCount[i] := PopIntBig;
  for i := 0 to CORRECT_SIZE-1 do mpcwNegCount[i] := PopIntBig;

  for i := 0 to CORRECT_SIZE-1 do begin
    case i of
      0: s := 'всего';
      1: s := 'часы GPS';
      2: s := 'клавиатура';
      3: s := 'запрос 0xFF 0x0B';
      4: s := 'запрос Esc K';
      5: s := 'запрос Esc k';
      6: s := 'запрос 0x0B';
      7: s := 'запрос 0x0C';
      8: s := 'запрос 0xEE';
      9: s := 'часы СИМЭК-48';
      else break;
    end;
      
    s := PackStrR(s,20);
    s := s + PackStrR('+'+Int2Str(mpcwPos[i] div 60)+':'+ Int2Str(mpcwPos[i] mod 60),8)+
             PackStrR('+'+IntToStr(mpcwPos[i]),8);
               
    s := s + PackStrR(IntToStr(mpcwPosCount[i]),6);
      
    s := s + PackStrR('-'+Int2Str(mpcwNeg[i] div 60)+':'+ Int2Str(mpcwNeg[i] mod 60),8)+
             PackStrR('-'+IntToStr(mpcwNeg[i]),8);
               
    s := s + PackStrR(IntToStr(mpcwNegCount[i]),6);
    AddInfo(s);  
  end;
end;

procedure ShowGetCorrect;
var
  i:  byte;
begin
  Stop;
    
  InitPopCRC;
  AddInfo('');    
  AddInfo('Параметры GPS');
  AddInfo('Порт: '+IntToStr(Pop));
  AddInfo('Последний прочитанный статус: '+IntToStr(Pop));
  AddInfo('Последний прочитанная версия: '+IntToStr(Pop)+'.'+IntToStr(Pop));
  AddInfo('Часовой пояс: '+IntToStr(Pop));

  AddInfo('');
  AddInfo('График коррекции GPS:');
  for i := 1 to 48 do
    AddInfo(PackStrR(IntToStr(i),5)+Int2Str((i div 2))+'.'+Int2Str((i mod 2)*30)+'   '+PopBool2Str);

  AddInfo('');
  AddInfo('Статистика GPS:');
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
  AddInfo('Время до последней коррекции GPS:    '+PopTimes2Str);
  AddInfo('Время после последней коррекции GPS: '+PopTimes2Str);
    
  AddInfo('');
  AddInfo('Коррекции за текущий месяц:');
  ShowCorrectMonth;
  AddInfo('');
  AddInfo('Коррекции за предыдущий месяц:');
  ShowCorrectMonth;

  AddInfo('');
  AddInfo('Сезонное время GPS (1: зимнее время, 0: летнее время): '+IntToStr(Pop));
  AddInfo('Признак добавления одного часа в летнее время GPS:     '+PopBool2Str);
    
  RunBox;
end;

end.
