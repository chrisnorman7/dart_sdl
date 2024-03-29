/// Provides renderer events.
import '../sdl_bindings.dart';
import 'base.dart';

/// The render targets have been reset and their contents need to be updated.
///
/// Exposes events of type [SDL_EventType.SDL_RENDER_TARGETS_RESET].
class RenderTargetsResetEvent extends Event {
  /// Create an event.
  const RenderTargetsResetEvent(super.sdl, super.timestamp);
}

/// The device has been reset and all textures need to be recreated.
///
/// Exposes events of type [SDL_EventType.SDL_RENDER_DEVICE_RESET].
class RenderDeviceReset extends Event {
  /// Create an instance.
  const RenderDeviceReset(super.sdl, super.timestamp);
}
