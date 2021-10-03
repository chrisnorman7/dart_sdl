/// Provides extensions.
import 'dart:ffi';

import 'package:ffi/ffi.dart';

import 'enumerations.dart';
import 'error.dart';
import 'sdl.dart';
import 'sdl_bindings.dart';

/// An extension for converting to an SDL flag.
extension SdlGameControllerAxisValues on GameControllerAxis {
  /// Return an SDL flag.
  int toSdlFlag() {
    switch (this) {
      case GameControllerAxis.invalid:
        return SDL_GameControllerAxis.SDL_CONTROLLER_AXIS_INVALID;
      case GameControllerAxis.leftX:
        return SDL_GameControllerAxis.SDL_CONTROLLER_AXIS_LEFTX;
      case GameControllerAxis.leftY:
        return SDL_GameControllerAxis.SDL_CONTROLLER_AXIS_LEFTY;
      case GameControllerAxis.rightX:
        return SDL_GameControllerAxis.SDL_CONTROLLER_AXIS_RIGHTX;
      case GameControllerAxis.rightY:
        return SDL_GameControllerAxis.SDL_CONTROLLER_AXIS_RIGHTY;
      case GameControllerAxis.triggerLeft:
        return SDL_GameControllerAxis.SDL_CONTROLLER_AXIS_TRIGGERLEFT;
      case GameControllerAxis.triggerRight:
        return SDL_GameControllerAxis.SDL_CONTROLLER_AXIS_TRIGGERRIGHT;
      case GameControllerAxis.max:
        return SDL_GameControllerAxis.SDL_CONTROLLER_AXIS_MAX;
    }
  }

  /// Return a string representing this axis.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_GameControllerGetStringForAxis)
  String toAxisString(Sdl sdl) => sdl.sdl
      .SDL_GameControllerGetStringForAxis(toSdlFlag())
      .cast<Utf8>()
      .toDartString();
}

/// An extension for converting to an SDL flag.
extension SdlGameControllerButtonValues on GameControllerButton {
  /// Return an SDL flag.
  int toSdlFlag() {
    switch (this) {
      case GameControllerButton.invalid:
        return SDL_GameControllerButton.SDL_CONTROLLER_BUTTON_INVALID;
      case GameControllerButton.a:
        return SDL_GameControllerButton.SDL_CONTROLLER_BUTTON_A;
      case GameControllerButton.b:
        return SDL_GameControllerButton.SDL_CONTROLLER_BUTTON_B;
      case GameControllerButton.x:
        return SDL_GameControllerButton.SDL_CONTROLLER_BUTTON_X;
      case GameControllerButton.y:
        return SDL_GameControllerButton.SDL_CONTROLLER_BUTTON_Y;
      case GameControllerButton.back:
        return SDL_GameControllerButton.SDL_CONTROLLER_BUTTON_BACK;
      case GameControllerButton.guide:
        return SDL_GameControllerButton.SDL_CONTROLLER_BUTTON_GUIDE;
      case GameControllerButton.start:
        return SDL_GameControllerButton.SDL_CONTROLLER_BUTTON_START;
      case GameControllerButton.leftStick:
        return SDL_GameControllerButton.SDL_CONTROLLER_BUTTON_LEFTSTICK;
      case GameControllerButton.rightStick:
        return SDL_GameControllerButton.SDL_CONTROLLER_BUTTON_RIGHTSTICK;
      case GameControllerButton.leftShoulder:
        return SDL_GameControllerButton.SDL_CONTROLLER_BUTTON_LEFTSHOULDER;
      case GameControllerButton.rightShoulder:
        return SDL_GameControllerButton.SDL_CONTROLLER_BUTTON_RIGHTSHOULDER;
      case GameControllerButton.dpadUp:
        return SDL_GameControllerButton.SDL_CONTROLLER_BUTTON_DPAD_UP;
      case GameControllerButton.dpadDown:
        return SDL_GameControllerButton.SDL_CONTROLLER_BUTTON_DPAD_DOWN;
      case GameControllerButton.dpadLeft:
        return SDL_GameControllerButton.SDL_CONTROLLER_BUTTON_DPAD_LEFT;
      case GameControllerButton.dpadRight:
        return SDL_GameControllerButton.SDL_CONTROLLER_BUTTON_DPAD_RIGHT;
      case GameControllerButton.max:
        return SDL_GameControllerButton.SDL_CONTROLLER_BUTTON_MAX;
    }
  }

