/// Provides the base [Event] class.
///
/// To see the list of all SDL events, see the
/// [SDL_EventType](https://wiki.libsdl.org/SDL_EventType) enumeration.
///
/// To implement a new event, add it to the relevant file, and inherit from the
/// [Event] class.
import 'dart:math';

import '../sdl.dart';
import '../window.dart';

/// The base event class.
///
/// All Dart-side SDL events should inherit from this class.
class Event {
  /// Create an event.
  Event(this.sdl, this.timestamp);

  /// The SDL bindings to use for this event.
  final Sdl sdl;

  /// The time this event was emitted.
  final int timestamp;
}

/// For events which have window IDs.
mixin WindowMixin on Event {
  /// The ID of the window that emitted this event.
  late final int windowId;

  /// The window that emitted this event.
  Window? get window => sdl.windows[windowId];
}

/// Add coordinates to any event type.
mixin CoordinatesMixin<T extends num> on Event {
  /// X coordinate.
  late final T x;

  /// Y coordinate.
  late final T y;

  /// Complete coordinates.
  Point<T> get coordinates => Point<T>(x, y);
}
