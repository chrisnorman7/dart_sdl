/// Provides the [UserEvent] class.
import '../sdl.dart';
import '../sdl_bindings.dart';
import 'base.dart';

/// A user event.
///
/// Exposes events of type [SDL_EventType.SDL_USEREVENT].
class UserEvent extends Event {
  /// Create an instance.
  const UserEvent({
    required final Sdl sdl,
    required final int timestamp,
    required this.type,
    required this.windowId,
    required this.code,
  }) : super(sdl, timestamp);

  /// The type of this event.
  ///
  /// This type will have been returned by [Sdl.registerEvents].
  final int type;

  /// The window ID (if any).
  final int? windowId;

  /// A user defined code.
  final int code;
}
