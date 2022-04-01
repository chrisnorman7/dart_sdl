/// Provides the [InitFlags] class.
import 'src/sdl.dart';
import 'src/sdl_bindings.dart';

/// Flags to pass to [Sdl.init].
class InitFlags {
  /// Create an instance.
  ///
  /// By default, all flags are set to `false`. Instead of creating a new
  /// instance with all flags set to `true`, consider using the
  /// [everything] constant.
  const InitFlags({
    this.timer = false,
    this.audio = false,
    this.video = false,
    this.joystick = false,
    this.haptic = false,
    this.gameController = false,
    this.events = false,
    this.sensor = false,
  });

  /// Initialise all flags to `true`.
  ///
  /// This will produce [flags] like [SDL_INIT_EVERYTHING].
  static const everything = InitFlags(
    audio: true,
    events: true,
    gameController: true,
    haptic: true,
    joystick: true,
    sensor: true,
    timer: true,
    video: true,
  );

  /// [SDL_INIT_TIMER].
  final bool timer;

  /// [SDL_INIT_AUDIO].
  final bool audio;

  /// [SDL_INIT_VIDEO].
  final bool video;

  /// [SDL_INIT_JOYSTICK].
  final bool joystick;

  /// [SDL_INIT_HAPTIC].
  final bool haptic;

  /// [SDL_INIT_GAMECONTROLLER].
  final bool gameController;

  /// [SDL_INIT_EVENTS].
  final bool events;

  /// [SDL_INIT_SENSOR].
  final bool sensor;

  /// Get the flags as an integer.
  int get flags {
    var f = 0;
    if (audio) {
      f |= SDL_INIT_AUDIO;
    }
    if (events) {
      f |= SDL_INIT_EVENTS;
    }
    if (gameController) {
      f |= SDL_INIT_GAMECONTROLLER;
    }
    if (haptic) {
      f |= SDL_INIT_HAPTIC;
    }
    if (joystick) {
      f |= SDL_INIT_JOYSTICK;
    }
    if (sensor) {
      f |= SDL_INIT_SENSOR;
    }
    if (timer) {
      f |= SDL_INIT_TIMER;
    }
    if (video) {
      f |= SDL_INIT_VIDEO;
    }
    return f;
  }
}
