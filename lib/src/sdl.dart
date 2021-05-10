/// Provides the main [Sdl] class.
import 'dart:ffi';
import 'dart:io';

import 'package:ffi/ffi.dart';

import 'enumerations.dart';
import 'error.dart';
import 'sdl_bindings.dart';

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
    _sdl = DartSdl(DynamicLibrary.open(libName));
  }

  /// The SDL bindings to use.
  late final DartSdl _sdl;

  /// Get a Dart boolean from an SDL one.
  bool _getBool(int value) => value == SDL_bool.SDL_TRUE;

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
        throw SDLException(value, 'Invalid log priority.');
    }
  }

  /// Throw an error if return value is non-null.
  void _check(int value) {
    if (value != 0) {
      final message = _sdl.SDL_GetError().cast<Utf8>().toDartString();
      throw SDLException(value, message);
    }
  }

  /// Initialise SDL.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_Init)
  void init({int flags = SDL_INIT_EVERYTHING}) => _check(_sdl.SDL_Init(flags));

  /// Shutdown SDL.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_Quit)
  void quit() => _sdl.SDL_Quit();

  /// Set main ready.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_SetMainReady)
  void setMainReady() => _sdl.SDL_SetMainReady();

  /// Get the systems which are currently initialised.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_WasInit)
  int wasInit({int flags = 0}) => _sdl.SDL_WasInit(flags);

  /// Clear all hints.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_ClearHints)
  void clearHints() => _sdl.SDL_ClearHints();

  /// Set a hint at normal priority.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_SetHint)
  bool setHint(String hint, String value) {
    final hintPointer = hint.toNativeUtf8().cast<Int8>();
    final valuePointer = value.toNativeUtf8().cast<Int8>();
    final retval = _sdl.SDL_SetHint(hintPointer, valuePointer);
    [hintPointer, valuePointer].forEach(calloc.free);
    return _getBool(retval);
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
    final retval = _sdl.SDL_SetHintWithPriority(hintPointer, valuePointer, p);
    [hintPointer, valuePointer].forEach(calloc.free);
    return _getBool(retval);
  }

  /// Clear the last error message.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_ClearError)
  void clearError() => _sdl.SDL_ClearError();

  /// Set the error message.
  ///
  ///[SDL Docs](https://wiki.libsdl.org/SDL_SetError)
  void setError(String message) {
    final messagePointer = message.toNativeUtf8().cast<Int8>();
    _sdl.SDL_SetError(messagePointer);
    calloc.free(messagePointer);
  }

  /// Log a message.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_Log)
  void log(String message) {
    final messagePointer = message.toNativeUtf8().cast<Int8>();
    _sdl.SDL_Log(messagePointer);
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
      _log(category, message, _sdl.SDL_LogCritical);

  /// Log a debug message.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_LogDebug)
  void logDebug(LogCategory category, String message) =>
      _log(category, message, _sdl.SDL_LogDebug);

  /// Log an error message.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_LogError)
  void logError(LogCategory category, String message) =>
      _log(category, message, _sdl.SDL_LogError);

  /// Log an informational message.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_LogInfo)
  void logInfo(LogCategory category, String message) =>
      _log(category, message, _sdl.SDL_LogInfo);

  /// Log a message.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_LogMessage)
  void logMessage(LogCategory category, LogPriority priority, String message) {
    final messagePointer = message.toNativeUtf8().cast<Int8>();
    _sdl.SDL_LogMessage(
        categoryToInt(category), priorityToInt(priority), messagePointer);
    calloc.free(messagePointer);
  }

  /// Log a verbose message.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_LogVerbose)
  void logVerbose(LogCategory category, String message) =>
      _log(category, message, _sdl.SDL_LogVerbose);

  /// Log a warning message.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_LogWarn)
  void logWarn(LogCategory category, String message) =>
      _log(category, message, _sdl.SDL_LogWarn);

  /// Get log priority.
  LogPriority getLogPriority(LogCategory category) =>
      intToPriority(_sdl.SDL_LogGetPriority(categoryToInt(category)));

  /// Reset log priorities.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_LogResetPriorities)
  void resetLogPriorities() => _sdl.SDL_LogResetPriorities();

  /// Set the priority of all log categories.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_LogSetAllPriority)
  void setAllLogPriorities(LogPriority priority) =>
      _sdl.SDL_LogSetAllPriority(priorityToInt(priority));

  /// Set log priority.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_LogSetPriority)
  void setLogPriority(LogCategory category, LogPriority priority) =>
      _sdl.SDL_LogSetPriority(categoryToInt(category), priorityToInt(priority));
}
