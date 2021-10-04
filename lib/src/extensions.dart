/// Provides extensions.
import 'dart:ffi';

import 'package:ffi/ffi.dart';

import 'enumerations.dart';
import 'error.dart';
import 'events/drop.dart';
import 'events/game_controller.dart';
import 'modifiers.dart';
import 'sdl.dart';
import 'sdl_bindings.dart';

/// Pressed state.
enum PressedState {
  /// [SDL_PRESSED].
  pressed,

  /// [SDL_RELEASED].
  released,
}

/// Possible joystick hat values.
enum JoyHatValue {
  /// [SDL_HAT_LEFTUP].
  leftUp,

  /// [SDL_HAT_UP].
  up,

  /// [SDL_HAT_RIGHTUP].
  rightUp,

  /// [SDL_HAT_LEFT].
  left,

  /// [SDL_HAT_CENTERED].
  centered,

  /// [SDL_HAT_RIGHT].
  right,

  /// [SDL_HAT_LEFTDOWN].
  leftDown,

  /// [SDL_HAT_DOWN].
  down,

  /// [SDL_HAT_RIGHTDOWN].
  rightDown,
}

/// Whether a device was added or removed.
enum DeviceState {
  /// A device was added.
  added,

  /// A device was removed.
  removed,

  /// A controller device was remapped.
  remapped,
}

/// Dollar event types.
enum DollarGestureEventType {
  /// [SDL_EventType.SDL_DOLLARGESTURE].
  gesture,

  /// [SDL_EventType.SDL_DOLLARRECORD].
  record,
}

/// Touch finger event types.
enum TouchFingerEventType {
  /// [SDL_EventType.SDL_FINGERMOTION].
  motion,

  /// [SDL_EventType.SDL_FINGERDOWN].
  down,

  /// [SDL_EventType.SDL_FINGERUP].
  up,
}

/// Haptic directions.
///
/// The page in the link below is not for an enumeration, but the values of
/// this enum are taken from constants mentioned by that page.
///
/// [SDL Docs](https://wiki.libsdl.org/SDL_HapticDirection)
enum HapticDirectionType {
  /// [SDL_HAPTIC_POLAR].
  polar,

  /// [SDL_HAPTIC_CARTESIAN].
  cartesian,

  /// [SDL_HAPTIC_SPHERICAL].
  spherical,
}

/// An extension for converting to an SDL flag.
extension SdlHapticDirectionTypeValues on HapticDirectionType {
  /// Return an SDL value.
  int toInt() {
    switch (this) {
      case HapticDirectionType.polar:
        return SDL_HAPTIC_POLAR;
      case HapticDirectionType.cartesian:
        return SDL_HAPTIC_CARTESIAN;
      case HapticDirectionType.spherical:
        return SDL_HAPTIC_SPHERICAL;
    }
  }
}

/// The type of a haptic effect.
///
/// This link below does not point to an enum, but the values of this enum are
/// taken from that page.
///
/// [SDL Docs](https://wiki.libsdl.org/SDL_HapticPeriodic)
enum HapticPeriodicType {
  /// SDL_HAPTIC_SINE
  sine,

  /// SDL_HAPTIC_LEFTRIGHT
  leftRight,

  /// SDL_HAPTIC_TRIANGLE
  triangle,

  /// SDL_HAPTIC_SAWTOOTHUP
  sawToothUp,

  /// SDL_HAPTIC_SAWTOOTHDOWN
  sawToothDown,
}

/// An extension for converting to an SDL flag.
extension SdlHapticEffectTypeValues on HapticPeriodicType {
  /// Return an SDL value.
  int toInt() {
    switch (this) {
      case HapticPeriodicType.sine:
        return SDL_HAPTIC_SINE;
      case HapticPeriodicType.leftRight:
        return SDL_HAPTIC_LEFTRIGHT;
      case HapticPeriodicType.triangle:
        return SDL_HAPTIC_TRIANGLE;
      case HapticPeriodicType.sawToothUp:
        return SDL_HAPTIC_SAWTOOTHUP;
      case HapticPeriodicType.sawToothDown:
        return SDL_HAPTIC_SAWTOOTHDOWN;
    }
  }
}

/// The type of a conditional haptic effect.
///
/// The below link does not point to an enum, but the values of this enum are
/// taken from that page.
///
/// [SDL Docs](https://wiki.libsdl.org/SDL_HapticPeriodic)
enum HapticConditionType {
  /// SDL_HAPTIC_SPRING: effect based on axis position
  spring,

  /// SDL_HAPTIC_DAMPER: effect based on axis velocity
  damper,

  /// SDL_HAPTIC_INERTIA: effect based on axis acceleration
  inertia,

  /// SDL_HAPTIC_FRICTION: effect based on axis movement
  friction,
}

