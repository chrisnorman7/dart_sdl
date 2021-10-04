/// Provides the [AudioDriver] class.
import 'package:ffi/ffi.dart';

import '../sdl.dart';

/// An audio driver on the system.
class AudioDriver {
  /// Initialise the driver.
  AudioDriver(this.sdl, this.index);

  /// The SDL bindings to use.
  final Sdl sdl;

  /// The index of the device driver.
  final int index;

  /// The name of this driver.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_GetAudioDriver)
  String get name =>
      sdl.sdl.SDL_GetAudioDriver(index).cast<Utf8>().toDartString();
}
