/// Provides the [GameController] class.
import 'dart:ffi';

import 'enumerations.dart';
import 'extensions.dart';
import 'sdl.dart';
import 'sdl_bindings.dart';

/// A game controller.
class GameController {
  /// Create an instance.
  GameController(this.sdl, this.handle);

  /// The bindings to use.
  final Sdl sdl;

  /// The handle for communicating with the bindings.
  final Pointer<SDL_GameController> handle;

  /// Return `true` if this controller is open and attached.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_GameControllerGetAttached)
  bool get attached =>
      sdl.getBool(sdl.sdl.SDL_GameControllerGetAttached(handle));

  /// Get the current state of an axis control on this game controller.
  ///
  /// [SDL Docs]([SDL_GameControllerAxis](https://wiki.libsdl.org/SDL_GameControllerAxis))
  int getAxis(GameControllerAxis axis) =>
      sdl.sdl.SDL_GameControllerGetAxis(handle, axis.toSdlFlag());

  /// Close this controller.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_GameControllerClose)
  void close() {
    sdl.sdl.SDL_GameControllerClose(handle);
    sdl.gameControllers.remove(handle);
  }
}
