unit terminal;

interface

procedure ShowOutData(wSize: word);
procedure ShowInData(wSize: word);
procedure ShowTimeout;

var
  mpbOut,
  mpbIn:  array[0..$4000] of byte;

  iwOut,
  iwIn:   word;

  daOut,
  daIn:   TDateTime;

  dwTerminalTimeout: longword;

implementation

uses SysUtils, Graphics, main, support, kernel, histograms;

function Time2Str: string;
begin
  Result := FormatDateTime('hh:mm:ss:zzz dd.mm.yyyy',Now);
end;

function GetTimeDiff: longword;
var
  Hour,Min,Sec,MSec:  word;
begin
  DecodeTime(daIn-daOut, Hour,Min,Sec,MSec);
  Result := Sec*1000+MSec;
end;

procedure ShowTimeout;
begin
  with frmMain do
    stbMain.Panels[panTIMEOUT].Text := ' ' + IntToStr(GetTimeDiff) + ' ����';
end;

procedure ShowOutData(wSize: word);
var
  i:  word;
  s:  string;
begin
  with frmMain,ComPort do if wSize > 0 then begin
    AddTerminal('',clGray);
    AddTerminal('',clGray);
    s := '';
    for i := 0 to wSize-1 do s := s + IntToHex(mpbOut[i],2) + ' ';

    daOut := Now;
    AddTerminal(s + '  // ��������: ' + IntToStr(wSize) + ' ����; ' + Time2Str,clGray);

    HistogramsAddOutBytes(wSize);
  end;
end;

procedure ShowInData(wSize: word);
var
  i:  word;
  s:  string;
begin
  with frmMain,ComPort do if wSize > 0 then begin

    AddTerminal('',clGray);
    s := '';
    for i := 0 to wSize-1 do s := s + IntToHex(mpbIn[i],2) + ' ';

    daIn := Now;
    AddTerminal(s+'  // �����: ' + IntToStr(wSize) + ' ����; ' + Time2Str,clGray);
    dwTerminalTimeout := GetTimeDiff;
    AddTerminal('// �������: ' + IntToStr(dwTerminalTimeout) + ' ����',clGray);
    AddTerminal('',clGray);

    HistogramsAddInBytes(wSize);
    HistogramsAddTimeout(dwTerminalTimeout);

    if chbChart.Enabled then
      crtMain.Series[0].AddXY(wSize, dwTerminalTimeout);
  end;
end;

end.
