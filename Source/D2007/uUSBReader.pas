unit uUSBReader;

interface

uses
  SysUtils, Classes, uLogFile, uUSBReaderCommonTypes, uUSBReaderConst, Messages;
  
type
  TtUSBReader = class(TComponent)
  private
    FCallDeep: Integer;
    FisErrorState: Boolean;
    FisGenerateException: Boolean;
    FisKeepOpened: Boolean;
    FisConnected: Boolean;
    FLogFile: TtLogFile;
    FWriteToLog: Boolean;
    FisReadScanCodes: Boolean;
    FIniFileName: string;
    FIniFileSectionName: string;
    FHandle: THandle;
    FEnable: Boolean;
    FExceptionGenerationOption: TUSBReaderExceptionGenerationOption;
    FErrorMessage: string;
    FDeviceName: string;
    FisCanseled: Boolean;
    procedure SetCallDeep(const Value: Integer);
    procedure SetisErrorState(const Value: Boolean);
    procedure SetisGenerateException(const Value: Boolean);
    procedure SetisKeepOpened(const Value: Boolean);
    procedure SetisConnected(const Value: Boolean);
    procedure SetLogFile(const Value: TtLogFile);
    procedure SetWriteToLog(const Value: Boolean);
    procedure SetisReadScanCodes(const Value: Boolean);
    procedure SetIniFileName(const Value: string);
    procedure SetIniFileSectionName(const Value: string);
    procedure SetHandle(const Value: THandle);
    procedure SetEnable(const Value: Boolean);
    procedure SetExceptionGenerationOption(
      const Value: TUSBReaderExceptionGenerationOption);
    procedure SetErrorMessage(const Value: string);
    procedure SetDeviceName(const Value: string);
    function Test: Boolean;
    function InitRawInput: Boolean;
    function UnInitRawInput: Boolean;
    procedure SetisCanseled(const Value: Boolean);
    { Private declarations }
  protected
    { Protected declarations }
    procedure WinProc(var Message: TMessage);
  public
    { Public declarations }
      {����������}
    constructor Create(AOwner: TComponent); override;
      {����������}
    destructor Destroy; override;
      {��������� ��� ����������� ��������� �� ������}
    procedure LogException(AlogLevel: TLogLevel; AMsg: string; AE: Exception;
      AGenerateException: Boolean);
      {������� ����� ������ ������}
    property CallDeep: Integer read FCallDeep write SetCallDeep;
      {�� ����� ������ ���������� �������� ������}
    property isErrorState: Boolean read FisErrorState write SetisErrorState;
      {����� ������}
    property ErrorMessage: string read FErrorMessage write SetErrorMessage;
      {���������� ��������� ��� ������}
    property isConnected: Boolean read FisConnected write SetisConnected;
      {���������� � ���}
    property WriteToLog: Boolean read FWriteToLog write SetWriteToLog;
      {������� ���� ��� ���������� ���� �������� �������������}
    property isCanseled: Boolean read FisCanseled write SetisCanseled;
  published
      { Published declarations }
      {������� ���������� ��� ����� � ����������� �� �������� isKeepOpened}
    function Open: Boolean;
      {������� ���������� ��� ����� � ����������� �� �������� isKeepOpened}
    function Close: Boolean;
      {������� ���������� ��� ����� ��� ����������� �� �������� isKeepOpened}
    function Connect: Boolean;
      {������� ���������� ��� ����� ��� ����������� �� �������� isKeepOpened}
    function Disconnect: Boolean;
      {���� � ini - file , ��� ����� ��������� ��������� ��� ���� �����}
    property IniFileName: string read FIniFileName write SetIniFileName;
      {�������� ������ � ini - file, �� ������� ��������� ����� ��������
        ��������� ��� �����������}
    property IniFileSectionName: string read FIniFileSectionName write SetIniFileSectionName;
      {������� ����������� � ���������� �������� }
    property isKeepOpened: Boolean read FisKeepOpened write SetisKeepOpened;
      {������������ ���������� ��� ������ ��� ���� ����� ���������� False}
    property isGenerateException: Boolean read FisGenerateException write
      SetisGenerateException;
      {��� ���� ��� ����������� ������ ������}
    property LogFile: TtLogFile read FLogFile write SetLogFile;
      {������� ���� ��� ������ ������ ���� ����, � �� ������� ����������}
    property isReadScanCodes: Boolean read FisReadScanCodes write SetisReadScanCodes;
      {��������� ��������� ������}
    property Enable: Boolean read FEnable write SetEnable;
      {Handle ���� ���� � �������� ���� �����������}
    property Handle: THandle read FHandle write SetHandle;
      {ExceptionGenerationOption - ����� ��������� ������}
    property ExceptionGenerationOption: TUSBReaderExceptionGenerationOption read
      FExceptionGenerationOption write SetExceptionGenerationOption;
      {�������� ���������� � ������� ���� ������}
    property DeviceName: string read FDeviceName write SetDeviceName;
  end;

