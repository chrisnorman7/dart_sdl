/// Provides the [Joystick] class.
import 'dart:ffi';
import 'dart:math';

import 'package:ffi/ffi.dart';

import 'enumerations.dart';
import 'error.dart';
import 'sdl.dart';
import 'sdl_bindings.dart';

/// A joystick device.
///
/// [SDL Docs](https://wiki.libsdl.org/SDL_Joystick)
class Joystick {
  /// Create an opened joystick.
  Joystick(this.sdl, this.handle);

  /// The bindings to use.
  final Sdl sdl;

  /// The handle for this joystick.
  final Pointer<SDL_Joystick> handle;

  /// Get the power level for this joystick.
  JoystickPowerLevel get powerLevel {
    final level = sdl.sdl.SDL_JoystickCurrentPowerLevel(handle);
    switch (level) {
      case SDL_JoystickPowerLevel.SDL_JOYSTICK_POWER_UNKNOWN:
        return JoystickPowerLevel.unknown;
      case SDL_JoystickPowerLevel.SDL_JOYSTICK_POWER_EMPTY:
        return JoystickPowerLevel.empty;
      case SDL_JoystickPowerLevel.SDL_JOYSTICK_POWER_LOW:
        return JoystickPowerLevel.low;
      case SDL_JoystickPowerLevel.SDL_JOYSTICK_POWER_MEDIUM:
        return JoystickPowerLevel.medium;
      case SDL_JoystickPowerLevel.SDL_JOYSTICK_POWER_FULL:
        return JoystickPowerLevel.full;
      case SDL_JoystickPowerLevel.SDL_JOYSTICK_POWER_WIRED:
        return JoystickPowerLevel.wired;
      case SDL_JoystickPowerLevel.SDL_JOYSTICK_POWER_MAX:
        return JoystickPowerLevel.max;
      default:
        throw SdlError(level, 'Unknown power level.');
    }
  }

  /// Returns `true` if this joystick has been opened.
  bool get attached => sdl.getBool(sdl.sdl.SDL_JoystickGetAttached(handle));

  /// Get the current state of an axis control.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_JoystickGetAxis)
  int getAxis(int axis) {
    final value = sdl.sdl.SDL_JoystickGetAxis(handle, axis);
    if (value == 0) {
      throw SdlError(0, sdl.getError());
    }
    return value;
  }

  /// Get the ball axis change since the last poll.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_JoystickGetBall)
  Point<int> getBall(int ball) {
    final dx = calloc<Int32>();
    final dy = calloc<Int32>();
    try {
      sdl.checkReturnValue(sdl.sdl.SDL_JoystickGetBall(handle, ball, dx, dy));
      return Point<int>(dx.value, dy.value);
    } finally {
      [dx, dy].forEach(calloc.free);
    }
  }

  /// Get the current state of a button.
  ///
  /// Returns `true` if the button is currently pressed, `false` otherwise.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_JoystickGetButton)
  bool getButton(int button) =>
      sdl.getBool(sdl.sdl.SDL_JoystickGetButton(handle, button));

  /// Get the position of a hat.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_JoystickGetHat)
  JoyHatValues getHat(int hat) {
    final value = sdl.sdl.SDL_JoystickGetHat(handle, hat);
    switch (value) {
      case SDL_HAT_LEFTUP:
        return JoyHatValues.leftUp;
      case SDL_HAT_UP:
        return JoyHatValues.up;
      case SDL_HAT_RIGHTUP:
        return JoyHatValues.rightUp;
      case SDL_HAT_LEFT:
        return JoyHatValues.left;
      case SDL_HAT_CENTERED:
        return JoyHatValues.centered;
      case SDL_HAT_RIGHT:
        return JoyHatValues.right;
      case SDL_HAT_LEFTDOWN:
        return JoyHatValues.leftDown;
      case SDL_HAT_DOWN:
        return JoyHatValues.down;
      case SDL_HAT_RIGHTDOWN:
        return JoyHatValues.rightDown;
      default:
        throw SdlError(value, 'Unknown hat value.');
    }
  }

  /// Get the name of this joystick.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_JoystickName)
  String get name {
    final name = sdl.sdl.SDL_JoystickName(handle).cast<Utf8>().toDartString();
    if (name.isEmpty) {
      throw SdlError(0, sdl.getError());
    }
    return name;
  }

  /// Get the number of axes supported by this joystick.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_JoystickNumAxes)
  int get numAxes => sdl.checkReturnValue(sdl.sdl.SDL_JoystickNumAxes(handle));

  /// Get the number of balls for this joystick.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_JoystickNumBalls)
  int get numBalls =>
      sdl.checkReturnValue(sdl.sdl.SDL_JoystickNumBalls(handle));

  /// Get the number of buttons for this joystick.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_JoystickNumButtons)
  int get numButtons =>
      sdl.checkReturnValue(sdl.sdl.SDL_JoystickNumButtons(handle));

  /// Get the number of hats for this joystick.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_JoystickNumHats)
  int get numHats => sdl.checkReturnValue(sdl.sdl.SDL_JoystickNumHats(handle));

  /// Close this joystick.
  void close() => sdl.sdl.SDL_JoystickClose(handle);
}
