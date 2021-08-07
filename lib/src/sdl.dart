/// Provides the main [Sdl] class.
import 'dart:ffi';
import 'dart:io';
import 'dart:math';

import 'package:ffi/ffi.dart';

import 'audio/device.dart';
import 'audio/driver.dart';
import 'audio/spec.dart';
import 'button.dart';
import 'display.dart';
import 'enumerations.dart';
import 'error.dart';
import 'events/application.dart';
import 'events/audio.dart';
import 'events/base.dart';
import 'events/clipboard.dart';
import 'events/drop.dart';
import 'events/game_controller.dart';
import 'events/gestures.dart';
import 'events/joystick.dart';
import 'events/keyboard.dart';
import 'events/mouse.dart';
import 'events/platform.dart';
import 'events/text.dart';
import 'events/touch_finger.dart';
import 'events/window.dart';
import 'extensions.dart';
import 'game_controller.dart';
import 'joystick.dart';
import 'sdl_bindings.dart';
import 'version.dart';
import 'window.dart';

/// The main SDL class.
class Sdl {
  /// Create an object.
  Sdl() {
    String libName;
    if (Platform.isWindows) {
      libName = 'SDL2.dll';
    } else {
      throw Exception(
          'Unimplemented operating system: ${Platform.operatingSystem}.');
    }
    sdl = DartSdl(DynamicLibrary.open(libName));
  }

  /// The SDL bindings to use.
  late final DartSdl sdl;

  /// Get a Dart boolean from an SDL one.
  bool getBool(int value) => value == SDL_bool.SDL_TRUE;

  /// Convert a boolean to one of the members of [SDL_bool].
  int boolToValue(bool value) => value ? SDL_bool.SDL_TRUE : SDL_bool.SDL_FALSE;

  /// Throw an error if return value is non-null.
  ///
  /// If [value] is >= 0, it will be returned.
  int checkReturnValue(int value) {
    if (value >= 0) {
      return value;
    }
    final message = getError();
    throw SdlError(value, message);
  }

  /// Initialise SDL.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_Init)
  void init({int flags = SDL_INIT_EVERYTHING}) =>
      checkReturnValue(sdl.SDL_Init(flags));

  /// Shutdown SDL.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_Quit)
  void quit() => sdl.SDL_Quit();

  /// Set main ready.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_SetMainReady)
  void setMainReady() => sdl.SDL_SetMainReady();

  /// Get the systems which are currently initialised.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_WasInit)
  int wasInit({int flags = 0}) => sdl.SDL_WasInit(flags);

  /// Get the most recent SDL error for this thread.
  ///
  String getError() => sdl.SDL_GetError().cast<Utf8>().toDartString();

  /// Clear all hints.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_ClearHints)
  void clearHints() => sdl.SDL_ClearHints();

  /// Set a hint at normal priority.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_SetHint)
  bool setHint(String hint, String value) {
    final hintPointer = hint.toInt8Pointer();
    final valuePointer = value.toInt8Pointer();
    final retval = sdl.SDL_SetHint(hintPointer, valuePointer);
    [hintPointer, valuePointer].forEach(calloc.free);
    return getBool(retval);
  }

  /// Set hint with priority.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_SetHintWithPriority)
  bool setHintPriority(String hint, String value, HintPriority priority) {
    final hintPointer = hint.toInt8Pointer();
    final valuePointer = value.toInt8Pointer();
    final retval = sdl.SDL_SetHintWithPriority(
        hintPointer, valuePointer, priority.toSdlFlag());
    [hintPointer, valuePointer].forEach(calloc.free);
    return getBool(retval);
  }

  /// Clear the last error message.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_ClearError)
  void clearError() => sdl.SDL_ClearError();

  /// Set the error message.
  ///
  ///[SDL Docs](https://wiki.libsdl.org/SDL_SetError)
  void setError(String message) {
    final messagePointer = message.toInt8Pointer();
    sdl.SDL_SetError(messagePointer);
    calloc.free(messagePointer);
  }

  /// Log a message.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_Log)
  void log(String message) {
    final messagePointer = message.toInt8Pointer();
    sdl.SDL_Log(messagePointer);
    calloc.free(messagePointer);
  }

