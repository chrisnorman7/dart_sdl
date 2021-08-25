/// Provides the [Haptic] class.
import 'dart:ffi';

import 'sdl.dart';
import 'sdl_bindings.dart';

/// A haptic device.
class Haptic {
  /// Create an instance.
  Haptic(this.sdl, this.handle);

  /// The SDL instance to use.
  final Sdl sdl;

  /// The handle to use.
  final Pointer<SDL_Haptic> handle;

  /// Close this device.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_HapticClose)
  void close() => sdl.sdl.SDL_HapticClose(handle);

  /// Get the number of effects a haptic device can play at the same time.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_HapticNumEffectsPlaying)
  int get numEffectsPlaying =>
      sdl.checkReturnValue(sdl.sdl.SDL_HapticNumEffectsPlaying(handle));

  /// Get the number of effects a haptic device can store.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_HapticNumEffects)
  int get numEffects =>
      sdl.checkReturnValue(sdl.sdl.SDL_HapticNumEffects(handle));

  /// Get the number of haptic axes the device has.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_HapticNumAxes)
  int get numAxes => sdl.checkReturnValue(sdl.sdl.SDL_HapticNumAxes(handle));

  /// Get the index of a haptic device.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_HapticIndex)
  int get index => sdl.checkReturnValue(sdl.sdl.SDL_HapticIndex(handle));

  /// Get the implementation dependent name of a haptic device.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_HapticName)
  String get name => sdl.getHapticName(index);

  /// Pause a haptic device.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_HapticPause)
  void pause() => sdl.checkReturnValue(sdl.sdl.SDL_HapticPause(handle));

  /// Initialize a haptic device for simple rumble playback.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_HapticRumbleInit)
  void init() => sdl.checkReturnValue(sdl.sdl.SDL_HapticRumbleInit(handle));

  /// Run a simple rumble effect on a haptic device.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_HapticRumblePlay)
  void rumblePlay(double strength, int length) => sdl
      .checkReturnValue(sdl.sdl.SDL_HapticRumblePlay(handle, strength, length));

  /// Stop the simple rumble on a haptic device.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_HapticRumbleStop)
  void rumbleStop() =>
      sdl.checkReturnValue(sdl.sdl.SDL_HapticRumbleStop(handle));

  /// Check whether rumble is supported on a haptic device.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_HapticRumbleSupported)
  bool get rumbleSupported => sdl
      .getBool(sdl.checkReturnValue(sdl.sdl.SDL_HapticRumbleSupported(handle)));

  /// Set the global autocenter of the device.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_HapticSetAutocenter)
  set autocenter(int value) =>
      sdl.checkReturnValue(sdl.sdl.SDL_HapticSetAutocenter(handle, value));

  /// Set the global gain of the specified haptic device.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_HapticSetGain)
  set gain(int value) =>
      sdl.checkReturnValue(sdl.sdl.SDL_HapticSetGain(handle, value));

  /// Stop all the currently playing effects on a haptic device.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_HapticStopAll)
  void stopAll() => sdl.checkReturnValue(sdl.sdl.SDL_HapticStopAll(handle));

  /// Unpause a haptic device.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_HapticUnpause)
  void unpause() => sdl.checkReturnValue(sdl.sdl.SDL_HapticUnpause(handle));
}
