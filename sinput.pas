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
      0:    InfBox('�������� ��������� �������');

      1:    WrnBox('������������ ������� !');
      2:    WrnBox('������������ ����� !');
      3:    WrnBox('������������ ������ !');
      4:    WrnBox('������������ ����� ������� !');
      5:    WrnBox('������������ ����� !');
      6:    WrnBox('������ ������ !');
      7:    WrnBox('������ ��������� �������� !');
      8:    WrnBox('������������ ���� ��������� !');
      9:    WrnBox('������������ ������ !');
      10:   WrnBox('������������ ��������� !');
      11:   WrnBox('������ ����� !');

      99:   WrnBox('������������ ��������� ������ !');

      100:  WrnBox('��������� ����� ''����������������'' !');
      101:  WrnBox('��������� ����� ''����������������'' !');
      102:  WrnBox('��������� ����� ''��������������������'' !');

      else WrnBox('����������� ������ (��� ' + IntToStr(mpbIn[5]) + ')');
    end;
  end;
end;

procedure BadSizeBox(wSize1,wSize2: word);
begin
 ErrBox('������������ ����� ������: ' +
         IntToStr(wSize1) + ' ������ ' + IntToStr(wSize2) + ' ����');
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
    AddTerminal('// ������� � �����: ' + IntToStr(wSize) + ' ����',clGray);

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
      AddInfo('��� ������ �� ����������, ������: ' + IntToStr(cbCurRepeat) + ' �� ' + IntToStr(cbMaxRepeat));
      Query(queQueryCRC);
    end
    else if (CRC16(mpbIn,wSize) <> 0) and (cbCurRepeat < cbMaxRepeat) then begin
      Inc(cbCurRepeat);
      Inc(cbIncRepeat); ShowRepeat;
      AddInfo('������ ����������� �����, ������: ' + IntToStr(cbCurRepeat) + ' �� ' + IntToStr(cbMaxRepeat));
      Query(queQueryCRC);
    end

    else begin
      if wSize = 0 then ErrBox('��� ������ �� ���������� !')
      else
      if (CRC16(mpbIn,wSize) <> 0) then ErrBox('������ ����������� ����� !')
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
    AddTerminal('// ������� � ������: ' + IntToStr(wSize) + ' ����',clGray);

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
      AddInfo('��� ������ �� ����������, ������: ' + IntToStr(cbCurRepeat) + ' �� ' + IntToStr(cbMaxRepeat));
      Query(queQueryCRC);
    end
    else if (CRC16(mpbIn,wSize) <> 0) and (cbCurRepeat < cbMaxRepeat) then begin
      Inc(cbCurRepeat);
      Inc(cbIncRepeat); ShowRepeat;
      AddInfo('������ ����������� �����, ������: ' + IntToStr(cbCurRepeat) + ' �� ' + IntToStr(cbMaxRepeat));
      Query(queQueryCRC);
    end

    else begin
      if wSize = 0 then ErrBox('��� ������ �� ���������� !')
      else
      if (CRC16(mpbIn,wSize) <> 0) then ErrBox('������ ����������� ����� !')
      else
      if not MultiBox(wSize) then OtherActionsCRC(wSize);
    end;
  end;
end;

end.

