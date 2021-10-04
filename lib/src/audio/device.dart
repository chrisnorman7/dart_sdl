/// Provides the [AudioDevice], and [OpenAudioDevice] classes.
import 'dart:ffi';

import 'package:ffi/ffi.dart';

import '../enumerations.dart';
import '../sdl.dart';
import 'spec.dart';
import 'wave_file.dart';

/// An audio device on the system.
class AudioDevice {
  /// Create a device.
  ///
  /// To open the device, use [open].
  AudioDevice(this.sdl, this.index, this.isCapture);

  /// The SDL bindings to use.
  final Sdl sdl;

  /// The index of this audio device.
  final int index;

  /// Whether or not this device is a capture device.
  final bool isCapture;

  /// Get the name of this device.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_GetAudioDeviceName)
  String get name => sdl.sdl
      .SDL_GetAudioDeviceName(index, sdl.boolToValue(isCapture))
      .cast<Utf8>()
      .toDartString();

  /// Open this device.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_OpenAudioDevice)
  OpenAudioDevice open({AudioSpec? settings}) =>
      sdl.openAudioDevice(device: this, settings: settings);
}

/// An open device.
///
/// This class does not represent anything specific in SDL, but is used because
/// [SDL_OpenAudioDevice](https://wiki.libsdl.org/SDL_OpenAudioDevice)
/// essentially returns 2 values:
/// * The ID of the device (which apparently can be different from the original
///   index).
/// * The [AudioSpec] of the opened device, which is inaccessible outside of
///   this function.
class OpenAudioDevice {
  /// Create a device.
  OpenAudioDevice(this.sdl, this.device, this.id, this.spec);

  /// The SDL bindings to use.
  final Sdl sdl;

  /// The device which was opened to create this object.
  final AudioDevice? device;

  /// The ID returned by
  /// [SDL_OpenAudioDevice](https://wiki.libsdl.org/SDL_OpenAudioDevice).
  final int id;

  /// The settings for the opened audio device.
  final AudioSpec spec;

  /// Clear queued audio.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_ClearQueuedAudio)
  void clearQueuedAudio() => sdl.sdl.SDL_ClearQueuedAudio(id);

  /// Close this device.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_CloseAudioDevice)
  void close() => sdl.sdl.SDL_CloseAudioDevice(id);

  /// The status of this device.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_GetAudioDeviceStatus)
  AudioStatus get status =>
      sdl.sdl.SDL_GetAudioDeviceStatus(id).toAudioStatus();

  /// Get the number of bytes of still-queued audio.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_GetQueuedAudioSize)
  int get queueSize => sdl.sdl.SDL_GetQueuedAudioSize(id);

  /// Lock the audio device.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_LockAudioDevice)
  void lock() => sdl.sdl.SDL_LockAudioDevice(id);

  /// Unlock the audio device.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_UnlockAudioDevice)
  void unlock() => sdl.sdl.SDL_UnlockAudioDevice(id);

  /// Returns `true` if this device is paused.
  bool get paused => status == AudioStatus.paused;

  /// Set Whether or not this device is paused.
  ///
  /// If [value] is `true`, then this device will be paused. Otherwise, audio
  /// will resume.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_PauseAudioDevice)
  set paused(bool value) =>
      sdl.sdl.SDL_PauseAudioDevice(id, sdl.boolToValue(value));

  /// Pause this device.
  void pause() => paused = true;

  /// Start or resume this device.
  void play() => paused = false;

  /// Queue a wave file.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_QueueAudio)
  void queueAudio(WaveFile file) => sdl.sdl
      .SDL_QueueAudio(id, file.bufferPointer.value.cast<Void>(), file.length);
}
