/// Provides the main [Sdl] class.
import 'dart:ffi';
import 'dart:io';

import 'package:ffi/ffi.dart';

import 'button.dart';
import 'enumerations.dart';
import 'error.dart';
import 'sdl_bindings.dart';
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
  void checkReturnValue(int value) {
    if (value != 0) {
      final message = getError();
      throw SdlError(value, message);
    }
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
  String get version {
    final ptr = calloc<SDL_version>();
    sdl.SDL_GetVersion(ptr);
    final v = ptr.ref;
    calloc.free(ptr);
    return '${v.major}.${v.minor}.${v.patch}';
  }

  /// Get the SDL revision.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_REVISION)
  String get revision => SDL_REVISION;

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
    return window;
  }

  /// Destroy a window.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_DestroyWindow)
  void destroyWindow(Window window) => sdl.SDL_DestroyWindow(window.handle);

  /// Return whether or not the screen saver is currently enabled.
  bool get screenSaverEnabled => getBool(sdl.SDL_IsScreenSaverEnabled());

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
    if (ptr.value == 0) {
      throw SdlError(0, getError());
    }
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
}
