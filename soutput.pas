{---}
unit soutput;

interface

uses SysUtils, Classes, Graphics, StdCtrls, Windows, IdGlobal, box;

var
  queQueryCRC:  querys;

procedure Stop;

procedure InitPushZero;
procedure InitPushCRC;
procedure Push(bT: byte);
procedure PushInt(wT: word);
procedure PushLong(dwT: longword);

procedure InitPopZero;
procedure InitPopCRC;
procedure InitPop(i: word);
function Pop: byte;
function PopIntBig: word;
function PopIntLtl: word;
function PopLong: longword;
function PopLongBig: longword;
function PopLongLtl: longword;
function Bool2Str(i: byte): string;
function PopBool2Str: string;
function PopSwitch2Str: string;
function PopBits2Str: string;

procedure Query(quT: querys);
procedure OutData(cwSize: word; stName: string);
procedure NormalMode;

implementation

uses main, support, terminal, crc, kernel, borders, sinput, get_memory3, get_echo_n_to_n, get_echo_n_to_1, get_echo_1_to_n;

const
  stHEADER:         AnsiString = 'Калюмны ';
  bPACKET_HEADER:   byte = 8;

procedure Stop;
begin
  with frmMain do begin
    timTimeout.Enabled := False;

    queQueryCRC.Action := acNone;
    queQueryCRC.cwIn := 0;
  end;
end;

procedure InitPushZero;
begin
  iwOut := 0;
end;

procedure InitPushCRC;
begin
  iwOut := 5;
end;

procedure Push(bT: byte);
begin
  mpbOut[iwOut] := bT;
  Inc(iwOut);
end;

procedure PushInt(wT: word);
begin
  Push(wT div $100);
  Push(wT mod $100);
end;

procedure PushLong(dwT: longword);
begin
  PushInt(dwT div $10000);
  PushInt(dwT mod $10000);
end;

procedure InitPopZero;
begin
  iwIn := 0;
end;

procedure InitPopCRC;
begin
  iwIn := 5;
end;

procedure InitPop(i: word);
begin
  iwIn := i;
end;

function Pop: byte;
begin
  Result := mpbIn[iwIn];
  Inc(iwIn);
end;

function PopIntBig: word;
begin
  Result := Pop*$100 + Pop;
end;

function PopIntLtl: word;
begin
  Result := Pop + Pop*$100;
end;

function PopLong: longword;
begin
  Result := Pop*$1000000 + Pop*$10000 + Pop*$100 + Pop;
end;

function PopLongBig: longword;
begin
  Result := PopIntBig*$10000 + PopIntBig;
end;

function PopLongLtl: longword;
begin
  Result := PopIntLtl + PopIntLtl*$10000;
end;

function Bool2Str(i: byte): string;
begin
  case i of
    0:    Result := 'нет';
    255:  Result := 'да';
    else  Result := '?';
  end;
  Result := IntToStr(i) + ' - ' + Result;
end;

function PopBool2Str: string;
begin
  Result := Bool2Str(Pop);
end;

function PopSwitch2Str: string;
var
  i:  byte;
begin
  i := Pop();
  case i of
    0:    Result := 'выкл.';
    255:  Result := 'вкл.';
    else  Result := '?';
  end;
  Result := IntToStr(i) + ' - ' + Result;
end;

function PopBits2Str: string;
var
  i:  byte;
begin
  i := Pop();
  
  Result := '';
  
  if (i and $80 <> 0) then Result := Result + '1' else Result := Result + '0';
  if (i and $40 <> 0) then Result := Result + '1' else Result := Result + '0';
  if (i and $20 <> 0) then Result := Result + '1' else Result := Result + '0';
  if (i and $10 <> 0) then Result := Result + '1' else Result := Result + '0';
  if (i and $08 <> 0) then Result := Result + '1' else Result := Result + '0';
  if (i and $04 <> 0) then Result := Result + '1' else Result := Result + '0';
  if (i and $02 <> 0) then Result := Result + '1' else Result := Result + '0';
  if (i and $01 <> 0) then Result := Result + '1' else Result := Result + '0';

  Result := IntToHex(i,2) + '  ' + Result;
end;

