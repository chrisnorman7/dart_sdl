/// Provides the [WaveFile] class.
import 'dart:ffi';

import 'package:ffi/ffi.dart';
import 'package:meta/meta.dart';

import '../extensions.dart';
import '../sdl.dart';
import '../sdl_bindings.dart';

/// A class representing a wave file.
class WaveFile {
  /// Create an instance from a file name.
  WaveFile(this.sdl, this.filename)
      : specPointer = calloc<SDL_AudioSpec>(),
        bufferPointer = calloc<Pointer<Uint8>>(),
        lengthPointer = calloc<Uint32>() {
    sdl.sdl.SDL_LoadWAV_RW(
      sdl.sdl.SDL_RWFromFile(filename.toInt8Pointer(), 'rb'.toInt8Pointer()),
      1,
      specPointer,
      bufferPointer,
      lengthPointer,
    );
  }

  /// The SDL bindings to use.
  final Sdl sdl;

  /// The filename of the loaded file.
  final String filename;

  /// The pointer to the specification of the loaded file.
  final Pointer<SDL_AudioSpec> specPointer;

  /// The pointer to the buffer where the wave file was loaded.
  final Pointer<Pointer<Uint8>> bufferPointer;

  /// The pointer which holds the length of the loaded file.
  final Pointer<Uint32> lengthPointer;

  /// Get the actual length from [lengthPointer].
  int get length => lengthPointer.value;

  /// Destroy this instance.
  @mustCallSuper
  void destroy() {
    [specPointer, bufferPointer, lengthPointer].forEach(calloc.free);
  }
}
