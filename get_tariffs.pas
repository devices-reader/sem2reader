unit get_tariffs;

interface

uses timez;

procedure BoxGetPublic;
procedure ShowGetPublic;

procedure BoxGetPubTariffs;
procedure ShowGetPubTariffs;

procedure BoxGetPowTariffs;
procedure ShowGetPowTariffs;

procedure BoxGetEngTariffs;
procedure ShowGetEngTariffs;

implementation

uses SysUtils, soutput, support, progress, box, kernel;

const
  TARIFFS_BREAKS  = 6;
  TARIFFS_MONTHS  = 12;  

  quGetPublic:      querys = (Action: acGetPublic;     cwOut: 1+6; cwIn: 5+2+2;  bNumber: 14);   
  quGetPowTariffs:  querys = (Action: acGetPowTariffs; cwOut: 3+6; cwIn: 5+19+2; bNumber: 18); 
  quGetEngTariffs:  querys = (Action: acGetEngTariffs; cwOut: 3+6; cwIn: 5+19+2; bNumber: 20); 
  quGetPubTariffs:  querys = (Action: acGetPubTariffs; cwOut: 3+6; cwIn: 5+19+2; bNumber: 22); 

type
  tariff = record
    bHour:      byte;
    bMinute:    byte;
    bTariff:    byte;
  end;

  zones = record
    bSize:      byte;
    mpTariffs:  array[1..TARIFFS_BREAKS] of tariff;
  end;
  
var
  ibMon:    byte;
  Zone:     zones;
  mpZonesM: array[0..TARIFFS_MONTHS-1] of zones;
  
procedure QueryGetPublic;
begin
  Query(quGetPublic);
end;

procedure BoxGetPublic;
begin
  QueryGetPublic;
end;

function Public2Str(i: byte): string;
begin
  case i of
    0:    Result := 'раздельные';
    255:  Result := 'совмещенные';
    else  Result := '?';
  end;
  Result := IntToStr(i) + ' - ' + Result;
end;

procedure ShowGetPublic;
begin
  Stop;
  InitPopCRC;

  AddInfo('');
  AddInfo('Тип учёта тарифов: '+Public2Str(Pop));

  RunBox;
end;

procedure QueryGetPubTariffs;
begin
  InitPushCRC;
  Push(ibMon);
  Push(0);
  Query(quGetPubTariffs);
end;

procedure QueryGetPowTariffs;
begin
  InitPushCRC;
  Push(ibMon);
  Push(0);
  Query(quGetPowTariffs);
end;

procedure QueryGetEngTariffs;
begin
  InitPushCRC;
  Push(ibMon);
  Push(0);
  Query(quGetEngTariffs);
end;

procedure BoxGetPubTariffs;
begin
  ibMon := 0;
  QueryGetPubTariffs;
end;

procedure BoxGetPowTariffs;
begin
  ibMon := 0;
  QueryGetPowTariffs;
end;

procedure BoxGetEngTariffs;
begin
  ibMon := 0;
  QueryGetEngTariffs;
end;

procedure PopTariffs;
var
  i:  byte;
begin
  with Zone do begin
    InitPopCRC;
    bSize := Pop;

    for i := 1 to TARIFFS_BREAKS do begin
      with mpTariffs[i] do begin
        bHour   := Pop;
        bMinute := Pop;
        bTariff := Pop;

        if (bHour > 0) or (bMinute > 0) then Inc(bTariff);
      end;
    end;
  end;

  mpZonesM[ibMon] := Zone;
end;

procedure ShowTariffs;
var
  s:    string;
  i,j:  byte;
begin
  s := PackStrR('',GetColWidth div 2);
  for j := 0 to TARIFFS_MONTHS-1 do s := s + PackStrR('месяц '+IntToStr(j+1),GetColWidth);
  AddInfo(s);

  for i := 1 to TARIFFS_BREAKS do begin
    s := PackStrR(IntToStr(i),GetColWidth div 2);
    for j := 0 to TARIFFS_MONTHS-1 do with mpZonesM[j].mpTariffs[i] do begin
      s := s  + PackStrR(Int2Str(bHour) + ':' + Int2Str(bMinute) + ' - ' + IntToStr(bTariff),GetColWidth);
    end;
    AddInfo(s);
  end;

  AddInfo('');  
  for j := 0 to TARIFFS_MONTHS-1 do begin
    s := PackStrR('месяц: ' + IntToStr(j+1),GetColWidth);
    for i := 1 to TARIFFS_BREAKS do with mpZonesM[j].mpTariffs[i] do
        s := s  + PackStrR(Int2Str(bHour) + ':' + Int2Str(bMinute) + ' - ' + IntToStr(bTariff) + ' ',GetColWidth);
    AddInfo(s);
  end;
end;

procedure ShowGetPubTariffs;
begin
  Stop;
  PopTariffs;
  
  ShowProgress(ibMon,MONTHS);
  
  Inc(ibMon);
  if ibMon < 12 then begin
    QueryGetPubTariffs;
  end
  else begin 
    AddInfo('');
    AddInfo('Совмещённые тарифы для мощности и энергии');
    ShowTariffs; 
    RunBox; 
  end;
end;

procedure ShowGetPowTariffs;
begin
  Stop;
  PopTariffs;
  
  ShowProgress(ibMon,MONTHS);
  
  Inc(ibMon);
  if ibMon < 12 then begin
    QueryGetPowTariffs;
  end
  else begin 
    AddInfo('');
    AddInfo('Раздельные тарифы для мощности');
    ShowTariffs; 
    RunBox; 
  end;
end;

procedure ShowGetEngTariffs;
begin
  Stop;
  PopTariffs;
  
  ShowProgress(ibMon,MONTHS);
  
  Inc(ibMon);
  if ibMon < 12 then begin
    QueryGetEngTariffs;
  end
  else begin 
    AddInfo('');
    AddInfo('Раздельные тарифы для энергии');
    ShowTariffs; 
    RunBox; 
  end;
end;

end.
