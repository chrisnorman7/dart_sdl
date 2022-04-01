/// Provides the [AudioSpec] class.
import 'dart:ffi';

import '../sdl_bindings.dart';

/// Audio specification.
///
/// [SDL Docs](https://wiki.libsdl.org/SDL_AudioSpec)
class AudioSpec {
  /// Create an instance.
  const AudioSpec({
    required this.freq,
    required this.audioFormat,
    required this.channels,
    required this.silence,
    required this.samples,
    required this.size,
  });

  /// Create an instance from a pointer.
  factory AudioSpec.fromPointer(final Pointer<SDL_AudioSpec> ptr) {
    final o = ptr.ref;
    return AudioSpec(
      freq: o.freq,
      audioFormat: o.format,
      channels: o.channels,
      silence: o.silence,
      samples: o.samples,
      size: o.size,
    );
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
