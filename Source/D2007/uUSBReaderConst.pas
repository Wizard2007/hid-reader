unit uUSBReaderConst;

interface

const
  cSuccessfully = 'Успешно.';
  cKeeepOpenedON = ' Включен режим держать подключение к устройству.';
  cErrorOccuredOnPreviousStep = 'На предиидущем шаге произошла ошибка!'+
    'Процедура выполняться не будет!';
  cAlertEnabledModeON = 'Включен режим работы без USB устройства.';
  cDeviceNotConnected = 'Устройство не подключено.';
  cOperationWasCanseled = 'Операция была отменена';
{------------------------------------------------------------------------------}
  ENUMERATE_EXISTING_MICE=0;
  MAX_DEVICES=2;
  MAX_DEVICEID_LEN=2048;

  WM_INPUT = $00FF;

  RIM_INPUT       = 0;
  RIM_INPUTSINK   = 1;

  RIM_TYPEMOUSE      = 0;
  RIM_TYPEKEYBOARD   = 1;
  RIM_TYPEHID        = 2;


  RI_MOUSE_LEFT_BUTTON_DOWN   = $0001; // Left Button changed to down.
  {$EXTERNALSYM RI_MOUSE_LEFT_BUTTON_DOWN}
  RI_MOUSE_LEFT_BUTTON_UP     = $0002; // Left Button changed to up.
  {$EXTERNALSYM RI_MOUSE_LEFT_BUTTON_UP}
  RI_MOUSE_RIGHT_BUTTON_DOWN  = $0004; // Right Button changed to down.
  {$EXTERNALSYM RI_MOUSE_RIGHT_BUTTON_DOWN}
  RI_MOUSE_RIGHT_BUTTON_UP    = $0008; // Right Button changed to up.
  {$EXTERNALSYM RI_MOUSE_RIGHT_BUTTON_UP}
  RI_MOUSE_MIDDLE_BUTTON_DOWN = $0010; // Middle Button changed to down.
  {$EXTERNALSYM RI_MOUSE_MIDDLE_BUTTON_DOWN}
  RI_MOUSE_MIDDLE_BUTTON_UP   = $0020; // Middle Button changed to up.
  {$EXTERNALSYM RI_MOUSE_MIDDLE_BUTTON_UP}
  {--- Это похоже, что не надо ------------------------------------------------}
  RI_MOUSE_BUTTON_1_DOWN = RI_MOUSE_LEFT_BUTTON_DOWN;
  {$EXTERNALSYM RI_MOUSE_BUTTON_1_DOWN}
  RI_MOUSE_BUTTON_1_UP   = RI_MOUSE_LEFT_BUTTON_UP;
  {$EXTERNALSYM RI_MOUSE_BUTTON_1_UP}
  RI_MOUSE_BUTTON_2_DOWN = RI_MOUSE_RIGHT_BUTTON_DOWN;
  {$EXTERNALSYM RI_MOUSE_BUTTON_2_DOWN}
  RI_MOUSE_BUTTON_2_UP   = RI_MOUSE_RIGHT_BUTTON_UP;
  {$EXTERNALSYM RI_MOUSE_BUTTON_2_UP}
  RI_MOUSE_BUTTON_3_DOWN = RI_MOUSE_MIDDLE_BUTTON_DOWN;
  {$EXTERNALSYM RI_MOUSE_BUTTON_3_DOWN}
  RI_MOUSE_BUTTON_3_UP   = RI_MOUSE_MIDDLE_BUTTON_UP;
  {$EXTERNALSYM RI_MOUSE_BUTTON_3_UP}

  RI_MOUSE_BUTTON_4_DOWN = $0040;
  {$EXTERNALSYM RI_MOUSE_BUTTON_4_DOWN}
  RI_MOUSE_BUTTON_4_UP   = $0080;
  {$EXTERNALSYM RI_MOUSE_BUTTON_4_UP}
  RI_MOUSE_BUTTON_5_DOWN = $0100;
  {$EXTERNALSYM RI_MOUSE_BUTTON_5_DOWN}
  RI_MOUSE_BUTTON_5_UP   = $0200;
  {$EXTERNALSYM RI_MOUSE_BUTTON_5_UP}
  {----------------------------------------------------------------------------}
  RI_MOUSE_WHEEL = $0400;
  {$EXTERNALSYM RI_MOUSE_WHEEL}

  MOUSE_MOVE_RELATIVE      = 0;
  {$EXTERNALSYM MOUSE_MOVE_RELATIVE}
  MOUSE_MOVE_ABSOLUTE      = 1;
  {$EXTERNALSYM MOUSE_MOVE_ABSOLUTE}
  MOUSE_VIRTUAL_DESKTOP    = $02; // the coordinates are mapped to the virtual desktop
  {$EXTERNALSYM MOUSE_VIRTUAL_DESKTOP}
  MOUSE_ATTRIBUTES_CHANGED = $04; // requery for mouse attributes
  {$EXTERNALSYM MOUSE_ATTRIBUTES_CHANGED}

  KEYBOARD_OVERRUN_MAKE_CODE = $FF;
  {$EXTERNALSYM KEYBOARD_OVERRUN_MAKE_CODE}

  RI_KEY_MAKE            = 0;
  {$EXTERNALSYM RI_KEY_MAKE}
  RI_KEY_BREAK           = 1;
  {$EXTERNALSYM RI_KEY_BREAK}
  RI_KEY_E0              = 2;
  {$EXTERNALSYM RI_KEY_E0}
  RI_KEY_E1              = 4;
  {$EXTERNALSYM RI_KEY_E1}
  RI_KEY_TERMSRV_SET_LED = 8;
  {$EXTERNALSYM RI_KEY_TERMSRV_SET_LED}
  RI_KEY_TERMSRV_SHADOW  = $10;
  {$EXTERNALSYM RI_KEY_TERMSRV_SHADOW}

  RID_INPUT  = $10000003;
  {$EXTERNALSYM RID_INPUT}
  RID_HEADER = $10000005;
  {$EXTERNALSYM RID_HEADER}

  RIDI_PREPARSEDDATA = $20000005;
  {$EXTERNALSYM RIDI_PREPARSEDDATA}
  RIDI_DEVICENAME    = $20000007; // the return valus is the character length, not the byte size
  {$EXTERNALSYM RIDI_DEVICENAME}
  RIDI_DEVICEINFO    = $2000000b;
  {$EXTERNALSYM RIDI_DEVICEINFO}

  RIDEV_REMOVE       = $00000001;
  {$EXTERNALSYM RIDEV_REMOVE}
  RIDEV_EXCLUDE      = $00000010;
  {$EXTERNALSYM RIDEV_EXCLUDE}
  RIDEV_PAGEONLY     = $00000020;
  {$EXTERNALSYM RIDEV_PAGEONLY}
  RIDEV_NOLEGACY     = $00000030;
  {$EXTERNALSYM RIDEV_NOLEGACY}
  RIDEV_INPUTSINK    = $00000100;
  {$EXTERNALSYM RIDEV_INPUTSINK}
  RIDEV_CAPTUREMOUSE = $00000200; // effective when mouse nolegacy is specified, otherwise it would be an error
  {$EXTERNALSYM RIDEV_CAPTUREMOUSE}
  RIDEV_NOHOTKEYS    = $00000200; // effective for keyboard.
  {$EXTERNALSYM RIDEV_NOHOTKEYS}
  RIDEV_APPKEYS      = $00000400;  // effective for keyboard.
  {$EXTERNALSYM RIDEV_APPKEYS}
  RIDEV_EXMODEMASK   = $000000F0;
  {$EXTERNALSYM RIDEV_EXMODEMASK}
  RIDEV_DEVNOTIFY = $00002000;
  {$EXTERNALSYM RIDEV_DEVNOTIFY}

{------------------------------------------------------------------------------}
implementation

end.
