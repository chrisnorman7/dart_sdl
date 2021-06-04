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
import 'events/base.dart';
import 'events/joystick.dart';
import 'events/keyboard.dart';
import 'events/mouse.dart';
import 'events/platform.dart';
import 'events/text.dart';
import 'events/window.dart';
import 'sdl_bindings.dart';
import 'version.dart';
import 'window.dart';

/// The main SDL class.
class Sdl {
  /// Create an object.
  Sdl() : windows = <int, Window>{} {
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

  /// All the created windows.
  final Map<int, Window> windows;

  /// Get a Dart boolean from an SDL one.
  bool getBool(int value) => value == SDL_bool.SDL_TRUE;

  /// Convert a boolean to one of the members of [SDL_bool].
  int boolToValue(bool value) => value ? SDL_bool.SDL_TRUE : SDL_bool.SDL_FALSE;

  /// Convert a [LogCategory] instance to an integer.
  int categoryToInt(LogCategory category) {
    switch (category) {
      case LogCategory.applicationCategory:
        return SDL_LogCategory.SDL_LOG_CATEGORY_APPLICATION;
      case LogCategory.errorCategory:
        return SDL_LogCategory.SDL_LOG_CATEGORY_ERROR;
      case LogCategory.assertCategory:
        return SDL_LogCategory.SDL_LOG_CATEGORY_ASSERT;
      case LogCategory.systemCategory:
        return SDL_LogCategory.SDL_LOG_CATEGORY_SYSTEM;
      case LogCategory.audioCategory:
        return SDL_LogCategory.SDL_LOG_CATEGORY_AUDIO;
      case LogCategory.videoCategory:
        return SDL_LogCategory.SDL_LOG_CATEGORY_VIDEO;
      case LogCategory.renderCategory:
        return SDL_LogCategory.SDL_LOG_CATEGORY_RENDER;
      case LogCategory.inputCategory:
        return SDL_LogCategory.SDL_LOG_CATEGORY_INPUT;
      case LogCategory.testCategory:
        return SDL_LogCategory.SDL_LOG_CATEGORY_TEST;
    }
  }

  /// Convert a priority to an integer.
  int priorityToInt(LogPriority priority) {
    switch (priority) {
      case LogPriority.verbosePriority:
        return SDL_LogPriority.SDL_LOG_PRIORITY_VERBOSE;
      case LogPriority.debugPriority:
        return SDL_LogPriority.SDL_LOG_PRIORITY_DEBUG;
      case LogPriority.infoPriority:
        return SDL_LogPriority.SDL_LOG_PRIORITY_INFO;
      case LogPriority.warnPriority:
        return SDL_LogPriority.SDL_LOG_PRIORITY_WARN;
      case LogPriority.errorPriority:
        return SDL_LogPriority.SDL_LOG_PRIORITY_ERROR;
      case LogPriority.criticalPriority:
        return SDL_LogPriority.SDL_LOG_PRIORITY_CRITICAL;
    }
  }

  /// Convert an integer to a log priority.
  LogPriority intToPriority(int value) {
    switch (value) {
      case SDL_LogPriority.SDL_LOG_PRIORITY_CRITICAL:
        return LogPriority.criticalPriority;
      case SDL_LogPriority.SDL_LOG_PRIORITY_DEBUG:
        return LogPriority.debugPriority;
      case SDL_LogPriority.SDL_LOG_PRIORITY_ERROR:
        return LogPriority.errorPriority;
      case SDL_LogPriority.SDL_LOG_PRIORITY_INFO:
        return LogPriority.infoPriority;
      case SDL_LogPriority.SDL_LOG_PRIORITY_VERBOSE:
        return LogPriority.verbosePriority;
      case SDL_LogPriority.SDL_LOG_PRIORITY_WARN:
        return LogPriority.warnPriority;
      default:
        throw SdlError(value, 'Invalid log priority.');
    }
  }

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
    final hintPointer = hint.toNativeUtf8().cast<Int8>();
    final valuePointer = value.toNativeUtf8().cast<Int8>();
    final retval = sdl.SDL_SetHint(hintPointer, valuePointer);
    [hintPointer, valuePointer].forEach(calloc.free);
    return getBool(retval);
  }