  /// Get a string representing this button.
  ///
  /// [SDL Docs](https://wiki.libsdl.org/SDL_GameControllerGetStringForButton)
  String toButtonString(Sdl sdl) => sdl.sdl
      .SDL_GameControllerGetStringForButton(toSdlFlag())
      .cast<Utf8>()
      .toDartString();
}

/// An extension for converting to an SDL flag.
extension SdlFullScreenModeValues on FullScreenMode {
  /// Return an SDL flag.
  int toSdlFlag() {
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

/// An extension for converting to an SDL flag.
extension SdlMessageBoxFlagsValues on MessageBoxFlags {
  /// Return an SDL flag.
  int toSdlFlag() {
    switch (this) {
      case MessageBoxFlags.error:
        return SDL_MessageBoxFlags.SDL_MESSAGEBOX_ERROR;
      case MessageBoxFlags.warning:
        return SDL_MessageBoxFlags.SDL_MESSAGEBOX_WARNING;
      case MessageBoxFlags.information:
        return SDL_MessageBoxFlags.SDL_MESSAGEBOX_INFORMATION;
    }
  }
}

/// An extension for converting to an SDL flag.
extension SdlButtonFlagsValues on ButtonFlags {
  /// Return an SDL flag.
  int toSdlFlag() {
    switch (this) {
      case ButtonFlags.noDefaults:
        return 0;
      case ButtonFlags.returnKeyDefault:
        return SDL_MessageBoxButtonFlags
            .SDL_MESSAGEBOX_BUTTON_RETURNKEY_DEFAULT;
      case ButtonFlags.escapeKeyDefault:
        return SDL_MessageBoxButtonFlags
            .SDL_MESSAGEBOX_BUTTON_ESCAPEKEY_DEFAULT;
    }
  }
}

/// An extension for converting to an SDL flag.
extension SdlHintPriorityValues on HintPriority {
  /// Return an SDL flag.
  int toSdlFlag() {
    switch (this) {
      case HintPriority.defaultPriority:
        return SDL_HintPriority.SDL_HINT_DEFAULT;
      case HintPriority.normalPriority:
        return SDL_HintPriority.SDL_HINT_NORMAL;
      case HintPriority.overridePriority:
        return SDL_HintPriority.SDL_HINT_OVERRIDE;
    }
  }
}

/// An extension for converting to an SDL flag.
extension SdlLogPriorityValues on LogPriority {
  /// Return an SDL flag.
  int toSdlFlag() {
    switch (this) {
      case LogPriority.verbosePriority:
        return SDL_LogPriority.SDL_LOG_PRIORITY_VERBOSE;
      case LogPriority.debugPriority:
        return SDL_LogPriority.SDL_LOG_PRIORITY_DEBUG;
      case LogPriority.infoPriority:
        return SDL_LogPriority.SDL_LOG_PRIORITY_INFO;
      case LogPriority.warnPriority:
        return SDL_LogPriority.SDL_LOG_PRIORITY_WARN;
      case LogPriority.errorPriority:
        return SDL_LogPriority.SDL_LOG_PRIORITY_ERROR;
      case LogPriority.criticalPriority:
        return SDL_LogPriority.SDL_LOG_PRIORITY_CRITICAL;
    }
  }
}

/// An extension for converting to an SDL flag.
extension SdlLogCategoryValues on LogCategory {
  /// Return an SDL flag.
  int toSdlFlag() {
    switch (this) {
      case LogCategory.applicationCategory:
        return SDL_LogCategory.SDL_LOG_CATEGORY_APPLICATION;
      case LogCategory.errorCategory:
        return SDL_LogCategory.SDL_LOG_CATEGORY_ERROR;
      case LogCategory.assertCategory:
        return SDL_LogCategory.SDL_LOG_CATEGORY_ASSERT;
      case LogCategory.systemCategory:
        return SDL_LogCategory.SDL_LOG_CATEGORY_SYSTEM;
      case LogCategory.audioCategory:
        return SDL_LogCategory.SDL_LOG_CATEGORY_AUDIO;
      case LogCategory.videoCategory:
        return SDL_LogCategory.SDL_LOG_CATEGORY_VIDEO;
      case LogCategory.renderCategory:
        return SDL_LogCategory.SDL_LOG_CATEGORY_RENDER;
      case LogCategory.inputCategory:
        return SDL_LogCategory.SDL_LOG_CATEGORY_INPUT;
      case LogCategory.testCategory:
        return SDL_LogCategory.SDL_LOG_CATEGORY_TEST;
    }
  }
}

/// An extension for converting to an SDL flag.
extension SdlDollarGestureEventTypeValues on DollarGestureEventType {
  /// Return an SDL flag.
  int toSdlFlag() {
    switch (this) {
      case DollarGestureEventType.gesture:
        return SDL_EventType.SDL_DOLLARGESTURE;
      case DollarGestureEventType.record:
        return SDL_EventType.SDL_DOLLARRECORD;
    }
  }
}

/// An extension for converting to an SDL flag.
extension SdlDropEventTypeValues on DropEventType {
  /// Return an SDL flag.
  int toSdlFlag() {
    switch (this) {
      case DropEventType.file:
        return SDL_EventType.SDL_DROPFILE;
      case DropEventType.text:
        return SDL_EventType.SDL_DROPTEXT;
      case DropEventType.begin:
        return SDL_EventType.SDL_DROPBEGIN;
      case DropEventType.complete:
        return SDL_EventType.SDL_DROPCOMPLETE;
    }
  }
}

/// An extension for converting SDL flags to `dart_sdl` values.
extension DartSdlValues on int {
  /// Get a mouse wheel direction.
  MouseWheelDirection toMouseWheelDirection() {
    switch (this) {
      case SDL_MouseWheelDirection.SDL_MOUSEWHEEL_NORMAL:
        return MouseWheelDirection.normal;
      case SDL_MouseWheelDirection.SDL_MOUSEWHEEL_FLIPPED:
        return MouseWheelDirection.flipped;
      default:
        throw SdlError(this, 'Invalid mouse wheel direction.');
    }
  }

  /// Convert an integer to a log priority.
  LogPriority toLogPriority() {
    switch (this) {
      case SDL_LogPriority.SDL_LOG_PRIORITY_CRITICAL:
        return LogPriority.criticalPriority;
      case SDL_LogPriority.SDL_LOG_PRIORITY_DEBUG:
        return LogPriority.debugPriority;
      case SDL_LogPriority.SDL_LOG_PRIORITY_ERROR:
        return LogPriority.errorPriority;
      case SDL_LogPriority.SDL_LOG_PRIORITY_INFO:
        return LogPriority.infoPriority;
      case SDL_LogPriority.SDL_LOG_PRIORITY_VERBOSE:
        return LogPriority.verbosePriority;
      case SDL_LogPriority.SDL_LOG_PRIORITY_WARN:
        return LogPriority.warnPriority;
      default:
        throw SdlError(this, 'Unknown log priority.');
    }
  }

  /// Convert to a joy hat value.
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
        throw SdlError(this, 'Unknown hat value.');
    }
  }

