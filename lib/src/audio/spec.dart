/// Provides the [AudioSpec] class.
import 'dart:ffi';

import '../sdl_bindings.dart';

/// Audio specification.
///
/// [SDL Docs](https://wiki.libsdl.org/SDL_AudioSpec)
class AudioSpec {
  /// Create an instance.
  AudioSpec(this.freq, this.audioFormat, this.channels, this.silence,
      this.samples, this.size);

  /// Create an instance from a pointer.
  factory AudioSpec.fromPointer(Pointer<SDL_AudioSpec> ptr) {
    final o = ptr.ref;
    return AudioSpec(
        o.freq, o.format, o.channels, o.silence, o.samples, o.size);
  }

  /// DSP frequency.
  final int freq;

  /// The audio format.
  final int audioFormat;

  /// The number of channels.
  final int channels;

  /// Audio buffer silence value.
  final int silence;

  /// Buffer size in samples.
  final int samples;

  /// Buffer size.
  final int size;
}