  /// Log anything.
  void _log(LogCategory category, String message,
      void Function(int, Pointer<Int8>) func) {
    final messagePointer = message.toInt8Pointer();
    func(category.toSdlFlag(), messagePointer);
    calloc.free(messagePointer);
  }

  /// Log a critical message.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_LogCritical)
  void logCritical(LogCategory category, String message) =>
      _log(category, message, sdl.SDL_LogCritical);

  /// Log a debug message.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_LogDebug)
  void logDebug(LogCategory category, String message) =>
      _log(category, message, sdl.SDL_LogDebug);

  /// Log an error message.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_LogError)
  void logError(LogCategory category, String message) =>
      _log(category, message, sdl.SDL_LogError);

  /// Log an informational message.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_LogInfo)
  void logInfo(LogCategory category, String message) =>
      _log(category, message, sdl.SDL_LogInfo);

  /// Log a message.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_LogMessage)
  void logMessage(LogCategory category, LogPriority priority, String message) {
    final messagePointer = message.toInt8Pointer();
    sdl.SDL_LogMessage(
        category.toSdlFlag(), priority.toSdlFlag(), messagePointer);
    calloc.free(messagePointer);
  }

  /// Log a verbose message.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_LogVerbose)
  void logVerbose(LogCategory category, String message) =>
      _log(category, message, sdl.SDL_LogVerbose);

  /// Log a warning message.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_LogWarn)
  void logWarn(LogCategory category, String message) =>
      _log(category, message, sdl.SDL_LogWarn);

  /// Get log priority.
  LogPriority getLogPriority(LogCategory category) =>
      sdl.SDL_LogGetPriority(category.toSdlFlag()).toLogPriority();

  /// Reset log priorities.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_LogResetPriorities)
  void resetLogPriorities() => sdl.SDL_LogResetPriorities();

  /// Set the priority of all log categories.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_LogSetAllPriority)
  void setAllLogPriorities(LogPriority priority) =>
      sdl.SDL_LogSetAllPriority(priority.toSdlFlag());

  /// Set log priority.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_LogSetPriority)
  void setLogPriority(LogCategory category, LogPriority priority) =>
      sdl.SDL_LogSetPriority(category.toSdlFlag(), priority.toSdlFlag());

  /// Get the compiled version.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_COMPILEDVERSION)
  int get compiledVersion => SDL_COMPILEDVERSION;

  /// Get SDL version.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_GetVersion)
  SdlVersion get version {
    final ptr = calloc<SDL_version>();
    sdl.SDL_GetVersion(ptr);
    final v = ptr.ref;
    calloc.free(ptr);
    return SdlVersion(v.major, v.minor, v.patch);
  }

  /// Get the SDL revision.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_REVISION)
  String get revision => SDL_REVISION;

  /// Get revision number.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_GetRevisionNumber)
  int get revisionNumber => sdl.SDL_GetRevisionNumber();

  /// Create a window.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_CreateWindow)
  Window createWindow(String title,
      {int x = SDL_WINDOWPOS_CENTERED,
      int y = SDL_WINDOWPOS_CENTERED,
      int width = 1024,
      int height = 648,
      int flags = 0}) {
    final titlePtr = title.toInt8Pointer();
    final window = Window(
        this, sdl.SDL_CreateWindow(titlePtr, x, y, width, height, flags));
    calloc.free(titlePtr);
    return window;
  }

  /// Destroy a window.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_DestroyWindow)
  void destroyWindow(Window window) => sdl.SDL_DestroyWindow(window.handle);

  /// Get the current window.
  ///
  /// *Note*: the value returned by this method is not cached.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_GL_GetCurrentWindow)
  Window get currentWindow {
    final ptr = sdl.SDL_GL_GetCurrentWindow();
    if (ptr == nullptr) {
      calloc.free(ptr);
      throw SdlError(0, getError());
    }
    return Window(this, ptr);
  }

  /// Return whether or not the screen saver is currently enabled.
  bool get screenSaverEnabled => getBool(sdl.SDL_IsScreenSaverEnabled());

  /// Set whether or not the screen saver is enabled.
  ///
  /// SDL Links:
  /// [SDL_EnableScreenSaver](https://wiki.libsdl.org/SDL_EnableScreenSaver)
  /// [SDL_DisableScreenSaver](https://wiki.libsdl.org/SDL_DisableScreenSaver)
  set screenSaverEnabled(bool value) {
    if (value) {
      sdl.SDL_EnableScreenSaver();
    } else {
      sdl.SDL_DisableScreenSaver();
    }
  }

