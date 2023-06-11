unit get_port;

interface

uses kernel;

procedure BoxGetPort;
procedure ShowGetPort;

implementation

uses SysUtils, soutput, support, box, timez;

const  
  quGetPort:   querys = (Action: acGetPort; cwOut: 7+1; cwIn: 100+7; bNumber: $FF);
    
procedure QueryGetPort;
begin
  InitPushCRC;
  Push(55);
  Query(quGetPort);
end;

procedure BoxGetPort;
begin
  QueryGetPort;
end;

function GetIOMode(b: byte): string;
begin
  if b = 0 then Result := 'in (прием)' else Result := 'out (передача)';
end;

function GetIOControl(b: byte): string;
begin
  if b = 0 then Result := 'нет' else Result := 'через ' + IntToStr(b) + ' получас(ов)';
end;

procedure ShowGetPort;
var
  Prt:  byte;
  s:    string;
  Ver:  byte;
  a:    byte;
begin
  Stop;
  InitPopCRC;

  AddInfo('');    
  AddInfo('');    
  AddInfo('Порты');

  AddInfo('');    
  AddInfo('Настройки (скорость/четность/режим)');
  for Prt := 1 to 4 do begin
    s := PackStrR('порт '+IntToStr(Prt),GetColWidth);
    s := s + IntToStr(Pop)+'.'+IntToStr(Pop)+'.'+IntToStr(Pop);
    AddInfo(s);
  end;  

  AddInfo('');    
  AddInfo('Таймауты P98 (счетчик/время)');
  for Prt := 1 to 4 do begin
    s := PackStrR('порт '+IntToStr(Prt),GetColWidth);
    s := s + PackStrR(IntToStr(PopIntBig),GetColWidth);
    s := s + IntToStr(PopLong);
    AddInfo(s);
  end;

  AddInfo('');    
  AddInfo('Таймауты P97 (счетчик/время)');
  for Prt := 1 to 4 do begin
    s := PackStrR('порт '+IntToStr(Prt),GetColWidth);
    s := s + PackStrR(IntToStr(PopIntBig),GetColWidth);
    s := s + IntToStr(PopLong);
    AddInfo(s);
  end;

  AddInfo('');    
  AddInfo('Текущее состояние');
  for Prt := 1 to 4 do begin
    s := PackStrR('порт '+IntToStr(Prt),GetColWidth) + IntToStr(Pop);
    AddInfo(s);
  end;  

  AddInfo('');    
  AddInfo('Локальный режим ведущих портов');
  for Prt := 1 to 4 do begin
    s := PackStrR('порт '+IntToStr(Prt),GetColWidth) + PopBool2Str;
    AddInfo(s);
  end;  

  AddInfo('');    
  AddInfo('Запрещение локального режима ведущих портов');
  for Prt := 1 to 4 do begin
    s := PackStrR('порт '+IntToStr(Prt),GetColWidth) + PopBool2Str;
    AddInfo(s);
  end;

  AddInfo('');
  AddInfo('Статусы');
  AddInfo(PackStrR('статус 1',GetColWidth) + IntToStr(PopIntBig));
  AddInfo(PackStrR('статус 2',GetColWidth) + IntToStr(PopIntBig));
  AddInfo(PackStrR('статус 3',GetColWidth) + IntToStr(PopIntBig));

  Ver := Pop;
  if (Ver >= 1) then begin
    a := Pop;
    AddInfo('');
    AddInfo('Автоматическое переключение на прием ведомых портов 3,4');
    AddInfo(PackStrR('состояние',GetColWidth) + IntToHex(a,2));
    AddInfo(PackStrR('порт 3',GetColWidth) + GetIOMode(a and $01));
    AddInfo(PackStrR('порт 4',GetColWidth) + GetIOMode(a and $02));
    AddInfo('период переключения            ' + GetIOControl(Pop));
    AddInfo('время последнего переключения  ' + PopTimes2Str);
    AddInfo('количество переключений        ' + IntToStr(PopLong));
  end;

  RunBox;
end;

end.