  /// Convert to a joystick power level.
  JoystickPowerLevel toJoystickPowerLevel() {
    switch (this) {
      case SDL_JoystickPowerLevel.SDL_JOYSTICK_POWER_UNKNOWN:
        return JoystickPowerLevel.unknown;
      case SDL_JoystickPowerLevel.SDL_JOYSTICK_POWER_EMPTY:
        return JoystickPowerLevel.empty;
      case SDL_JoystickPowerLevel.SDL_JOYSTICK_POWER_LOW:
        return JoystickPowerLevel.low;
      case SDL_JoystickPowerLevel.SDL_JOYSTICK_POWER_MEDIUM:
        return JoystickPowerLevel.medium;
      case SDL_JoystickPowerLevel.SDL_JOYSTICK_POWER_FULL:
        return JoystickPowerLevel.full;
      case SDL_JoystickPowerLevel.SDL_JOYSTICK_POWER_WIRED:
        return JoystickPowerLevel.wired;
      case SDL_JoystickPowerLevel.SDL_JOYSTICK_POWER_MAX:
        return JoystickPowerLevel.max;
      default:
        throw SdlError(this, 'Unknown power level.');
    }
  }

  /// Convert to a pressed state.
  PressedState toMouseButtonPressedState() {
    switch (this) {
      case SDL_EventType.SDL_MOUSEBUTTONDOWN:
        return PressedState.pressed;
      case SDL_EventType.SDL_MOUSEBUTTONUP:
        return PressedState.released;
      default:
        throw SdlError(this, 'Unknown mouse button event type.');
    }
  }

