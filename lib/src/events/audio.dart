// ignore_for_file: prefer_final_parameters
/// Provides audio related events.
import '../error.dart';
import '../sdl.dart';
import '../sdl_bindings.dart';
import 'base.dart';

/// An audio device event.
class AudioDeviceEvent extends Event {
  /// Create an event.
  const AudioDeviceEvent({
    required final Sdl sdl,
    required final int timestamp,
    required this.index,
    required this.isCapture,
  }) : super(sdl, timestamp);

  /// Create an instance from an SDL event.
  factory AudioDeviceEvent.fromSdlEvent(
    final Sdl sdl,
    final SDL_AudioDeviceEvent event,
  ) {
    final type = event.type;
    switch (type) {
      case SDL_EventType.SDL_AUDIODEVICEADDED:
        return AudioDeviceAddedEvent(
          sdl: sdl,
          timestamp: event.timestamp,
          index: event.which,
          isCapture: sdl.getBool(event.iscapture),
        );
      case SDL_EventType.SDL_AUDIODEVICEREMOVED:
        return AudioDeviceRemovedEvent(
          sdl: sdl,
          timestamp: event.timestamp,
          index: event.which,
          isCapture: sdl.getBool(event.iscapture),
        );
      default:
        throw SdlError(type, 'Invalid audio device state.');
    }
  }

  /// The index for an added device.
  final int index;

  /// Whether or not the device is a capture device.
  final bool isCapture;
}

/// A device was added.
class AudioDeviceAddedEvent extends AudioDeviceEvent {
  /// Create an event.
  const AudioDeviceAddedEvent({
    required super.sdl,
    required super.timestamp,
    required super.index,
    required super.isCapture,
  });
}

/// A device was removed.
class AudioDeviceRemovedEvent extends AudioDeviceEvent {
  /// Create an event.
  const AudioDeviceRemovedEvent({
    required super.sdl,
    required super.timestamp,
    required super.index,
    required super.isCapture,
  });
}
