unit get_checkup;

interface

function InfoGetCheckup: string;
procedure BoxGetCheckup;
procedure ShowGetCheckup;

implementation

uses SysUtils, kernel, soutput, support, borders, box;

const
  quGetCheckup:   querys = (Action: acGetCheckup; cwOut: 7+1; cwIn: 5+1+64+64+2; bNumber: $FF);

function InfoGetCheckup: string;
begin
  Result := 'проверка достоверности';
end;

procedure QueryGetCheckup;
begin
  InitPushCRC;
  Push(120);
  Query(quGetCheckup);
end;

procedure BoxGetCheckup;
begin
  if TestCanals then begin
    AddInfo('');    
    AddInfo('ѕроверка достоверности');
    
    QueryGetCheckup;
  end;
end;

procedure ShowGetCheckup;
var
  Can:  byte;
  s:    string;
begin
  Stop;
  InitPop(5);

  AddInfo('ѕризнак всключени€ режима: '+PopBool2Str);

  AddInfo(' оличество суток дл€ проверки достоверности');
  for Can := 0 to CANALS-1 do  begin
    s := PackStrR('канал '+IntToStr(Can+1),GetColWidth);
    s := s + IntToStr(Pop);
    AddInfo(s);
  end;

  AddInfo(' оличество мес€цев дл€ проверки достоверности');
  for Can := 0 to CANALS-1 do  begin
    s := PackStrR('канал '+IntToStr(Can+1),GetColWidth);
    s := s + IntToStr(Pop);
    AddInfo(s);
  end;

  RunBox;
end;

end.
