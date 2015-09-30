{---}
unit main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  basic, ComCtrls, ToolWin, StdCtrls, IniFiles, ExtCtrls, Math,
  Buttons, Mask, Grids, Menus, FileCtrl, OoMisc, AdPort, ImgList, CheckLst,
  AdTapi, AdTStat, IdBaseComponent, IdComponent, IdTCPConnection,
  IdTCPClient;

type
  TfrmMain = class(TfrmBasic)
    ComPort: TApdComPort;
    timTimeout: TTimer;
    timNow: TTimer;
    sd_RichToFile: TSaveDialog;
    stbMain: TStatusBar;
    panClient: TPanel;
    TapiDevice: TApdTapiDevice;
    TapiLog: TApdTapiLog;
    pgcMain: TPageControl;
    tbsFirst: TTabSheet;
    tbsLast: TTabSheet;
    panTop3: TPanel;
    panRight3: TPanel;
    btbClearTerminal: TBitBtn;
    btbSaveTerminal: TBitBtn;
    chbTerminal: TCheckBox;
    lblDevice: TLabel;
    lblAddress: TLabel;
    edtAddress: TEdit;
    updAddress: TUpDown;
    tbsParams: TTabSheet;
    panBottom2: TPanel;
    panRigth2: TPanel;
    btbCrealInfo: TBitBtn;
    btbSaveInfo: TBitBtn;
    btbStopInfo: TBitBtn;
    btbStopTerminal: TBitBtn;
    prbMain: TProgressBar;
    clbMain: TCheckListBox;
    panClient2: TPanel;
    memInfo: TMemo;
    ppmMain: TPopupMenu;
    mitVersion: TMenuItem;
    ppmList: TPopupMenu;
    mitSetItems: TMenuItem;
    mitClearItems: TMenuItem;
    splMain: TSplitter;
    lblColWidth: TLabel;
    lblDigits: TLabel;
    lblTunnel: TLabel;
    edtColWidth: TEdit;
    updColWidth: TUpDown;
    edtDigits: TEdit;
    updDigits: TUpDown;
    cmbTunnel: TComboBox;
    lblSetting: TLabel;
    chbUseTrans: TCheckBox;
    chbUseTariffs: TCheckBox;
    redTerminal: TMemo;
    panRight4: TPanel;
    clbCanals: TCheckListBox;
    clbGroups: TCheckListBox;
    ppmCan: TPopupMenu;
    mitSetCanals: TMenuItem;
    mitClearCanals: TMenuItem;
    ppmGrp: TPopupMenu;
    mitSetGroups: TMenuItem;
    mitClearGroups: TMenuItem;
    chbCtrlZ: TCheckBox;
    pgcTop2: TPageControl;
    tbsEnergy: TTabSheet;
    tbsFlash: TTabSheet;
    lblDaysFrom1: TLabel;
    lblDaysTo: TLabel;
    lblMonthFrom1: TLabel;
    lblMonthsTo: TLabel;
    lblDaysSize: TLabel;
    lblMonthsSize: TLabel;
    lblDays2From1: TLabel;
    lblDays2To: TLabel;
    lblDays2Name: TLabel;
    lblDays2Size: TLabel;
    lblMonthFrom2: TLabel;
    lblDaysFrom2: TLabel;
    lblDays2From2: TLabel;
    btbRun: TBitBtn;
    edtDaysMin: TEdit;
    edtDaysMax: TEdit;
    edtMonthsMin: TEdit;
    edtMonthsMax: TEdit;
    edtDays2Min: TEdit;
    edtDays2Max: TEdit;
    lblFlashIndexTo: TLabel;
    lblFlashIndex: TLabel;
    lblFlashIndexFrom: TLabel;
    edtFlashIndexMax: TEdit;
    updFlashIndexMax: TUpDown;
    edtFlashIndexMin: TEdit;
    updFlashIndexMin: TUpDown;
    btbRun2: TBitBtn;
    lblFlashDay: TLabel;
    edtFlashDayMin: TEdit;
    updFlashDayMin: TUpDown;
    lblFlashDayInfo: TLabel;
    lblFlashDayTo: TLabel;
    edtFlashDayMax: TEdit;
    updFlashDayMax: TUpDown;
    lblFlashDayFrom: TLabel;
    tbsCurrent: TTabSheet;
    edtShiftTo: TLabel;
    lblShift: TLabel;
    edtShiftFrom: TLabel;
    lblParam: TLabel;
    lblParamTo: TLabel;
    lblParamFrom: TLabel;
    edtShiftMax: TEdit;
    updShiftMax: TUpDown;
    edtShiftMin: TEdit;
    updShiftMin: TUpDown;
    btbRun3: TBitBtn;
    edtParamMin: TEdit;
    updParamMin: TUpDown;
    edtParamMax: TEdit;
    updParamMax: TUpDown;
    lblShiftRange: TLabel;
    lblParamRange: TLabel;
    tbsRecords: TTabSheet;
    btbRun4: TBitBtn;
    lblRecord: TLabel;
    lblRecordTo: TLabel;
    lblRecordFrom: TLabel;
    lblRecordRange: TLabel;
    edtRecordMin: TEdit;
    updRecordMin: TUpDown;
    edtRecordMax: TEdit;
    updRecordMax: TUpDown;
    chbBulk: TCheckBox;
    panTAPI: TPanel;
    memDial: TMemo;
    pgcMode: TPageControl;
    tbsPort: TTabSheet;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    lblTimeoutPort: TLabel;
    cmbComNumber: TComboBox;
    cmbBaud: TComboBox;
    cmbParity: TComboBox;
    edtTimeoutPort: TEdit;
    updTimeoutPort: TUpDown;
    tbsModem: TTabSheet;
    lblSelectedDevice: TLabel;
    lblTimeoutModem: TLabel;
    btbSelectDevice: TBitBtn;
    btbShowConfigDialog: TBitBtn;
    btbDial: TBitBtn;
    btbCancelCall: TBitBtn;
    edtDial: TEdit;
    edtTimeoutModem: TEdit;
    updTimeoutModem: TUpDown;
    tbsSocket: TTabSheet;
    lblTimeoutSocket: TLabel;
    lblSocketHost: TLabel;
    lblSocketPort: TLabel;
    btbSocketOpen: TBitBtn;
    edtSocketHost: TEdit;
    btbSocketClose: TBitBtn;
    edtSocketPort: TEdit;
    edtTimeoutSocket: TEdit;
    updTimeoutSocket: TUpDown;
    IdTCPClient: TIdTCPClient;
    rgrPacket: TRadioGroup;
    edtMemAddr: TEdit;
    edtMemSize: TEdit;
    procedure ShowConnect;
    procedure SetBaud(dwBaud: longword);
    procedure SetComNumber(wComNumber: word);
    procedure cmbComNumberChange(Sender: TObject);
    procedure cmbBaudChange(Sender: TObject);
    procedure SetParity(ibParity: byte);
    function GetParity: byte;
    function GetParityStr: string;
    function GetTimeout: word;
    procedure FormShow(Sender: TObject);
    procedure ComPortTriggerAvail(CP: TObject; Count: Word);
    procedure timTimeoutTimer(Sender: TObject);
    procedure timNowTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure cmbParityChange(Sender: TObject);
    procedure FocusTerminal;
    procedure ClearTerminal;
    procedure InsTerminal(stT: string; clOut: TColor);
    procedure AddTerminal(stT: string; clOut: TColor);
    procedure ComTerminal(stT: string);
    procedure AddTerminalTime(stT: string; clOut: TColor);
    procedure AddInfo(stT: string);
    procedure AddInfoAll(stT: TStrings);
    procedure ClearInfo;
    procedure ClearDial;
    procedure AddDial(stT: string);
    procedure InsByte(bT: byte; clT: TColor);
    procedure ShowSelectedDevice;
    procedure ShowTAPI(Flag: boolean);
    procedure TAPIoff;
    procedure TAPIon;
    procedure TapiDeviceTapiStatus(CP: TObject; First, Last: Boolean;
      Device, Message, Param1, Param2, Param3: Integer);
    procedure TapiDeviceTapiLog(CP: TObject; Log: TTapiLogCode);
    procedure TapiDeviceTapiPortOpen(Sender: TObject);
    procedure TapiDeviceTapiPortClose(Sender: TObject);
    procedure TapiDeviceTapiConnect(Sender: TObject);
    procedure TapiDeviceTapiFail(Sender: TObject);
    procedure btbClearTerminalClick(Sender: TObject);
    procedure btbSelectDeviceClick(Sender: TObject);
    procedure btbShowConfigDialogClick(Sender: TObject);
    procedure btbDialClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btbCancelCallClick(Sender: TObject);
    procedure btbStopInfoClick(Sender: TObject);
    procedure btbSaveTerminalClick(Sender: TObject);
    procedure SaveRich(Rich: TRichEdit; stName: string);
    procedure SaveMemo(Memo: TMemo; stName: string);
    procedure SaveLog(Memo: TMemo; stName: string);
    procedure ShowRepeat;
    procedure btbCrealInfoClick(Sender: TObject);
    procedure btbSaveInfoClick(Sender: TObject);
    procedure btbRunClick(Sender: TObject);
    procedure mitSetItemsClick(Sender: TObject);
    procedure mitClearItemsClick(Sender: TObject);
    procedure MasksCreate;
    procedure MasksShow;
    procedure mitSetCanalsClick(Sender: TObject);
    procedure mitClearCanalsClick(Sender: TObject);
    procedure mitSetGroupsClick(Sender: TObject);
    procedure mitClearGroupsClick(Sender: TObject);
    procedure clbMainMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure pgcModeChange(Sender: TObject);
    procedure btbSocketOpenClick(Sender: TObject);
    procedure btbSocketCloseClick(Sender: TObject);
    procedure IdTCPClientConnected(Sender: TObject);
    procedure IdTCPClientDisconnected(Sender: TObject);
    procedure IdTCPClientStatus(ASender: TObject; const AStatus: TIdStatus; const AStatusText: String);
    procedure IdTCPClientWork(Sender: TObject; AWorkMode: TWorkMode; const AWorkCount: Integer);
    procedure IdTCPClientWorkBegin(Sender: TObject; AWorkMode: TWorkMode; const AWorkCountMax: Integer);
    procedure IdTCPClientWorkEnd(Sender: TObject; AWorkMode: TWorkMode);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TSocketInputThread = class(TThread)
  private
    sBuff:    string;
    sCurr:    string;
    procedure HandleInput;
  protected
    procedure Execute; override;
  public
    function Data: string;
  end;

