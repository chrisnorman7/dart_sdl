/// Provides audio related events.
import '../enumerations.dart';
import '../error.dart';
import '../sdl.dart';
import '../sdl_bindings.dart';
import 'base.dart';

/// An audio device event.
class AudioDeviceEvent extends Event {
  /// Create an event.
  AudioDeviceEvent(
      Sdl sdl, int timestamp, this.state, this.index, this.isCapture)
      : super(sdl, timestamp);

  /// Create an instance from an SDL event.
  factory AudioDeviceEvent.fromSdlEvent(Sdl sdl, SDL_AudioDeviceEvent event) {
    DeviceState type;
    switch (event.type) {
      case SDL_EventType.SDL_AUDIODEVICEADDED:
        type = DeviceState.added;
        break;
      case SDL_EventType.SDL_AUDIODEVICEREMOVED:
        type = DeviceState.removed;
        break;
      default:
        throw SdlError(event.type, 'Unrecognised audio device event type.');
    }
    return AudioDeviceEvent(sdl, event.timestamp, type, event.which,
        event.iscapture == 0 ? false : true);
  }

  /// Whether or not an audio device was added or removed.
  final DeviceState state;

  /// The index for an added device.
  final int index;

  /// Whether or not the device is a capture device.
  final bool isCapture;
}
