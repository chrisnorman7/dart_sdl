/// Provides the [Window] class.
import 'dart:ffi';
import 'dart:math';

import 'package:ffi/ffi.dart';
import 'package:meta/meta.dart';

import 'display.dart';
import 'enumerations.dart';
import 'extensions.dart';
import 'sdl.dart';
import 'sdl_bindings.dart';

/// A class to represent the size of a window's borders.
class BordersSize {
  /// Create the borders sizes.
  BordersSize(this.top, this.left, this.bottom, this.right);

  /// The size of the top border.
  final int top;

  /// The size of the left border.
  final int left;

  /// The size of the bottom border.
  final int bottom;

  /// The size of the right border.
  final int right;
}

/// The size of a window.
class WindowSize {
  /// Create a size.
  WindowSize(this.width, this.height);

  /// Window width.
  final int width;

  /// Window height.
  final int height;
}

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
  void destroy() {
    sdl.destroyWindow(this);
    sdl.windows.remove(id);
  }

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
  set bordered(bool value) =>
      sdl.sdl.SDL_SetWindowBordered(handle, sdl.boolToValue(value));

  /// Get the brightness of this window.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_GetWindowBrightness)
  double get brightness => sdl.sdl.SDL_GetWindowBrightness(handle);

  /// Set the brightness of this window.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_SetWindowBrightness)
  set brightness(double value) =>
      sdl.checkReturnValue(sdl.sdl.SDL_SetWindowBrightness(handle, value));

  /// Get the size of the window's borders.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_GetWindowBordersSize)
  BordersSize get bordersSize {
    final topPointer = calloc<Int32>();
    final leftPointer = calloc<Int32>();
    final bottomPointer = calloc<Int32>();
    final rightPointer = calloc<Int32>();
    sdl.checkReturnValue(sdl.sdl.SDL_GetWindowBordersSize(
        handle, topPointer, leftPointer, bottomPointer, rightPointer));
    final b = BordersSize(topPointer.value, leftPointer.value,
        bottomPointer.value, rightPointer.value);
    [topPointer, leftPointer, bottomPointer, rightPointer].forEach(calloc.free);
    return b;
  }

  /// Get the index of the display this window is associated with.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_GetWindowDisplayIndex)
  int get displayIndex =>
      sdl.checkReturnValue(sdl.sdl.SDL_GetWindowDisplayIndex(handle));

  /// Gets the display this window is associated with.
  ///
  /// *Note*: the object returned by this method is not cached.
  Display get display => sdl.createDisplay(displayIndex);

  /// Get the display mode for this window.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_GetWindowDisplayMode)
  DisplayMode get displayMode {
    final ptr = calloc<SDL_DisplayMode>();
    sdl.checkReturnValue(sdl.sdl.SDL_GetWindowDisplayMode(handle, ptr));
    final m = ptr.ref;
    calloc.free(ptr);
    return DisplayMode(m.format, m.w, m.h, m.refresh_rate);
  }

  /// Set the display mode for this window.
  ///
  ///
  set displayMode(DisplayMode mode) {
    final ptr = calloc<SDL_DisplayMode>();
    ptr.ref
      ..refresh_rate = mode.refreshRate
      ..w = mode.width
      ..h = mode.height;
    sdl.checkReturnValue(sdl.sdl.SDL_SetWindowDisplayMode(handle, ptr));
    calloc.free(ptr);
  }

  /// Get the flags for this window.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_GetWindowFlags)
  int get flags => sdl.sdl.SDL_GetWindowFlags(handle);

  /// Get the input grab mode for this window.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_GetWindowGrab)
  bool get grab => sdl.getBool(sdl.sdl.SDL_GetWindowGrab(handle));

  /// Set the grab mode of this window.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_SetWindowGrab)
  set grab(bool value) =>
      sdl.sdl.SDL_SetWindowGrab(handle, sdl.boolToValue(value));

  /// Get the ID of this window.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_GetWindowID)
  int get id => sdl.checkReturnValue(sdl.sdl.SDL_GetWindowID(handle));

  /// Get the maximum size of a window's client area.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_GetWindowMaximumSize)
  WindowSize get maximumSize {
    final widthPointer = calloc<Int32>();
    final heightPointer = calloc<Int32>();
    sdl.sdl.SDL_GetWindowMaximumSize(handle, widthPointer, heightPointer);
    final s = WindowSize(widthPointer.value, heightPointer.value);
    [widthPointer, heightPointer].forEach(calloc.free);
    return s;
  }

  /// Set the maximum size of the client area.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_SetWindowMaximumSize)
  set maximumSize(WindowSize size) =>
      sdl.sdl.SDL_SetWindowMaximumSize(handle, size.width, size.height);

  /// Get the minimum size of a window's client area.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_GetWindowMinimumSize)
  WindowSize get minimumSize {
    final widthPointer = calloc<Int32>();
    final heightPointer = calloc<Int32>();
    sdl.sdl.SDL_GetWindowMinimumSize(handle, widthPointer, heightPointer);
    final s = WindowSize(widthPointer.value, heightPointer.value);
    [widthPointer, heightPointer].forEach(calloc.free);
    return s;
  }

  /// Set the minimum size of this client area.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_SetWindowMinimumSize)
  set minimumSize(WindowSize size) =>
      sdl.sdl.SDL_SetWindowMinimumSize(handle, size.width, size.height);

  /// Get the opacity of this window.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_GetWindowOpacity)
  double get opacity {
    final ptr = calloc<Float>();
    sdl.checkReturnValue(sdl.sdl.SDL_GetWindowOpacity(handle, ptr));
    final f = ptr.value;
    calloc.free(ptr);
    return f;
  }

  /// Set the opacity for this window.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_SetWindowOpacity)
  set opacity(double value) =>
      sdl.checkReturnValue(sdl.sdl.SDL_SetWindowOpacity(handle, value));

  /// Get the position of this window.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_GetWindowPosition)
  Point<int> get position {
    final xPointer = calloc<Int32>();
    final yPointer = calloc<Int32>();
    sdl.sdl.SDL_GetWindowPosition(handle, xPointer, yPointer);
    final pos = Point(xPointer.value, yPointer.value);
    [xPointer, yPointer].forEach(calloc.free);
    return pos;
  }

  /// Set the position of this window.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_SetWindowPosition)
  set position(Point<int> pos) =>
      sdl.sdl.SDL_SetWindowPosition(handle, pos.x, pos.y);

  /// Get the size of this window.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_GetWindowSize)
  WindowSize get size {
    final widthPointer = calloc<Int32>();
    final heightPointer = calloc<Int32>();
    sdl.sdl.SDL_GetWindowSize(handle, widthPointer, heightPointer);
    final s = WindowSize(widthPointer.value, heightPointer.value);
    [widthPointer, heightPointer].forEach(calloc.free);
    return s;
  }

  /// Set the size of this window.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_SetWindowSize)
  set size(WindowSize value) =>
      sdl.sdl.SDL_SetWindowSize(handle, value.width, value.height);

  /// Set this window full screen.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_SetWindowFullscreen)
  set fullscreen(FullScreenMode mode) => sdl.checkReturnValue(
      sdl.sdl.SDL_SetWindowFullscreen(handle, mode.toSdlFlag()));

  /// Set input focus.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_SetWindowInputFocus)
  void setInputFocus() =>
      sdl.checkReturnValue(sdl.sdl.SDL_SetWindowInputFocus(handle));

  /// Set this window as modal for another window.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_SetWindowModalFor)
  set modalFor(Window other) =>
      sdl.checkReturnValue(sdl.sdl.SDL_SetWindowModalFor(handle, other.handle));

  /// Set the window resizeable.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_SetWindowResizable)
  set resizeable(bool value) =>
      sdl.sdl.SDL_SetWindowResizable(handle, sdl.boolToValue(value));
}
