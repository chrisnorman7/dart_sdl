/// Provides the [GameController] class.
import 'dart:ffi';

import 'package:ffi/ffi.dart';

import 'enumerations.dart';
import 'joystick.dart';
import 'sdl.dart';
import 'sdl_bindings.dart';
import 'sdl_object.dart';

/// A game controller.
class GameController extends SdlObject<SDL_GameController> {
  /// Create an instance.
  GameController(Sdl sdl, Pointer<SDL_GameController> handle)
      : super(sdl, handle);

  /// Return `true` if this controller is open and attached.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_GameControllerGetAttached)
  bool get attached =>
      sdl.getBool(sdl.sdl.SDL_GameControllerGetAttached(handle));

  /// Get the current state of an axis control on this game controller.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_GameControllerAxis)
  int getAxis(GameControllerAxis axis) =>
      sdl.sdl.SDL_GameControllerGetAxis(handle, axis.toInt());

  /// Get the value of [axis], as a number between -1.0 and 1.0.
  double getAxisSmall(GameControllerAxis axis) {
    final value = getAxis(axis);
    if (value < 0) {
      return value / 32768;
    } else if (value > 0) {
      return value / 32767;
    } else {
      return 0.0;
    }
  }

  /// Return `true` if [button] is pressed.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_GameControllerGetButton)
  bool getButton(GameControllerButton button) =>
      sdl.getBool(sdl.sdl.SDL_GameControllerGetButton(handle, button.toInt()));

  /// Get the value of a joystick on this controller.
  /// [SDL Docs](https://wiki.libsdl.org/SDL_GameControllerGetJoystick)
  Joystick get joystick {
    final ptr = sdl.sdl.SDL_GameControllerGetJoystick(handle);
    return Joystick(sdl, ptr);
  }

  /// Get the name of this controller.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_GameControllerName)
  String get name =>
      sdl.sdl.SDL_GameControllerName(handle).cast<Utf8>().toDartString();

  /// Close this controller.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_GameControllerClose)
  void close() {
    sdl.sdl.SDL_GameControllerClose(handle);
  }
}