  /// Set hint with priority.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_SetHintWithPriority)
  bool setHintPriority(String hint, String value, HintPriority priority) {
    final hintPointer = hint.toNativeUtf8().cast<Int8>();
    final valuePointer = value.toNativeUtf8().cast<Int8>();
    int p;
    switch (priority) {
      case HintPriority.defaultPriority:
        p = SDL_HintPriority.SDL_HINT_DEFAULT;
        break;
      case HintPriority.normalPriority:
        p = SDL_HintPriority.SDL_HINT_NORMAL;
        break;
      case HintPriority.overridePriority:
        p = SDL_HintPriority.SDL_HINT_OVERRIDE;
        break;
    }
    final retval = sdl.SDL_SetHintWithPriority(hintPointer, valuePointer, p);
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
    final messagePointer = message.toNativeUtf8().cast<Int8>();
    sdl.SDL_SetError(messagePointer);
    calloc.free(messagePointer);
  }

  /// Log a message.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_Log)
  void log(String message) {
    final messagePointer = message.toNativeUtf8().cast<Int8>();
    sdl.SDL_Log(messagePointer);
    calloc.free(messagePointer);
  }

  /// Log anything.
  void _log(LogCategory category, String message,
      void Function(int, Pointer<Int8>) func) {
    final messagePointer = message.toNativeUtf8().cast<Int8>();
    func(categoryToInt(category), messagePointer);
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
    final messagePointer = message.toNativeUtf8().cast<Int8>();
    sdl.SDL_LogMessage(
        categoryToInt(category), priorityToInt(priority), messagePointer);
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
      intToPriority(sdl.SDL_LogGetPriority(categoryToInt(category)));

  /// Reset log priorities.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_LogResetPriorities)
  void resetLogPriorities() => sdl.SDL_LogResetPriorities();

  /// Set the priority of all log categories.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_LogSetAllPriority)
  void setAllLogPriorities(LogPriority priority) =>
      sdl.SDL_LogSetAllPriority(priorityToInt(priority));

  /// Set log priority.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_LogSetPriority)
  void setLogPriority(LogCategory category, LogPriority priority) =>
      sdl.SDL_LogSetPriority(categoryToInt(category), priorityToInt(priority));

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
    final titlePtr = title.toNativeUtf8().cast<Int8>();
    final window = Window(
        this, sdl.SDL_CreateWindow(titlePtr, x, y, width, height, flags));
    calloc.free(titlePtr);
    windows[window.id] = window;
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
    final titlePointer = title.toNativeUtf8().cast<Int8>();
    final messagePointer = message.toNativeUtf8().cast<Int8>();
    final a = calloc<SDL_MessageBoxButtonData>(buttons.length);
    for (var i = 0; i < buttons.length; i++) {
      final button = buttons[i];
      int buttonFlags;
      switch (button.flags) {
        case ButtonFlags.noDefaults:
          buttonFlags = 0;
          break;
        case ButtonFlags.returnKeyDefault:
          buttonFlags =
              SDL_MessageBoxButtonFlags.SDL_MESSAGEBOX_BUTTON_RETURNKEY_DEFAULT;
          break;
        case ButtonFlags.escapeKeyDefault:
          buttonFlags =
              SDL_MessageBoxButtonFlags.SDL_MESSAGEBOX_BUTTON_ESCAPEKEY_DEFAULT;
          break;
      }
      final textPointer = button.text.toNativeUtf8().cast<Int8>();
      a[i]
        ..buttonid = button.id
        ..flags = buttonFlags
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
    int flags;
    switch (type) {
      case MessageBoxFlags.warning:
        flags = SDL_MessageBoxFlags.SDL_MESSAGEBOX_WARNING;
        break;
      case MessageBoxFlags.information:
        flags = SDL_MessageBoxFlags.SDL_MESSAGEBOX_INFORMATION;
        break;
    }
    final titlePointer = title.toNativeUtf8().cast<Int8>();
    final messagePointer = message.toNativeUtf8().cast<Int8>();
    checkReturnValue(sdl.SDL_ShowSimpleMessageBox(
        flags, titlePointer, messagePointer, window?.handle ?? nullptr));
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
    final valuePointer = value.toNativeUtf8().cast<Int8>();
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
        namePointer = device.name.toNativeUtf8().cast<Int8>();
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
          switch (windowEvent.type) {
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
          MouseWheelDirection direction;
          switch (e.wheel.direction) {
            case SDL_MouseWheelDirection.SDL_MOUSEWHEEL_NORMAL:
              direction = MouseWheelDirection.normal;
              break;
            case SDL_MouseWheelDirection.SDL_MOUSEWHEEL_FLIPPED:
              direction = MouseWheelDirection.flipped;
              break;
            default:
              throw SdlError(
                  e.wheel.direction, 'Invalid mouse wheel direction.');
          }
          event = MouseWheelEvent(this, e.wheel.timestamp, e.wheel.windowID,
              e.wheel.which, e.wheel.x, e.wheel.y, direction);
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
        default:
          throw SdlError(e.type, 'Unrecognised event type.');
      }
      return event;
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
}