procedure Register;

var
  GetRawInputDeviceInfo        : TGetRawInputDeviceInfo        = nil;
  GetRawInputBuffer            : TGetRawInputBuffer            = nil;
  GetRawInputData              : TGetRawInputData              = nil;
  GetRawInputDeviceList        : TGetRawInputDeviceList        = nil;
  RegisterRawInputDevices      : TRegisterRawInputDevices      = nil;
  GetRegisteredRawInputDevices : TGetRegisteredRawInputDevices = nil;
implementation

procedure Register;
begin
  RegisterComponents('TTComponets', [TtUSBReader]);
end;

{ TtUSBReader }

function TtUSBReader.Close: Boolean;
var
  lRaiseError, lKeepOpened: Boolean;
const
  cAlertSkipDisconnect = '�������� USB ���������� ���������.';
  cPrintDisconnect = '��������� USB ���������� ��� ������.';
  cErrorWhileDisconnect = '������ ��� �������� USB ����������.';
begin
  Result:= False;
  try
    CallDeep:= CallDeep+1;
    LogFile.Add(llINFO, cPrintDisconnect);
    lRaiseError:= ExceptionGenerationOption.egoOpen;
    if isErrorState then begin
      Result:= False;
      LogFile.Add(llTRACE, cErrorOccuredOnPreviousStep);
      Exit;
    end;
    if Enable then begin
      Result:= True;
      LogFile.Add(llTRACE, cAlertEnabledModeON);
      Exit;
    end;
    lKeepOpened:= isKeepOpened;
    isKeepOpened:= True;
    try
      {����� ��������� ����������}

    Except on e: Exception do
      begin
        Result:= False;
        LogException(llERROR, cErrorWhileDisconnect, e, lRaiseError);
      end;
    end;
  finally
    isConnected:= not Result;
    if Result then LogFile.Add(llINFO, cSuccessfully);
    isKeepOpened:= lKeepOpened;
    CallDeep:= CallDeep-1;
  end;
end;

function TtUSBReader.Connect: Boolean;
var
  lRaiseError, lKeepOpened: Boolean;
const
  cPrintConnect = '��������� USB ���������� ��� ������.';
  cErrorWhileConnect = '������ ��� �������� USB ����������.';
begin
  Result:= False;
  try
    CallDeep:= CallDeep+1;
    LogFile.Add(llINFO, cPrintConnect);
    lRaiseError:= ExceptionGenerationOption.egoConnect;
    if isErrorState then begin
      Result:= False;
      LogFile.Add(llTRACE, cErrorOccuredOnPreviousStep);
      Exit;
    end;
    if Enable then begin
      Result:= True;
      LogFile.Add(llTRACE, cAlertEnabledModeON);
      Exit;
    end;
    lKeepOpened:= isKeepOpened;
    isKeepOpened:= True;
    try
      {����� ���������� ����������}

    Except on e: Exception do
      begin
        Result:= False;
        LogException(llERROR, cErrorWhileConnect, e, lRaiseError);
      end;
    end;
  finally
    isConnected:= Result;
    if Result then LogFile.Add(llINFO, cSuccessfully);
    isKeepOpened:= lKeepOpened;
    CallDeep:= CallDeep-1;
  end;
end;

constructor TtUSBReader.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  with Self do
  begin
    CallDeep:= 0;
    isErrorState:= False;
    isKeepOpened:= True;
    isGenerateException:= False;
    isConnected:= False;
    isReadScanCodes:= True;
    with ExceptionGenerationOption do
    begin
      egoOpen:= True;
      egoClose:= True;
      egoConnect:= True;
      egoDisconnect:= True;
    end;
  end;
end;

destructor TtUSBReader.Destroy;
begin
  inherited;
  LogFile.Free;
end;

function TtUSBReader.Disconnect: Boolean;
var
  lRaiseError, lKeepOpened: Boolean;
const
  cPrintDisconnect = '��������� USB ���������� ��� ������.';
  cErrorWhileDisconnect = '������ ��� �������� USB ����������.';