var
  frmMain:            TfrmMain;
  SocketInputThread:  TSocketInputThread;

implementation

{$R *.DFM}

uses support, kernel, soutput, sinput, ports, box, get_records;

var
  FIni:         TIniFile;
  stIni:        string;

procedure TSocketInputThread.HandleInput;
var
  cwIn: word;
begin
  with frmMain do begin
    timTimeout.Enabled := False;
    timTimeout.Enabled := True;

    cwIn := Length(sBuff);
    sCurr := sCurr + sBuff;

    AddTerminalTime('// принято ' + IntToStr(cwIn) + ' байт (доступно ' + IntToStr(Length(sCurr)) + ' из ' + IntToStr(queQueryCRC.cwIn) + ' байт)',clGray);

    if Length(sCurr) >= queQueryCRC.cwIn  then begin
      PostInputSocket(sCurr);
      sCurr := '';
    end;
  end;
end;

procedure TSocketInputThread.Execute;
begin
  with frmMain do begin
    while not Terminated do begin
      if not IdTCPClient.Connected then
        Terminate
      else
      try
        sBuff := IdTCPClient.CurrentReadBuffer;
        Synchronize(HandleInput);
      except
      end;
    end;
  end;
end;

function TSocketInputThread.Data: string;
begin
  Result := sCurr;
