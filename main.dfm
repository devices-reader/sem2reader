�
 TFRMMAIN 0*D  TPF0�TfrmMainfrmMainLeft� Top� BorderStylebsSingleCaption=   Чтение параметров сумматора СЭМ+2ClientHeight�ClientWidth�WindowStatewsMaximizedOnClose	FormCloseOnCreate
FormCreate	OnDestroyFormDestroyOnResize
FormResizeOnShowFormShowExplicitWidth�ExplicitHeightPixelsPerInchx
TextHeight 
TStatusBarstbMainLeft Top�Width�HeightPanelsWidth�  Width�  Width�  Width�  Width�  Width,  SizeGripOnDrawPanelstbMainDrawPanel  TPanel	panClientLeft Top Width�Height�AlignalClient
BevelOuterbvNoneTabOrder TPageControlpgcMainLeft Top Width�Height�
ActivePage	tbsParamsAlignalClientTabOrder  	TTabSheettbsFirstCaption
   !>548=5=85	PopupMenuppmMain TLabel	lblDeviceLeftTopWidth� HeightCaption   Параметры обмена  TLabel
lblAddressLeftTop4Width,HeightCaption   4@5A  TLabellblColWidthLeft� TopZWidth� HeightCaption*   Ширина столбца таблицы  TLabel	lblDigitsLeft� Top4Width� HeightCaption;   Количество знаков после запятой  TLabel	lblTunnelLeftTop� Width=HeightCaption   "C==5;L  TLabel
lblSettingLeft� TopWidth� HeightCaption   Параметры отчета  TEdit
edtAddressLeftdTop0Width@HeightTabOrder Text0  TUpDown
updAddressLeft� Top0WidthHeight	Associate
edtAddressMax� TabOrder	Thousands  TEditedtColWidthLeft�TopVWidth#HeightTabOrderText10  TUpDownupdColWidthLeftTopVWidthHeight	AssociateedtColWidthMinPosition
TabOrder	Thousands  TEdit	edtDigitsLeft�Top0Width#HeightTabOrderText4  TUpDown	updDigitsLeftTop0WidthHeight	Associate	edtDigitsMax
PositionTabOrder	Thousands  	TComboBox	cmbTunnelLeftlTop� WidthUHeightStylecsDropDownListTabOrderItems.Strings
   порт 1
   порт 2
   порт 3
   порт 4   	TCheckBoxchbUseTransLeft� Top� Width�HeightCaption�   при расчете энергии по каналам за сутки/месяц использовать коэффициент трансформацииChecked	State	cbCheckedTabOrder  	TCheckBoxchbUseTariffsLeft� Top� Width�HeightCaption�   при расчете энергии по каналам/группам за сутки/месяц выдавать результат по тарифамTabOrder  	TCheckBoxchbCtrlZLeft� Top� Width�HeightCaption�   выдавать Ctrl Z перед началом опроса (необходимо, если порт является ведущим)TabOrder	  TPanelpanTAPILeft TopdWidth�HeightXAlignalBottom
BevelOuterbvNoneTabOrder
 TMemomemDialLeft Top� Width�Height� AlignalBottomFont.CharsetRUSSIAN_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameLucida Console
