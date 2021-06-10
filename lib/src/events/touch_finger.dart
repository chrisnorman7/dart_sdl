/// Provides various touch events.
import 'dart:math';

import '../enumerations.dart';
import '../extensions.dart';
import '../sdl.dart';
import '../sdl_bindings.dart';
import 'base.dart';

/// A touch event.
///
/// [SDL Docs](https://wiki.libsdl.org/SDL_TouchFingerEvent)
class TouchFingerEvent extends Event with WindowedEvent {
  /// Create an event.
  TouchFingerEvent(
      Sdl sdl,
      int timestamp,
      this.type,
      this.touchId,
      this.fingerId,
      this.x,
      this.y,
      this.distanceX,
      this.distanceY,
      this.pressure,
      int wndId)
      : super(sdl, timestamp) {
    windowId = wndId;
  }

  /// Create an instance from an SDL event.
  factory TouchFingerEvent.fromSdlEvent(Sdl sdl, SDL_TouchFingerEvent event) =>
      TouchFingerEvent(
          sdl,
          event.timestamp,
          event.type.toTouchEventType(),
          event.touchId,
          event.fingerId,
          event.x,
          event.y,
          event.dx,
          event.dy,
          event.pressure,
          event.windowID);

  /// The type of this event.
  final TouchFingerEventType type;

  /// The touch device id.
  final int touchId;

  /// The finger ID.
  final int fingerId;

  /// The x-axis location of the touch event, normalized (0...1).
  final double x;

  /// The y-axis location of the touch event, normalized (0...1).
  final double y;

  /// The coordinates of the touch.
  Point<double> get coordinates => Point<double>(x, y);

  /// The distance moved in the x-axis, normalized (-1...1).
  final double distanceX;

  /// The distance moved in the y-axis, normalized (-1...1).
  final double distanceY;

  /// The distance.
  Point<double> get distance => Point<double>(distanceX, distanceY);

  /// The quantity of pressure applied, normalized (0...1).
  final double pressure;
}
