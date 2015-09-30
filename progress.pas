unit progress;

interface

procedure ShowProgress(i: integer; j: integer);

implementation

uses main;

procedure ShowProgress(i: integer; j: integer);
begin
  with frmMain.prbMain do begin
    Min := 0;
    Max := j;
    Position := i+1;
  end;
end;

end.
