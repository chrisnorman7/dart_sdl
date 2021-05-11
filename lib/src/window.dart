/// Provides the [Window] class.
import 'dart:ffi';

import 'package:ffi/ffi.dart';
import 'package:meta/meta.dart';

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
  @mustCallSuper
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
  @mustCallSuper
  void hide() => sdl.sdl.SDL_HideWindow(handle);

  /// Show this window.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_ShowWindow)
  @mustCallSuper
  void show() => sdl.sdl.SDL_ShowWindow(handle);

  /// Minimise this window.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_MinimizeWindow)
  @mustCallSuper
  void minimise() => sdl.sdl.SDL_MinimizeWindow(handle);

  /// Maximise this window.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_MaximizeWindow)
  @mustCallSuper
  void maximise() => sdl.sdl.SDL_MaximizeWindow(handle);

  /// Raise this window.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_RaiseWindow)
  @mustCallSuper
  void raise() => sdl.sdl.SDL_RaiseWindow(handle);

  /// Restore this window.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_RestoreWindow)
  @mustCallSuper
  void restoreWindow() => sdl.sdl.SDL_RestoreWindow(handle);

  /// Set whether or not this window has a border.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_SetWindowBordered)
  @mustCallSuper
  void setBordered(bool value) => sdl.sdl.SDL_SetWindowBordered(
      handle, value ? SDL_bool.SDL_TRUE : SDL_bool.SDL_FALSE);

  /// Set the brightness of this window.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_SetWindowBrightness)
  @mustCallSuper
  void setBrightness(double value) =>
      sdl.checkReturnValue(sdl.sdl.SDL_SetWindowBrightness(handle, value));
}
