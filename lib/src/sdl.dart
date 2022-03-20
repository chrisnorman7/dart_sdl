/// Provides the main [Sdl] class.
import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'dart:math';

import 'package:ffi/ffi.dart';
import 'package:path/path.dart' as path;

import 'audio/device.dart';
import 'audio/driver.dart';
import 'audio/spec.dart';
import 'display.dart';
import 'enumerations.dart';
import 'error.dart';
import 'events/application.dart';
import 'events/audio.dart';
import 'events/base.dart';
import 'events/clipboard.dart';
import 'events/display.dart';
import 'events/drop.dart';
import 'events/game_controller.dart';
import 'events/gestures.dart';
import 'events/joystick.dart';
import 'events/keyboard.dart';
import 'events/mouse.dart';
import 'events/platform.dart';
import 'events/renderer.dart';
import 'events/sensor.dart';
import 'events/text.dart';
import 'events/touch_finger.dart';
import 'events/user.dart';
import 'events/window.dart';
import 'extensions.dart';
import 'game_controller.dart';
import 'haptic/haptic.dart';
import 'haptic/haptic_direction.dart';
import 'joystick.dart';
import 'keycodes.dart';
import 'message_box_button.dart';
import 'modifiers.dart';
import 'sdl_bindings.dart';
import 'version.dart';
import 'window.dart';

/// The main SDL class.
class Sdl {
  /// Create an object.
  Sdl({String? libName})
      : xPointer = calloc<Int32>(),
        yPointer = calloc<Int32>(),
        x2Pointer = calloc<Int32>(),
        y2Pointer = calloc<Int32>(),
        floatPointer = calloc<Float>(),
        displayModePointer = calloc<SDL_DisplayMode>(),
        _audioSpecDesiredPointer = calloc<SDL_AudioSpec>(),
        _audioSpecObtainedPointer = calloc<SDL_AudioSpec>(),
        _messageBoxDataPointer = calloc<SDL_MessageBoxData>(),
        _versionPointer = calloc<SDL_version>(),
        hapticDirectionPointer = calloc<SDL_HapticDirection>(),
        rectPointer = calloc<SDL_Rect>(),
        _eventHandle = calloc<SDL_Event>() {
    if (libName == null) {
      if (Platform.isWindows) {
        libName = 'SDL2.dll';
      } else if (Platform.isLinux) {
        libName = path.join(Directory.current.path, 'libSDL2.so');
      } else if (Platform.isMacOS) {
        if (File('libSDL2.dylib').existsSync()) {
          libName = 'libSDL2.dylib';
        } else {
          libName = 'SDL2.framework/SDL2';
        }
      } else {
        throw Exception(
            'Unimplemented operating system: ${Platform.operatingSystem}. '
            'You must specify your own `libName`.');
      }
    }
    sdl = DartSdl(DynamicLibrary.open(libName));
  }

  /// The x [Int32] pointer.
  final Pointer<Int32> xPointer;

  /// The y [Int32] pointer.
  final Pointer<Int32> yPointer;

  /// An extra [Int32] pointer.
  final Pointer<Int32> x2Pointer;

  /// Another [Int32] pointer.
  final Pointer<Int32> y2Pointer;

  /// The [Float] pointer.
  final Pointer<Float> floatPointer;

  /// The display pointer.
  final Pointer<SDL_DisplayMode> displayModePointer;

  /// The desired audio spec pointer.
  final Pointer<SDL_AudioSpec> _audioSpecDesiredPointer;

  /// The obtained audio spec pointer.
  final Pointer<SDL_AudioSpec> _audioSpecObtainedPointer;

  /// The message box data pointer.
  final Pointer<SDL_MessageBoxData> _messageBoxDataPointer;

  /// The SDL version pointer to use.
  final Pointer<SDL_version> _versionPointer;

  /// The haptic direction pointer.
  final Pointer<SDL_HapticDirection> hapticDirectionPointer;

  /// The rectangle pointer.
  final Pointer<SDL_Rect> rectPointer;

