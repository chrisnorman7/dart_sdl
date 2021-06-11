/// Provides mouse-related events.
import 'dart:math';

import '../enumerations.dart';
import '../extensions.dart';
import '../sdl.dart';
import '../sdl_bindings.dart';
import 'base.dart';

/// The base class for all mouse events.
class MouseEvent extends Event with WindowMixin, CoordinatesMixin<int> {
  /// Create an event.
  MouseEvent(Sdl sdl, int timestamp, int windowId, this.which, int x, int y)
      : super(sdl, timestamp) {
    this.windowId = windowId;
    this.x = x;
    this.y = y;
  }

  /// The mouse instance ID.
  final int which;
}

/// A mouse has moved in the window.
///
/// [SDL Docs](https://wiki.libsdl.org/SDL_MouseMotionEvent)
class MouseMotionEvent extends MouseEvent {
  /// Create a motion event.
  MouseMotionEvent(Sdl sdl, int timestamp, int wndId, int which, this.state,
      int x, int y, this.relativeX, this.relativeY)
      : super(sdl, timestamp, wndId, which, x, y);

  /// The state of the mouse button.
  final int state;

  /// Relative x.
  final int relativeX;

  /// Relative y.
  final int relativeY;

  /// Relative coordinates.
  Point<int> get relative => Point<int>(relativeX, relativeY);
}

/// A mouse button has been pressed or released.
///
/// [SDL Docs](https://wiki.libsdl.org/SDL_MouseButtonEvent)
class MouseButtonEvent extends MouseEvent {
  /// Create an event.
  MouseButtonEvent(Sdl sdl, int timestamp, int wndId, int which, this.button,
      this.state, this.clicks, int x, int y)
      : super(sdl, timestamp, wndId, which, x, y);

  /// Create an instance from an event.
  factory MouseButtonEvent.fromSdlEvent(Sdl sdl, SDL_MouseButtonEvent e) =>
      MouseButtonEvent(
          sdl,
          e.timestamp,
          e.windowID,
          e.which,
          e.button.toMouseButton(),
          e.type.toMouseButtonPressedState(),
          e.x,
          e.x,
          e.y);

  /// The button which was pressed.
  final MouseButton button;

  /// Whether or not the button was pressed or released.
  final PressedState state;

  /// The number of clicks that were made.
  final int clicks;
}

/// A mouse wheel event.
///
/// [SDL Docs](https://wiki.libsdl.org/SDL_MouseWheelEvent)
class MouseWheelEvent extends MouseEvent {
  /// Create an event.
  MouseWheelEvent(Sdl sdl, int timestamp, int windowId, int which, int x, int y,
      this.direction)
      : super(sdl, timestamp, windowId, which, x, y);

  /// The direction the wheel was moved.
  final MouseWheelDirection direction;
}
