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
  bool setHintPriority(String hint, String value, HintPriorities priority) {
    final hintPointer = hint.toNativeUtf8().cast<Int8>();
    final valuePointer = value.toNativeUtf8().cast<Int8>();
    int p;
    switch (priority) {
      case HintPriorities.defaultPriority:
        p = SDL_HintPriority.SDL_HINT_DEFAULT;
        break;
      case HintPriorities.normalPriority:
        p = SDL_HintPriority.SDL_HINT_NORMAL;
        break;
      case HintPriorities.overridePriority:
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
}