procedure OutCharPause(chT: AnsiChar; Pause: boolean);
begin
  with frmMain do begin

    if (pgcMode.ActivePage = tbsPort) or (pgcMode.ActivePage = tbsModem) then begin
      ComPort.PutChar(AnsiChar(chT));
    end
    else begin
//      IdTCPClient.Write(chT);  ???
      IdTCPClient.IOHandler.Write(Ord(chT));
    end;

    InsByte(Ord(chT),clRed);

    if Pause then Delay(100);
  end;
end;

procedure Query(quT: querys);
var
  i,j,cwOut: word;
begin
  try
    with frmMain,ComPort do begin
      if quT.Action = acGetBorder     then quT.cwIn := 15+cbCanMask*2+2;    
      if quT.Action = acGetBorder1    then quT.cwIn := 15+cbCanMask*2+2;    
      if quT.Action = acGetBorder2    then quT.cwIn := 15+1+cbCanMask*13+2;    
      if quT.Action = acGetDigit2     then quT.cwIn := 15+cbCanMask*8+2;    
      if quT.Action = acGetDigitEnbl  then quT.cwIn := 15+cbCanMask*1+2;    
      
      if quT.Action = acGetDiagram    then quT.cwIn := 15+cbCanMask*48*(4+3)+2;    
      if quT.Action = acGetImpCanHou  then quT.cwIn := 15+cbCanMask*96+2;
      if quT.Action = acGetPowCanHou  then quT.cwIn := 15+cbCanMask*192+2;
      if quT.Action = acGetPowGrpHou  then quT.cwIn := 15+cbGrpMask*192+2;    
      if quT.Action = acGetImpCanDay  then quT.cwIn := 15+cbCanMask*16+2;
      if quT.Action = acGetImpCanMon  then quT.cwIn := 15+cbCanMask*16+2;

      if quT.Action = acGetDefCanHou  then quT.cwIn := 15+cbCanMask*96+2;
      if quT.Action = acGetDefGrpHou  then quT.cwIn := 15+cbGrpMask*192+2;
      if quT.Action = acGetDefCanDay  then quT.cwIn := 15+cbCanMask*(4+16)+2;
      if quT.Action = acGetDefCanMon  then quT.cwIn := 15+cbCanMask*(4+16)+2;
      if quT.Action = acGetDefGrpDay  then quT.cwIn := 15+cbGrpMask*(4+16)+2;
      if quT.Action = acGetDefGrpMon  then quT.cwIn := 15+cbGrpMask*(4+16)+2;

      if quT.Action = acGetEngGrpPrevHou_Def then quT.cwIn := 15+cbGrpMask*4+2;
      if quT.Action = acGetPowGrpPrevHou_Def then quT.cwIn := 15+cbGrpMask*4+2;
      if quT.Action = acGetEngGrpDay_Def then quT.cwIn := 15+cbGrpMask*16+2;
      if quT.Action = acGetEngGrpMon_Def then quT.cwIn := 15+cbGrpMask*16+2;
      if quT.Action = acGetMaxGrpDay_Def then quT.cwIn := 15+cbGrpMask*40+2;
      if quT.Action = acGetMaxGrpMon_Def then quT.cwIn := 15+cbGrpMask*40+2;

      if quT.Action = acGetEngGrpHou  then quT.cwIn := 15+cbGrpMask*192+2;    
      if quT.Action = acGetEngGrpDay  then quT.cwIn := 15+cbGrpMask*16+2;
      if quT.Action = acGetEngGrpMon  then quT.cwIn := 15+cbGrpMask*16+2;
      if quT.Action = acGetEngGrpDayX2 then quT.cwIn := 15+cbGrpMask*32+2;
      if quT.Action = acGetEngGrpMonX2 then quT.cwIn := 15+cbGrpMask*32+2;
      if quT.Action = acGetEngCanDay  then quT.cwIn := 15+cbCanMask*16+2;
      if quT.Action = acGetEngCanMon  then quT.cwIn := 15+cbCanMask*16+2;

      if quT.Action = acGetMaxGrpDay  then quT.cwIn := 15+cbGrpMask*40+2;
      if quT.Action = acGetMaxGrpMon  then quT.cwIn := 15+cbGrpMask*40+2;

      if quT.Action = acGetEscS       then quT.cwIn := 15+cbCanMask*4+2;
      if quT.Action = acGetEscS_Time  then quT.cwIn := 15+cbCanMask*6+2;
      if quT.Action = acGetEscV       then quT.cwIn := 15+cbCanMask*4+2;
      if quT.Action = acGetEscV_Time  then quT.cwIn := 15+cbCanMask*6+2;
      if quT.Action = acGetEscU       then quT.cwIn := 15+cbCanMask*12+2;
      
      if quT.Action = acGetCurrent1   then quT.cwIn := 15+cbCanMask*67+2;
      if quT.Action = acGetCurrent2   then quT.cwIn := 15+cbCanMask*80+2;
      if quT.Action = acGetCurrent3   then quT.cwIn := 15+cbCanMask*160+2;

      if quT.Action = acGetImpCanMnt  then quT.cwIn := 15+cbCanMask*80+2;
      if quT.Action = acGetPowCanMnt  then quT.cwIn := 15+cbCanMask*160+2;
      
      if quT.Action = acGetExt40      then quT.cwIn := 15+cbCanMask*15+2;      
      if quT.Action = acGetExt40X2    then quT.cwIn := 15+cbCanMask*19+2;
      if quT.Action = acGetExt43      then quT.cwIn := 15+cbCanMask*1+2;
      if quT.Action = acGetExt44      then quT.cwIn := 15+6+cbCanMask*15+2;
      if quT.Action = acGetExt44X2    then quT.cwIn := 15+6+cbCanMask*19+2;
      if quT.Action = acGetExt7       then quT.cwIn := 15+2+cbCanMask*11+2;
      if quT.Action = acGetExt7X2     then quT.cwIn := 15+2+cbCanMask*15+2;
      if quT.Action = acGetExt6       then quT.cwIn := 15+4+cbCanMask*11+2;
      if quT.Action = acGetExt6X2     then quT.cwIn := 15+4+cbCanMask*15+2;
      if quT.Action = acGetExt50      then quT.cwIn := 15+1+cbCanMask*27+2;
      if quT.Action = acGetExt51      then quT.cwIn := 15+1+cbCanMask*22+2;
      if quT.Action = acGetExt50X2    then quT.cwIn := 15+1+cbCanMask*(8*4+6+1+2+2)+2;
      if quT.Action = acGetExt51X2    then quT.cwIn := 15+1+cbCanMask*(8*4+6)+2;
      if quT.Action = acGetExt40T     then quT.cwIn := 15+2+cbCanMask*(1+4*4+6)+2;
      if quT.Action = acGetExt40TX2   then quT.cwIn := 15+2+cbCanMask*(1+4*8+6)+2;

      if quT.Action = acGetQueryFF19  then quT.cwIn := 15+10+cbCanMask*12+2;

      if quT.Action = acGetParams3    then quT.cwIn := 5+11+cwPar*4+2;

      if quT.Action = acGetXBYTE      then quT.cwIn := 5+wMemSize+2;
      if quT.Action = acGetFVAR       then quT.cwIn := 5+wMemSize+2;
      if quT.Action = acGetCBYTE      then quT.cwIn := 5+wMemSize+2;
      if quT.Action = acGetFCVAR      then quT.cwIn := 5+wMemSize+2;

      if quT.Action = acGetMemory1    then quT.cwIn := bHEADER+1056+2;
      if quT.Action = acGetMemory12   then quT.cwIn := bHEADER+1056+2;
      if quT.Action = acGetMemory2    then quT.cwIn := bHEADER+wPageSize+2;
      if quT.Action = acGetMemory21   then quT.cwIn := bHEADER+wPageSize+2;
      if quT.Action = acGetMemory22   then quT.cwIn := bHEADER+wPageSize+2;
      if quT.Action = acGetMemory23   then quT.cwIn := bHEADER+wPageSize+2;

      if quT.Action = acGetRecords0   then quT.cwIn := 5+6+wFreePageSize+2;
      if quT.Action = acGetRecords1   then quT.cwIn := 5+6+wFreePageSize+2;
      if quT.Action = acGetRecords2   then quT.cwIn := 5+6+wFreePageSize+2;
      if quT.Action = acGetRecords3   then quT.cwIn := 5+6+wFreePageSize+2;
      if quT.Action = acGetRecords4   then quT.cwIn := 5+6+wFreePageSize+2;
      if quT.Action = acGetRecords5   then quT.cwIn := 5+6+wFreePageSize+2;
      if quT.Action = acGetRecordsX0  then quT.cwIn := 5+6+wFreePageSize+2;

      if quT.Action = acGetEchoNtoN then begin quT.cwOut := 5+1+wEchoNtoN+2; quT.cwIn := 5+1+wEchoNtoN+2; end;
      if quT.Action = acGetEchoNto1 then quT.cwOut := 5+1+wEchoNto1+2;
      if quT.Action = acGetEcho1toN then quT.cwIn := 5+wEcho1toN+2;

      queQueryCRC := quT;

      InitPushZero;
      Push(updAddress.Position);
      Push(0);

      Push(quT.cwOut mod $100);
      Push(quT.cwOut div $100);
      Push(quT.bNumber);

      i := CRC16(mpbOut, quT.cwOut-2);
      mpbOut[quT.cwOut-2] := i div $100;
      mpbOut[quT.cwOut-1] := i mod $100;

      cwOut := queQueryCRC.cwOut;

      with timTimeout do begin
        Enabled  := False;
        if quT.fLong then Interval := 10000 else Interval := GetTimeout;
        Enabled  := True;
      end;

      if rgrPacket.ItemIndex = 1 then begin
        AddTerminal('', clGray);
        for j := 1 to bPACKET_HEADER do OutCharPause(stHEADER[j],false);
      end;

      if rgrPacket.ItemIndex = 2 then begin
        ShowOutData(queQueryCRC.cwOut);
        for j := 1 to quT.cwOut do
          mpbOut[6+quT.cwOut-j] := mpbOut[quT.cwOut-j];

        mpbOut[0] := $55;
        mpbOut[1] := updAddress.Position;

        mpbOut[2] := (quT.cwOut+10) div $100;
        mpbOut[3] := (quT.cwOut+10) mod $100;

        mpbOut[4] := $FFF0 div $100;
        mpbOut[5] := $FFF0 mod $100;

        mpbOut[quT.cwOut+6] := $21;
        mpbOut[quT.cwOut+7] := $B3;

        i := CRC16(mpbOut, quT.cwOut+8);
        mpbOut[quT.cwOut+8] := i div $100;
        mpbOut[quT.cwOut+9] := i mod $100;

        cwOut := quT.cwOut+10;
      end;

      if (pgcMode.ActivePage = tbsPort) or (pgcMode.ActivePage = tbsModem) then begin
        //FlushInBuffer;
        //FlushOutBuffer;
        ComPort.PutBlock(mpbOut, cwOut);
      end
      else begin
