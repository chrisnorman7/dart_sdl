/// Provides joystick events.
import 'dart:math';

import '../extensions.dart';
import '../sdl.dart';
import '../sdl_bindings.dart';
import 'base.dart';

/// The base class for all joystick events.
class JoystickEvent extends Event {
  /// Create an event.
  const JoystickEvent({
    required final Sdl sdl,
    required final int timestamp,
    required this.joystickId,
  }) : super(sdl, timestamp);

  /// The id of the joystick that generated this event.
  final int joystickId;
}

/// An axis on a joystick was moved.
///
/// [SDL Docs](https://wiki.libsdl.org/SDL_JoyAxisEvent)
class JoyAxisEvent extends JoystickEvent {
  /// Create an event.
  const JoyAxisEvent({
    required final Sdl sdl,
    required final int timestamp,
    required final int joystickId,
    required this.axis,
    required this.value,
  })  : smallValue =
            value < 0 ? (value / 32768) : (value == 0 ? 0.0 : (value / 32767)),
        super(sdl: sdl, timestamp: timestamp, joystickId: joystickId);

  /// The axis that changed.
  final int axis;

  /// The new value of the axis.
  ///
  /// This value will be between -32768 and 32767.
  final int value;

  /// The value normalised to between -1.0 and 1.0 (0.0 is centre).
  final double smallValue;
}

/// A trackball was moved.
///
/// [SDL Docs](https://wiki.libsdl.org/SDL_JoyBallEvent)
class JoyBallEvent extends JoystickEvent {
  /// Create an event.
  const JoyBallEvent({
    required final Sdl sdl,
    required final int timestamp,
    required final int joystickId,
    required this.ball,
    required this.relativeX,
    required this.relativeY,
  }) : super(sdl: sdl, timestamp: timestamp, joystickId: joystickId);

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
  const JoyHatEvent({
    required final Sdl sdl,
    required final int timestamp,
    required final int joystickId,
    required this.hat,
    required this.value,
  }) : super(sdl: sdl, timestamp: timestamp, joystickId: joystickId);

  /// Create an instance from an event.
  JoyHatEvent.fromSdlEvent(final Sdl sdl, final SDL_JoyHatEvent e)
      : value = e.value.toJoyHatValue(),
        hat = e.hat,
        super(joystickId: e.which, sdl: sdl, timestamp: e.timestamp);

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
  const JoyButtonEvent(
    final Sdl sdl,
    final int timestamp,
    final int joystickId,
    this.button,
    this.state,
  ) : super(sdl: sdl, timestamp: timestamp, joystickId: joystickId);

  /// Create an instance from an event.
  JoyButtonEvent.fromSdlEvent(final Sdl sdl, final SDL_JoyButtonEvent e)
      : button = e.button,
        state = e.state.toPressedState(),
        super(joystickId: e.which, sdl: sdl, timestamp: e.timestamp);

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
  const JoyDeviceEvent({
    required final Sdl sdl,
    required final int timestamp,
    required final int joystickId,
    required this.state,
  }) : super(sdl: sdl, timestamp: timestamp, joystickId: joystickId);

  /// Create an instance from an event.
  JoyDeviceEvent.fromSdlEvent(final Sdl sdl, final SDL_JoyDeviceEvent e)
      : state = e.type.toJoystickDeviceState(),
        super(joystickId: e.which, sdl: sdl, timestamp: e.timestamp);

  /// Whether or not the device was added ore removed.
  final DeviceState state;
}
