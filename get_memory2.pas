unit get_memory2;

interface

procedure BoxGetMemory2;
procedure ShowGetMemory2;

implementation

uses SysUtils, soutput, support, progress, box, kernel, main, t_memory;

const
  quGetMemory2: querys = (Action: acGetMemory2; cwOut: 7+2; cwIn: 0; bNumber: 249);

var
  wPage0,wPage1,wPage2: word;

procedure QueryGetMemory2;
begin
  AddInfo('');
  AddInfo('');
  AddInfo(PackStrR('страница', GetColWidth) + IntToStr(wPage1));
  
  InitPushCRC;
  Push(wPage1 div $100);
  Push(wPage1 mod $100);
  Query(quGetMemory2);
end;

procedure BoxGetMemory2;
begin
  InitPages;
  
  wPage0 := frmMain.updFlashIndexMin.Position;
  wPage1 := wPage0;
  wPage2 := frmMain.updFlashIndexMax.Position;

  AddInfo('');
  AddInfo('');
  AddInfo('Чтение памяти: от ' + IntToStr(wPage1) + ' до ' + IntToStr(wPage2) + ' (' + IntToStr(Abs(wPage0-wPage2)+1) + ' страниц)' );

  QueryGetMemory2;
end;

procedure ShowGetMemory2;
begin
  Stop;
  InitPop(15);

  AddInfoAll(TestPages('',wPageSize,wFreePageSize));

  ShowProgress(Abs(wPage0 - wPage1), Abs(wPage0 - wPage2) + 1);

  if wPage0 < wPage2 then begin
    Inc(wPage1);
    if wPage1 <= wPage2 then QueryGetMemory2 else begin
      AddInfoAll(ResultPages);
      BoxRun;
    end;
  end
  else begin
    Dec(wPage1);
    if wPage1 >= wPage2 then QueryGetMemory2 else begin
      AddInfoAll(ResultPages);
      BoxRun;
    end;
  end;
end;

end.