  /// Get the number of video displays.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_GetNumVideoDisplays)
  int get numVideoDisplays => checkReturnValue(sdl.SDL_GetNumVideoDisplays());

  /// Get the number of video drivers compiled into SDL.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_GetNumVideoDrivers)
  int get numVideoDrivers => checkReturnValue(sdl.SDL_GetNumVideoDrivers());

  /// Get the name of a video driver.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_GetVideoDriver)
  String getVideoDriver(int index) =>
      sdl.SDL_GetVideoDriver(index).cast<Utf8>().toDartString();

  /// Create a display.
  Display createDisplay(int index) => Display(this, index);

  /// Create a display with index 0.
  Display createFirstDisplay() => createDisplay(0);

  /// Show a message box.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_ShowMessageBox)
  int showMessageBox(
    String title,
    String message,
    List<Button> buttons, {
    Window? window,
    int? flags,
  }) {
    final data = calloc<SDL_MessageBoxData>();
    final titlePointer = title.toInt8Pointer();
    final messagePointer = message.toInt8Pointer();
    final a = calloc<SDL_MessageBoxButtonData>(buttons.length);
    for (var i = 0; i < buttons.length; i++) {
      final button = buttons[i];
      final textPointer = button.text.toInt8Pointer();
      a[i]
        ..buttonid = button.id
        ..flags = button.flags.toSdlFlag()
        ..text = textPointer;
    }
    data.ref
      ..title = titlePointer
      ..message = messagePointer
      ..window = window?.handle ?? nullptr
      ..numbuttons = buttons.length
      ..buttons = a;
    final buttonPointer = calloc<Int32>();
    checkReturnValue(sdl.SDL_ShowMessageBox(data, buttonPointer));
    final buttonId = buttonPointer.value;
    [a, buttonPointer, titlePointer, messagePointer].forEach(calloc.free);
    return buttonId;
  }

  /// Show a simple message box.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_ShowSimpleMessageBox)
  void showSimpleMessageBox(
    MessageBoxFlags type,
    String title,
    String message, {
    Window? window,
  }) {
    final titlePointer = title.toInt8Pointer();
    final messagePointer = message.toInt8Pointer();
    checkReturnValue(sdl.SDL_ShowSimpleMessageBox(type.toSdlFlag(),
        titlePointer, messagePointer, window?.handle ?? nullptr));
    [titlePointer, messagePointer].forEach(calloc.free);
  }

  /// Returns `true` if the clipboard contains text.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_HasClipboardText)
  bool hasClipboardText() => getBool(sdl.SDL_HasClipboardText());

  /// Get clipboard text.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_GetClipboardText)
  String? getClipboardText() {
    if (hasClipboardText() == false) {
      return null;
    }
    final ptr = sdl.SDL_GetClipboardText();
    checkReturnValue(ptr.value);
    final s = ptr.cast<Utf8>().toDartString();
    sdl.SDL_free(ptr.cast<Void>());
    return s;
  }

  /// Set clipboard text.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_SetClipboardText)
  void setClipboardText(String value) {
    final valuePointer = value.toInt8Pointer();
    checkReturnValue(sdl.SDL_SetClipboardText(valuePointer));
    calloc.free(valuePointer);
  }

  /// Pump events.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_PumpEvents)
  void pumpEvents() => sdl.SDL_PumpEvents();

  /// Get the audio drivers on the system.
  ///
  /// Under the hood, uses the
  /// [SDL_GetNumAudioDrivers](https://wiki.libsdl.org/SDL_GetNumAudioDrivers)
  /// method.
  List<AudioDriver> get audioDrivers {
    final numDrivers = sdl.SDL_GetNumAudioDrivers();
    final l = <AudioDriver>[];
    for (var i = 0; i < numDrivers; i++) {
      l.add(AudioDriver(this, i));
    }
    return l;
  }

  /// Get the current audio driver.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_GetCurrentAudioDriver)
  AudioDriver get audioDriver {
    final name = sdl.SDL_GetCurrentAudioDriver().cast<Utf8>().toDartString();
    return audioDrivers.firstWhere((element) => element.name == name);
  }

