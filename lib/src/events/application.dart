/// Provides application events.
import 'base.dart';

/// User requested quit.
class QuitEvent extends Event {
  /// Create the event.
  const QuitEvent(super.sdl, super.timestamp);
}

/// Locale changed.
class LocaleChangedEvent extends Event {
  /// Create an event.
  const LocaleChangedEvent(super.sdl, super.timestamp);
}

/// SDL_POLLSENTINEL.
class PollSentinelEvent extends Event {
  /// Create an instance.
  const PollSentinelEvent(super.sdl, super.timestamp);
}