begin
  Result:= False;
  try
    CallDeep:= CallDeep+1;
    LogFile.Add(llINFO, cPrintDisconnect);
    lRaiseError:= ExceptionGenerationOption.egoDisconnect;
    if isErrorState then begin
      Result:= False;
      LogFile.Add(llTRACE, cErrorOccuredOnPreviousStep);
      Exit;
    end;
    if Enable then begin
      Result:= True;
      LogFile.Add(llTRACE, cAlertEnabledModeON);
      Exit;
    end;
    lKeepOpened:= isKeepOpened;
    isKeepOpened:= True;
    try
      {����� ��������� ����������}

    Except on e: Exception do
      begin
        Result:= False;
        LogException(llERROR, cErrorWhileDisconnect, e, lRaiseError);
      end;
    end;
  finally
    isConnected:= not Result;
    if Result then LogFile.Add(llINFO, cSuccessfully);
    isKeepOpened:= lKeepOpened;
    CallDeep:= CallDeep-1;
  end;
end;

function TtUSBReader.InitRawInput: Boolean;
var
  nDevices: Cardinal;
  pRawIn:   PRAWINPUTDEVICELIST;
  hRawIn:   array[1..100] of RAWINPUTDEVICELIST;
  rawInDev: array [0..0] of RAWINPUTDEVICE;
begin
  if GetRawInputDeviceList(nil, nDevices, sizeof(RAWINPUTDEVICELIST)) <> 0 then
    Result:= False;
  pRawIn:=nil;
  pRawIn:=@hRawIn;
  if GetRawInputDeviceList(pRawIn, nDevices, sizeof(RAWINPUTDEVICELIST)) = -1 then
    Result:= False;

  rawInDev[0].usUsagePage:=1;
  rawInDev[0].usUsage:=6;
  rawInDev[0].dwFlags:= RIDEV_NOLEGACY;
  rawInDev[0].hwndTarget:= Handle;

  RegisterRawInputDevices(@rawInDev,Length(rawInDev),sizeOf(rawInDev[0]));
end;

procedure TtUSBReader.LogException(AlogLevel: TLogLevel; AMsg: string;
  AE: Exception; AGenerateException: Boolean);
var
  lMsg: string;
const
  cSystemError = '������ ������������ �������:';
begin
  isErrorState:= True;
  lMsg:= AMsg+#10#13;
  if AE <> nil then begin
    lMsg:= lMsg+'ClassName = '+AE.ClassName+#10#13;
    lMsg:= lMsg+'Message = '+AE.Message+#10#13;
  end
  else begin
    lMsg:= lMsg+cSystemError+#10#13;
    lMsg:= lMsg+SysErrorMessage(GetLastError)+#10#13;
  end;
  ErrorMessage:= lMsg;
  LogFile.Add(llERROR, ErrorMessage);
  if AGenerateException and isGenerateException then raise Exception.Create(lMsg);
end;

function TtUSBReader.Open: Boolean;
var
  lRaiseError, lKeepOpened: Boolean;
const
  cAlertSkipOpen = '�������� USB ���������� ���������';
  cPrintOpen = '��������� USB ���������� ��� ������.';
  cErrorWhileOpen = '������ ��� �������� USB ����������.';
begin
  Result:= False;
  try
    CallDeep:= CallDeep+1;
    LogFile.Add(llINFO, cPrintOpen);
    lRaiseError:= ExceptionGenerationOption.egoOpen;
    if isErrorState then begin
      Result:= False;
      LogFile.Add(llTRACE, cErrorOccuredOnPreviousStep);
      Exit;
    end;
    if Enable then begin
      Result:= True;
      LogFile.Add(llTRACE, cAlertEnabledModeON);
      Exit;
    end;
    if isConnected then begin
      if isKeepOpened then begin
        Result:= True;
        LogFile.Add(llINFO, cAlertSkipOpen + cKeeepOpenedON);
        Exit;
      end;
    end
    else LogFile.Add(llINFO, cDeviceNotConnected);
    lKeepOpened:= isKeepOpened;
    isKeepOpened:= True;
    try
      {����� ���������� ����������}
       Result:= InitRawInput;
    Except on e: Exception do
      begin
        Result:= False;
        LogException(llERROR, cErrorWhileOpen, e, lRaiseError);
      end;
    end;
  finally
    isConnected:= Result;
    if Result then LogFile.Add(llINFO, cSuccessfully);
    isKeepOpened:= lKeepOpened;
    CallDeep:= CallDeep-1;
  end;
end;

procedure TtUSBReader.SetCallDeep(const Value: Integer);
begin
  if FCallDeep <> Value then begin
    FCallDeep := Value;
    if FCallDeep = 0 then begin
      isErrorState:= False;
      ErrorMessage:= '';
      isCanseled:= False;
    end;
  end;
