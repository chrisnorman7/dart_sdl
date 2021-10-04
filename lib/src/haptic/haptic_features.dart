/// Provides the [HapticFeature] enum.
import '../sdl_bindings.dart';

/// An enumeration of SDL haptic types.
enum HapticFeature {
  /// [SDL_HAPTIC_CONSTANT].
  constant,

  /// [SDL_HAPTIC_SINE].
  sine,

  /// [SDL_HAPTIC_LEFTRIGHT].
  leftRight,

  /// [SDL_HAPTIC_TRIANGLE].
  triangle,

  /// [SDL_HAPTIC_SAWTOOTHUP].
  sawToothUp,

  /// [SDL_HAPTIC_SAWTOOTHDOWN].
  sawToothDown,

  /// [SDL_HAPTIC_RAMP].
  ramp,

  /// [SDL_HAPTIC_SPRING].
  spring,

  /// [SDL_HAPTIC_DAMPER].
  damper,

  /// [SDL_HAPTIC_INERTIA].
  inertia,

  /// [SDL_HAPTIC_FRICTION].
  friction,

  /// [SDL_HAPTIC_CUSTOM].
  custom,

  /// [SDL_HAPTIC_GAIN].
  gain,

  /// [SDL_HAPTIC_AUTOCENTER].
  autocenter,

  /// [SDL_HAPTIC_STATUS].
  status,

  /// [SDL_HAPTIC_PAUSE].
  pause,
}
