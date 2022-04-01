/// Provides various touch events.
import 'dart:math';

import '../extensions.dart';
import '../sdl.dart';
import '../sdl_bindings.dart';
import 'base.dart';

/// A touch event.
///
/// [SDL Docs](https://wiki.libsdl.org/SDL_TouchFingerEvent)
class TouchFingerEvent extends Event
    with WindowMixin, CoordinatesMixin<double> {
  /// Create an event.
  TouchFingerEvent(
    final Sdl sdl,
    final int timestamp,
    this.type,
    this.touchId,
    this.fingerId,
    final double x,
    final double y,
    this.distanceX,
    this.distanceY,
    this.pressure,
    final int windowId,
  ) : super(sdl, timestamp) {
    this.windowId = windowId;
    this.x = x;
    this.y = y;
  }

  /// Create an instance from an SDL event.
  factory TouchFingerEvent.fromSdlEvent(
    final Sdl sdl,
    final SDL_TouchFingerEvent event,
  ) =>
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
        event.windowID,
      );

  /// The type of this event.
  final TouchFingerEventType type;

  /// The touch device id.
  final int touchId;

  /// The finger ID.
  final int fingerId;

  /// The distance moved in the x-axis, normalized (-1...1).
  final double distanceX;

  /// The distance moved in the y-axis, normalized (-1...1).
  final double distanceY;

  /// The distance.
  Point<double> get distance => Point<double>(distanceX, distanceY);

  /// The quantity of pressure applied, normalized (0...1).
  final double pressure;
}
