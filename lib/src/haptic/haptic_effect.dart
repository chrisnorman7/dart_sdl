/// Provides the [HapticEffect] class, and all its subclasses.
import 'dart:ffi';

import 'package:ffi/ffi.dart';

import '../extensions.dart';
import '../sdl.dart';
import '../sdl_bindings.dart';
import 'haptic_direction.dart';

/// A haptic effect.
///
/// [SDL Docs](https://wiki.libsdl.org/SDL_HapticEffect)
class HapticEffect {
  /// Create an instance.
  HapticEffect(this.sdl) : handle = calloc<SDL_HapticEffect>();

  /// The SDL bindings to use.
  final Sdl sdl;

  /// The pointer to use.
  final Pointer<SDL_HapticEffect> handle;
}

/// A constant haptic effect.
///
/// [SDL Docs](https://wiki.libsdl.org/SDL_HapticConstant)
class HapticConstant extends HapticEffect {
  /// Create a constant effect.
  HapticConstant(
      {required Sdl sdl,
      required this.direction,
      required this.length,
      required this.delay,
      required this.button,
      required this.interval,
      required this.level,
      required this.attackLength,
      required this.attackLevel,
      required this.fadeLength,
      required this.fadeLevel})
      : super(sdl) {
    sdl.loadHapticDirection(direction);
    handle.ref.type = SDL_HAPTIC_CONSTANT;
    handle.ref.constant
      ..direction = sdl.hapticDirectionPointer.ref
      ..length = length
      ..delay = delay
      ..button = button
      ..interval = interval
      ..level = level
      ..attack_length = attackLength
      ..fade_length = fadeLength
      ..fade_level = fadeLevel;
  }

  /// The direction of the effect.
  final HapticDirection direction;

  /// Duration of the effect.
  final int length;

  /// Delay before starting the effect.
  final int delay;

  /// Button that triggers the effect.
  final int button;

  /// How soon it can be triggered again after button.
  final int interval;

  /// Strength of the constant effect.
  final int level;

  /// Duration of the attack.
  final int attackLength;

  /// Level at the start of the attack.
  final int attackLevel;

  /// Duration of the fade.
  final int fadeLength;

  /// Level at the end of the fade.
  final int fadeLevel;
}

/// A periodic haptic effect.
///
/// [SDL Docs](https://wiki.libsdl.org/SDL_HapticPeriodic)
class HapticPeriodic extends HapticEffect {
  /// Create an instance.
  HapticPeriodic(
      {required Sdl sdl,
      required this.type,
      required this.direction,
      required this.length,
      required this.delay,
      required this.button,
      required this.interval,
      required this.period,
      required this.magnitude,
      required this.offset,
      required this.phase,
      required this.attackLength,
      required this.attackLevel,
      required this.fadeLength,
      required this.fadeLevel})
      : super(sdl) {
    sdl.loadHapticDirection(direction);
    handle.ref
      ..type = type.toInt()
      ..periodic.type = type.toInt();
    handle.ref.periodic
      ..direction = sdl.hapticDirectionPointer.ref
      ..length = length
      ..delay = delay
      ..button = button
      ..interval = interval
      ..period = period
      ..magnitude = magnitude
      ..offset = offset
      ..phase = phase
      ..attack_length = attackLength
      ..attack_level = attackLevel
      ..fade_length = fadeLength
      ..fade_level = fadeLevel;
  }

  /// The type of this effect.
  final HapticPeriodicType type;

  /// The direction of the effect.
  final HapticDirection direction;

  /// Duration of the effect.
  final int length;

  /// Delay before starting the effect.
  final int delay;

  /// Button that triggers the effect.
  final int button;

  /// How soon it can be triggered again after button.
  final int interval;

  /// Period of the wave.
  final int period;

  /// Peak value; if negative, equivalent to 180 degrees extra phase shift.
  final int magnitude;

  /// Mean value of the wave.
  final int offset;

  /// Positive phase shift given by hundredth of a degree.
  final int phase;

  /// Duration of the attack.
  final int attackLength;

  /// Level at the start of the attack.
  final int attackLevel;

  /// Duration of the fade.
  final int fadeLength;

  /// Level at the end of the fade.
  final int fadeLevel;
}

/// A 3-part number for use with [HapticCondition] members.
class ConditionEffect {
  /// Create an instance.
  ConditionEffect(this.x, this.y, this.z);

  /// The x axis
  final int x;

  /// The y axis.
  final int y;

  /// The z axis.
  final int z;
}

