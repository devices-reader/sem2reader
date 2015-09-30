unit get_correct3;

interface

procedure BoxGetCorrect3;
procedure ShowGetCorrect3;

implementation

uses SysUtils, soutput, kernel, support, timez, box;

const
  quGetCorrect3:   querys = (Action: acGetCorrect3; cwOut: 7+1; cwIn: 5+100+2; bNumber: $FF);  

procedure QueryGetCorrect3;
begin
  InitPushCRC;
  Push(59);
  Query(quGetCorrect3);
end;

procedure BoxGetCorrect3;
begin
  AddInfo('');
  AddInfo('Статистика ограничения коррекции времени при использовании часов GPS');
  
  QueryGetCorrect3;
end;  

procedure ShowGetCorrect3;
var
  i:  byte;
  s:  string;
begin
  Stop;

  InitPopCRC;
  AddInfo('');      
  AddInfo(PackStrR('режим GPS:',GetColWidth*5)+PopBool2Str);    
  AddInfo(PackStrR('режим коррекции времени с учетом состояния GPS:',GetColWidth*5)+PopBool2Str);    

  AddInfo(PackStrR('общее количество попыток коррекций:',GetColWidth*5)+IntToStr(PopLong));    
  AddInfo(PackStrR('количество последовательных положительных коррекций:',GetColWidth*5)+IntToStr(PopLong));    
  AddInfo(PackStrR('предельное количество положительных коррекций:',GetColWidth*5)+IntToStr(Pop));    

  AddInfo(PackStrR('время последней успешной коррекции GPS:',GetColWidth*5)+PopTimes2Str);    
  AddInfo(PackStrR('время последней неудачной коррекции GPS:',GetColWidth*5)+PopTimes2Str);    
  
  AddInfo(PackStrR('запрет коррекции времени:',GetColWidth*5)+PopBool2Str);    

  AddInfo('');      
  AddInfo('Статистика отказов коррекции');
  for i := 0 to 15-1 do begin
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
      else s := '-'
    end;
      
    s := PackStrR(s,2*GetColWidth);
    s := s + IntToStr(PopInt);
    AddInfo(s);  
  end;  
    
  RunBox;
end;

end.