/// An extension for converting to an SDL flag.
extension SdlHapticConstantEffectTypeValues on HapticConditionType {
  /// Return an SDL value.
  int toInt() {
    switch (this) {
      case HapticConditionType.spring:
        return SDL_HAPTIC_SPRING;
      case HapticConditionType.damper:
        return SDL_HAPTIC_DAMPER;
      case HapticConditionType.inertia:
        return SDL_HAPTIC_INERTIA;
      case HapticConditionType.friction:
        return SDL_HAPTIC_FRICTION;
    }
  }
}

/// Types for a [ControllerTouchpadEvent].
enum ControllerTouchpadEventType {
  /// [SDL_EventType.SDL_CONTROLLERTOUCHPADDOWN].
  down,

  /// [SDL_EventType.SDL_CONTROLLERTOUCHPADMOTION].
  motion,

  /// [SDL_EventType.SDL_CONTROLLERTOUCHPADUP].
  up,
}

/// The types for [DropEvent] instances.
enum DropEventType {
  /// [SDL_EventType.SDL_DROPBEGIN].
  begin,

  /// [SDL_EventType.SDL_DROPFILE].
  file,

  /// [SDL_EventType.SDL_DROPTEXT].
  text,

  /// [SDL_EventType.SDL_DROPCOMPLETE].
  complete,
}

/// Full screen modes.
enum FullScreenMode {
  /// Real fullscreen with a videomode change.
  real,

  /// Desktop fullscreen that takes the size of the desktop.
  desktop,

  /// Windowed mode.
  windowed,
}

/// An extension for converting to an SDL flag.
extension SdlFullScreenModeValues on FullScreenMode {
  /// Return an SDL flag.
  int toInt() {
    switch (this) {
      case FullScreenMode.real:
        return SDL_WindowFlags.SDL_WINDOW_FULLSCREEN;
      case FullScreenMode.desktop:
        return SDL_WindowFlags.SDL_WINDOW_FULLSCREEN_DESKTOP;
      case FullScreenMode.windowed:
        return 0;
    }
  }
}

/// An extension for converting strings to `dart_sdl` values.
extension SdlStringValues on String {
  /// Return a pointer.
  Pointer<Int8> toInt8Pointer() => toNativeUtf8().cast<Int8>();

  /// Convert to a game controller axis.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_GameControllerGetAxisFromString)
  GameControllerAxis toGameControllerAxis(Sdl sdl) {
    final ptr = toInt8Pointer();
    final i = sdl.sdl.SDL_GameControllerGetAxisFromString(ptr);
    calloc.free(ptr);
    final v = i.toGameControllerAxis();
    if (v == GameControllerAxis.invalid) {
      throw SdlError(0, 'Invalid axis string "$this".');
    }
    return v;
  }

  /// Get a game controller button.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_GameControllerGetButtonFromString)
  GameControllerButton toGameControllerButton(Sdl sdl) {
    final ptr = toInt8Pointer();
    final i = sdl.sdl.SDL_GameControllerGetButtonFromString(ptr);
    calloc.free(ptr);
    final v = i.toGameControllerButton();
    if (v == GameControllerButton.invalid) {
      throw SdlError(0, 'Invalid game controller button "$this".');
    }
    return v;
  }
}

/// An extension for converting to an SDL flag.
extension SdlKeyModValues on KeyMod {
  /// Return an SDL value.
  int toInt() {
    switch (this) {
      case KeyMod.none:
        return SDL_Keymod.KMOD_NONE;
      case KeyMod.lShift:
        return SDL_Keymod.KMOD_LSHIFT;
      case KeyMod.rShift:
        return SDL_Keymod.KMOD_RSHIFT;
      case KeyMod.lCtrl:
        return SDL_Keymod.KMOD_LCTRL;
      case KeyMod.rCtrl:
        return SDL_Keymod.KMOD_RCTRL;
      case KeyMod.lAlt:
        return SDL_Keymod.KMOD_LALT;
      case KeyMod.rAlt:
        return SDL_Keymod.KMOD_RALT;
      case KeyMod.lGui:
        return SDL_Keymod.KMOD_LGUI;
      case KeyMod.rGui:
        return SDL_Keymod.KMOD_RGUI;
      case KeyMod.num:
        return SDL_Keymod.KMOD_NUM;
      case KeyMod.caps:
        return SDL_Keymod.KMOD_CAPS;
      case KeyMod.mode:
        return SDL_Keymod.KMOD_MODE;
      case KeyMod.ctrl:
        return SDL_Keymod.KMOD_CTRL;
      case KeyMod.shift:
        return SDL_Keymod.KMOD_SHIFT;
      case KeyMod.alt:
        return SDL_Keymod.KMOD_ALT;
      case KeyMod.gui:
        return SDL_Keymod.KMOD_GUI;
      case KeyMod.reserved:
        return SDL_Keymod.KMOD_RESERVED;
    }
  }
}

