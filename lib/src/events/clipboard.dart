/// Provides clipboard events.
import '../sdl.dart';
import 'base.dart';

/// The clipboard changed.
class ClipboardChangedEvent extends Event {
  /// Create an event.
  ClipboardChangedEvent(Sdl sdl, int timestamp) : super(sdl, timestamp);
}