end;
  
procedure TfrmMain.ShowConnect;
begin
  with ComPort do
    stbMain.Panels[panCOMPORT].Text :=
      ' COM' + IntToStr(ComNumber) + ': ' + IntToStr(Baud) + ', ' + GetParityStr;
end;

procedure TfrmMain.SetComNumber(wComNumber: word);
begin
  try
    with ComPort do ComNumber := wComNumber;
    ShowConnect;
  except
    ErrBox('Ошибка при изменении номера порта: COM' + IntToStr(wComNumber));
  end;
end;

procedure TfrmMain.SetBaud(dwBaud: longword);
begin
  try
    with ComPort do begin
//      AutoOpen := False;

      Baud := dwBaud;
//      Open := True;
    end;

    ShowConnect;
  except
    ErrBox('Ошибка при изменении скорости обмена: ' + IntToStr(dwBaud) + ' бод');
  end;
end;

procedure TfrmMain.SetParity(ibParity: byte);
begin
  try
    with ComPort do case ibParity of
      1:   Parity := pEven;
      2:   Parity := pOdd;
      3:   Parity := pMark;
      4:   Parity := pSpace;
      else Parity := pNone;
    end;

    ShowConnect;
  except
    ErrBox('Ошибка при изменениии контроля чётности: ' + GetParityStr);
  end;
end;

function TfrmMain.GetParity: byte;
begin
  with ComPort do case Parity of
    pEven:  Result := 1;
    pOdd:   Result := 2;
    pMark:  Result := 3;
    pSpace: Result := 4;
    else    Result := 0;
  end;
end;

function TfrmMain.GetParityStr: string;
begin
  with ComPort do case Parity of
    pEven:  Result := 'even';
    pOdd:   Result := 'odd';
    pMark:  Result := 'mark';
    pSpace: Result := 'space';
    else    Result := 'none';
  end;
end;

function TfrmMain.GetTimeout: word;
begin
  if (pgcMode.ActivePage = tbsPort) then
    Result := updTimeoutPort.Position
  else if (pgcMode.ActivePage = tbsModem) then
    Result := updTimeoutModem.Position
  else begin
    Result := updTimeoutSocket.Position;
  end;
end;

procedure TfrmMain.cmbComNumberChange(Sender: TObject);
begin
  inherited;
  try
    with cmbComNumber do SetComNumber(ItemIndex+1);
  except
    ErrBox('Фатальная ошибка при изменении номера порта !');
  end;
end;

procedure TfrmMain.cmbBaudChange(Sender: TObject);
begin
  inherited;
  try
    with cmbBaud do SetBaud( GetBaudSize(ItemIndex) );
  except
    ErrBox('Фатальная ошибка при изменении скорости обмена !');
  end;
end;

procedure TfrmMain.cmbParityChange(Sender: TObject);
begin
  inherited;
  try
    with cmbParity do SetParity(ItemIndex);
  except
    ErrBox('Фатальная ошибка при изменении контроля чётности !');
  end;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
var
  i:  word;
