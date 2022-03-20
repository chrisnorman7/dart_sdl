/// Provides the [Joystick] class.
import 'dart:ffi';
import 'dart:math';

import 'package:ffi/ffi.dart';

import 'enumerations.dart';
import 'error.dart';
import 'extensions.dart';
import 'game_controller.dart';
import 'haptic/haptic.dart';
import 'sdl.dart';
import 'sdl_bindings.dart';
import 'sdl_object.dart';

/// A joystick device.
///
/// [SDL Docs](https://wiki.libsdl.org/SDL_Joystick)
class Joystick extends SdlObject<SDL_Joystick> {
  /// Create an opened joystick.
  Joystick(Sdl sdl, Pointer<SDL_Joystick> handle) : super(sdl, handle);

  /// Get the power level for this joystick.
  JoystickPowerLevel get powerLevel =>
      sdl.sdl.SDL_JoystickCurrentPowerLevel(handle).toJoystickPowerLevel();

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
    sdl.checkReturnValue(
        sdl.sdl.SDL_JoystickGetBall(handle, ball, sdl.xPointer, sdl.yPointer));
    return Point(sdl.xPointer.value, sdl.yPointer.value);
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
  JoyHatValue getHat(int hat) =>
      sdl.sdl.SDL_JoystickGetHat(handle, hat).toJoyHatValue();

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

  /// Get the ID of this joystick.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_JoystickInstanceID)
  int get instanceId =>
      sdl.checkReturnValue(sdl.sdl.SDL_JoystickInstanceID(handle));

  /// Get a controller associated with this joystick.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_GameControllerFromInstanceID)
  ///
  /// If this method returns `null`, use the [Sdl.openGameController] to open
  /// the controller, using [instanceId].
  GameController? get controller {
    final handle = sdl.sdl.SDL_GameControllerFromInstanceID(instanceId);
    if (handle == nullptr) {
      return null;
    }
    return GameController(sdl, handle);
  }

  /// Close this joystick.
  void close() {
    sdl.sdl.SDL_JoystickClose(handle);
    destroy();
  }

  /// Query if a joystick has haptic features.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_JoystickIsHaptic)
  bool get isHaptic =>
      sdl.getBool(sdl.checkReturnValue(sdl.sdl.SDL_JoystickIsHaptic(handle)));

  /// Open a haptic device for use from a joystick device.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_HapticOpenFromJoystick)
  Haptic openHaptic() {
    final pointer = sdl.sdl.SDL_HapticOpenFromJoystick(handle);
    if (pointer == nullptr) {
      throw SdlError(-1, sdl.getError());
    }
    return Haptic(sdl, pointer);
  }

  /// Get the type of this joystick.
  JoystickType get type => sdl.sdl.SDL_JoystickGetType(handle).toJoystickType();
}
