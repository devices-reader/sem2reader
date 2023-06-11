unit get_correct21;

interface

procedure BoxGetCorrect21;
procedure ShowGetCorrect21;

implementation

uses SysUtils, soutput, kernel, support, timez, box;

const
  quGetCorrect21:   querys = (Action: acGetCorrect21;   
                            cwOut: 7+1;   
                            cwIn: 5+100+2;  
                            bNumber: $FF);  

procedure QueryGetCorrect21;
begin
  InitPushCRC;
  Push(57);
  Query(quGetCorrect21);
end;

procedure BoxGetCorrect21;
begin
  AddInfo('');
  AddInfo('Статистика запрета коррекции времени');
  
  QueryGetCorrect21;
end;  

procedure ShowGetCorrect21;
var
  i:  byte;
  s:  string;
begin
  Stop;

  InitPopCRC;
  AddInfo('');      
  AddInfo(PackStrR('Режим:',2*GetColWidth)+PopBool2Str);    

  s := '';
  for i := 1 to 10 do s := s + IntToHex(Pop,2) + ' ';
  AddInfo(PackStrR('Буфер:',2*GetColWidth)+s);

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
    s := s + IntToStr(PopIntBig);
    AddInfo(s);  
  end;  

  AddInfo('');      
  AddInfo('Статистика запроса коррекции 0xFF 0x38');
  AddInfo(PackStrR('всего запросов:',3*GetColWidth)+IntToStr(PopLong));    
  AddInfo(PackStrR('разрешение по запрету режима:',3*GetColWidth)+IntToStr(PopLong));    
  AddInfo(PackStrR('разрешение по специальному доступу:',3*GetColWidth)+IntToStr(PopLong));    
  AddInfo(PackStrR('разрешение по паролю:',3*GetColWidth)+IntToStr(PopLong));    
  AddInfo(PackStrR('запрещение по паролю:',3*GetColWidth)+IntToStr(PopLong));    
    
  RunBox;
end;

end.