begin
  inherited;
  lblDays2Size.Caption := '0..'+IntToStr(DAYS2-1);
  lblDaysSize.Caption := '0..'+IntToStr(DAYS-1);
  lblMonthsSize.Caption := '0..'+IntToStr(MONTHS-1);
  
  LoadCmbBauds(cmbBaud.Items);
  LoadCmbParitys(cmbParity.Items);

  try
    stIni := ChangeFileExt(ParamStr(0),'.ini');
    FileSetAttr(stIni, FileGetAttr(stIni) and not faReadOnly);
  except
  end;

  try
    FIni := TIniFile.Create(ChangeFileExt(ParamStr(0),'.ini'));

    with FIni do begin
      SetComNumber(ReadInteger(COM_PORT, NUMBER, 1));
      SetBaud(ReadInteger(COM_PORT, BAUD, 9600));
      SetParity(ReadInteger(COM_PORT, PARITY, 0));
      updTimeoutPort.Position := ReadInteger(COM_PORT, TIMEOUT, 1000);

      edtDial.Text := ReadString(MODEM, DIAL, '');
      TapiDevice.SelectedDevice := ReadString(MODEM, DEVICE, '');
      updTimeoutModem.Position := ReadInteger(MODEM, TIMEOUT, 4000);
      ShowSelectedDevice;

      edtSocketHost.Text := ReadString(SOCKET, HOST, '');
      edtSocketPort.Text := ReadString(SOCKET, PORT, '');
      updTimeoutSocket.Position := ReadInteger(SOCKET, TIMEOUT, 5000);

      updAddress.Position := ReadInteger(SETTING, ADDRESS, 0);
      rgrPacket.ItemIndex := ReadInteger(SETTING, PACKET, 1);

      pgcMode.TabIndex := FIni.ReadInteger(SETTING, MODE, 0);
      pgcModeChange(nil);

      Stop;

      edtDaysMin.Text   := ReadString(PARAMS, DAYS_MIN,   IntToStr(0));
      edtDaysMax.Text   := ReadString(PARAMS, DAYS_MAX,   IntToStr(DAYS-1));
      edtDays2Min.Text  := ReadString(PARAMS, DAYS2_MIN,  IntToStr(0));
      edtDays2Max.Text  := ReadString(PARAMS, DAYS2_MAX,  IntToStr(DAYS2-1));
      edtMonthsMin.Text := ReadString(PARAMS, MONTHS_MIN, IntToStr(0));
      edtMonthsMax.Text := ReadString(PARAMS, MONTHS_MAX, IntToStr(MONTHS-1));

      updFlashDayMin.Position   := ReadInteger(PARAMS, F_DAYS_MIN, 0);
      updFlashDayMax.Position   := ReadInteger(PARAMS, F_DAYS_MAX, 0);
      updFlashIndexMin.Position := ReadInteger(PARAMS, F_INDEX_MIN, 0);
      updFlashIndexMax.Position := ReadInteger(PARAMS, F_INDEX_MAX, 0);

      updParamMin.Position := ReadInteger(PARAMS, PARAMS_MIN, 1);
      updParamMax.Position := ReadInteger(PARAMS, PARAMS_MAX, 1);
      updShiftMin.Position := ReadInteger(PARAMS, SHIFT_MIN, 0);
      updShiftMax.Position := ReadInteger(PARAMS, SHIFT_MAX, 0);

      updRecordMin.Position := ReadInteger(PARAMS, RECORD_MIN, 0);
      updRecordMax.Position := ReadInteger(PARAMS, RECORD_MAX, wRECORD2_PAGES-1);

      updDigits.Position   := FIni.ReadInteger(PARAMS, DIGITS, 4);
      updColWidth.Position := FIni.ReadInteger(PARAMS, COLWIDTH, 12);
      cmbTunnel.ItemIndex  := FIni.ReadInteger(PARAMS, TUNNEL, 2);
      
      BoxCreate;
      MasksCreate;

      for i := 0 to clbMain.Count-1 do 
        clbMain.Checked[i] := ReadBool(OPTIONS, INQUIRY+IntTOStr(i), False);      

      for i := 0 to clbCanals.Count-1 do 
        clbCanals.Checked[i] := ReadBool(stCANALS, stCANAL_ITEM+IntTOStr(i), False);      
      for i := 0 to clbGroups.Count-1 do 
        clbGroups.Checked[i] := ReadBool(stGROUPS, stGROUP_ITEM+IntTOStr(i), False);      

      MasksShow;        
    end;
  except
    ErrBox('Ошибка при чтении настроек программы !');
  end;

  with ComPort do begin
    if (ComNumber < 1) or (ComNumber > 16) then begin
      ErrBox('Ошибочный номер порта: COM' + IntToStr(ComNumber));
      ComNumber := 0;
    end;
    cmbComNumber.ItemIndex := ComNumber-1;

    if cmbBaud.Items.IndexOf( IntToStr(Baud) ) = -1 then begin
      ErrBox('Ошибочная скорость обмена: ' + IntToStr(Baud)  + ' бод');
      Baud := 9600;
    end;
    cmbBaud.ItemIndex := cmbBaud.Items.IndexOf( IntToStr(Baud) );
  end;

  cmbParity.ItemIndex := GetParity;
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
  inherited;
  pgcMain.ActivePage := tbsFirst;
  pgcTop2.ActivePage := tbsEnergy;
  Application.Title := Caption;
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
var
  i:  word;
