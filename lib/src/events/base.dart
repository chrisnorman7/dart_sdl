/// Provides the base [Event] class.
///
/// To see the list of all SDL events, see the
/// [SDL_EventType](https://wiki.libsdl.org/SDL_EventType) enumeration.
///
/// To implement a new event, add it to the relevant file, and inherit from the
/// [Event] class.
import '../sdl.dart';

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