//        IdTCPClient.WriteBuffer(mpbOut, cwOut);
        IdTCPClient.IOHandler.Write(IdGlobal.RawToBytes(mpbOut, cwOut));
      end;

      ShowOutData(cwOut);

      Inc(cwIncTotal);
    end;
  except
    ErrBox('Ошибка при передаче !');
  end;
end;

procedure OutData(cwSize: word; stName: string);
begin
  try with frmMain,ComPort do begin
      with timTimeout do begin
        Enabled := False;
        Interval := GetTimeout;
        Enabled := True;
      end;

      ComTerminal(stName);

      if (pgcMode.ActivePage = tbsPort) or (pgcMode.ActivePage = tbsModem) then begin
        //FlushInBuffer;
        //FlushOutBuffer;
        ComPort.PutBlock(mpbOut, cwSize);
      end
      else begin
//        IdTCPClient.WriteBuffer(mpbOut, cwSize);
        IdTCPClient.IOHandler.Write(IdGlobal.RawToBytes(mpbOut, cwSize));
      end;

      ShowOutData(cwSize);
    end;
  except
    ErrBox('Ошибка при передаче запроса !');
  end;
end;

procedure CtrlZ;
begin
  InitPushZero;
  Push($1A);

  queQueryCRC.Action := acCtrlZ;
  queQueryCRC.cwIn := 0;

  OutData(1,'Ctrl Z');
end;

procedure NormalMode;
begin
  if (frmMain.chbCtrlZ.Checked) then begin 
    CtrlZ; Delay(50);
  end;  
end;
    
end.


