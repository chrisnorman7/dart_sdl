/// Provides application events.
import '../sdl.dart';
import 'base.dart';

/// User requested quit.
class QuitEvent extends Event {
  /// Create the event.
  QuitEvent(Sdl sdl, int timestamp) : super(sdl, timestamp);
}
