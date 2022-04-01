/// Provides the [Display] class.
import 'dart:ffi';

import 'package:ffi/ffi.dart';

import 'rectangle.dart';
import 'sdl.dart';

/// A display mode.
///
/// [SDL Docs](https://wiki.libsdl.org/SDL_DisplayMode)
class DisplayMode {
  /// Create a mode.
  DisplayMode(this.format, this.width, this.height, this.refreshRate);

  /// Display format.
  final int format;

  /// The width of the display.
  final int width;

  /// The height of the display.
  final int height;

  /// The refresh rate of the display.
  ///
  /// If unspecified, this value will be `0`.
  final int refreshRate;

  @override
  String toString() => '$runtimeType($width x $height at $refreshRate HZ)';
}

/// The display class.
class Display {
  /// Create a display.
  Display(this.sdl, this.index);

  /// The dsl class to use for bindings.
  final Sdl sdl;

  /// The index of this display.
  final int index;

  /// Get the name of this display.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_GetDisplayName)
  String get name {
    final ptr = sdl.sdl.SDL_GetDisplayName(index);
    return ptr.cast<Utf8>().toDartString();
  }

  /// Get the bounds of this display.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_GetDisplayBounds)
  Rectangle get bounds {
    sdl.checkReturnValue(sdl.sdl.SDL_GetDisplayBounds(index, sdl.rectPointer));
    final r = sdl.rectPointer.ref;
    return Rectangle(r.x, r.y, r.w, r.h);
  }

  /// Get usable bounds.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_GetDisplayUsableBounds)
  Rectangle get usableBounds {
    sdl.checkReturnValue(
      sdl.sdl.SDL_GetDisplayUsableBounds(index, sdl.rectPointer),
    );
    final r = sdl.rectPointer.ref;
    return Rectangle(r.x, r.y, r.w, r.h);
  }

  /// Get the desktop display mode.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_GetDesktopDisplayMode)
  DisplayMode get desktopMode {
    sdl.checkReturnValue(
      sdl.sdl.SDL_GetDesktopDisplayMode(index, sdl.displayModePointer),
    );
    final m = sdl.displayModePointer.ref;
    return DisplayMode(m.format, m.w, m.h, m.refresh_rate);
  }

  /// Get display mode.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_GetDisplayMode)
  DisplayMode getMode(final int modeIndex) {
    sdl.checkReturnValue(
      sdl.sdl.SDL_GetDisplayMode(index, modeIndex, sdl.displayModePointer),
    );
    final m = sdl.displayModePointer.ref;
    return DisplayMode(m.format, m.w, m.h, m.refresh_rate);
  }

  /// Get the number of modes for this display.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_GetNumDisplayModes)
  int get numDisplayModes =>
      sdl.checkReturnValue(sdl.sdl.SDL_GetNumDisplayModes(index));
}
