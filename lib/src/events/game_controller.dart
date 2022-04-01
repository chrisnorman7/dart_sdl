/// Provides game controller events.
import 'dart:ffi';

import '../enumerations.dart';
import '../extensions.dart';
import '../sdl.dart';
import '../sdl_bindings.dart';
import 'base.dart';
import 'joystick.dart';

/// The base for all game controller events.
class GameControllerEvent extends JoystickEvent {
  /// Create an event.
  const GameControllerEvent({
    required final Sdl sdl,
    required final int timestamp,
    required final int controllerId,
  }) : super(sdl: sdl, timestamp: timestamp, joystickId: controllerId);
}

/// A controller axis moved.
///
/// [SDL Docs](https://wiki.libsdl.org/SDL_ControllerAxisEvent)
class ControllerAxisEvent extends GameControllerEvent {
  /// Create an event.
  const ControllerAxisEvent({
    required final Sdl sdl,
    required final int timestamp,
    required final int joystickId,
    required this.axis,
    required this.value,
  })  : smallValue =
            value < 0 ? (value / 32768) : (value == 0 ? 0.0 : (value / 32767)),
        super(sdl: sdl, timestamp: timestamp, controllerId: joystickId);

  /// The axis which moved.
  final GameControllerAxis axis;

  /// The new position.
  ///
  /// This value will be between -32768 and 32767.
  final int value;

  /// The value normalised to between -1.0 and 1.0 (0.0 is centre).
  final double smallValue;
}

/// A controller button was pressed or released.
///
/// [SDL Docs](https://wiki.libsdl.org/SDL_ControllerButtonEvent)
class ControllerButtonEvent extends GameControllerEvent {
  /// Create an event.
  const ControllerButtonEvent({
    required final Sdl sdl,
    required final int timestamp,
    required final int joystickId,
    required this.button,
    required this.state,
  }) : super(sdl: sdl, timestamp: timestamp, controllerId: joystickId);

  /// Create an instance from an SDL event.
  ControllerButtonEvent.fromSdlEvent(
    final Sdl sdl,
    final SDL_ControllerButtonEvent event,
  )   : button = event.button.toGameControllerButton(),
        state = event.state.toPressedState(),
        super(controllerId: event.which, sdl: sdl, timestamp: event.timestamp);

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
  const ControllerDeviceEvent({
    required final Sdl sdl,
    required final int timestamp,
    required final int joystickId,
    required this.state,
  }) : super(sdl: sdl, timestamp: timestamp, controllerId: joystickId);

  /// Create an instance from an SDL event.
  ControllerDeviceEvent.fromSdlEvent(
    final Sdl sdl,
    final SDL_ControllerDeviceEvent event,
  )   : state = event.type.toGameControllerDeviceState(),
        super(controllerId: event.which, sdl: sdl, timestamp: event.timestamp);

  /// The type of this event.
  final DeviceState state;
}

/// A controller touch device event.
class ControllerTouchpadEvent extends GameControllerEvent
    with CoordinatesMixin<double> {
  /// Create an event.
  ControllerTouchpadEvent({
    required final Sdl sdl,
    required final int timestamp,
    required final int controllerId,
    required this.type,
    required this.touchpad,
    required this.finger,
    required final double x,
    required final double y,
    required this.pressure,
  }) : super(controllerId: controllerId, sdl: sdl, timestamp: timestamp) {
    this.x = x;
    this.y = y;
  }

  /// Create an instance from an SDL event.
  ControllerTouchpadEvent.fromSdlEvent(
    final Sdl sdl,
    final SDL_ControllerTouchpadEvent event,
  )   : type = event.type.toControllerTouchpadEventType(),
        finger = event.finger,
        pressure = event.pressure,
        touchpad = event.touchpad,
        super(controllerId: event.which, sdl: sdl, timestamp: event.timestamp) {
    x = event.x;
    y = event.y;
  }

  /// The type of this event.
  final ControllerTouchpadEventType type;

  /// The index of the touchpad.
  final int touchpad;

  /// The index of the finger on the touchpad.
  final int finger;

  /// Finger pressure.
  final double pressure;
}

/// A controller sensor event.
///
/// Exposes [SDL_ControllerSensorEvent].
class ControllerSensorEvent extends GameControllerEvent
    with CoordinatesMixin<double> {
  /// Create an event.
  ControllerSensorEvent({
    required final Sdl sdl,
    required final int timestamp,
    required final int controllerId,
    required this.sensor,
    required final double x,
    required final double y,
    required this.z,
  }) : super(controllerId: controllerId, sdl: sdl, timestamp: timestamp) {
    this.x = x;
    this.y = y;
  }

  /// Create an instance from an SDL event.
  ControllerSensorEvent.fromSdlEvent(
    final Sdl sdl,
    final SDL_ControllerSensorEvent event,
  )   : sensor = event.sensor.toSensorType(),
        z = event.data[2],
        super(controllerId: event.which, sdl: sdl, timestamp: event.timestamp) {
    x = event.data[0];
    y = event.data[1];
  }

  /// The type of the sensor.
  final SensorType sensor;

  /// Z data.
  final double z;
}
