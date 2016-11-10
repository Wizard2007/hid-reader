unit uUSBReaderCommonTypes;

interface
uses Windows;

type
  TUSBReaderExceptionGenerationOption = packed record
    egoOpen: Boolean;
    egoClose: Boolean;
    egoConnect: Boolean;
    egoDisconnect: Boolean;

  end;

  HRAWINPUT = THANDLE;

  tagRAWINPUTHEADER = record
    dwType: DWORD;
    dwSize: DWORD;
    hDevice: THANDLE;
    wParam: WPARAM;
  end;
  {$EXTERNALSYM tagRAWINPUTHEADER}
  RAWINPUTHEADER = tagRAWINPUTHEADER;
  {$EXTERNALSYM RAWINPUTHEADER}
  PRAWINPUTHEADER = ^RAWINPUTHEADER;
  {$EXTERNALSYM PRAWINPUTHEADER}
  LPRAWINPUTHEADER = ^RAWINPUTHEADER;
  {$EXTERNALSYM LPRAWINPUTHEADER}
  TRawInputHeader = RAWINPUTHEADER;

  tagRAWMOUSE = record
    usFlags: WORD;
    union: record
    case Integer of
      0: (
        ulButtons: ULONG);
      1: (
        usButtonFlags: WORD;
        usButtonData: WORD);
    end;
    ulRawButtons: ULONG;
    lLastX: LongInt;
    lLastY: LongInt;
    ulExtraInformation: ULONG;
  end;
  {$EXTERNALSYM tagRAWMOUSE}
  RAWMOUSE = tagRAWMOUSE;
  {$EXTERNALSYM RAWMOUSE}
  PRAWMOUSE = ^RAWMOUSE;
  {$EXTERNALSYM PRAWMOUSE}
  LPRAWMOUSE = ^RAWMOUSE;
  {$EXTERNALSYM LPRAWMOUSE}
  TRawMouse = RAWMOUSE;

  tagRAWKEYBOARD = record
    MakeCode: WORD;
    Flags: WORD;
    Reserved: WORD;
    VKey: WORD;
    Message: UINT;
    ExtraInformation: ULONG;
  end;
  {$EXTERNALSYM tagRAWKEYBOARD}
  RAWKEYBOARD = tagRAWKEYBOARD;
  {$EXTERNALSYM RAWKEYBOARD}
  PRAWKEYBOARD = ^RAWKEYBOARD;
  {$EXTERNALSYM PRAWKEYBOARD}
  LPRAWKEYBOARD = ^RAWKEYBOARD;
  {$EXTERNALSYM LPRAWKEYBOARD}
  TRawKeyBoard = RAWKEYBOARD;

  tagRAWHID = record
    dwSizeHid: DWORD;    // byte size of each report
    dwCount: DWORD;      // number of input packed
    bRawData: array [0..0] of BYTE;
  end;
  {$EXTERNALSYM tagRAWHID}
  RAWHID = tagRAWHID;
  {$EXTERNALSYM RAWHID}
  PRAWHID = ^RAWHID;
  {$EXTERNALSYM PRAWHID}
  LPRAWHID = ^RAWHID;
  {$EXTERNALSYM LPRAWHID}
  TRawHid = RAWHID;

  tagRAWINPUT = record
    header: RAWINPUTHEADER;
    case Integer of
      0: (mouse: RAWMOUSE);
      1: (keyboard: RAWKEYBOARD);
      2: (hid: RAWHID);
  end;
  {$EXTERNALSYM tagRAWINPUT}
  RAWINPUT = tagRAWINPUT;
  {$EXTERNALSYM RAWINPUT}
  PRAWINPUT = ^RAWINPUT;
  {$EXTERNALSYM PRAWINPUT}
  LPRAWINPUT = ^RAWINPUT;
  {$EXTERNALSYM LPRAWINPUT}
  TRawInput = RAWINPUT;

  PRID_DEVICE_INFO_MOUSE = ^RID_DEVICE_INFO_MOUSE;
  {$EXTERNALSYM PRID_DEVICE_INFO_MOUSE}
  tagRID_DEVICE_INFO_MOUSE = record
    dwId: DWORD;
    dwNumberOfButtons: DWORD;
    dwSampleRate: DWORD;
  end;
  {$EXTERNALSYM tagRID_DEVICE_INFO_MOUSE}
  RID_DEVICE_INFO_MOUSE = tagRID_DEVICE_INFO_MOUSE;
  {$EXTERNALSYM RID_DEVICE_INFO_MOUSE}
  TRidDeviceInfoMouse = RID_DEVICE_INFO_MOUSE;
  PRidDeviceInfoMouse = PRID_DEVICE_INFO_MOUSE;

  PRID_DEVICE_INFO_KEYBOARD = ^RID_DEVICE_INFO_KEYBOARD;
  {$EXTERNALSYM PRID_DEVICE_INFO_KEYBOARD}

  tagRID_DEVICE_INFO_KEYBOARD = record
    dwType: DWORD;
    dwSubType: DWORD;
    dwKeyboardMode: DWORD;
    dwNumberOfFunctionKeys: DWORD;
    dwNumberOfIndicators: DWORD;
    dwNumberOfKeysTotal: DWORD;
  end;
  {$EXTERNALSYM tagRID_DEVICE_INFO_KEYBOARD}
  RID_DEVICE_INFO_KEYBOARD = tagRID_DEVICE_INFO_KEYBOARD;
  {$EXTERNALSYM RID_DEVICE_INFO_KEYBOARD}
  TRidDeviceInfoKeyboard = RID_DEVICE_INFO_KEYBOARD;
  PRidDeviceInfoKeyboard = PRID_DEVICE_INFO_KEYBOARD;

  PRID_DEVICE_INFO_HID = ^RID_DEVICE_INFO_HID;
  {$EXTERNALSYM PRID_DEVICE_INFO_HID}
  tagRID_DEVICE_INFO_HID = record
    dwVendorId: DWORD;
    dwProductId: DWORD;
    dwVersionNumber: DWORD;
    usUsagePage: WORD;
    usUsage: WORD;
  end;
  {$EXTERNALSYM tagRID_DEVICE_INFO_HID}
  RID_DEVICE_INFO_HID = tagRID_DEVICE_INFO_HID;
  {$EXTERNALSYM RID_DEVICE_INFO_HID}
  TRidDeviceInfoHid = RID_DEVICE_INFO_HID;
  PRidDeviceInfoHid = PRID_DEVICE_INFO_HID;

  tagRID_DEVICE_INFO = record
    cbSize: DWORD;
    dwType: DWORD;
    case Integer of
    0: (mouse: RID_DEVICE_INFO_MOUSE);
    1: (keyboard: RID_DEVICE_INFO_KEYBOARD);
    2: (hid: RID_DEVICE_INFO_HID);
  end;
  {$EXTERNALSYM tagRID_DEVICE_INFO}
  RID_DEVICE_INFO = tagRID_DEVICE_INFO;
  {$EXTERNALSYM RID_DEVICE_INFO}
  PRID_DEVICE_INFO = ^RID_DEVICE_INFO;
  {$EXTERNALSYM PRID_DEVICE_INFO}
  LPRID_DEVICE_INFO = ^RID_DEVICE_INFO;
  {$EXTERNALSYM LPRID_DEVICE_INFO}
  TRidDeviceInfo = RID_DEVICE_INFO;
  PRidDeviceInfo = PRID_DEVICE_INFO;

  TGetRawInputDeviceInfo = function (hDevice: THANDLE; uiCommand: UINT; pData: POINTER;
    var pcbSize: UINT): UINT; stdcall;

  TGetRawInputBuffer = function (pData: PRAWINPUT; var pcbSize: UINT;
    cbSizeHeader: UINT): UINT; stdcall;

  TGetRawInputData = function (hRawInput: HRAWINPUT; uiCommand: UINT; pData: POINTER;
    var pcbSize: UINT; cbSizeHeader: UINT): UINT; stdcall;

  LPRAWINPUTDEVICE = ^RAWINPUTDEVICE;
  {$EXTERNALSYM LPRAWINPUTDEVICE}
  PRAWINPUTDEVICE = ^RAWINPUTDEVICE;
  {$EXTERNALSYM PRAWINPUTDEVICE}
  tagRAWINPUTDEVICE = record
    usUsagePage: WORD; // Toplevel collection UsagePage
    usUsage: WORD;     // Toplevel collection Usage
    dwFlags: DWORD;
    hwndTarget: HWND;    // Target hwnd. NULL = follows keyboard focus
  end;

  {$EXTERNALSYM tagRAWINPUTDEVICE}
  RAWINPUTDEVICE = tagRAWINPUTDEVICE;
  {$EXTERNALSYM RAWINPUTDEVICE}
  TRawInputDevice = RAWINPUTDEVICE;

  PRAWINPUTDEVICELIST = ^RAWINPUTDEVICELIST;
  {$EXTERNALSYM PRAWINPUTDEVICELIST}
  tagRAWINPUTDEVICELIST = record
    hDevice: THANDLE;
    dwType: DWORD;
  end;
  {$EXTERNALSYM tagRAWINPUTDEVICELIST}
  RAWINPUTDEVICELIST = tagRAWINPUTDEVICELIST;
  {$EXTERNALSYM RAWINPUTDEVICELIST}
  TRawInputDeviceList = RAWINPUTDEVICELIST;

  TGetRawInputDeviceList = function (pRawInputDeviceList: PRAWINPUTDEVICELIST;
    var puiNumDevices: UINT; cbSize: UINT): UINT; stdcall;

  TRegisterRawInputDevices = function (pRawInputDevices: PRAWINPUTDEVICE;
    uiNumDevices: UINT; cbSize: UINT): BOOL; stdcall;

  TGetRegisteredRawInputDevices = function (pRawInputDevices: PRAWINPUTDEVICE;
    var puiNumDevices: UINT; cbSize: UINT): UINT; stdcall;

implementation

end.
