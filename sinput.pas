unit sinput;

interface

procedure PostInputComPort;
procedure PostInputSocket(s: string);

const
  cbMaxRepeat = 20;
  
var
  cwIncTotal,
  cbIncRepeat,
  cbCurRepeat:  word;

implementation

uses SysUtils, Graphics, support, soutput, main, terminal, crc, box;

function MultiBox(wSize: word): boolean;
begin
  Result := False;

  if wSize = 5+1+2 then begin
    Result := True;

    case mpbIn[5] of
      0:    InfBox('Операция завершена успешно');

      1:    WrnBox('Неправильная команда !');
      2:    WrnBox('Неправильный адрес !');
      3:    WrnBox('Неправильные данные !');
      4:    WrnBox('Неправильная длина запроса !');
      5:    WrnBox('Неправильный режим !');
      6:    WrnBox('Ошибка памяти !');
      7:    WrnBox('Ошибка цифрового счётчика !');
      8:    WrnBox('Неправильный порт сумматора !');
      9:    WrnBox('Неправильный доступ !');
      10:   WrnBox('Неправильная коррекция !');
      11:   WrnBox('Прибор занят !');

      99:   WrnBox('Переполнение выходного буфера !');

      100:  WrnBox('Требуется режим ''Программирование'' !');
      101:  WrnBox('Требуется режим ''Функционирование'' !');
      102:  WrnBox('Требуется режим ''Перепрограммирование'' !');

      else WrnBox('Неизвестная ошибка (код ' + IntToStr(mpbIn[5]) + ')');
    end;
  end;
end;

procedure BadSizeBox(wSize1,wSize2: word);
begin
 ErrBox('Неправильная длина ответа: ' +
         IntToStr(wSize1) + ' вместо ' + IntToStr(wSize2) + ' байт');
end;

procedure OtherActionsCRC(cwIn: word);
begin
  cbCurRepeat := 0;

  if cwIn <> queQueryCRC.cwIn then 
    BadSizeBox(cwIn,queQueryCRC.cwIn)
  else 
    BoxShow(queQueryCRC.Action);
end;

procedure PostInputComPort;
var
  wSize:  word;
begin
  with frmMain,ComPort do begin

    wSize := InBuffUsed;
    AddTerminal('// принято с порта: ' + IntToStr(wSize) + ' байт',clGray);

    GetBlock(mpbIn, wSize);

    ShowInData(wSize);
    ShowTimeout;

    if queQueryCRC.Action = acNone then begin
    end
    else if queQueryCRC.Action = acCtrlZ then begin
    end
    else if (wSize = 0) and (cbCurRepeat < cbMaxRepeat) then begin
      Inc(cbCurRepeat);
      Inc(cbIncRepeat); ShowRepeat;
      AddInfo('Нет ответа от устройства, повтор: ' + IntToStr(cbCurRepeat) + ' из ' + IntToStr(cbMaxRepeat));
      Query(queQueryCRC);
    end
    else if (CRC16(mpbIn,wSize) <> 0) and (cbCurRepeat < cbMaxRepeat) then begin
      Inc(cbCurRepeat);
      Inc(cbIncRepeat); ShowRepeat;
      AddInfo('Ошибка контрольной суммы, повтор: ' + IntToStr(cbCurRepeat) + ' из ' + IntToStr(cbMaxRepeat));
      Query(queQueryCRC);
    end

    else begin
      if wSize = 0 then ErrBox('Нет ответа от устройства !')
      else
      if (CRC16(mpbIn,wSize) <> 0) then ErrBox('Ошибка контрольной суммы !')
      else
      if not MultiBox(wSize) then OtherActionsCRC(wSize);
    end;
  end;
end;

procedure PostInputSocket(s: string);
var
  wSize: word;
  i:  word;
begin
  with frmMain do begin

    wSize := Length(s);
    AddTerminal('// принято с сокета: ' + IntToStr(wSize) + ' байт',clGray);

    if wSize = 0 then exit;
    for i := 0 to Length(s) - 1 do  mpbIn[i] := Ord(s[i+1]);

    ShowInData(wSize);
    ShowTimeout;

    if queQueryCRC.Action = acNone then begin
    end
    else if queQueryCRC.Action = acCtrlZ then begin
    end
    else if (wSize = 0) and (cbCurRepeat < cbMaxRepeat) then begin
      Inc(cbCurRepeat);
      Inc(cbIncRepeat); ShowRepeat;
      AddInfo('Нет ответа от устройства, повтор: ' + IntToStr(cbCurRepeat) + ' из ' + IntToStr(cbMaxRepeat));
      Query(queQueryCRC);
    end
    else if (CRC16(mpbIn,wSize) <> 0) and (cbCurRepeat < cbMaxRepeat) then begin
      Inc(cbCurRepeat);
      Inc(cbIncRepeat); ShowRepeat;
      AddInfo('Ошибка контрольной суммы, повтор: ' + IntToStr(cbCurRepeat) + ' из ' + IntToStr(cbMaxRepeat));
      Query(queQueryCRC);
    end

    else begin
      if wSize = 0 then ErrBox('Нет ответа от устройства !')
      else
      if (CRC16(mpbIn,wSize) <> 0) then ErrBox('Ошибка контрольной суммы !')
      else
      if not MultiBox(wSize) then OtherActionsCRC(wSize);
    end;
  end;
end;

end.