/// A conditional haptic effect.
///
/// [SDL Docs](https://wiki.libsdl.org/SDL_HapticCondition)
class HapticCondition extends HapticEffect {
  /// Create an instance.
  HapticCondition(
      {required Sdl sdl,
      required this.type,
      required this.length,
      required this.delay,
      required this.button,
      required this.interval,
      required this.rightSat,
      required this.leftSat,
      required this.rightCoeff,
      required this.leftCoeff,
      required this.deadband,
      required this.center})
      : super(sdl) {
    handle.ref.type = type.toInt();
    handle.ref.condition
      ..type = type.toInt()
      ..length = length
      ..delay = delay
      ..button = button
      ..interval = interval
      ..right_sat[0] = rightSat.x
      ..right_sat[1] = rightSat.y
      ..right_sat[2] = rightSat.z
      ..left_sat[0] = leftSat.x
      ..left_sat[1] = leftSat.y
      ..left_sat[2] = leftSat.z
      ..right_coeff[0] = rightCoeff.x
      ..right_coeff[1] = rightCoeff.y
      ..right_coeff[2] = rightCoeff.z
      ..left_coeff[0] = leftCoeff.x
      ..left_coeff[1] = leftCoeff.y
      ..left_coeff[2] = leftCoeff.z
      ..deadband[0] = deadband.x
      ..deadband[1] = deadband.y
      ..deadband[2] = deadband.z
      ..center[0] = center.x
      ..center[1] = center.y
      ..center[2] = center.z;
  }

  /// The type of this effect.
  final HapticConditionType type;

  /// Duration of the effect.
  final int length;

  /// Delay before starting the effect.
  final int delay;

  /// Button that triggers the effect.
  final int button;

  /// How soon it can be triggered again after button.
  final int interval;

  /// Level when joystick is to the positive side; max 0xFFFF.
  final ConditionEffect rightSat;

  /// Level when joystick is to the negative side; max 0xFFFF.
  final ConditionEffect leftSat;

  /// How fast to increase the force towards the positive side.
  final ConditionEffect rightCoeff;

  /// How fast to increase the force towards the negative side.
  final ConditionEffect leftCoeff;

  /// Size of the dead zone; max 0xFFFF: whole axis-range when 0-centered.
  final ConditionEffect deadband;

  /// Position of the dead zone.
  final ConditionEffect center;
}

/// A ramp effect.
///
/// [SDL Docs](https://wiki.libsdl.org/SDL_HapticRamp)
class HapticRamp extends HapticEffect {
  /// Create an instance.
  HapticRamp(
      {required Sdl sdl,
      required this.direction,
      required this.length,
      required this.delay,
      required this.button,
      required this.interval,
      required this.start,
      required this.end,
      required this.attackLength,
      required this.attackLevel,
      required this.fadeLength,
      required this.fadeLevel})
      : super(sdl) {
    sdl.loadHapticDirection(direction);
    handle.ref.type = SDL_HAPTIC_RAMP;
    handle.ref.ramp
      ..direction = sdl.hapticDirectionPointer.ref
      ..length = length
      ..delay = delay
      ..button = button
      ..interval = interval
      ..start = start
      ..end = end
      ..attack_length = attackLength
      ..attack_level = attackLevel
      ..fade_length = fadeLength
      ..fade_level = fadeLevel;
  }

  /// Direction of the effect.
  final HapticDirection direction;

  /// Duration of the effect.
  final int length;

  /// Delay before starting the effect.
  final int delay;

  /// Button that triggers the effect.
  final int button;

  /// How soon it can be triggered again after button.
  final int interval;

  /// Beginning strength level.
  final int start;

  /// Ending strength level.
  final int end;

  /// Duration of the attack.
  final int attackLength;

  /// Level at the start of the attack.
  final int attackLevel;

  /// Duration of the fade.
  final int fadeLength;

  /// Level at the end of the fade.
  final int fadeLevel;
}

/// A left/right effect.
///
/// [SDL Docs](https://wiki.libsdl.org/SDL_HapticLeftRight)
class HapticLeftRight extends HapticEffect {
  /// Create an instance.
  HapticLeftRight(
      {required Sdl sdl,
      required this.length,
      required this.largeMagnitude,
      required this.smallMagnitude})
      : super(sdl) {
    handle.ref.type = SDL_HAPTIC_LEFTRIGHT;
    handle.ref.leftright
      ..length = length
      ..large_magnitude = largeMagnitude
      ..small_magnitude = smallMagnitude;
  }

  /// Duration of the effect.
  final int length;

  /// Control of the large controller motor.
  final int largeMagnitude;

  /// Control of the small controller motor.
  final int smallMagnitude;
}
