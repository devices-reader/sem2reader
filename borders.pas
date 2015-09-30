unit borders;

interface

uses kernel;

function MinCan: byte;
function MaxCan: byte;
function MinGrp: byte;
function MaxGrp: byte;
function TestCanals: boolean;
function CanalChecked(i: byte): boolean;
function TestGroups: boolean;
function GroupChecked(i: byte): boolean;
function TestDays: boolean;
function TestDays2: boolean;
function TestMonths: boolean;
function PushCanMask: boolean;
function PushGrpMask: boolean;

var
  ibMinHou,
  ibMaxHou:     byte;
  
  ibMinDay,
  ibMaxDay:     byte;

  ibMinMon,
  ibMaxMon:     byte;
  
  mpbGrpMask:   array[0..(GROUPS div 8)-1] of byte;  
  cbGrpMask:    byte;

  mpbCanMask:   array[0..(CANALS div 8)-1] of byte;  
  cbCanMask:    byte;

  cwPar:        word;
  
implementation

uses SysUtils, main, support, soutput;

function MinCan: byte;
var
  Can:  byte;
begin
  Result := High(byte);
  for Can := 0 to CANALS-1 do if CanalChecked(Can) then begin 
    Result := Can;
    exit;
  end;

  raise Exception.Create('Минимальный канал не задан !');
end;

function MaxCan: byte;
var
  Can:  byte;
begin
  Result := High(byte);
  for Can := 0 to CANALS-1 do if CanalChecked(Can) then
    Result := Can;

  if Result = High(byte) then
    raise Exception.Create('Максимальный канал не задан !');
end;

function MinGrp: byte;
var
  Grp:  byte;
begin
  Result := High(byte);
  for Grp := 0 to GROUPS-1 do if GroupChecked(Grp) then begin 
    Result := Grp;
    exit;
  end;

  raise Exception.Create('Минимальная группа не задана !');
end;

function MaxGrp: byte;
var
  Grp:  byte;
begin
  Result := High(byte);
  for Grp := 0 to GROUPS-1 do if GroupChecked(Grp) then
    Result := Grp;

  if Result = High(byte) then
    raise Exception.Create('Максимальная группа не задана !');
end;

function TestCanals: boolean;
var
  i:  byte;
begin
  with frmMain do begin
    Result := False;

    for i := 0 to CANALS-1 do
      if clbCanals.Checked[i] then Result := True;

    if not Result then ErrBox('Каналы не заданы !');  
  end;  
end;

function CanalChecked(i: byte): boolean;
begin
  Result := frmMain.clbCanals.Checked[i];
end;

function TestGroups: boolean;
var
  i:  byte;
begin
  with frmMain do begin
    Result := False;

    for i := 0 to GROUPS-1 do
      if clbGroups.Checked[i] then Result := True;

    if not Result then ErrBox('Группы не заданы !');  
  end;  
end;

function GroupChecked(i: byte): boolean;
begin
  Result := frmMain.clbGroups.Checked[i];
end;

function TestDays: boolean;
begin
  with frmMain do begin
    Result := False;

    ibMinDay := StrToIntDef(edtDaysMin.Text,0);
    if (ibMinDay > DAYS-1) then begin ErrBox('Начальный номер суток задан неправильно !'); exit; end;

    ibMaxDay := StrToIntDef(edtDaysMax.Text,0);
    if (ibMaxDay > DAYS-1) then begin ErrBox('Конечный номер суток задан неправильно !'); exit; end;

    if (ibMaxDay < ibMinDay) then begin ErrBox('Начальный номер суток больше конечного !'); exit; end;

    Result := True;
  end;  
end;

function TestDays2: boolean;
begin
  with frmMain do begin
    Result := False;

    ibMinDay := StrToIntDef(edtDays2Min.Text,0);
    if (ibMinDay > DAYS2-1) then begin ErrBox('Начальный номер суток задан неправильно !'); exit; end;

    ibMaxDay := StrToIntDef(edtDays2Max.Text,0);
    if (ibMaxDay > DAYS2-1) then begin ErrBox('Конечный номер суток задан неправильно !'); exit; end;

    if (ibMaxDay < ibMinDay) then begin ErrBox('Начальный номер суток больше конечного !'); exit; end;

    Result := True;
  end;  
end;

function TestMonths: boolean;
begin
  with frmMain do begin
    Result := False;

    ibMinMon := StrToIntDef(edtMonthsMin.Text,0);
    if (ibMinMon > MONTHS-1) then begin ErrBox('Начальный номер месяца задан неправильно !'); exit; end;

    ibMaxMon := StrToIntDef(edtMonthsMax.Text,0);
    if (ibMaxMon > MONTHS-1) then begin ErrBox('Конечный номер месяца задан неправильно !'); exit; end;

    if (ibMaxMon < ibMinMon) then begin ErrBox('Начальный номер месяца больше конечного !'); exit; end;

    Result := True;
  end;  
end;

function PushCanMask: boolean;
var
  i,a,b: word;
begin
  if not TestCanals then Abort;
  
  with frmMain do begin
    Result := False;

    cbCanMask := 0;
    for i := 0 to CANALS-1 do begin
      a := i div 8;
      b := $80 shr (i mod 8);

      mpbCanMask[a] := mpbCanMask[a] and not(b);
      if clbCanals.Checked[i] then begin
        mpbCanMask[a] := mpbCanMask[a] or b;
        Inc(cbCanMask);
      end;
    end;

    for i := 0 to (CANALS div 8)-1 do Push(mpbCanMask[i]);
    Result := True;
  end;
end;

function PushGrpMask: boolean;
var
  i,a,b: word;
begin
  if not TestGroups then Abort;
  
  with frmMain do begin
    Result := False;

    cbGrpMask := 0;
    for i := 0 to GROUPS-1 do begin
      a := i div 8;
      b := $80 shr (i mod 8);

      mpbGrpMask[a] := mpbGrpMask[a] and not(b);
      if clbGroups.Checked[i] then begin
        mpbGrpMask[a] := mpbGrpMask[a] or b;
        Inc(cbGrpMask);
      end;
    end;

    for i := 0 to (GROUPS div 8)-1 do Push(mpbGrpMask[i]);
    Result := True;
  end;
end;

end.

