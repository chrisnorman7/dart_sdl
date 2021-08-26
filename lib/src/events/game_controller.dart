/// Provides game controller events.
import '../enumerations.dart';
import '../extensions.dart';
import '../sdl.dart';
import '../sdl_bindings.dart';
import 'joystick.dart';

/// The base for all game controller events.
class GameControllerEvent extends JoystickEvent {
  /// Create an event.
  GameControllerEvent(Sdl sdl, int timestamp, int joystickId)
      : super(sdl, timestamp, joystickId);
}

/// A controller axis moved.
///
/// [SDL Docs](https://wiki.libsdl.org/SDL_ControllerAxisEvent)
class ControllerAxisEvent extends GameControllerEvent {
  /// Create an event.
  ControllerAxisEvent(
      Sdl sdl, int timestamp, int joystickId, this.axis, this.value)
      : super(sdl, timestamp, joystickId) {
    if (value < 0) {
      smallValue = value / 32768;
    } else if (value > 0) {
      smallValue = value / 32767;
    } else {
      smallValue = 0.0;
    }
  }

  /// The axis which moved.
  final GameControllerAxis axis;

  /// The new position.
  ///
  /// This value will be between -32768 and 32767.
  final int value;

  /// The value normalised to between -1.0 and 1.0 (0.0 is centre).
  late final double smallValue;
}

/// A controller button was pressed or released.
///
/// [SDL Docs](https://wiki.libsdl.org/SDL_ControllerButtonEvent)
class ControllerButtonEvent extends GameControllerEvent {
  /// Create an event.
  ControllerButtonEvent(
      Sdl sdl, int timestamp, int joystickId, this.button, this.state)
      : super(sdl, timestamp, joystickId);

  /// Create an instance from an SDL event.
  factory ControllerButtonEvent.fromSdlEvent(
          Sdl sdl, SDL_ControllerButtonEvent event) =>
      ControllerButtonEvent(sdl, event.timestamp, event.which,
          event.button.toGameControllerButton(), event.state.toPressedState());

  /// The button that was pressed or released.
  final GameControllerButton button;

  /// The state of [button].
  final PressedState state;
}

/// A device was added, removed, or remapped.
///
/// [SDL Docs](https://wiki.libsdl.org/SDL_ControllerDeviceEvent)
class ControllerDeviceEvent extends GameControllerEvent {
  /// Create an event.
  ControllerDeviceEvent(Sdl sdl, int timestamp, int joystickId, this.state)
      : super(sdl, timestamp, joystickId);

  /// Create an instance from an SDL event.
  factory ControllerDeviceEvent.fromSdlEvent(
          Sdl sdl, SDL_ControllerDeviceEvent event) =>
      ControllerDeviceEvent(sdl, event.timestamp, event.which,
          event.type.toGameControllerDeviceState());

  /// The type of this event.
  final DeviceState state;
}