  /// Convert [SDL_PRESSED] or [SDL_RELEASED] to a proper pressed state.
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

  /// Return a mouse button.
  MouseButton toMouseButton() {
    switch (this) {
      case SDL_BUTTON_LEFT:
        return MouseButton.left;
      case SDL_BUTTON_MIDDLE:
        return MouseButton.middle;
      case SDL_BUTTON_RIGHT:
        return MouseButton.right;
      case SDL_BUTTON_X1:
        return MouseButton.x1;
      case SDL_BUTTON_X2:
        return MouseButton.x2;
      default:
        throw SdlError(this, 'Invalid mouse button.');
    }
  }

  /// Convert to an audio status.
  AudioStatus toAudioStatus() {
    switch (this) {
      case SDL_AudioStatus.SDL_AUDIO_PAUSED:
        return AudioStatus.paused;
      case SDL_AudioStatus.SDL_AUDIO_PLAYING:
        return AudioStatus.playing;
      case SDL_AudioStatus.SDL_AUDIO_STOPPED:
        return AudioStatus.stopped;
      default:
        throw SdlError(this, 'Unknown audio status.');
    }
  }

  /// Convert to a joystick device state.
  DeviceState toJoystickDeviceState() {
    switch (this) {
      case SDL_EventType.SDL_JOYDEVICEADDED:
        return DeviceState.added;
      case SDL_EventType.SDL_JOYDEVICEREMOVED:
        return DeviceState.removed;
      default:
        throw SdlError(this, 'Unknown joystick device state.');
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

  /// Convert to a game controller axis.
  GameControllerAxis toGameControllerAxis() {
    switch (this) {
      case SDL_GameControllerAxis.SDL_CONTROLLER_AXIS_INVALID:
        return GameControllerAxis.invalid;
      case SDL_GameControllerAxis.SDL_CONTROLLER_AXIS_LEFTX:
        return GameControllerAxis.leftX;
      case SDL_GameControllerAxis.SDL_CONTROLLER_AXIS_LEFTY:
        return GameControllerAxis.leftY;
      case SDL_GameControllerAxis.SDL_CONTROLLER_AXIS_RIGHTX:
        return GameControllerAxis.rightX;
      case SDL_GameControllerAxis.SDL_CONTROLLER_AXIS_RIGHTY:
        return GameControllerAxis.rightY;
      case SDL_GameControllerAxis.SDL_CONTROLLER_AXIS_TRIGGERLEFT:
        return GameControllerAxis.triggerLeft;
      case SDL_GameControllerAxis.SDL_CONTROLLER_AXIS_TRIGGERRIGHT:
        return GameControllerAxis.triggerRight;
      case SDL_GameControllerAxis.SDL_CONTROLLER_AXIS_MAX:
        return GameControllerAxis.max;
      default:
        throw SdlError(this, 'Unknown game controller axis.');
    }
  }

  /// Convert to a game controller button.
  GameControllerButton toGameControllerButton() {
    switch (this) {
      case SDL_GameControllerButton.SDL_CONTROLLER_BUTTON_INVALID:
        return GameControllerButton.invalid;
      case SDL_GameControllerButton.SDL_CONTROLLER_BUTTON_A:
        return GameControllerButton.a;
      case SDL_GameControllerButton.SDL_CONTROLLER_BUTTON_B:
        return GameControllerButton.b;
      case SDL_GameControllerButton.SDL_CONTROLLER_BUTTON_X:
        return GameControllerButton.x;
      case SDL_GameControllerButton.SDL_CONTROLLER_BUTTON_Y:
        return GameControllerButton.y;
      case SDL_GameControllerButton.SDL_CONTROLLER_BUTTON_BACK:
        return GameControllerButton.back;
      case SDL_GameControllerButton.SDL_CONTROLLER_BUTTON_GUIDE:
        return GameControllerButton.guide;
      case SDL_GameControllerButton.SDL_CONTROLLER_BUTTON_START:
        return GameControllerButton.start;
      case SDL_GameControllerButton.SDL_CONTROLLER_BUTTON_LEFTSTICK:
        return GameControllerButton.leftStick;
      case SDL_GameControllerButton.SDL_CONTROLLER_BUTTON_RIGHTSTICK:
        return GameControllerButton.rightStick;
      case SDL_GameControllerButton.SDL_CONTROLLER_BUTTON_LEFTSHOULDER:
        return GameControllerButton.leftShoulder;
      case SDL_GameControllerButton.SDL_CONTROLLER_BUTTON_RIGHTSHOULDER:
        return GameControllerButton.rightShoulder;
      case SDL_GameControllerButton.SDL_CONTROLLER_BUTTON_DPAD_UP:
        return GameControllerButton.dpadUp;
      case SDL_GameControllerButton.SDL_CONTROLLER_BUTTON_DPAD_DOWN:
        return GameControllerButton.dpadDown;
      case SDL_GameControllerButton.SDL_CONTROLLER_BUTTON_DPAD_LEFT:
        return GameControllerButton.dpadLeft;
      case SDL_GameControllerButton.SDL_CONTROLLER_BUTTON_DPAD_RIGHT:
        return GameControllerButton.dpadRight;
      case SDL_GameControllerButton.SDL_CONTROLLER_BUTTON_MAX:
        return GameControllerButton.max;
      default:
        throw SdlError(this, 'Unknown game controller button.');
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

  /// Return a list of modifiers.
  List<KeyMod> toModifiersList() {
    final mods = <KeyMod>[];
    for (final modifier in KeyMod.values) {
      if (this & modifier.toSdlValue() != 0) {
        mods.add(modifier);
      }
    }
    return mods;
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
  int toSdlValue() {
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

/// An extension for converting to an SDL flag.
extension SdlHapticDirectionTypeValues on HapticDirectionType {
  /// Return an SDL value.
  int toSdlValue() {
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

/// An extension for converting to an SDL flag.
extension SdlHapticEffectTypeValues on HapticPeriodicType {
  /// Return an SDL value.
  int toSdlValue() {
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

/// An extension for converting to an SDL flag.
extension SdlHapticConstantEffectTypeValues on HapticConditionType {
  /// Return an SDL value.
  int toSdlValue() {
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

/// Various list methods used by this package.
extension SdlListMethods on List<int> {
  /// Iterate over every element, and xor the values.
  int xor() {
    var result = 0;
    forEach((e) => result |= e);
    return result;
  }
}