  /// The event handle to use.
  final Pointer<SDL_Event> _eventHandle;

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
  void quit() {
    [
      xPointer,
      yPointer,
      x2Pointer,
      y2Pointer,
      floatPointer,
      displayModePointer,
      _audioSpecDesiredPointer,
      _audioSpecObtainedPointer,
      _messageBoxDataPointer,
      _versionPointer,
      rectPointer,
      _eventHandle,
    ].forEach(calloc.free);
    sdl.SDL_Quit();
  }

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
        hintPointer, valuePointer, priority.toInt());
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
    func(category.toInt(), messagePointer);
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
    sdl.SDL_LogMessage(category.toInt(), priority.toInt(), messagePointer);
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
      sdl.SDL_LogGetPriority(category.toInt()).toLogPriority();

  /// Reset log priorities.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_LogResetPriorities)
  void resetLogPriorities() => sdl.SDL_LogResetPriorities();

  /// Set the priority of all log categories.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_LogSetAllPriority)
  void setAllLogPriorities(LogPriority priority) =>
      sdl.SDL_LogSetAllPriority(priority.toInt());

  /// Set log priority.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_LogSetPriority)
  void setLogPriority(LogCategory category, LogPriority priority) =>
      sdl.SDL_LogSetPriority(category.toInt(), priority.toInt());

  /// Get the compiled version.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_COMPILEDVERSION)
  int get compiledVersion => SDL_COMPILEDVERSION;

  /// Get SDL version.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_GetVersion)
  SdlVersion get version {
    sdl.SDL_GetVersion(_versionPointer);
    final v = _versionPointer.ref;
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
    List<MessageBoxButton> buttons, {
    Window? window,
    List<MessageBoxFlags>? flags,
  }) {
    final titlePointer = title.toInt8Pointer();
    final messagePointer = message.toInt8Pointer();
    final a = calloc<SDL_MessageBoxButtonData>(buttons.length);
    for (var i = 0; i < buttons.length; i++) {
      final button = buttons[i];
      final textPointer = button.text.toInt8Pointer();
      a[i]
        ..buttonid = button.id
        ..flags = button.flags.fold(
            0, (previousValue, element) => previousValue | element.toInt())
        ..text = textPointer;
    }
    _messageBoxDataPointer.ref
      ..title = titlePointer
      ..message = messagePointer
      ..window = window?.handle ?? nullptr
      ..numbuttons = buttons.length
      ..buttons = a
      ..flags = [for (final f in flags ?? <MessageBoxFlags>[]) f.toInt()].xor();
    checkReturnValue(sdl.SDL_ShowMessageBox(_messageBoxDataPointer, xPointer));
    final buttonId = xPointer.value;
    [a, titlePointer].forEach(calloc.free);
    return buttonId;
  }

  /// Show a simple message box.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_ShowSimpleMessageBox)
  void showSimpleMessageBox(
    List<MessageBoxFlags> types,
    String title,
    String message, {
    Window? window,
  }) {
    final titlePointer = title.toInt8Pointer();
    final messagePointer = message.toInt8Pointer();
    checkReturnValue(sdl.SDL_ShowSimpleMessageBox(
        [for (final t in types) t.toInt()].xor(),
        titlePointer,
        messagePointer,
        window?.handle ?? nullptr));
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
    if (settings != null) {
      _audioSpecDesiredPointer.ref
        ..channels = settings.channels
        ..format = settings.audioFormat
        ..freq = settings.freq
        ..samples = settings.samples
        ..silence = settings.silence
        ..size = settings.size;
    }
    final id = checkReturnValue(sdl.SDL_OpenAudioDevice(
        namePointer,
        boolToValue(isCapture),
        _audioSpecDesiredPointer,
        _audioSpecObtainedPointer,
        0));
    if (id <= 0) {
      throw SdlError(id, getError());
    }
    final spec = AudioSpec.fromPointer(_audioSpecObtainedPointer);
    calloc.free(namePointer);
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

  /// Throw an error to show that an event was unhandled.
  Never throwInvalidEvent(EventType type) =>
      throw SdlError(type.toInt(), 'Invalid event type $type.');

  /// Poll events.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_PollEvent)
  Event? pollEvent() {
    final n = sdl.SDL_PollEvent(_eventHandle);
    if (n != 0) {
      final e = _eventHandle.ref;
      Event event;
      final type = e.type.toEventType();
      switch (type) {
        case EventType.firstevent:
          throwInvalidEvent(type);
        case EventType.quit:
          event = QuitEvent(this, e.quit.timestamp);
          break;
        case EventType.appTerminating:
          event = AppTerminatingEvent(this, e.common.timestamp);
          break;
        case EventType.appLowmemory:
          event = AppLowMemoryEvent(this, e.common.timestamp);
          break;
        case EventType.appWillenterbackground:
          event = AppWillEnterBackgroundEvent(this, e.common.timestamp);
          break;
        case EventType.appDidenterbackground:
          event = AppDidEnterBackgroundEvent(this, e.common.timestamp);
          break;
        case EventType.appWillenterforeground:
          event = AppWillEnterForegroundEvent(this, e.common.timestamp);
          break;
        case EventType.appDidenterforeground:
          event = AppDidEnterForegroundEvent(this, e.common.timestamp);
          break;
        case EventType.localechanged:
          event = LocaleChanged(this, e.common.timestamp);
          break;
        case EventType.displayevent:
          event = DisplayEvent.fromEvent(this, e);
          break;
        case EventType.windowevent:
          final windowEvent = e.window;
          final timestamp = windowEvent.timestamp;
          final windowId = windowEvent.windowID;
          switch (windowEvent.event.toWindowEventID()) {
            case WindowEventID.none:
              throw SdlError(windowEvent.event, 'No event ID.');
            case WindowEventID.shown:
              event = WindowShownEvent(this, timestamp, windowId);
              break;
            case WindowEventID.hidden:
              event = WindowHiddenEvent(this, timestamp, windowId);
              break;
            case WindowEventID.exposed:
              event = WindowExposedEvent(this, timestamp, windowId);
              break;
            case WindowEventID.moved:
              event = WindowMovedEvent(this, timestamp, windowId,
                  Point<int>(windowEvent.data1, windowEvent.data2));
              break;
            case WindowEventID.resized:
              event = WindowResizedEvent(this, timestamp, windowId,
                  WindowSize(windowEvent.data1, windowEvent.data2));
              break;
            case WindowEventID.sizeChanged:
              event = WindowSizeChangedEvent(this, timestamp, windowId);
              break;
            case WindowEventID.minimized:
              event = WindowMinimizedEvent(this, timestamp, windowId);
              break;
            case WindowEventID.maximized:
              event = WindowMaximizedEvent(this, timestamp, windowId);
              break;
            case WindowEventID.restored:
              event = WindowRestoredEvent(this, timestamp, windowId);
              break;
            case WindowEventID.enter:
              event = WindowEnterEvent(this, timestamp, windowId);
              break;
            case WindowEventID.leave:
              event = WindowLeaveEvent(this, timestamp, windowId);
              break;
            case WindowEventID.focusGained:
              event = WindowFocusGainedEvent(this, timestamp, windowId);
              break;
            case WindowEventID.focusLost:
              event = WindowFocusLostEvent(this, timestamp, windowId);
              break;
            case WindowEventID.close:
              event = WindowClosedEvent(this, timestamp, windowId);
              break;
            case WindowEventID.takeFocus:
              event = WindowTakeFocusEvent(this, timestamp, windowId);
              break;
            case WindowEventID.hitTest:
              event = WindowHitTestEvent(this, timestamp, windowId);
              break;
          }
          break;
        case EventType.syswmevent:
          final msg = e.syswm.msg;
          event = SysWmEvent(this, e.syswm.timestamp, msg);
          break;
        case EventType.keydown:
          event = KeyboardEvent.fromSdlEvent(this, e.key);
          break;
        case EventType.keyup:
          event = KeyboardEvent.fromSdlEvent(this, e.key);
          break;
        case EventType.textediting:
          final s = String.fromCharCodes(
              [for (var i = 0; i < e.edit.length; i++) e.edit.text[i]]);
          event = TextEditingEvent(
              sdl: this,
              timestamp: e.edit.timestamp,
              wndId: e.edit.windowID,
              text: s,
              start: e.edit.start,
              length: e.edit.length);
          break;
        case EventType.textinput:
          final charCodes = <int>[];
          var i = 0;
          while (true) {
            var c = e.text.text[i];
            if (c == 0) {
              break;
            } else {
              if (c < 0) {
                c += 256;
              }
              charCodes.add(c);
              i++;
            }
          }
          event =
              TextInputEvent(this, e.text.timestamp, utf8.decode(charCodes));
          break;
        case EventType.keymapchanged:
          event = KeymapChangedEvent(this, e.common.timestamp);
          break;
        case EventType.mousemotion:
          final motion = e.motion;
          event = MouseMotionEvent(
              sdl: this,
              timestamp: motion.timestamp,
              wndId: motion.windowID,
              which: motion.which,
              state: motion.state,
              x: motion.x,
              y: motion.y,
              relativeX: motion.xrel,
              relativeY: motion.yrel);
          break;
        case EventType.mousebuttondown:
          event = MouseButtonEvent.fromSdlEvent(this, e.button);
          break;
        case EventType.mousebuttonup:
          event = MouseButtonEvent.fromSdlEvent(this, e.button);
          break;
        case EventType.mousewheel:
          final wheel = e.wheel;
          event = MouseWheelEvent(
              sdl: this,
              timestamp: wheel.timestamp,
              windowId: wheel.windowID,
              which: wheel.which,
              x: wheel.x,
              y: wheel.y,
              direction: wheel.direction.toMouseWheelDirection());
          break;
        case EventType.joyaxismotion:
          final axis = e.jaxis;
          event = JoyAxisEvent(
              sdl: this,
              timestamp: axis.timestamp,
              joystickId: axis.which,
              axis: axis.axis,
              value: axis.value);
          break;
        case EventType.joyballmotion:
          final ball = e.jball;
          event = JoyBallEvent(
              sdl: this,
              timestamp: ball.timestamp,
              joystickId: ball.which,
              ball: ball.ball,
              relativeX: ball.xrel,
              relativeY: ball.yrel);
          break;
        case EventType.joyhatmotion:
          final hat = e.jhat;
          event = JoyHatEvent(
              sdl: this,
              timestamp: hat.timestamp,
              joystickId: hat.which,
              hat: hat.hat,
              value: hat.value.toJoyHatValue());
          break;
        case EventType.joybuttondown:
          event = JoyButtonEvent.fromSdlEvent(this, e.jbutton);
          break;
        case EventType.joybuttonup:
          event = JoyButtonEvent.fromSdlEvent(this, e.jbutton);
          break;
        case EventType.joydeviceadded:
          event = JoyDeviceEvent.fromSdlEvent(this, e.jdevice);
          break;
        case EventType.joydeviceremoved:
          event = JoyDeviceEvent.fromSdlEvent(this, e.jdevice);
          break;
        case EventType.controlleraxismotion:
          final axis = e.caxis;
          event = ControllerAxisEvent(
              sdl: this,
              timestamp: axis.timestamp,
              joystickId: axis.which,
              axis: axis.axis.toGameControllerAxis(),
              value: axis.value);
          break;
        case EventType.controllerbuttondown:
          event = ControllerButtonEvent.fromSdlEvent(this, e.cbutton);
          break;
        case EventType.controllerbuttonup:
          event = ControllerButtonEvent.fromSdlEvent(this, e.cbutton);
          break;
        case EventType.controllerdeviceadded:
          event = ControllerDeviceEvent.fromSdlEvent(this, e.cdevice);
          break;
        case EventType.controllerdeviceremoved:
          event = ControllerDeviceEvent.fromSdlEvent(this, e.cdevice);
          break;
        case EventType.controllerdeviceremapped:
          event = ControllerDeviceEvent.fromSdlEvent(this, e.cdevice);
          break;
        case EventType.controllertouchpaddown:
          event = ControllerTouchpadEvent.fromSdlEvent(this, e.ctouchpad);
          break;
        case EventType.controllertouchpadmotion:
          event = ControllerTouchpadEvent.fromSdlEvent(this, e.ctouchpad);
          break;
        case EventType.controllertouchpadup:
          event = ControllerTouchpadEvent.fromSdlEvent(this, e.ctouchpad);
          break;
        case EventType.controllersensorupdate:
          event = ControllerSensorEvent.fromSdlEvent(this, e.csensor);
          break;
        case EventType.fingerdown:
          event = TouchFingerEvent.fromSdlEvent(this, e.tfinger);
          break;
        case EventType.fingerup:
          event = TouchFingerEvent.fromSdlEvent(this, e.tfinger);
          break;
        case EventType.fingermotion:
          event = TouchFingerEvent.fromSdlEvent(this, e.tfinger);
          break;
        case EventType.dollargesture:
          event = DollarGestureEvent.fromSdlEvent(this, e.dgesture);
          break;
        case EventType.dollarrecord:
          event = DollarGestureEvent.fromSdlEvent(this, e.dgesture);
          break;
        case EventType.multigesture:
          final gesture = e.mgesture;
          event = MultiGestureEvent(
              sdl: this,
              timestamp: gesture.timestamp,
              touchId: gesture.touchId,
              dTheta: gesture.dTheta,
              dDist: gesture.dDist,
              numFingers: gesture.numFingers,
              x: gesture.x,
              y: gesture.y);
          break;
        case EventType.clipboardupdate:
          event = ClipboardChangedEvent(this, e.common.timestamp);
          break;
        case EventType.dropfile:
          event = DropEvent.fromSdlEvent(this, e.drop);
          break;
        case EventType.droptext:
          event = DropEvent.fromSdlEvent(this, e.drop);
          break;
        case EventType.dropbegin:
          event = DropEvent.fromSdlEvent(this, e.drop);
          break;
        case EventType.dropcomplete:
          event = DropEvent.fromSdlEvent(this, e.drop);
          break;
        case EventType.audiodeviceadded:
          event = AudioDeviceEvent.fromSdlEvent(this, e.adevice);
          break;
        case EventType.audiodeviceremoved:
          event = AudioDeviceEvent.fromSdlEvent(this, e.adevice);
          break;
        case EventType.sensorupdate:
          final sensor = e.sensor;
          event = SensorEvent(
              sdl: this,
              timestamp: sensor.timestamp,
              sensor: sensor.which,
              data1: sensor.data[0],
              data2: sensor.data[1],
              data3: sensor.data[2],
              data4: sensor.data[3],
              data5: sensor.data[4],
              data6: sensor.data[5]);
          break;
        case EventType.renderTargetsReset:
          event = RenderTargetsResetEvent(this, e.common.timestamp);
          break;
        case EventType.renderDeviceReset:
          event = RenderDeviceReset(this, e.common.timestamp);
          break;
        case EventType.userevent:
          final user = e.user;
          event = UserEvent(
              sdl: this,
              timestamp: user.timestamp,
              type: user.type,
              windowId: user.windowID == 0 ? null : user.windowID,
              code: user.code);
          break;
        case EventType.lastevent:
          throw SdlError(e.type, 'Last event type.');
      }
      return event;
    }
    return null;
  }

  /// Get a stream of all SDL events.
  ///
  /// A pause of [duration] will be awaited between calls to [pollEvent].
  Stream<Event> getEvents({Duration duration = Duration.zero}) async* {
    while (true) {
      final event = pollEvent();
      if (event != null) {
        yield event;
      }
      await Future<void>.delayed(duration);
    }
  }

  ///Stream all events.
  ///
  ///This stream uses the [getEvents] method with the default duration.
  Stream<Event> get events => getEvents();

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

  /// Wait a specified number of milliseconds before returning.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_Delay)
  void delay(int ms) => sdl.SDL_Delay(ms);

  /// Query the window which currently has keyboard focus.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_GetKeyboardFocus)
  Window? getKeyboardFocus() {
    final pointer = sdl.SDL_GetKeyboardFocus();
    if (pointer == nullptr) {
      return null;
    }
    return Window(this, pointer);
  }

  /// Get a snapshot of the current state of the keyboard.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_GetKeyboardState)
  List<PressedState> get keyboardState {
    final array = sdl.SDL_GetKeyboardState(xPointer);
    return [
      for (var i = 0; i < xPointer.value; i++)
        array[i] == 1 ? PressedState.pressed : PressedState.released
    ];
  }

  /// Get a key code from a human-readable name.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_GetKeyFromName)
  KeyCode getKeyFromName(String name) {
    final key = sdl.SDL_GetKeyFromName(name.toInt8Pointer());
    if (key == SDL_KeyCode.SDLK_UNKNOWN) {
      throw SdlError(key, getError());
    }
    return key.toKeyCode();
  }

  /// Get the key code corresponding to the given scancode according to the
  /// current keyboard layout.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_GetKeyFromScancode)
  KeyCode getKeyFromScanCode(ScanCode scanCode) =>
      sdl.SDL_GetKeyFromScancode(scanCode.toSdlValue()).toKeyCode();

  /// Get a human-readable name for a key.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_GetKeyName)
  String getKeyName(KeyCode keyCode) =>
      sdl.SDL_GetKeyName(keyCode.toSdlValue()).cast<Utf8>().toDartString();

  /// Get the current key modifier state for the keyboard.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_GetModState)
  Set<KeyMod> get modState => sdl.SDL_GetModState().toModifiersSet();

  /// Set the current key modifier state for the keyboard.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_SetModState)
  set modState(Set<KeyMod> modifiers) {
    var mod = 0;
    for (final modifier in modifiers) {
      mod |= modifier.toInt();
    }
    sdl.SDL_SetModState(mod);
  }

  /// Get the scancode corresponding to the given key code according to the
  /// current keyboard layout.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_GetScancodeFromKey)
  ScanCode getScanCodeFromKey(KeyCode key) =>
      sdl.SDL_GetScancodeFromKey(key.toSdlValue()).toScanCode();

  /// Get a scancode from a human-readable name.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_GetScancodeFromName)
  ScanCode getScanCodeFromName(String name) {
    final scanCode = sdl.SDL_GetScancodeFromName(name.toInt8Pointer());
    if (scanCode == SDL_Scancode.SDL_SCANCODE_UNKNOWN) {
      throw SdlError(scanCode, getError());
    }
    return scanCode.toScanCode();
  }

  /// Get a human-readable name for a scancode.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_GetScancodeName)
  String getScanCodeName(ScanCode scanCode) =>
      sdl.SDL_GetScancodeName(scanCode.toSdlValue())
          .cast<Utf8>()
          .toDartString();

  /// Check whether the platform has screen keyboard support.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_HasScreenKeyboardSupport)
  bool get hasScreenKeyboardSupport =>
      getBool(sdl.SDL_HasScreenKeyboardSupport());

  /// Check whether or not Unicode text input events are enabled.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_IsTextInputActive)
  bool get isTextInputActive => getBool(sdl.SDL_IsTextInputActive());

  /// Start accepting Unicode text input events.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_StartTextInput)
  void startTextInput() => sdl.SDL_StartTextInput();

  /// Stop receiving any text input events.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_StopTextInput)
  void stopTextInput() => sdl.SDL_StopTextInput();

  /// Capture the mouse and to track input outside an SDL window.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_CaptureMouse)
  void captureMouse(bool enabled) =>
      checkReturnValue(sdl.SDL_CaptureMouse(boolToValue(enabled)));

  /// Get the window which currently has mouse focus.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_GetMouseFocus)
  Window getMouseFocus() => Window(this, sdl.SDL_GetMouseFocus());

  /// Query whether relative mouse mode is enabled.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_GetRelativeMouseMode)
  bool get relativeMouseMode => getBool(sdl.SDL_GetRelativeMouseMode());

  /// Set relative mouse mode.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_SetRelativeMouseMode)
  set relativeMouseMode(bool enabled) =>
      checkReturnValue(sdl.SDL_SetRelativeMouseMode(boolToValue(enabled)));

  /// Returns `true` if the cursor is shown, `false` otherwise.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_ShowCursor)
  bool get showCursor =>
      getBool(checkReturnValue(sdl.SDL_ShowCursor(SDL_QUERY)));

  /// Toggle whether or not the cursor is shown.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_ShowCursor)
  set showCursor(bool enabled) =>
      checkReturnValue(sdl.SDL_ShowCursor(boolToValue(enabled)));

  /// Move the mouse to the given position in global screen space.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_WarpMouseGlobal)
  void warpMouse(int x, int y) =>
      checkReturnValue(sdl.SDL_WarpMouseGlobal(x, y));

  /// Count the number of sensors attached to the system right now.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_NumSensors)
  int get numSensors => sdl.SDL_NumSensors();

  /// Count the number of haptic devices attached to the system.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_NumHaptics)
  int get numHaptics => sdl.SDL_NumHaptics();

  /// Check if the haptic device at the designated [index] has been opened.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_HapticOpened)
  bool hapticOpened(int index) => getBool(sdl.SDL_HapticOpened(index));

  /// Open a haptic device for use.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_HapticOpen)
  Haptic openHaptic(int index) {
    final handle = sdl.SDL_HapticOpen(index);
    if (handle == nullptr) {
      throw SdlError(-1, getError());
    }
    return Haptic(this, handle);
  }

  /// Get the implementation dependent name of a haptic device.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_HapticName)
  String getHapticName(int index) {
    final pointer = sdl.SDL_HapticName(index);
    if (pointer == nullptr) {
      throw SdlError(index, getError());
    }
    return pointer.cast<Utf8>().toDartString();
  }

  /// Try to open a haptic device from the current mouse.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_HapticOpenFromMouse)
  Haptic openHapticFromMouse() {
    final pointer = sdl.SDL_HapticOpenFromMouse();
    if (pointer == nullptr) {
      throw SdlError(-1, getError());
    }
    return Haptic(this, pointer);
  }

  /// Query whether or not the current mouse has haptic capabilities.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_MouseIsHaptic)
  bool get mouseIsHaptic => getBool(checkReturnValue(sdl.SDL_MouseIsHaptic()));

  /// Load [direction] onto [hapticDirectionPointer].
  void loadHapticDirection(HapticDirection direction) {
    hapticDirectionPointer.ref.type = direction.type.toInt();
    var value = direction.x;
    if (value != null) {
      hapticDirectionPointer.ref.dir[0] = value;
    } else {
      hapticDirectionPointer.ref.dir[0] = 0;
    }
    value = direction.y;
    if (value != null) {
      hapticDirectionPointer.ref.dir[1] = value;
    } else {
      hapticDirectionPointer.ref.dir[1] = 0;
    }
    value = direction.z;
    if (value != null) {
      hapticDirectionPointer.ref.dir[2] = value;
    } else {
      hapticDirectionPointer.ref.dir[2] = 0;
    }
  }

  /// Get the number of ticks.
  int get ticks => sdl.SDL_GetTicks();

  /// Get the base path.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_GetBasePath)
  String get basePath {
    final ptr = sdl.SDL_GetBasePath();
    if (ptr == nullptr) {
      throw SdlError(-1, getError());
    }
    final string = ptr.cast<Utf8>().toDartString();
    sdl.SDL_free(ptr.cast<Void>());
    return string;
  }

  /// Get the preferences path for your [org] and [app].
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_GetPrefPath)
  String getPrefPath(String org, String app) {
    final orgPointer = org.toInt8Pointer();
    final appPointer = app.toInt8Pointer();
    final ptr = sdl.SDL_GetPrefPath(orgPointer, appPointer);
    [orgPointer, appPointer].forEach(calloc.free);
    if (ptr == nullptr) {
      throw SdlError(-1, getError());
    }
    final string = ptr.cast<Utf8>().toDartString();
    sdl.SDL_free(ptr.cast<Void>());
    return string;
  }
}
