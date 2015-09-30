unit get_phone2;

interface

uses kernel;

procedure BoxGetPhone2;
procedure ShowGetPhone2;

implementation

uses SysUtils, soutput, support, progress, realz, timez, box;

const  
  quGetPhone2:   querys = (Action: acGetPhone2; cwOut: 7+2; cwIn: 5+400+2; bNumber: $FF);

  mpCode:        array[1..10] of string =
  (
    'резерв',
    'успешно',
    'отбой с клавиатуры',
    'сбой модема',
    'сбой установки режима',
    'сбой подготовки сообщения',
    'сбой отправки сообщения ',
    'резерв',
    'резерв',
    'неизвестный сбой'
  );
  
procedure QueryGetPhone2;
begin
  InitPushCRC;
  Push(54);
  Query(quGetPhone2);
end;

procedure BoxGetPhone2;
begin
  QueryGetPhone2;
end;

function PopPhone2(bSize: byte): string;
var
  i,j:  byte;
  s:  string;
begin
  Result := ''; s:='';
  for  i := 1 to bSize do begin
    j := Pop;
    s := s + IntToHex(j,2) + ' ';
    if j > $20 then
      Result := Result + Chr(j)
    else if j > 0 then
      Result := Result + '_'
    else  
      Result := Result + ' ';
  end;
  Result := '"' + Result + '"  ' + s;
end;
  
procedure ShowGetPhone2;
var
  i:  byte;
begin
  Stop;
  InitPopCRC;

  AddInfo('');    
  AddInfo('');    
  AddInfo('Статистика СМС-контроля');
  
  AddInfo('');    
  AddInfo(PackStrR('полная индикация:', 3*GetColWidth) + PopBool2Str);
  AddInfo(PackStrR('включение режима:', 3*GetColWidth) + IntToStr(Pop) + ' (1 - да, 0 - нет)');
  
  AddInfo('');    
  AddInfo(PackStrR('порт:', 3*GetColWidth) + IntToStr(Pop));
  AddInfo(PackStrR('значение мощности:', 3*GetColWidth) + Reals2Str(PopReals));
  AddInfo(PackStrR('лимит мощности:', 3*GetColWidth) + Reals2Str(PopReals));
  AddInfo(PackStrR('телефон 1:', 3*GetColWidth) + PopPhone2(NUMBERS));
  AddInfo(PackStrR('телефон 2:', 3*GetColWidth) + PopPhone2(NUMBERS));
  AddInfo(PackStrR('телефон 3:', 3*GetColWidth) + PopPhone2(NUMBERS));
  AddInfo(PackStrR('телефон 4:', 3*GetColWidth) + PopPhone2(NUMBERS));
  AddInfo(PackStrR('флаг режима:', 3*GetColWidth) + IntToStr(Pop));
  AddInfo(PackStrR('таймаут:', 3*GetColWidth) + IntToStr(Pop));

  AddInfo('');      
  AddInfo(PackStrR('ответ при подготовке сообщения:',3*GetColWidth) + PopPhone2(50));
  AddInfo(PackStrR('ответ при отправке сообщения:',3*GetColWidth) + PopPhone2(50));

  AddInfo('');      
  for i := 1 to 10 do
    AddInfo(PackStrR(mpCode[i],3*GetColWidth) + PackStrR(IntToStr(PopInt),GetColWidth) + PopTimes2Str);

  AddInfo('');      
  AddInfo(PackStrR('буфер подготовки событий:',3*GetColWidth) + PopPhone2(8));

  AddInfo('');      
  AddInfo(PackStrR('счетчик включения режима',3*GetColWidth) + IntToStr(PopLong));
  AddInfo(PackStrR('счетчик пиковых тарифов',3*GetColWidth) + IntToStr(PopLong));
  AddInfo(PackStrR('счетчик непиковых тарифов',3*GetColWidth) + IntToStr(PopLong));
  AddInfo(PackStrR('счетчик превышения мощности',3*GetColWidth) + IntToStr(PopLong));
  AddInfo(PackStrR('счетчик непревышения мощности',3*GetColWidth) + IntToStr(PopLong));
  AddInfo(PackStrR('счетчик успешной отправки',3*GetColWidth) + IntToStr(PopLong));
       
  RunBox;
end;

end.