end;

procedure TtUSBReader.SetDeviceName(const Value: string);
begin
  FDeviceName := Value;
end;

procedure TtUSBReader.SetEnable(const Value: Boolean);
begin
  FEnable := Value;
end;

procedure TtUSBReader.SetErrorMessage(const Value: string);
begin
  FErrorMessage := Value;
end;

procedure TtUSBReader.SetExceptionGenerationOption(
  const Value: TUSBReaderExceptionGenerationOption);
begin
  FExceptionGenerationOption := Value;
end;

procedure TtUSBReader.SetHandle(const Value: THandle);
begin
  FHandle := Value;
end;

procedure TtUSBReader.SetIniFileName(const Value: string);
begin
  FIniFileName := Value;
end;

procedure TtUSBReader.SetIniFileSectionName(const Value: string);
begin
  FIniFileSectionName := Value;
end;

procedure TtUSBReader.SetisCanseled(const Value: Boolean);
begin
  if FisCanseled <> Value then begin
    FisCanseled := Value;
  end;
end;

procedure TtUSBReader.SetisConnected(const Value: Boolean);
begin
  if FisConnected <> Value then begin
    FisConnected := Value;
  end;
end;

procedure TtUSBReader.SetisErrorState(const Value: Boolean);
begin
  FisErrorState := Value;
end;

procedure TtUSBReader.SetisGenerateException(const Value: Boolean);
begin
  FisGenerateException := Value;
end;

procedure TtUSBReader.SetisKeepOpened(const Value: Boolean);
begin
  FisKeepOpened := Value;
end;

procedure TtUSBReader.SetisReadScanCodes(const Value: Boolean);
begin
  FisReadScanCodes := Value;
end;

procedure TtUSBReader.SetLogFile(const Value: TtLogFile);
begin
  FLogFile := Value;
end;

procedure TtUSBReader.SetWriteToLog(const Value: Boolean);
begin
  FWriteToLog := Value;
  LogFile.Active:= FWriteToLog;
end;

function TtUSBReader.Test: Boolean;
var
  lRaiseError, lKeepOpened: Boolean;
  lCansel: Boolean;
const
  cAlertSkipOpen = '�������� USB ���������� ���������';
  cPrintOpen = '��������� USB ���������� ��� ������.';
  cErrorWhileOpen = '������ ��� �������� USB ����������.';
begin
  Result:= False;
  try
    CallDeep:= CallDeep+1;
    LogFile.Add(llINFO, cPrintOpen);
    lRaiseError:= ExceptionGenerationOption.egoOpen;
    if isErrorState then begin
      Result:= False;
      LogFile.Add(llTRACE, cErrorOccuredOnPreviousStep);
      Exit;
    end;
    if isCanseled then begin
      LogFile.Add(llINFO, cOperationWasCanseled);
      Result:= True;
      Exit; 
    end;
    if Enable then begin
      Result:= True;
      LogFile.Add(llTRACE, cAlertEnabledModeON);
      Exit;
    end;
    if isKeepOpened then begin
      Result:= True;
      LogFile.Add(llINFO, cAlertSkipOpen + cKeeepOpenedON);
      Exit;
    end;
    lKeepOpened:= isKeepOpened;
    isKeepOpened:= True;
    try
      if not Open then begin
        {���� ���������� �� ��������� ��� �� �������, �� ������ ������}
        Result:= False;
        Exit;
      end;
      {����� ���������� ����������}

    Except on e: Exception do
      begin
        Result:= False;
        LogException(llERROR, cErrorWhileOpen, e, lRaiseError);
      end;
    end;
  finally
    isCanseled:= lCansel;
    if Result then LogFile.Add(llINFO, cSuccessfully);
    isKeepOpened:= lKeepOpened;
    CallDeep:= CallDeep-1;
  end;
end;

function TtUSBReader.UnInitRawInput: Boolean;
var
  rawInDev: array [0..0] of RAWINPUTDEVICE;
begin
  rawInDev[0].usUsagePage:=1;
  rawInDev[0].usUsage:=6;
  rawInDev[0].dwFlags:= RIDEV_REMOVE;
  rawInDev[0].hwndTarget:= 0;
  RegisterRawInputDevices(@rawInDev,Length(rawInDev),sizeOf(rawInDev[0]));
end;

procedure TtUSBReader.WinProc(var Message: TMessage);
begin
  inherited;
  {��� ����� ��������� WM_INPUT}
end;

end.