begin
  inherited;
  Stop;

  try
    with FIni do begin
      WriteInteger(COM_PORT, NUMBER, ComPort.ComNumber);
      WriteInteger(COM_PORT, BAUD, ComPort.Baud);
      WriteInteger(COM_PORT, PARITY, GetParity);
      WriteInteger(COM_PORT, TIMEOUT, updTimeoutPort.Position);

      WriteString(MODEM, DIAL, edtDial.Text);
      WriteString(MODEM, DEVICE, TapiDevice.SelectedDevice);
      WriteInteger(MODEM, TIMEOUT, updTimeoutModem.Position);

      WriteString(SOCKET, HOST, edtSocketHost.Text);
      WriteString(SOCKET, PORT, edtSocketPort.Text);
      WriteInteger(SOCKET, TIMEOUT, updTimeoutSocket.Position);
      WriteString(SOCKET, VERSION, '2');

      WriteInteger(SETTING, MODE, pgcMode.ActivePageIndex);
      WriteInteger(SETTING, ADDRESS, updAddress.Position);
      WriteInteger(SETTING, PACKET, rgrPacket.ItemIndex);

      WriteString(PARAMS, DAYS_MIN,   edtDaysMin.Text);
      WriteString(PARAMS, DAYS_MAX,   edtDaysMax.Text);
      WriteString(PARAMS, DAYS2_MIN,  edtDays2Min.Text);
      WriteString(PARAMS, DAYS2_MAX,  edtDays2Max.Text);
      WriteString(PARAMS, MONTHS_MIN, edtMonthsMin.Text);
      WriteString(PARAMS, MONTHS_MAX, edtMonthsMax.Text);

      WriteInteger(PARAMS, F_DAYS_MIN,  updFlashDayMin.Position);
      WriteInteger(PARAMS, F_DAYS_MAX,  updFlashDayMax.Position);
      WriteInteger(PARAMS, F_INDEX_MIN, updFlashIndexMin.Position);
      WriteInteger(PARAMS, F_INDEX_MAX, updFlashIndexMax.Position);

      WriteInteger(PARAMS, PARAMS_MIN, updParamMin.Position);
      WriteInteger(PARAMS, PARAMS_MAX, updParamMax.Position);
      WriteInteger(PARAMS, SHIFT_MIN,  updShiftMin.Position);
      WriteInteger(PARAMS, SHIFT_MAX,  updShiftMax.Position);
      WriteInteger(PARAMS, RECORD_MIN, updRecordMin.Position);
      WriteInteger(PARAMS, RECORD_MAX, updRecordMax.Position);

      WriteInteger(PARAMS, DIGITS,    updDigits.Position);
      WriteInteger(PARAMS, COLWIDTH,  updColWidth.Position);
      WriteInteger(PARAMS, TUNNEL,    cmbTunnel.ItemIndex);

      for i := 0 to clbMain.Count-1 do 
        WriteBool(OPTIONS, INQUIRY+IntTOStr(i), clbMain.Checked[i]);
        
      for i := 0 to clbCanals.Count-1 do 
        WriteBool(stCANALS, stCANAL_ITEM+IntTOStr(i), clbCanals.Checked[i]);        
      for i := 0 to clbGroups.Count-1 do 
        WriteBool(stGROUPS, stGROUP_ITEM+IntTOStr(i), clbGroups.Checked[i]);
    end;
  except
    ErrBox('Ошибка при записи настроек программы !');
  end;
end;

procedure TfrmMain.ComPortTriggerAvail(CP: TObject; Count: Word);
begin
  inherited;
  if chbBulk.Checked then
    ComTerminal('// доступно ' + IntToStr(ComPort.InBuffUsed) + ' байт; ' + FormatDateTime('hh:mm:ss:zzz',Now));

  timTimeout.Enabled := False;    // перезапуск таймера
  timTimeout.Enabled := True;

  with ComPort do if InBuffUsed >= queQueryCRC.cwIn then begin
    ComTerminal('// приём по количеству байт: ' + IntToStr(InBuffUsed) + ' из ' + IntToStr(queQueryCRC.cwIn));
    PostInputComPort;
  end;
end;

procedure TfrmMain.timTimeoutTimer(Sender: TObject);
begin
  inherited;
  timTimeout.Enabled := False;

  ComTerminal('// приём по таймауту: ' + IntToStr(GetTimeout) + ' мс');
  
  if (pgcMode.ActivePage = tbsPort) or (pgcMode.ActivePage = tbsModem) then
    PostInputComPort
  else begin
    if SocketInputThread <> nil then PostInputSocket(SocketInputThread.Data);
  end;
end;


procedure TfrmMain.timNowTimer(Sender: TObject);
begin
  inherited;
  stbMain.Panels[panNOW].Text := ' ' + FormatDateTime('hh:mm:ss dd.mm.yyyy',Now);

  if TapiDevice.TapiState = tsConnected then begin
    Inc(cwConnect);
    stbMain.Panels[panCONNECT].Text := ' соединение: ' + IntToStr(timNow.Interval * cwConnect div 1000) + ' сек';
  end;
end;

procedure TfrmMain.FormResize(Sender: TObject);
var
  i,j:  word;
begin
  inherited;
  with prbMain do begin
    Top := stbMain.Top;

    j := 0;
    for i := 0 to panPROGRESS-1 do j := j + stbMain.Panels[i].Width;

    Left := j;
    Width := stbMain.Width - j;
  end;
end;

procedure TfrmMain.FocusTerminal;
begin
  if chbTerminal.Checked then begin
    try
      with redTerminal do if CanFocus and Visible then SetFocus;
    except
    end;
  end;
end;

procedure TfrmMain.ClearTerminal;
begin
  redTerminal.Clear;
end;

procedure TfrmMain.InsTerminal(stT: string; clOut: TColor);
begin
  {if chbTerminal.Checked then} begin
    try
      FocusTerminal;
      with redTerminal do begin
//        SelAttributes.Color := clOut;
        SelText := stT;
      end;
    except
    end;
  end;
end;

procedure TfrmMain.AddTerminal(stT: string; clOut: TColor);
begin
  if chbTerminal.Checked then begin
    try
      FocusTerminal;
      with redTerminal do begin
        //SelAttributes.Color := clOut;
        Lines.Append(stT);
      end;
    except
    end;
  end;
end;

procedure TfrmMain.AddTerminalTime(stT: string; clOut: TColor);
begin
  AddTerminal(stT + '   // ' + FormatDateTime('hh:mm:ss dd.mm.yyyy',Now), clOut);
