/// Provides application events.
import '../sdl.dart';
import 'base.dart';

/// User requested quit.
class QuitEvent extends Event {
  /// Create the event.
  QuitEvent(Sdl sdl, int timestamp) : super(sdl, timestamp);
}

/// Locale changed.
class LocaleChangedEvent extends Event {
  /// Create an event.
  LocaleChangedEvent(Sdl sdl, int timestamp) : super(sdl, timestamp);
}

/// SDL_POLLSENTINEL.
class PollSentinelEvent extends Event {
  /// Create an instance.
  PollSentinelEvent(Sdl sdl, int timestamp) : super(sdl, timestamp);
}
