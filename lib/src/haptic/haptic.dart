/// Provides the [Haptic] class.
import 'dart:ffi';

import '../sdl.dart';
import '../sdl_bindings.dart';
import '../sdl_object.dart';
import 'haptic_effect.dart';
import 'haptic_features.dart';

/// A haptic device.
class Haptic extends SdlObject<SDL_Haptic> {
  /// Create an instance.
  Haptic(final Sdl sdl, final Pointer<SDL_Haptic> handle) : super(sdl, handle);

  /// Close this device.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_HapticClose)
  void close() {
    sdl.sdl.SDL_HapticClose(handle);
    destroy();
  }

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
  void rumblePlay(final double strength, final int length) => sdl
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
  set autocenter(final int value) =>
      sdl.checkReturnValue(sdl.sdl.SDL_HapticSetAutocenter(handle, value));

  /// Set the global gain of the specified haptic device.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_HapticSetGain)
  set gain(final int value) =>
      sdl.checkReturnValue(sdl.sdl.SDL_HapticSetGain(handle, value));

  /// Stop all the currently playing effects on a haptic device.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_HapticStopAll)
  void stopAll() => sdl.checkReturnValue(sdl.sdl.SDL_HapticStopAll(handle));

  /// Unpause a haptic device.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_HapticUnpause)
  void unpause() => sdl.checkReturnValue(sdl.sdl.SDL_HapticUnpause(handle));

  /// Returns `true` if the given [effect] is supported by this device.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_HapticEffectSupported)
  bool isSupported(final HapticEffect effect) => sdl.getBool(
        sdl.checkReturnValue(
          sdl.sdl.SDL_HapticEffectSupported(handle, effect.handle),
        ),
      );

  /// Upload the given [effect] to this device.
  ///
  /// The returned index can be used with [runEffect] or [destroyEffect].
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_HapticNewEffect)
  int newEffect(final HapticEffect effect) =>
      sdl.checkReturnValue(sdl.sdl.SDL_HapticNewEffect(handle, effect.handle));

  /// Run the effect referenced by the given [effectId].
  ///
  /// The index can be obtained from the [newEffect] method.
  ///
  /// If [iterations] is `null`, the effect will run forever.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_HapticRunEffect)
  void runEffect(final int effectId, {final int? iterations}) =>
      sdl.checkReturnValue(
        sdl.sdl.SDL_HapticRunEffect(
          handle,
          effectId,
          iterations ?? SDL_HAPTIC_INFINITY,
        ),
      );

  /// Destroy the effect referenced by the given [effectId].
  ///
  /// The index can be obtained from [newEffect].
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_HapticDestroyEffect)
  void destroyEffect(final int effectId) =>
      sdl.sdl.SDL_HapticDestroyEffect(handle, effectId);

  /// Return `true` if the effect represented by [effectId] is currently
  /// playing.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_HapticGetEffectStatus)
  bool getEffectPlaying(final int effectId) => sdl.getBool(
        sdl.checkReturnValue(
          sdl.sdl.SDL_HapticGetEffectStatus(handle, effectId),
        ),
      );

  /// Stop the effect referenced by [effectId].
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_HapticStopEffect)
  void stopEffect(final int effectId) =>
      sdl.checkReturnValue(sdl.sdl.SDL_HapticStopEffect(handle, effectId));

  /// Update the effect referenced by [effectId] with [effect].
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_HapticUpdateEffect)
  void updateEffect(final int effectId, final HapticEffect effect) =>
      sdl.checkReturnValue(
        sdl.sdl.SDL_HapticUpdateEffect(handle, effectId, effect.handle),
      );

  /// Get the features supported by this device.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_HapticQuery)
  List<HapticFeature> get features {
    final possibleFeatures = <int, HapticFeature>{
      SDL_HAPTIC_CONSTANT: HapticFeature.constant,
      SDL_HAPTIC_SINE: HapticFeature.sine,
      SDL_HAPTIC_LEFTRIGHT: HapticFeature.leftRight,
      SDL_HAPTIC_TRIANGLE: HapticFeature.triangle,
      SDL_HAPTIC_SAWTOOTHUP: HapticFeature.sawToothUp,
      SDL_HAPTIC_SAWTOOTHDOWN: HapticFeature.sawToothDown,
      SDL_HAPTIC_RAMP: HapticFeature.ramp,
      SDL_HAPTIC_SPRING: HapticFeature.spring,
      SDL_HAPTIC_DAMPER: HapticFeature.damper,
      SDL_HAPTIC_INERTIA: HapticFeature.inertia,
      SDL_HAPTIC_FRICTION: HapticFeature.friction,
      SDL_HAPTIC_CUSTOM: HapticFeature.custom,
      SDL_HAPTIC_GAIN: HapticFeature.gain,
      SDL_HAPTIC_AUTOCENTER: HapticFeature.autocenter,
      SDL_HAPTIC_STATUS: HapticFeature.status,
      SDL_HAPTIC_PAUSE: HapticFeature.pause,
    };
    final value = sdl.checkReturnValue(sdl.sdl.SDL_HapticQuery(handle));
    return [
      for (final element in possibleFeatures.entries)
        if (value & element.key != 0) element.value
    ];
  }
}
