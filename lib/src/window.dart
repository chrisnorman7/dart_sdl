/// Provides the [Window] class.
import 'dart:ffi';

import 'package:ffi/ffi.dart';

import 'sdl.dart';
import 'sdl_bindings.dart';

/// An SDL Window.
class Window {
  /// Create a window.
  Window(this.sdl, this.handle);

  /// The main SDL object.
  final Sdl sdl;

  /// The Handle for this instance.
  Pointer<SDL_Window> handle;

  /// Destroy this window.
  void destroy() => sdl.destroyWindow(this);

  /// The title of this window.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_GetWindowTitle)
  String get title =>
      sdl.sdl.SDL_GetWindowTitle(handle).cast<Utf8>().toDartString();

  /// Set the title of the window.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_SetWindowTitle)
  set title(String value) {
    final ptr = value.toNativeUtf8().cast<Int8>();
    sdl.sdl.SDL_SetWindowTitle(handle, ptr);
    calloc.free(ptr);
  }

  /// Hide this window.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_HideWindow)
  void hide() => sdl.sdl.SDL_HideWindow(handle);

  /// Minimise this window.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_MinimizeWindow)
  void minimise() => sdl.sdl.SDL_MinimizeWindow(handle);

  /// Raise this window.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_RaiseWindow)
  void raise() => sdl.sdl.SDL_RaiseWindow(handle);

  /// Restore this window.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_RestoreWindow)
  void restoreWindow() => sdl.sdl.SDL_RestoreWindow(handle);

  /// Set whether or not this window has a border.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_SetWindowBordered)
  void setBordered(bool value) => sdl.sdl.SDL_SetWindowBordered(
      handle, value ? SDL_bool.SDL_TRUE : SDL_bool.SDL_FALSE);

  /// Set the brightness of this window.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_SetWindowBrightness)
  void setBrightness(double value) =>
      sdl.checkReturnValue(sdl.sdl.SDL_SetWindowBrightness(handle, value));

  /// Show this window.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_ShowWindow)
  void show() => sdl.sdl.SDL_ShowWindow(handle);
}
