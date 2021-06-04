/// Provides joystick events.
import 'dart:math';

import '../enumerations.dart';
import '../error.dart';
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
  factory JoyHatEvent.fromSdlEvent(Sdl sdl, SDL_JoyHatEvent e) {
    JoyHatValues v;
    switch (e.value) {
      case SDL_HAT_LEFTUP:
        v = JoyHatValues.leftUp;
        break;
      case SDL_HAT_UP:
        v = JoyHatValues.up;
        break;
      case SDL_HAT_RIGHTUP:
        v = JoyHatValues.rightUp;
        break;
      case SDL_HAT_LEFT:
        v = JoyHatValues.left;
        break;
      case SDL_HAT_CENTERED:
        v = JoyHatValues.centered;
        break;
      case SDL_HAT_RIGHT:
        v = JoyHatValues.right;
        break;
      case SDL_HAT_LEFTDOWN:
        v = JoyHatValues.leftDown;
        break;
      case SDL_HAT_DOWN:
        v = JoyHatValues.down;
        break;
      case SDL_HAT_RIGHTDOWN:
        v = JoyHatValues.rightDown;
        break;
      default:
        throw SdlError(e.value, 'Unknown hat value.');
    }
    return JoyHatEvent(sdl, e.timestamp, e.which, e.hat, v);
  }

  /// The hat that has changed.
  final int hat;

  /// The value of the hat.
  final JoyHatValues value;
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
  factory JoyButtonEvent.fromSdlEvent(Sdl sdl, SDL_JoyButtonEvent e) {
    PressedState s;
    switch (e.state) {
      case SDL_PRESSED:
        s = PressedState.pressed;
        break;
      case SDL_RELEASED:
        s = PressedState.released;
        break;
      default:
        throw SdlError(e.state, 'Unknown button state.');
    }
    return JoyButtonEvent(sdl, e.timestamp, e.which, e.button, s);
  }

  /// The button that was pressed.
  final int button;

  /// The state of the button.
  final PressedState state;
}
