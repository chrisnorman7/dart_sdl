/// Provides gesture events.
import '../extensions.dart';
import '../sdl.dart';
import '../sdl_bindings.dart';
import 'base.dart';

/// A gesture event.
///
/// [SDL Docs](https://wiki.libsdl.org/SDL_DollarGestureEvent)
class DollarGestureEvent extends Event with CoordinatesMixin<double> {
  /// Create an event.
  DollarGestureEvent(
      {required Sdl sdl,
      required int timestamp,
      required this.type,
      required this.touchId,
      required this.gestureId,
      required this.numFingers,
      required this.error,
      required double x,
      required double y})
      : super(sdl, timestamp) {
    this.x = x;
    this.y = y;
  }

  /// Create an instance from an SDL event.
  DollarGestureEvent.fromSdlEvent(Sdl sdl, SDL_DollarGestureEvent event)
      : error = event.error,
        gestureId = event.gestureId,
        numFingers = event.numFingers,
        touchId = event.touchId,
        type = event.type.toDollarGestureEventType(),
        super(sdl, event.timestamp);

  /// The type of this event.
  final DollarGestureEventType type;

  /// The touch device id.
  final int touchId;

  /// The unique id of the closest gesture to the performed stroke.
  final int gestureId;

  /// The number of fingers used to draw the stroke.
  final int numFingers;

  /// The difference between the gesture template and the actual performed
  /// gesture (lower error is a better match).
  final double error;
}

/// A multifinger gesture was made.
///
/// [SDL Docs](https://wiki.libsdl.org/SDL_MultiGestureEvent)
class MultiGestureEvent extends Event with CoordinatesMixin<double> {
  /// Create an event.
  MultiGestureEvent(
      {required Sdl sdl,
      required int timestamp,
      required this.touchId,
      required this.dTheta,
      required this.dDist,
      required this.numFingers,
      required double x,
      required double y})
      : super(sdl, timestamp) {
    this.x = x;
    this.y = y;
  }

  /// The touch device id.
  final int touchId;

  /// The amount that the fingers rotated during this motion.
  final double dTheta;

  /// The amount that the fingers pinched during this motion.
  final double dDist;

  /// The number of fingers used in the gesture.
  final int numFingers;
}
