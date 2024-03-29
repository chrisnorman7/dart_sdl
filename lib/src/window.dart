/// Provides the [Window] class.
import 'dart:ffi';
import 'dart:math';

import 'package:ffi/ffi.dart';
import 'package:meta/meta.dart';

import 'display.dart';
import 'error.dart';
import 'extensions.dart';
import 'sdl.dart';
import 'sdl_bindings.dart';
import 'sdl_object.dart';

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

  /// Describe this object.
  @override
  String toString() => '<$runtimeType $width x $height>';
}

/// An SDL Window.
class Window extends SdlObject<SDL_Window> {
  /// Create a window.
  Window(super.sdl, super.handle);

  /// Get a window from a stored ID.
  factory Window.fromId(final Sdl sdl, final int id) {
    final handle = sdl.sdl.SDL_GetWindowFromID(id);
    if (handle == nullptr) {
      throw SdlError(id, sdl.getError());
    }
    return Window(sdl, handle);
  }

  /// Destroy this window.
  @override
  void destroy() {
    sdl.destroyWindow(this);
  }

  /// The title of this window.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_GetWindowTitle)
  String get title =>
      sdl.sdl.SDL_GetWindowTitle(handle).cast<Utf8>().toDartString();

  /// Set the title of the window.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_SetWindowTitle)
  set title(final String value) {
    final ptr = value.toCharPointer();
    sdl.sdl.SDL_SetWindowTitle(handle, ptr);
    malloc.free(ptr);
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
  set bordered(final bool value) =>
      sdl.sdl.SDL_SetWindowBordered(handle, sdl.boolToValue(value));

  /// Get the brightness of this window.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_GetWindowBrightness)
  double get brightness => sdl.sdl.SDL_GetWindowBrightness(handle);

  /// Set the brightness of this window.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_SetWindowBrightness)
  set brightness(final double value) =>
      sdl.checkReturnValue(sdl.sdl.SDL_SetWindowBrightness(handle, value));

  /// Get the size of the window's borders.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_GetWindowBordersSize)
  BordersSize get bordersSize {
    sdl.checkReturnValue(
      sdl.sdl.SDL_GetWindowBordersSize(
        handle,
        sdl.xPointer,
        sdl.yPointer,
        sdl.x2Pointer,
        sdl.y2Pointer,
      ),
    );
    return BordersSize(
      sdl.xPointer.value,
      sdl.yPointer.value,
      sdl.x2Pointer.value,
      sdl.y2Pointer.value,
    );
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
    sdl.checkReturnValue(
      sdl.sdl.SDL_GetWindowDisplayMode(handle, sdl.displayModePointer),
    );
    final m = sdl.displayModePointer.ref;
    return DisplayMode(m.format, m.w, m.h, m.refresh_rate);
  }

  /// Set the display mode for this window.
  ///
  ///
  set displayMode(final DisplayMode mode) {
    sdl.displayModePointer.ref
      ..refresh_rate = mode.refreshRate
      ..w = mode.width
      ..h = mode.height;
    sdl.checkReturnValue(
      sdl.sdl.SDL_SetWindowDisplayMode(handle, sdl.displayModePointer),
    );
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
  set grab(final bool value) =>
      sdl.sdl.SDL_SetWindowGrab(handle, sdl.boolToValue(value));

  /// Get the ID of this window.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_GetWindowID)
  int get id => sdl.checkReturnValue(sdl.sdl.SDL_GetWindowID(handle));

  /// Get the maximum size of a window's client area.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_GetWindowMaximumSize)
  WindowSize get maximumSize {
    sdl.sdl.SDL_GetWindowMaximumSize(handle, sdl.xPointer, sdl.yPointer);
    return WindowSize(sdl.xPointer.value, sdl.yPointer.value);
  }

  /// Set the maximum size of the client area.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_SetWindowMaximumSize)
  set maximumSize(final WindowSize size) =>
      sdl.sdl.SDL_SetWindowMaximumSize(handle, size.width, size.height);

  /// Get the minimum size of a window's client area.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_GetWindowMinimumSize)
  WindowSize get minimumSize {
    sdl.sdl.SDL_GetWindowMinimumSize(handle, sdl.xPointer, sdl.yPointer);
    return WindowSize(sdl.xPointer.value, sdl.yPointer.value);
  }

  /// Set the minimum size of this client area.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_SetWindowMinimumSize)
  set minimumSize(final WindowSize size) =>
      sdl.sdl.SDL_SetWindowMinimumSize(handle, size.width, size.height);

  /// Get the opacity of this window.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_GetWindowOpacity)
  double get opacity {
    sdl.checkReturnValue(
      sdl.sdl.SDL_GetWindowOpacity(handle, sdl.floatPointer),
    );
    return sdl.floatPointer.value;
  }

  /// Set the opacity for this window.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_SetWindowOpacity)
  set opacity(final double value) =>
      sdl.checkReturnValue(sdl.sdl.SDL_SetWindowOpacity(handle, value));

  /// Get the position of this window.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_GetWindowPosition)
  Point<int> get position {
    sdl.sdl.SDL_GetWindowPosition(handle, sdl.xPointer, sdl.yPointer);
    final pos = Point(sdl.xPointer.value, sdl.yPointer.value);
    return pos;
  }

  /// Set the position of this window.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_SetWindowPosition)
  set position(final Point<int> pos) =>
      sdl.sdl.SDL_SetWindowPosition(handle, pos.x, pos.y);

  /// Get the size of this window.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_GetWindowSize)
  WindowSize get size {
    sdl.sdl.SDL_GetWindowSize(handle, sdl.xPointer, sdl.yPointer);
    return WindowSize(sdl.xPointer.value, sdl.yPointer.value);
  }

  /// Set the size of this window.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_SetWindowSize)
  set size(final WindowSize value) =>
      sdl.sdl.SDL_SetWindowSize(handle, value.width, value.height);

  /// Set this window full screen.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_SetWindowFullscreen)
  set fullscreen(final FullScreenMode mode) => sdl
      .checkReturnValue(sdl.sdl.SDL_SetWindowFullscreen(handle, mode.toInt()));

  /// Set input focus.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_SetWindowInputFocus)
  void setInputFocus() =>
      sdl.checkReturnValue(sdl.sdl.SDL_SetWindowInputFocus(handle));

  /// Set this window as modal for another window.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_SetWindowModalFor)
  set modalFor(final Window other) =>
      sdl.checkReturnValue(sdl.sdl.SDL_SetWindowModalFor(handle, other.handle));

  /// Set the window resizeable.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_SetWindowResizable)
  set resizeable(final bool value) =>
      sdl.sdl.SDL_SetWindowResizable(handle, sdl.boolToValue(value));

  /// Check whether the screen keyboard is shown for given window.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_IsScreenKeyboardShown)
  bool get isScreenKeyboardShown =>
      sdl.getBool(sdl.sdl.SDL_IsScreenKeyboardShown(handle));

  /// Move the mouse cursor to the given position within the window.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_WarpMouseInWindow)
  void warpMouse(final int x, final int y) =>
      sdl.sdl.SDL_WarpMouseInWindow(handle, x, y);
}