  /// Get all the audio devices on this system.
  ///
  /// Under the hood, uses the
  ///[SDL_GetNumAudioDevices](https://wiki.libsdl.org/SDL_GetNumAudioDevices)
  ///function.
  List<AudioDevice> getAudioDevices(bool isCapture) {
    final numDevices = sdl.SDL_GetNumAudioDevices(boolToValue(isCapture));
    final l = <AudioDevice>[];
    for (var i = 0; i < numDevices; i++) {
      l.add(AudioDevice(this, i, isCapture));
    }
    return l;
  }

  /// Get all audio devices suitable for output.
  List<AudioDevice> get outputAudioDevices => getAudioDevices(false);

  /// Get all audio devices suitable for input.
  List<AudioDevice> get inputAudioDevices => getAudioDevices(true);

  /// Open an audio device.
  ///
  /// If [device] is `null`, then the default device will be opened,.
  ///
  /// If [isCapture] is `null`, then `device.isCapture` will be used.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_OpenAudioDevice)
  OpenAudioDevice openAudioDevice(
      {AudioDevice? device, bool? isCapture, AudioSpec? settings}) {
    Pointer<Int8> namePointer;
    if (device != null) {
      if (isCapture == null) {
        isCapture = device.isCapture;
        namePointer = device.name.toInt8Pointer();
      } else {
        throw SdlError(-1,
            'You must specify either `device` or `isCapture`, but not both.');
      }
    } else {
      if (isCapture == null) {
        throw SdlError(
            -1, 'When `device == null`, `isCapture` must be specified.');
      } else {
        namePointer = nullptr;
      }
    }
    final desiredPointer = calloc<SDL_AudioSpec>();
    if (settings != null) {
      desiredPointer.ref
        ..channels = settings.channels
        ..format = settings.audioFormat
        ..freq = settings.freq
        ..samples = settings.samples
        ..silence = settings.silence
        ..size = settings.size;
    }
    final obtainedPointer = calloc<SDL_AudioSpec>();
    final id = checkReturnValue(sdl.SDL_OpenAudioDevice(namePointer,
        boolToValue(isCapture), desiredPointer, obtainedPointer, 0));
    if (id <= 0) {
      throw SdlError(id, getError());
    }
    final spec = AudioSpec.fromPointer(obtainedPointer);
    [namePointer, desiredPointer, obtainedPointer].forEach(calloc.free);
    return OpenAudioDevice(this, device, id, spec);
  }

  /// Get the number of joysticks on the system.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_NumJoysticks)
  int get numJoysticks => checkReturnValue(sdl.SDL_NumJoysticks());

