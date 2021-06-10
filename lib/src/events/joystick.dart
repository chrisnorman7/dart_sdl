/// Provides joystick events.
import 'dart:math';

import '../enumerations.dart';
import '../extensions.dart';
import '../sdl.dart';
import '../sdl_bindings.dart';
import 'base.dart';

/// The base class for all joystick events.
class JoystickEvent extends Event {
  /// Create an event.
  JoystickEvent(Sdl sdl, int timestamp, this.joystickId)
      : super(sdl, timestamp);

  /// The id of the joystick that generated this event.
  final int joystickId;
}

/// An axis on a joystick was moved.
///
/// [SDL Docs](https://wiki.libsdl.org/SDL_JoyAxisEvent)
class JoyAxisEvent extends JoystickEvent {
  /// Create an event.
  JoyAxisEvent(Sdl sdl, int timestamp, int joystickId, this.axis, this.value)
      : super(sdl, timestamp, joystickId);

  /// The axis that changed.
  final int axis;

  /// The new value of the axis.
  final int value;
}

/// A trackball was moved.
///
/// [SDL Docs](https://wiki.libsdl.org/SDL_JoyBallEvent)
class JoyBallEvent extends JoystickEvent {
  /// Create an event.
  JoyBallEvent(Sdl sdl, int timestamp, int joystickId, this.ball,
      this.relativeX, this.relativeY)
      : super(sdl, timestamp, joystickId);

  /// The ball that was moved.
  final int ball;

  /// Movement in the x direction.
  final int relativeX;

  /// Movement in the Y direction.
  final int relativeY;

  /// The relative coordinates.
  Point<int> get relative => Point<int>(relativeX, relativeY);
}

/// A hat on a joystick has moved.
///
/// [SDL Docs](https://wiki.libsdl.org/SDL_JoyHatEvent)
class JoyHatEvent extends JoystickEvent {
  /// Create an event.
  JoyHatEvent(Sdl sdl, int timestamp, int joystickId, this.hat, this.value)
      : super(sdl, timestamp, joystickId);

  /// Create an instance from an event.
  factory JoyHatEvent.fromSdlEvent(Sdl sdl, SDL_JoyHatEvent e) =>
      JoyHatEvent(sdl, e.timestamp, e.which, e.hat, e.value.toJoyHatValue());

  /// The hat that has changed.
  final int hat;

  /// The value of the hat.
  final JoyHatValue value;
}

/// A button was pressed or released.
///
/// [SDL Docs](https://wiki.libsdl.org/SDL_JoyButtonEvent)
class JoyButtonEvent extends JoystickEvent {
  /// Create an event.
  JoyButtonEvent(
      Sdl sdl, int timestamp, int joystickId, this.button, this.state)
      : super(sdl, timestamp, joystickId);

  /// Create an instance from an event.
  factory JoyButtonEvent.fromSdlEvent(Sdl sdl, SDL_JoyButtonEvent e) =>
      JoyButtonEvent(
          sdl, e.timestamp, e.which, e.button, e.state.toPressedState());

  /// The button that was pressed.
  final int button;

  /// The state of the button.
  final PressedState state;
}

/// A joystick device was connected or disconnected.
///
/// [SDL Docs](https://wiki.libsdl.org/SDL_JoyDeviceEvent)
class JoyDeviceEvent extends JoystickEvent {
  /// Create an event.
  JoyDeviceEvent(Sdl sdl, int timestamp, int joystickId, this.state)
      : super(sdl, timestamp, joystickId);

  /// Create an instance from an event.
  factory JoyDeviceEvent.fromSdlEvent(Sdl sdl, SDL_JoyDeviceEvent e) =>
      JoyDeviceEvent(sdl, e.timestamp, e.which, e.type.toJoystickDeviceState());

  /// Whether or not the device was added ore removed.
  final DeviceState state;
}
