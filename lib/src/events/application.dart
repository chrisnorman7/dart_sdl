/// Provides application events.
import '../sdl.dart';
import 'base.dart';

/// User requested quit.
class QuitEvent extends Event {
  /// Create the event.
  const QuitEvent(final Sdl sdl, final int timestamp) : super(sdl, timestamp);
}

/// Locale changed.
class LocaleChangedEvent extends Event {
  /// Create an event.
  const LocaleChangedEvent(final Sdl sdl, final int timestamp)
      : super(sdl, timestamp);
}

/// SDL_POLLSENTINEL.
class PollSentinelEvent extends Event {
  /// Create an instance.
  const PollSentinelEvent(final Sdl sdl, final int timestamp)
      : super(sdl, timestamp);
}
