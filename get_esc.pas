unit get_esc;

interface

uses kernel, timez;

procedure BoxGetEsc;
procedure ShowGetEscS;
procedure ShowGetEscS_Time;
procedure ShowGetEscV;
procedure ShowGetEscV_Time;
procedure ShowGetEscU;

var
  mpEscS:       array[0..CANALS-1] of extended;
  mpEscS_Time:  array[0..CANALS-1] of times;

  mpEscV:       array[0..CANALS-1] of extended;
  mpEscV_Time:  array[0..CANALS-1] of times;

  mpEscU_1:     array[0..CANALS-1] of times;
  mpEscU_2:     array[0..CANALS-1] of times;

implementation

uses SysUtils, soutput, support, realz, borders, progress, box;

const
  quGetEscS:      querys = (Action: acGetEscS;      cwOut: 7+9; cwIn: 0; bNumber: $FF);
  quGetEscS_Time: querys = (Action: acGetEscS_Time; cwOut: 7+9; cwIn: 0; bNumber: $FF);
  quGetEscV:      querys = (Action: acGetEscV;      cwOut: 7+9; cwIn: 0; bNumber: $FF);
  quGetEscV_Time: querys = (Action: acGetEscV_Time; cwOut: 7+9; cwIn: 0; bNumber: $FF);
  quGetEscU:      querys = (Action: acGetEscU;      cwOut: 7+9; cwIn: 0; bNumber: $FF);

procedure BoxGetEsc;
begin
  InitPushCRC;
  Push(4);
  if PushCanMask then Query(quGetEscS);
end;

procedure ShowGetEscS;
var
  Can:  word;
begin
  Stop;
  InitPop(15);

  ShowProgress(0,5);
  for Can := 0 to CANALS-1 do if CanalChecked(Can) then mpEscS[Can] := PopReals;

  InitPushCRC;
  Push(5);
  if PushCanMask then Query(quGetEscS_Time);
end;

procedure ShowGetEscS_Time;
var
  Can:  word;
begin
  Stop;
  InitPop(15);

  ShowProgress(1,5);
  for Can := 0 to CANALS-1 do if CanalChecked(Can) then mpEscS_Time[Can] := PopTimes;

  InitPushCRC;
  Push(242);
  if PushCanMask then Query(quGetEscV);
end;

procedure ShowGetEscV;
var
  Can:  word;
begin
  Stop;
  InitPop(15);

  ShowProgress(2,5);
  for Can := 0 to CANALS-1 do if CanalChecked(Can) then mpEscV[Can] := PopReals;

  InitPushCRC;
  Push(6);
  if PushCanMask then Query(quGetEscV_Time);
end;

procedure ShowGetEscV_Time;
var
  Can:  word;
begin
  Stop;
  InitPop(15);

  ShowProgress(3,5);
  for Can := 0 to CANALS-1 do if CanalChecked(Can) then mpEscV_Time[Can] := PopTimes;

  InitPushCRC;
  Push(3);
  if PushCanMask then Query(quGetEscU);
end;

procedure ShowGetEscU;
var
  Can:  word;
  s:    string;
begin
  Stop;
  InitPop(15);

  ShowProgress(4,5);
  for Can := 0 to CANALS-1 do if CanalChecked(Can) then begin
    mpEscU_1[Can] := PopTimes;
    mpEscU_2[Can] := PopTimes;
  end;

  AddInfo('');
  AddInfo('Показания счетчиков текущие (*разница времени опроса и времени компьютера)');
  for Can := 0 to CANALS-1 do if CanalChecked(Can) then begin
    s := PackStrR('канал ' + IntToStr(Can+1),GetColWidth);
    s := s + Reals2StrR(mpEscS[Can]) + Times2Str(mpEscS_Time[Can]);
    s := s + '  ' + DeltaTimes2Str(mpEscS_Time[Can],ToTimes(Now));
    AddInfo(s);
  end;

  AddInfo('');
  AddInfo('Показания счетчиков на начало суток (*разница времени опроса и времени компьютера)');
  for Can := 0 to CANALS-1 do if CanalChecked(Can) then begin
    s := PackStrR('канал ' + IntToStr(Can+1),GetColWidth);
    s := s+Reals2StrR(mpEscV[Can]) + Times2Str(mpEscV_Time[Can]);
    s := s + '  ' + DeltaTimes2Str(mpEscV_Time[Can],ToTimes(Now));
    AddInfo(s);
  end;

  AddInfo('');
  AddInfo('Время счётчиков и время сумматора (*разница времени счетчика и временем опроса)');
  for Can := 0 to CANALS-1 do if CanalChecked(Can) then begin
    s := PackStrR('канал ' + IntToStr(Can+1),GetColWidth);
    s := s + Times2Str(mpEscU_1[Can]) + '  ' + Times2Str(mpEscU_2[Can]);
    s := s + '  ' + DeltaTimes2Str(mpEscU_1[Can],mpEscU_2[Can]);
    AddInfo(s);
  end;

  RunBox;
end;
  
end.