Font.Style 
ParentFontReadOnly	
ScrollBarsssBothTabOrder   TPageControlpgcModeLeft Top Width�Height� 
ActivePagetbsPortAlignalClientTabOrderOnChangepgcModeChange 	TTabSheettbsPortCaption   >@B TLabellblPortLeftTopWidth%HeightCaption   >@B  TLabellblBaudLeftTop4WidthDHeightCaption   !:>@>ABL  TLabel	lblParityLeftTopZWidthCHeightCaption   'QB=>ABL  TLabellblTimeoutPortLeftTop� WidthXHeightCaption   Таймаут, мсParentShowHintShowHint	  	TComboBoxcmbComNumberLeftwTop
Width_HeightStylecsDropDownListDropDownCountTabOrder OnChangecmbComNumberChangeItems.StringsCOM1COM2COM3COM4COM5COM6COM7COM8COM9COM10COM11COM12COM13COM14COM15COM16   	TComboBoxcmbBaudLeftwTop0Width_HeightStylecsDropDownListDropDownCountTabOrderOnChangecmbBaudChangeItems.Strings300600120024004800960019200   	TComboBox	cmbParityLeftwTopVWidth`HeightStylecsDropDownListTabOrderOnChangecmbParityChangeItems.Stringsnoneevenoddmarkspace   TEditedtTimeoutPortLeftwTop|WidthIHeightParentShowHintShowHint	TabOrderText500  TUpDownupdTimeoutPortLeft� Top|WidthHeight	AssociateedtTimeoutPortMin2Max0u	Increment2ParentShowHintPosition�ShowHint	TabOrder	Thousands   	TTabSheettbsModemCaption   >45<
ImageIndex TLabellblSelectedDeviceLeftVTopWidthyHeightCaptionlblSelectedDevice  TLabellblTimeoutModemLeftTopwWidthXHeightCaption   Таймаут, мсParentShowHintShowHint	  TBitBtnbtbSelectDeviceLeftTopWidth� HeightCaption   >45<MarginTabOrder OnClickbtbSelectDeviceClick  TBitBtnbtbShowConfigDialogLeft� TopWidth� HeightCaption	   0AB@>9:0Margin	NumGlyphsTabOrderOnClickbtbShowConfigDialogClick  TBitBtnbtbDialLeftTopCWidth� HeightCaption   K7>2Margin	NumGlyphsTabOrderOnClickbtbDialClick  TBitBtnbtbCancelCallLeftVTopCWidth� HeightCaption   B1>9MarginTabOrderOnClickbtbCancelCallClick  TEditedtDialLeft� TopCWidth� HeightTabOrder  TEditedtTimeoutModemLeftwToprWidthIHeightParentShowHintShowHint	TabOrderText500  TUpDownupdTimeoutModemLeft� ToprWidthHeight	AssociateedtTimeoutModemMin2Max0u	Increment2ParentShowHintPosition�ShowHint	TabOrder	Thousands   	TTabSheet	tbsSocketCaption   !>:5B
ImageIndex TLabellblTimeoutSocketLeftTopwWidthXHeightCaption   Таймаут, мсParentShowHintShowHint	  TLabellblSocketHostLeft� TopWidth!HeightCaption   %>AB  TLabellblSocketPortLeft� TopGWidth%HeightCaption   >@B  TBitBtnbtbSocketOpenLeftTopWidth� HeightCaption   K7>2Margin	NumGlyphsTabOrder OnClickbtbSocketOpenClick  TEditedtSocketHostLeft� TopWidth� HeightTabOrder  TBitBtnbtbSocketCloseLeftTopCWidth� HeightCaption   B<5=0MarginTabOrderOnClickbtbSocketCloseClick  TEditedtSocketPortLeft� TopCWidth� HeightTabOrder  TEditedtTimeoutSocketLeftwToprWidthIHeightParentShowHintShowHint	TabOrderText500  TUpDownupdTimeoutSocketLeft� ToprWidthHeight	AssociateedtTimeoutSocketMin2Max0u	Increment2ParentShowHintPosition�ShowHint	TabOrder	Thousands     TRadioGroup	rgrPacketLeftTop~Width� Height]Caption    Протокол 	ItemIndexItems.StringsCRCEcs+CRC   # TabOrder   	TTabSheet	tbsParamsCaption	   0@0<5B@K
ImageIndex 	TSplittersplMainLefttTop WidthHeight�AutoSnapMinSizex  TPanel
panBottom2Left Top�Width�Height0AlignalBottom
BevelOuterbvNoneTabOrder  TPanel	panRigth2Left�Top Width�Height0AlignalRight
BevelOuterbvNoneTabOrder  TBitBtnbtbCrealInfoLeft� Top
WidthwHeightCaption   G8AB8BLMarginTabOrderOnClickbtbCrealInfoClick  TBitBtnbtbSaveInfoLeftTop
WidthwHeightCaption   В файл  Margin	NumGlyphsTabOrder OnClickbtbSaveInfoClick  TBitBtnbtbStopInfoLeftTop
WidthwHeightCaption
   Стоп !MarginTabOrderOnClickbtbStopInfoClick    TCheckListBoxclbMainLeft Top WidthtHeight�AlignalLeft
ItemHeightParentShowHint	PopupMenuppmListShowHint	TabOrderOnMouseMoveclbMainMouseMove  TPanel
panClient2LeftzTop WidthwHeight�AlignalClient
BevelOuterbvNoneTabOrder TMemomemInfoLeft Top� WidthwHeight�AlignalClientFont.CharsetRUSSIAN_CHARSET
Font.ColorclGrayFont.Height�	Font.NameLucida Console
Font.Style 
ParentFont
ScrollBarsssBothTabOrder   TPageControlpgcTop2Left Top WidthwHeight� 
ActivePagetbsFlashAlignalTopTabOrder 	TTabSheet	tbsEnergyCaption   A=>2=K5 TLabellblDaysFrom1Left� Top4Width.HeightCaption   сутки:  TLabel	lblDaysToLeft'Top4WidthHeightCaption   4>  TLabellblMonthFrom1Left� TopZWidth;HeightCaption   месяцы:  TLabellblMonthsToLeft'TopZWidthHeightCaption   4>  TLabellblDaysSizeLeftsTop4WidthHeightCaption?  TLabellblMonthsSizeLeftsTopZWidthHeightCaption?  TLabellblDays2From1Left� TopWidth.HeightCaption   сутки:  TLabel
lblDays2ToLeft'TopWidthHeightCaption   4>  TLabellblDays2NameLeftsTopWidthdHeightCaption   по получасам  TLabellblDays2SizeLeft�TopWidthHeightCaption?  TLabellblMonthFrom2Left� TopZWidthHeightCaption   >B  TLabellblDaysFrom2Left� Top4WidthHeightCaption   >B  TLabellblDays2From2Left� TopWidthHeightCaption   >B  TBitBtnbtbRunLeft
Top
WidthvHeightCaption	   @>G8B0BLMarginTabOrder OnClickbtbRunClick  TEdit
edtDaysMinLeft� Top0Width&HeightTabOrderText1  TEdit
edtDaysMaxLeftCTop0Width&HeightTabOrderText62  TEditedtMonthsMinLeft� TopVWidth&HeightTabOrderText0  TEditedtMonthsMaxLeftCTopVWidth&HeightTabOrderText12  TEditedtDays2MinLeft� Top
Width&HeightTabOrderText0  TEditedtDays2MaxLeftCTop
Width&HeightTabOrderText60   	TTabSheettbsFlashCaption   Параметры памяти
ImageIndexExplicitLeftExplicitTop TLabellblFlashIndexToLeft[Top4WidthHeightCaption   4>  TLabellblFlashIndexLeft� Top4WidthIHeightCaption   страница:  TLabellblFlashIndexFromLeft� Top4WidthHeightCaption   >B  TLabellblFlashDayLeft� TopWidth.HeightCaption   сутки:  TLabellblFlashDayInfoLeft�TopWidth� HeightCaption   по получасам 0..61  TLabellblFlashDayToLeft[TopWidthHeightCaption   4>  TLabellblFlashDayFromLeft� TopWidthHeightCaption   >B  TLabel
lblMemAddrLeft� Top\Width/HeightCaption   адрес:  TLabel
lblMemSizeLeftCTop\Width2HeightCaption   длина:  TEditedtFlashIndexMaxLeftxTop0Width0HeightTabOrder Text0  TUpDownupdFlashIndexMaxLeft�Top0WidthHeight	AssociateedtFlashIndexMaxMax'TabOrder	Thousands  TEditedtFlashIndexMinLeft� Top0Width1HeightTabOrderText0  TUpDownupdFlashIndexMinLeft(Top0WidthHeight	AssociateedtFlashIndexMinMax'TabOrder	Thousands  TBitBtnbtbRun2Left
Top
WidthvHeightCaption	   @>G8B0BLMarginTabOrderOnClickbtbRunClick  TEditedtFlashDayMinLeft� Top
Width1HeightTabOrderText0  TUpDownupdFlashDayMinLeft(Top
WidthHeight	AssociateedtFlashDayMinMax=TabOrder	Thousands  TEditedtFlashDayMaxLeftxTop
Width0HeightTabOrderText0  TUpDownupdFlashDayMaxLeft�Top
WidthHeight	AssociateedtFlashDayMaxMax'TabOrder	Thousands  TEdit
edtMemAddrLeft� TopXWidthEHeightTabOrder	Text0  TEdit
edtMemSizeLeft{TopXWidthCHeightTabOrder
Text16   	TTabSheet
tbsCurrentCaption'   Мгновенные параметры
ImageIndex TLabel
edtShiftToLeftCTop4WidthHeightCaption   4>  TLabellblShiftLeft� Top4WidthJHeightCaption   интервал:  TLabeledtShiftFromLeft� Top4WidthHeightCaption   >B  TLabellblParamLeft� TopWidthKHeightCaption   параметр:  TLabel
lblParamToLeftCTopWidthHeightCaption   4>  TLabellblParamFromLeft� TopWidthHeightCaption   >B  TLabellblShiftRangeLeft�Top4Width.HeightCaption0..479  TLabellblParamRangeLeft�TopWidth.HeightCaption1..500  TEditedtShiftMaxLeft`Top0Width0HeightTabOrder Text0  TUpDownupdShiftMaxLeft�Top0WidthHeight	AssociateedtShiftMaxMax�TabOrder	Thousands  TEditedtShiftMinLeft� Top0Width1HeightTabOrderText0  TUpDownupdShiftMinLeft(Top0WidthHeight	AssociateedtShiftMinMax�TabOrder	Thousands  TBitBtnbtbRun3Left
Top
WidthvHeightCaption	   @>G8B0BLMarginTabOrderOnClickbtbRunClick  TEditedtParamMinLeft� Top
Width1HeightTabOrderText1  TUpDownupdParamMinLeft(Top
WidthHeight	AssociateedtParamMinMinMax�PositionTabOrder	Thousands  TEditedtParamMaxLeft`Top
Width0HeightTabOrderText1  TUpDownupdParamMaxLeft�Top
WidthHeight	AssociateedtParamMaxMinMax�PositionTabOrder	Thousands   	TTabSheet
tbsRecordsCaption%   Расширенные журналы
ImageIndex TLabel	lblRecordLeft� TopWidthIHeightCaption   страница:  TLabellblRecordToLeftCTopWidthHeightCaption   4>  TLabellblRecordFromLeft� TopWidthHeightCaption   >B  TLabellblRecordRangeLeft�TopWidthHeightCaption1..?  TBitBtnbtbRun4Left
Top
WidthvHeightCaption	   @>G8B0BLMarginTabOrder OnClickbtbRunClick  TEditedtRecordMinLeft� Top
Width1HeightTabOrderText1  TUpDownupdRecordMinLeft(Top
WidthHeight	AssociateedtRecordMinMax�PositionTabOrder	Thousands  TEditedtRecordMaxLeft`Top
Width0HeightTabOrderText1  TUpDownupdRecordMaxLeft�Top
WidthHeight	AssociateedtRecordMaxMax�PositionTabOrder	Thousands     TPanel	panRight4Left�Top Width� Height�AlignalRight
BevelOuterbvNoneTabOrder TCheckListBox	clbCanalsLeft Top WidthQHeight�AlignalLeft
ItemHeight	PopupMenuppmCanTabOrder   TCheckListBox	clbGroupsLeftQTop WidthOHeight�AlignalClient
ItemHeight	PopupMenuppmGrpTabOrder    	TTabSheettbsLastCaption   "5@<8=0; TPanelpanTop3Left Top�Width�Height0AlignalBottom
BevelOuterbvNoneTabOrder  TPanel	panRight3Left�Top Width�Height0AlignalRight
BevelOuterbvNoneTabOrder  TBitBtnbtbClearTerminalLeft� Top
WidthwHeightCaption   G8AB8BLMarginTabOrderOnClickbtbClearTerminalClick  TBitBtnbtbSaveTerminalLeftTop
WidthwHeightCaption   В файл  Margin	NumGlyphsTabOrder OnClickbtbSaveTerminalClick  TBitBtnbtbStopTerminalLeftTop
WidthwHeightCaption
   Стоп !MarginTabOrderOnClickbtbStopInfoClick   	TCheckBoxchbTerminalLeftTopWidth� HeightCaption)   использовать терминалChecked	State	cbCheckedTabOrder  	TCheckBoxchbBulkLeft� TopWidth� HeightCaption#   показывать процессTabOrder   TMemoredTerminalLeft Top Width�Height�AlignalClientFont.CharsetRUSSIAN_CHARSET
Font.ColorclGrayFont.Height�	Font.NameLucida Console
Font.Style 
ParentFontReadOnly	
ScrollBars
ssVerticalTabOrder     TProgressBarprbMainLeft�TopWidth� HeightTabOrder  TApdComPortComPort	ComNumberBaud�InSize  AutoOpen	TraceSize }	TraceNamesem2reader.trcLogSize��  LogNamesem2reader.logTapiModetmOnOnTriggerAvailComPortTriggerAvailLeft�Top��    TTimer
timTimeoutEnabledOnTimertimTimeoutTimerLeft�Top��    TTimertimNowInterval,OnTimertimNowTimerLeft�Top��    TSaveDialogsd_RichToFile
DefaultExtrtfFilter!   файл формата TXT|*.txtOptionsofOverwritePromptofHideReadOnly Title   Записать файлLeft�Top��    TApdTapiDevice
TapiDeviceComPortComPortTapiLogTapiLogShowTapiDevices		ShowPortsEnableVoiceOnTapiStatusTapiDeviceTapiStatus	OnTapiLogTapiDeviceTapiLogOnTapiPortOpenTapiDeviceTapiPortOpenOnTapiPortCloseTapiDeviceTapiPortCloseOnTapiConnectTapiDeviceTapiConnect
OnTapiFailTapiDeviceTapiFailLeft Top��    TApdTapiLogTapiLogTapiHistoryNamesem2reader.his
TapiDevice
TapiDeviceLeftHTop��    
TPopupMenuppmMainLeftpTop��   	TMenuItem
mitVersionCaption3   версия от 30 сентября 2015 года   
TPopupMenuppmListLeft�Top��   	TMenuItemmitSetItemsCaption(   Установить все пунктыOnClickmitSetItemsClick  	TMenuItemmitClearItemsCaption$   Сбросить все пунктыOnClickmitClearItemsClick   
TPopupMenuppmCanLeft�Top��   	TMenuItemmitSetCanalsCaption(   Установить все каналыOnClickmitSetCanalsClick  	TMenuItemmitClearCanalsCaption$   Сбросить все каналыOnClickmitClearCanalsClick   
TPopupMenuppmGrpLeft�Top��   	TMenuItemmitSetGroupsCaption(   Установить все группыOnClickmitSetGroupsClick  	TMenuItemmitClearGroupsCaption$   Сбросить все группыOnClickmitClearGroupsClick   TIdTCPClientIdTCPClientOnStatusIdTCPClientStatusOnDisconnectedIdTCPClientDisconnected	OnWorkEndIdTCPClientWorkEndOnConnectedIdTCPClientConnectedConnectTimeout 	IPVersionId_IPv4Port ReadTimeout OnBeforeBindIdTCPClientBeforeBindOnAfterBindIdTCPClientAfterBindOnSocketAllocatedIdTCPClientSocketAllocatedLeftTop��     