end;

procedure TfrmMain.ComTerminal(stT: string);
//var
//  Charset: TFontCharset;
begin
  if chbTerminal.Checked then begin
    try
      FocusTerminal;
      with redTerminal do begin
        //SelAttributes.Color := clGray;

        //Charset := SelAttributes.CharSet;
        //SelAttributes.CharSet := RUSSIAN_CHARSET;
        Lines.Append(stT);
        //SelAttributes.CharSet := Charset;
      end;
    except
    end;
  end;
end;

procedure TfrmMain.AddInfo(stT: string);
begin
  try
    memInfo.Lines.Append(stT);
    AddTerminal(stT, clGray);
  except
  end
end;

procedure TfrmMain.AddInfoAll(stT: TStrings);
begin
  try
    memInfo.Lines.AddStrings(stT);
    memInfo.Lines.Append(' ');
    redTerminal.Lines.AddStrings(stT);
    redTerminal.Lines.Append(' ');
    stT.Free;
  except
  end
end;

procedure TfrmMain.ClearInfo;
begin
  memInfo.Clear;
end;

procedure TfrmMain.ClearDial;
begin
  memDial.Clear;
end;

procedure TfrmMain.AddDial(stT: string);
begin
  try
    memDial.Lines.Append(stT);
  except
  end
end;

procedure TfrmMain.InsByte(bT: byte; clT: TColor);
begin
  InsTerminal(IntToHex(bT,2) + ' ', clT);
end;

procedure TfrmMain.ShowSelectedDevice;
begin
  lblSelectedDevice.Caption := TapiDevice.SelectedDevice;
end;

procedure TfrmMain.ShowTAPI(Flag: boolean);
begin
  btbSelectDevice.Enabled       := Flag;
  btbShowConfigDialog.Enabled   := Flag;
  lblSelectedDevice.Enabled     := Flag;
  btbDial.Enabled               := Flag;
  edtDial.Enabled               := Flag;
  btbCancelCall.Enabled         := Flag;
  memDial.Enabled               := Flag;

  cmbComNumber.Enabled          := not Flag;
  cmbBaud.Enabled               := not Flag;
  cmbParity.Enabled             := not Flag;
end;

procedure TfrmMain.TAPIoff;
begin
  inherited;
  try
    with ComPort do begin
      TapiMode := tmOff;

      AutoOpen := False;
      Open := True;
    end;
    ShowSelectedDevice;
  except
    ErrBox('Ошибка при открытии порта COM' + IntToStr(ComPort.ComNumber));
  end;
end;

procedure TfrmMain.TAPIon;
begin
  inherited;
  with ComPort do begin
    TapiMode := tmOn;

    AutoOpen := False;
    Open := False;
  end;
  ShowSelectedDevice;
end;

procedure TfrmMain.TapiDeviceTapiStatus(CP: TObject; First,
  Last: Boolean; Device, Message, Param1, Param2, Param3: Integer);
begin
  inherited;
  AddTerminal('OnTapiStatus event',clGray);

  if First then
    AddTerminal('First event',clGray)
  else if Last then
    AddTerminal('Last event',clGray)
  else with TapiDevice do begin
    AddTerminal('событие: ' + TapiStatusMsg(Message,Param1,Param2) + ' ' + Number,clGray);
    AddDial('событие: ' + TapiStatusMsg(Message,Param1,Param2) + ' ' + Number);
  end;
end;

procedure TfrmMain.TapiDeviceTapiLog(CP: TObject; Log: TTapiLogCode);
begin
  inherited;
//  AddTerminal('OnTapiLog event',clGray);
end;

procedure TfrmMain.TapiDeviceTapiPortOpen(Sender: TObject);
begin
  inherited;
  AddTerminal('OnTapiPortOpen event',clGray);
  AddDial('порт открыт');
end;

procedure TfrmMain.TapiDeviceTapiPortClose(Sender: TObject);
begin
  inherited;
  AddTerminal('OnTapiPortClose event',clGray);
  AddDial('порт закрыт');
end;

procedure TfrmMain.TapiDeviceTapiConnect(Sender: TObject);
begin
  inherited;
  AddTerminal('OnTapiConnect event',clGray);

  with TapiDevice do begin
    AddTerminal('connect at ' + IntToStr(BPSRate),clGray);
    AddDial('соединение на скорости ' + IntToStr(BPSRate) + ' бод');

    InfBox('Установлено соединение с ' + edtDial.Text + ' на скорости ' + IntToStr(BPSRate) + ' бод');
  end;
end;

procedure TfrmMain.TapiDeviceTapiFail(Sender: TObject);
begin
  inherited;
  AddTerminal('OnTapiFail event',clGray);

  with TapiDevice do begin
    AddTerminal('fail: ' + FailureCodeMsg(FailureCode),clGray);
    AddDial('ошибка: ' + FailureCodeMsg(FailureCode));

    InfBox('Ошибка: ' + FailureCodeMsg(FailureCode));
  end;
end;

procedure TfrmMain.btbClearTerminalClick(Sender: TObject);
begin
  inherited;
  SaveLog(redTerminal, 'Терминал ' + DateTime2Str + ' ');
  ClearTerminal;
end;