  /// Get the implementation-dependent GUID for the joystick at a given device
  /// [index].
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_JoystickGetDeviceGUID)
  SDL_JoystickGUID getJoystickDeviceGuid(int index) {
    final g = sdl.SDL_JoystickGetDeviceGUID(index);
    if (g.data[0] == 0) {
      throw SdlError(0, getError());
    }
    return g;
  }

  /// Get the implementation dependent name of a joystick.
  ///
  /// Returns the name of the joystick with the given [index].
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_JoystickNameForIndex)
  String getJoystickName(int index) {
    final name = sdl.SDL_JoystickNameForIndex(index);
    if (name == nullptr) {
      throw SdlError(0, getError());
    }
    return name.cast<Utf8>().toDartString();
  }

  /// Get the instance ID of the joystick at index [index].
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_JoystickInstanceID)
  int getJoystickInstanceId(int index) =>
      checkReturnValue(sdl.SDL_JoystickGetDeviceInstanceID(index));

  /// Open a joystick with the given [index] for use.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_JoystickOpen)
  Joystick openJoystick(int index) {
    final handle = sdl.SDL_JoystickOpen(index);
    if (handle == nullptr) {
      throw SdlError(0, getError());
    }
    final j = Joystick(this, handle);
    return j;
  }

  /// Returns `true` if the joystick at [index] is a game controller.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_IsGameController)
  bool isGameController(int index) => getBool(sdl.SDL_IsGameController(index));

  /// Get the implementation dependent name for the game controller.
  ///
  /// Returns the name of the game controller with the given [index].
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_GameControllerNameForIndex)
  String getGameControllerName(int index) =>
      sdl.SDL_GameControllerNameForIndex(index).cast<Utf8>().toDartString();

  /// Open a game controller.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_GameControllerOpen)
  GameController openGameController(int index) {
    final handle = sdl.SDL_GameControllerOpen(index);
    if (handle == nullptr) {
      throw SdlError(0, getError());
    }
    final controller = GameController(this, handle);
    return controller;
  }

  /// Poll events.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_PollEvent)
  Event? pollEvent() {
    final ptr = calloc<SDL_Event>();
    final n = sdl.SDL_PollEvent(ptr);
    if (n != 0) {
      final e = ptr.ref;
      Event event;
      switch (e.type) {

        // Application events
        case SDL_EventType.SDL_QUIT:
          event = QuitEvent(this, e.common.timestamp);
          break;

        // Android, iOS and WinRT events
        case SDL_EventType.SDL_APP_TERMINATING:
          event = AppTerminatingEvent(this, e.common.timestamp);
          break;
        case SDL_EventType.SDL_APP_LOWMEMORY:
          event = AppLowMemoryEvent(this, e.common.timestamp);
          break;
        case SDL_EventType.SDL_APP_WILLENTERBACKGROUND:
          event = AppWillEnterBackgroundEvent(this, e.common.timestamp);
          break;
        case SDL_EventType.SDL_APP_DIDENTERBACKGROUND:
          event = AppDidEnterBackgroundEvent(this, e.common.timestamp);
          break;
        case SDL_EventType.SDL_APP_WILLENTERFOREGROUND:
          event = AppWillEnterForegroundEvent(this, e.common.timestamp);
          break;
        case SDL_EventType.SDL_APP_DIDENTERFOREGROUND:
          event = AppDidEnterForegroundEvent(this, e.common.timestamp);
          break;

        // Window events
        case SDL_EventType.SDL_WINDOWEVENT:
          final windowEvent = e.window;
          final timestamp = windowEvent.timestamp;
          final windowId = windowEvent.windowID;
          switch (windowEvent.event) {
            case SDL_WindowEventID.SDL_WINDOWEVENT_SHOWN:
              event = WindowShownEvent(this, timestamp, windowId);
              break;
            case SDL_WindowEventID.SDL_WINDOWEVENT_HIDDEN:
              event = WindowHiddenEvent(this, timestamp, windowId);
              break;
            case SDL_WindowEventID.SDL_WINDOWEVENT_EXPOSED:
              event = WindowExposedEvent(this, timestamp, windowId);
              break;
            case SDL_WindowEventID.SDL_WINDOWEVENT_MOVED:
              event = WindowMovedEvent(this, timestamp, windowId,
                  Point<int>(windowEvent.data1, windowEvent.data2));
              break;
            case SDL_WindowEventID.SDL_WINDOWEVENT_RESIZED:
              event = WindowResizedEvent(this, timestamp, windowId,
                  WindowSize(windowEvent.data1, windowEvent.data2));
              break;
            case SDL_WindowEventID.SDL_WINDOWEVENT_SIZE_CHANGED:
              event = WindowSizeChangedEvent(this, timestamp, windowId);
              break;
            case SDL_WindowEventID.SDL_WINDOWEVENT_MINIMIZED:
              event = WindowMinimizedEvent(this, timestamp, windowId);
              break;
            case SDL_WindowEventID.SDL_WINDOWEVENT_MAXIMIZED:
              event = WindowMaximizedEvent(this, timestamp, windowId);
              break;
            case SDL_WindowEventID.SDL_WINDOWEVENT_RESTORED:
              event = WindowRestoredEvent(this, timestamp, windowId);
              break;
            case SDL_WindowEventID.SDL_WINDOWEVENT_ENTER:
              event = WindowEnterEvent(this, timestamp, windowId);
              break;
            case SDL_WindowEventID.SDL_WINDOWEVENT_LEAVE:
              event = WindowLeaveEvent(this, timestamp, windowId);
              break;
            case SDL_WindowEventID.SDL_WINDOWEVENT_FOCUS_GAINED:
              event = WindowFocusGainedEvent(this, timestamp, windowId);
              break;
            case SDL_WindowEventID.SDL_WINDOWEVENT_FOCUS_LOST:
              event = WindowFocusLostEvent(this, timestamp, windowId);
              break;
            case SDL_WindowEventID.SDL_WINDOWEVENT_CLOSE:
              event = WindowClosedEvent(this, timestamp, windowId);
              break;
            case SDL_WindowEventID.SDL_WINDOWEVENT_TAKE_FOCUS:
              event = WindowTakeFocusEvent(this, timestamp, windowId);
              break;
            case SDL_WindowEventID.SDL_WINDOWEVENT_HIT_TEST:
              event = WindowHitTestEvent(this, timestamp, windowId);
              break;
            default:
              throw SdlError(windowEvent.type, 'Unknown window event type.');
          }
          break;
        case SDL_EventType.SDL_SYSWMEVENT:
          final msg = e.syswm.msg;
          event = SysWmEvent(this, e.syswm.timestamp, msg);
          break;

        // Keyboard events
        case SDL_EventType.SDL_KEYDOWN:
          event = KeyboardEvent.fromSdlEvent(this, e.key);
          break;
        case SDL_EventType.SDL_KEYUP:
          event = KeyboardEvent.fromSdlEvent(this, e.key);
          break;
        case SDL_EventType.SDL_TEXTEDITING:
          final s = String.fromCharCodes(
              [for (var i = 0; i < e.edit.length; i++) e.edit.text[i]]);
          event = TextEditingEvent(this, e.edit.timestamp, e.edit.windowID, s,
              e.edit.start, e.edit.length);
          break;
        case SDL_EventType.SDL_TEXTINPUT:
          var s = '';
          var i = 0;
          while (true) {
            final c = e.text.text[i];
            if (c == 0) {
              break;
            } else {
              s += String.fromCharCode(c);
              i++;
            }
          }
          event = TextInputEvent(this, e.text.timestamp, s);
          break;
        case SDL_EventType.SDL_KEYMAPCHANGED:
          event = KeymapChangedEvent(this, e.common.timestamp);
          break;

        // Mouse events
        case SDL_EventType.SDL_MOUSEMOTION:
          event = MouseMotionEvent(
              this,
              e.motion.timestamp,
              e.motion.windowID,
              e.motion.which,
              e.motion.state,
              e.motion.x,
              e.motion.y,
              e.motion.xrel,
              e.motion.yrel);
          break;
        case SDL_EventType.SDL_MOUSEBUTTONDOWN:
          event = MouseButtonEvent.fromSdlEvent(this, e.button);
          break;
        case SDL_EventType.SDL_MOUSEBUTTONUP:
          event = MouseButtonEvent.fromSdlEvent(this, e.button);
          break;
        case SDL_EventType.SDL_MOUSEWHEEL:
          event = MouseWheelEvent(
              this,
              e.wheel.timestamp,
              e.wheel.windowID,
              e.wheel.which,
              e.wheel.x,
              e.wheel.y,
              e.wheel.direction.toMouseWheelDirection());
          break;

        // Joystick events
        case SDL_EventType.SDL_JOYAXISMOTION:
          event = JoyAxisEvent(this, e.jaxis.timestamp, e.jaxis.which,
              e.jaxis.axis, e.jaxis.value);
          break;
        case SDL_EventType.SDL_JOYBALLMOTION:
          event = JoyBallEvent(this, e.jball.timestamp, e.jball.which,
              e.jball.ball, e.jball.xrel, e.jball.yrel);
          break;
        case SDL_EventType.SDL_JOYHATMOTION:
          event = JoyHatEvent.fromSdlEvent(this, e.jhat);
          break;
        case SDL_EventType.SDL_JOYBUTTONDOWN:
          event = JoyButtonEvent.fromSdlEvent(this, e.jbutton);
          break;
        case SDL_EventType.SDL_JOYBUTTONUP:
          event = JoyButtonEvent.fromSdlEvent(this, e.jbutton);
          break;
        case SDL_EventType.SDL_JOYDEVICEADDED:
          event = JoyDeviceEvent.fromSdlEvent(this, e.jdevice);
          break;
        case SDL_EventType.SDL_JOYDEVICEREMOVED:
          event = JoyDeviceEvent.fromSdlEvent(this, e.jdevice);
          break;

        // Controller events
        case SDL_EventType.SDL_CONTROLLERAXISMOTION:
          event = ControllerAxisEvent(this, e.caxis.timestamp, e.caxis.which,
              e.caxis.axis.toGameControllerAxis(), e.caxis.value);
          break;
        case SDL_EventType.SDL_CONTROLLERBUTTONDOWN:
          event = ControllerButtonEvent.fromSdlEvent(this, e.cbutton);
          break;
        case SDL_EventType.SDL_CONTROLLERBUTTONUP:
          event = ControllerButtonEvent.fromSdlEvent(this, e.cbutton);
          break;
        case SDL_EventType.SDL_CONTROLLERDEVICEADDED:
          event = ControllerDeviceEvent.fromSdlEvent(this, e.cdevice);
          break;
        case SDL_EventType.SDL_CONTROLLERDEVICEREMOVED:
          event = ControllerDeviceEvent.fromSdlEvent(this, e.cdevice);
          break;
        case SDL_EventType.SDL_CONTROLLERDEVICEREMAPPED:
          event = ControllerDeviceEvent.fromSdlEvent(this, e.cdevice);
          break;

        // Touch events
        case SDL_EventType.SDL_FINGERDOWN:
          event = TouchFingerEvent.fromSdlEvent(this, e.tfinger);
          break;
        case SDL_EventType.SDL_FINGERUP:
          event = TouchFingerEvent.fromSdlEvent(this, e.tfinger);
          break;
        case SDL_EventType.SDL_FINGERMOTION:
          event = TouchFingerEvent.fromSdlEvent(this, e.tfinger);
          break;

        // Gesture events
        case SDL_EventType.SDL_DOLLARGESTURE:
          event = DollarGestureEvent.fromSdlEvent(this, e.dgesture);
          break;
        case SDL_EventType.SDL_DOLLARRECORD:
          event = DollarGestureEvent.fromSdlEvent(this, e.dgesture);
          break;
        case SDL_EventType.SDL_MULTIGESTURE:
          event = MultiGestureEvent(
              this,
              e.mgesture.timestamp,
              e.mgesture.touchId,
              e.mgesture.dTheta,
              e.mgesture.dDist,
              e.mgesture.numFingers,
              e.mgesture.x,
              e.mgesture.y);
          break;

        // Clipboard events
        case SDL_EventType.SDL_CLIPBOARDUPDATE:
          event = ClipboardChangedEvent(this, e.common.timestamp);
          break;

        // Drag and drop events
        case SDL_EventType.SDL_DROPFILE:
          event = DropEvent.fromSdlEvent(this, e.drop);
          break;
        case SDL_EventType.SDL_DROPTEXT:
          event = DropEvent.fromSdlEvent(this, e.drop);
          break;
        case SDL_EventType.SDL_DROPBEGIN:
          event = DropEvent.fromSdlEvent(this, e.drop);
          break;
        case SDL_EventType.SDL_DROPCOMPLETE:
          event = DropEvent.fromSdlEvent(this, e.drop);
          break;

        // Audio hotplug events
        case SDL_EventType.SDL_AUDIODEVICEADDED:
          event = AudioDeviceEvent.fromSdlEvent(this, e.adevice);
          break;
        case SDL_EventType.SDL_AUDIODEVICEREMOVED:
          event = AudioDeviceEvent.fromSdlEvent(this, e.adevice);
          break;

        // Render events
        default:
          throw SdlError(e.type, 'Unrecognised event type.');
      }
      return event;
    }
  }

  /// Get a stream of all SDL events.
  Stream<Event> get events async* {
    while (true) {
      final event = pollEvent();
      if (event != null) {
        yield event;
      }
    }
  }

  /// Register user-defined event types.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_PumpEvents)
  int registerEvents(int n) {
    final r = sdl.SDL_RegisterEvents(n);
    if (r == 0xFFFFFFFF) {
      throw SdlError(r, 'Not enough user-defined events left.');
    }
    return r;
  }

  /// Get the state of game controller events.
  bool get gameControllerEventsEnabled {
    final value = sdl.SDL_GameControllerEventState(SDL_QUERY);
    switch (value) {
      case SDL_IGNORE:
        return false;
      case SDL_ENABLE:
        return true;
      default:
        throw SdlError(value, 'Unknown result.');
    }
  }

  /// Set whether or not game controller events are enabled.
  set gameControllerEventsEnabled(bool value) =>
      sdl.SDL_GameControllerEventState(value ? SDL_ENABLE : SDL_IGNORE);
}