/// Various list methods used by this package.
extension SdlListMethods on List<int> {
  /// Iterate over every element, and xor the values.
  int xor() => fold(0, (previousValue, element) => previousValue | element);
}

/// Various extension methods for integers.
extension DartSdlIntExtension on int {
  /// Return a pressed state.
  PressedState toPressedState() {
    switch (this) {
      case SDL_PRESSED:
        return PressedState.pressed;
      case SDL_RELEASED:
        return PressedState.released;
      default:
        throw SdlError(this, 'Invalid pressed state.');
    }
  }

  /// Get a joy hat value.
  JoyHatValue toJoyHatValue() {
    switch (this) {
      case SDL_HAT_LEFTUP:
        return JoyHatValue.leftUp;
      case SDL_HAT_UP:
        return JoyHatValue.up;
      case SDL_HAT_RIGHTUP:
        return JoyHatValue.rightUp;
      case SDL_HAT_LEFT:
        return JoyHatValue.left;
      case SDL_HAT_CENTERED:
        return JoyHatValue.centered;
      case SDL_HAT_RIGHT:
        return JoyHatValue.right;
      case SDL_HAT_LEFTDOWN:
        return JoyHatValue.leftDown;
      case SDL_HAT_DOWN:
        return JoyHatValue.down;
      case SDL_HAT_RIGHTDOWN:
        return JoyHatValue.rightDown;
      default:
        throw SdlError(this, 'Invalid joy hat value.');
    }
  }

  /// Return a device state.
  DeviceState toJoystickDeviceState() {
    switch (this) {
      case SDL_EventType.SDL_JOYDEVICEADDED:
        return DeviceState.added;
      case SDL_EventType.SDL_JOYDEVICEREMOVED:
        return DeviceState.removed;
      default:
        throw SdlError(this, 'Invalid joystick device state.');
    }
  }

  /// Convert to a game controller device state.
  DeviceState toGameControllerDeviceState() {
    switch (this) {
      case SDL_EventType.SDL_CONTROLLERDEVICEADDED:
        return DeviceState.added;
      case SDL_EventType.SDL_CONTROLLERDEVICEREMOVED:
        return DeviceState.removed;
      case SDL_EventType.SDL_CONTROLLERDEVICEREMAPPED:
        return DeviceState.remapped;
      default:
        throw SdlError(this, 'Invalid controller device state.');
    }
  }

  /// Return a list of modifiers.
  List<KeyMod> toModifiersList() {
    final mods = <KeyMod>[];
    for (final modifier in KeyMod.values) {
      if (this & modifier.toInt() != 0) {
        mods.add(modifier);
      }
    }
    return mods;
  }

  /// Convert to a dollar gesture event type.
  DollarGestureEventType toDollarGestureEventType() {
    switch (this) {
      case SDL_EventType.SDL_DOLLARGESTURE:
        return DollarGestureEventType.gesture;
      case SDL_EventType.SDL_DOLLARRECORD:
        return DollarGestureEventType.record;
      default:
        throw SdlError(this, 'Invalid gesture type.');
    }
  }

  /// Convert to a touch event type.
  TouchFingerEventType toTouchEventType() {
    switch (this) {
      case SDL_EventType.SDL_FINGERMOTION:
        return TouchFingerEventType.motion;
      case SDL_EventType.SDL_FINGERDOWN:
        return TouchFingerEventType.down;
      case SDL_EventType.SDL_FINGERUP:
        return TouchFingerEventType.up;
      default:
        throw SdlError(this, 'Invalid touch event type.');
    }
  }

  /// Convert to a controller touch event type.
  ControllerTouchpadEventType toControllerTouchpadEventType() {
    switch (this) {
      case SDL_EventType.SDL_CONTROLLERTOUCHPADDOWN:
        return ControllerTouchpadEventType.down;
      case SDL_EventType.SDL_CONTROLLERTOUCHPADMOTION:
        return ControllerTouchpadEventType.motion;
      case SDL_EventType.SDL_CONTROLLERTOUCHPADUP:
        return ControllerTouchpadEventType.up;
      default:
        throw SdlError(this, 'Invalid controller touch pad event type.');
    }
  }

  /// Convert to a drop event type.
  DropEventType toDropEventType() {
    switch (this) {
      case SDL_EventType.SDL_DROPFILE:
        return DropEventType.file;
      case SDL_EventType.SDL_DROPTEXT:
        return DropEventType.text;
      case SDL_EventType.SDL_DROPBEGIN:
        return DropEventType.begin;
      case SDL_EventType.SDL_DROPCOMPLETE:
        return DropEventType.complete;
      default:
        throw SdlError(this, 'Invalid drop event type.');
    }
  }
}