procedure TfrmMain.btbSelectDeviceClick(Sender: TObject);
begin
  inherited;
  try
    TapiDevice.SelectDevice;
    ClearDial;
  except
    on e: Exception do ErrBox('Ошибка при выборе модема: ' + e.Message);
  end;

  ShowSelectedDevice;
end;

procedure TfrmMain.btbShowConfigDialogClick(Sender: TObject);
begin
  inherited;
  try
    TapiDevice.ShowConfigDialog;
  except
    on e: Exception do ErrBox('Ошибка при настройке модема: ' + e.Message);
  end;
end;

procedure TfrmMain.btbDialClick(Sender: TObject);
begin
  inherited;
  try
    TapiDevice.Dial(edtDial.Text);
  except
    on e: Exception do ErrBox('Ошибка при установлении соединения: ' + e.Message);
  end;
end;

procedure TfrmMain.btbCancelCallClick(Sender: TObject);
begin
  inherited;
  try
    TapiDevice.CancelCall;
    AddDial('отбой !');
  except
    on e: Exception do ErrBox('Ошибка при разрыве связи: ' + e.Message);
  end;
end;

procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  if TapiDevice.TapiState = tsConnected then begin
    WrnBox('Модем находится в состоянии соединения.'+ #10#13 +
           'Перед выходом из программы необходимо разорвать связь !');
    Abort;
  end;

  timNow.Enabled := False;
  Stop;
  
  btbClearTerminalClick(nil);
end;

procedure TfrmMain.btbStopInfoClick(Sender: TObject);
begin
  inherited;
  Stop;
end;

procedure TfrmMain.SaveRich(Rich: TRichEdit; stName: string);
begin
  with sd_RichToFile,Rich do begin
    try
      InitialDir := ExtractFileDir(ParamStr(0));

      ForceDirectories(InitialDir);
      FileName := stName + '.rtf';

      if Execute then Rich.Lines.SaveToFile(FileName);
    except
      ErrBox('Ошибка при сохранении отчёта !')
    end;
  end;
end;

procedure TfrmMain.SaveMemo(Memo: TMemo; stName: string);
begin
  with sd_RichToFile,Memo do begin
    try
      InitialDir := ExtractFileDir(ParamStr(0));

      ForceDirectories(InitialDir);
      FileName := stName + '.txt';

      if Execute then Memo.Lines.SaveToFile(FileName);
    except
      ErrBox('Ошибка при сохранении отчёта !')
    end;
  end;
end;

procedure TfrmMain.SaveLog(Memo: TMemo; stName: string);
var
  s: string;
begin
  with Memo do if Lines.Count > 0 then begin
    try
      s := ExtractFileDir(ParamStr(0)) + '\'+ LOGS_DIR + '\'+ FormatDateTime('dd_mm_yyyy',Now) + '\';
      ForceDirectories(s);
      
      Memo.Lines.Append('');
      Memo.Lines.Append('// '+mitVersion.Caption);
      
      Memo.Lines.SaveToFile(s + stName + '.log');
    except
      ErrBox('Ошибка при сохранении отчёта !')
    end;
  end;
end;

procedure TfrmMain.btbSaveTerminalClick(Sender: TObject);
begin
  inherited;
  SaveLog(redTerminal, 'Терминал ' + DateTime2Str + ' ');
  SaveMemo(redTerminal, 'Терминал ' + DateTime2Str + ' ');
end;

procedure TfrmMain.ShowRepeat;
begin
  inherited;
  stbMain.Panels[panREPEATS].Text := ' повтор: ' + IntToStr(cbIncRepeat) + '  ' + IntToStr(100*cbIncRepeat div cwIncTotal)+'%';
end;

procedure TfrmMain.btbCrealInfoClick(Sender: TObject);
begin
  inherited;
  SaveLog(redTerminal, 'Терминал ' + DateTime2Str + ' ');
  ClearInfo;
end;

procedure TfrmMain.btbSaveInfoClick(Sender: TObject);
begin
  inherited;
  SaveMemo(memInfo, 'Отчет ' + DateTime2Str + ' ');
end;

procedure TfrmMain.btbRunClick(Sender: TObject);
begin
  inherited;
  BoxRead;
end;

procedure TfrmMain.mitSetItemsClick(Sender: TObject);
var
  i:  byte;
begin
  inherited;
  with clbMain do for i := 0 to Count-1 do Checked[i] := True;  
end;

procedure TfrmMain.mitClearItemsClick(Sender: TObject);
var
  i:  byte;
begin
  inherited;
  with clbMain do for i := 0 to Count-1 do Checked[i] := False;
end;

procedure TfrmMain.MasksCreate;
var
  i:  byte;
begin
  with clbCanals do
    for i := 0 to CANALS-1 do begin
      Items.Add('К ' + IntToStr(i+1));
    end;

  with clbGroups do
    for i := 0 to GROUPS-1 do begin
      Items.Add('Г ' + IntToStr(i+1));
    end;    
end;

procedure TfrmMain.MasksShow;
var
  i:  byte;
begin
  inherited;
{  cbCanMask := 0;
  for i := 0 to CANALS-1 do
    if clbCan.Checked[i] = True then Inc(cbCanMask);

  stbMask.Panels[0].Text := 'каналов: ' + IntToStr(cbCanMask);

  cbGrpMask := 0;
  for i := 0 to GROUPS-1 do
    if clbGrp.Checked[i] = True then Inc(cbGrpMask);

  stbMask.Panels[1].Text := 'групп: ' + IntToStr(cbGrpMask);}
end;

procedure TfrmMain.mitSetCanalsClick(Sender: TObject);
var
  i:  byte;
begin
  inherited;
  with clbCanals do for i := 0 to CANALS-1 do Checked[i] := True;
  MasksShow;
end;

procedure TfrmMain.mitClearCanalsClick(Sender: TObject);
var
  i:  byte;
begin
  inherited;
  with clbCanals do for i := 0 to CANALS-1 do Checked[i] := False;
  MasksShow;
end;

procedure TfrmMain.mitSetGroupsClick(Sender: TObject);
var
  i:  byte;
begin
  inherited;
  with clbGroups do for i := 0 to GROUPS-1 do Checked[i] := True;
  MasksShow;
end;

procedure TfrmMain.mitClearGroupsClick(Sender: TObject);
var
  i:  byte;
begin
  inherited;
  with clbGroups do for i := 0 to GROUPS-1 do Checked[i] := False;
  MasksShow;
end;

procedure TfrmMain.clbMainMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
const
  a: Longint = -1;
var
  b: Longint;
begin
  inherited;
  with Sender as TCheckListBox do begin
    b := ItemAtPos(Point(x,y),True);
    if (b < 0) or (b = a) then Exit;
    Application.ProcessMessages; 
    Application.CancelHint;
    a := b;
    Hint := '';
    //if Canvas.TextWidth(Items[b]) > Width - 4 then 
      Hint := Items[b];
  end;
end;

procedure TfrmMain.pgcModeChange(Sender: TObject);
begin
  inherited;
  if pgcMode.ActivePage = tbsPort then begin
    TAPIoff;
  end
  else if pgcMode.ActivePage = tbsModem then begin
    TAPIon;
  end
  else if pgcMode.ActivePage = tbsSocket then begin
  end
end;

procedure TfrmMain.btbSocketOpenClick(Sender: TObject);
var
  Port: word;
begin
  inherited;
  try
    Port := StrToIntDef(edtSocketPort.Text, 0);

    if (Port = 0) then
      ErrBox('Порт сокета задан неправильно')
    else begin
      IdTCPClient.Host := edtSocketHost.Text;
      IdTCPClient.Port := Port;
      IdTCPClient.Connect;

      SocketInputThread := TSocketInputThread.Create(True);
      SocketInputThread.FreeOnTerminate := True;
      SocketInputThread.Resume;
    end;
  except
    on e: Exception do ErrBox('Ошибка при открытии сокета: ' + e.Message);
  end;
end;

//http://stackoverflow.com/questions/12507677/terminate-a-thread-and-disconnect-an-indy-client
procedure TfrmMain.btbSocketCloseClick(Sender: TObject);
begin
  inherited;
  try
    if SocketInputThread <> nil then SocketInputThread.Terminate;
    try
      if IdTCPClient.Connected then IdTCPClient.Disconnect;
    finally
      if SocketInputThread <> nil then
      begin
        SocketInputThread.WaitFor;
        SocketInputThread.Free;
        SocketInputThread := nil;
      end;
    end;
  except
    on e: Exception do AddTerminalTime('Ошибка при закрытии сокета: ' + e.Message,clGray);
  end;
end;

procedure TfrmMain.IdTCPClientConnected(Sender: TObject);
var
  s: string;
begin
  inherited;
  s := 'Установлено соединение c сокетом: ' + IdTCPClient.Host + ':' + IntToStr(IdTCPClient.Port);

  AddTerminalTime(s,clGray);
  AddDial(s);
  InfBox(s);
end;

procedure TfrmMain.IdTCPClientDisconnected(Sender: TObject);
var
  s: string;
begin
  inherited;
  s := 'Отсоединение';

  AddTerminalTime(s,clGray);
  AddDial(s);
end;

procedure TfrmMain.IdTCPClientStatus(ASender: TObject; const AStatus: TIdStatus; const AStatusText: String);
var
  s: string;
begin
  inherited;
  s := 'Событие: ' + AStatusText;

  AddTerminalTime(s,clGray);
  AddDial(s);
end;

procedure TfrmMain.IdTCPClientWorkBegin(Sender: TObject; AWorkMode: TWorkMode; const AWorkCountMax: Integer);
var
  s: string;
begin
  inherited;
  if AWorkMode = wmRead then
    s := 'чтение начато: максимум ' + IntToStr(AWorkCountMax) + ' байт'
  else
    s := 'запись начата: максимум ' + IntToStr(AWorkCountMax) + ' байт';

  AddTerminalTime(s,clGray);
  AddDial(s);
end;

procedure TfrmMain.IdTCPClientWork(Sender: TObject; AWorkMode: TWorkMode; const AWorkCount: Integer);
var
  s: string;
begin
  inherited;
  if AWorkMode = wmRead then
    s := 'чтение: ' + IntToStr(AWorkCount) + ' байт'
  else
    s := 'запись: ' + IntToStr(AWorkCount) + ' байт';

  AddTerminalTime(s,clGray);
  AddDial(s);
end;

procedure TfrmMain.IdTCPClientWorkEnd(Sender: TObject; AWorkMode: TWorkMode);
var
  s: string;
begin
  inherited;
  if AWorkMode = wmRead then
    s := 'чтение закончено'
  else
    s := 'запись закончена';

  AddTerminalTime(s,clGray);
  AddDial(s);
end;

end.



