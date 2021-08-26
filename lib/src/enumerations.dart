/// Provides various enumerations for use with SDL.
import 'events/drop.dart';
import 'events/gestures.dart';
import 'events/touch_finger.dart';
import 'haptic/haptic.dart';

/// Hint priorities.
///
/// [SDL Docs](https://wiki.libsdl.org/SDL_HintPriority)
enum HintPriority {
  /// low priority, used for default values
  defaultPriority,

  /// medium priority
  normalPriority,

  /// high priority
  overridePriority,
}

/// Log categories.
///
/// [SDL Docs](https://wiki.libsdl.org/SDL_LOG_CATEGORY)
enum LogCategory {
  /// application log
  applicationCategory,

  /// error log
  errorCategory,

  /// assert log
  assertCategory,

  /// system log
  systemCategory,

  /// audio log
  audioCategory,

  /// video log
  videoCategory,

  /// render log
  renderCategory,

  /// input log
  inputCategory,

  /// test log
  testCategory,
}

/// Log priorities.
///
/// [SDL Docs](https://wiki.libsdl.org/SDL_LogPriority)
enum LogPriority {
  /// Verbose
  verbosePriority,

  /// Debug
  debugPriority,

  /// Info
  infoPriority,

  /// Warnings
  warnPriority,

  /// Errors
  errorPriority,

  /// Critical
  criticalPriority,
}

/// Blend mode.
///
/// [SDL Docs](https://wiki.libsdl.org/SDL_BlendMode)
enum BlendMode {
  /// no blending
  ///
  /// dstRGBA = srcRGBA
  /// none,
  /// alpha blending
  ///
  /// dstRGB = (srcRGB * srcA) + (dstRGB * (1-srcA))
  ///
  /// dstA = srcA + (dstA * (1-srcA))
  blend,

  /// additive blending
  ///
  /// dstRGB = (srcRGB * srcA) + dstRGB
  ///
  /// dstA = dstA
  add,

  /// color modulate
  ///
  /// dstRGB = srcRGB * dstRGB
  ///
  /// dstA = dstA
  mod,
}

/// Button flags.
///
/// [SDL Docs](https://wiki.libsdl.org/SDL_MessageBoxButtonFlags)
enum ButtonFlags {
  /// no flags
  noDefaults,

  /// marks the default button when return is hit
  returnKeyDefault,

  /// marks the default button when escape is hit
  escapeKeyDefault,
}

/// Message box flags.
///
/// [SDL Docs](https://wiki.libsdl.org/SDL_MessageBoxFlags)
enum MessageBoxFlags {
  /// error dialog
  ///error,
  /// warning dialog
  warning,

  /// informational dialog
  information,
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

/// Audio status.
///
/// [SDL Docs](https://wiki.libsdl.org/SDL_AudioStatus)
enum AudioStatus {
  /// Audio device is stopped.
  stopped,

  /// Audio device is playing.
  playing,

  /// Audio device is paused.
  paused,
}

/// The state of a key or button.
enum PressedState {
  /// Key is pressed.
  pressed,

  /// Key is released.
  released,
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

/// Which mouse button was pressed.
enum MouseButton {
  /// Left mouse button,
  left,

  /// Middle mouse button.
  middle,

  /// Right mouse button.
  right,

  /// X1 mouse button.
  x1,

  /// X2 mouse button.
  x2,
}

/// The direction of a mouse wheel event.
enum MouseWheelDirection {
  /// Normal.
  normal,

  /// Flipped.
  flipped,
}

/// The various positions possible with joystick hats.
enum JoyHatValue {
  /// SDL_HAT_LEFTUP
  leftUp,

  /// SDL_HAT_UP
  up,

  /// SDL_HAT_RIGHTUP
  rightUp,

  /// SDL_HAT_LEFT
  left,

  /// SDL_HAT_CENTERED
  centered,

  /// SDL_HAT_RIGHT
  right,

  /// SDL_HAT_LEFTDOWN
  leftDown,

  /// SDL_HAT_DOWN
  down,

  /// SDL_HAT_RIGHTDOWN
  rightDown,
}

/// The possible power levels of a joystick.
///
/// [SDL Docs](https://wiki.libsdl.org/SDL_JoystickPowerLevel)
enum JoystickPowerLevel {
  /// SDL_JOYSTICK_POWER_UNKNOWN
  unknown,

  /// SDL_JOYSTICK_POWER_EMPTY
  empty,

  /// SDL_JOYSTICK_POWER_LOW
  low,

  /// SDL_JOYSTICK_POWER_MEDIUM
  medium,

  /// SDL_JOYSTICK_POWER_FULL
  full,

  /// SDL_JOYSTICK_POWER_WIRED
  wired,

  /// SDL_JOYSTICK_POWER_MAX
  max,
}

/// An enumeration of axes available from a controller.
///
/// [SDL Docs](https://wiki.libsdl.org/SDL_GameControllerAxis)
enum GameControllerAxis {
  /// SDL_CONTROLLER_AXIS_INVALID
  invalid,

  /// SDL_CONTROLLER_AXIS_LEFTX
  leftX,

  /// SDL_CONTROLLER_AXIS_LEFTY
  leftY,

  /// SDL_CONTROLLER_AXIS_RIGHTX
  rightX,

  /// SDL_CONTROLLER_AXIS_RIGHTY
  rightY,

  /// SDL_CONTROLLER_AXIS_TRIGGERLEFT
  triggerLeft,

  /// SDL_CONTROLLER_AXIS_TRIGGERRIGHT
  triggerRight,

  /// SDL_CONTROLLER_AXIS_MAX
  max
}

/// An enumeration of buttons available from a controller.
///
/// [SDL Docs](https://wiki.libsdl.org/SDL_GameControllerButton)
enum GameControllerButton {
  /// SDL_CONTROLLER_BUTTON_INVALID
  invalid,

  /// SDL_CONTROLLER_BUTTON_A
  a,

  /// SDL_CONTROLLER_BUTTON_B
  b,

  /// SDL_CONTROLLER_BUTTON_X
  x,

  /// SDL_CONTROLLER_BUTTON_Y
  y,

  /// SDL_CONTROLLER_BUTTON_BACK
  back,

  /// SDL_CONTROLLER_BUTTON_GUIDE
  guide,

  /// SDL_CONTROLLER_BUTTON_START
  start,

  /// SDL_CONTROLLER_BUTTON_LEFTSTICK
  leftStick,

  /// SDL_CONTROLLER_BUTTON_RIGHTSTICK
  rightStick,

  /// SDL_CONTROLLER_BUTTON_LEFTSHOULDER
  leftShoulder,

  /// SDL_CONTROLLER_BUTTON_RIGHTSHOULDER
  rightShoulder,

  /// SDL_CONTROLLER_BUTTON_DPAD_UP
  dpadUp,

  /// SDL_CONTROLLER_BUTTON_DPAD_DOWN
  dpadDown,

  /// SDL_CONTROLLER_BUTTON_DPAD_LEFT
  dpadLeft,

  /// SDL_CONTROLLER_BUTTON_DPAD_RIGHT
  dpadRight,

  /// SDL_CONTROLLER_BUTTON_MAX
  max,
}

/// The type of a [TouchFingerEvent].
enum TouchFingerEventType {
  /// SDL_FINGERMOTION
  motion,

  /// SDL_FINGERDOWN
  down,

  /// SDL_FINGERUP
  up,
}

/// The type of a [DollarGestureEvent].
enum DollarGestureEventType {
  /// SDL_DOLLARGESTURE
  gesture,

  /// SDL_DOLLARRECORD
  record,
}

/// The type of a [DropEvent].
enum DropEventType {
  /// SDL_DROPFILE
  file,

  /// SDL_DROPTEXT
  text,

  /// SDL_DROPBEGIN
  begin,

  /// SDL_DROPCOMPLETE
  complete,
}

/// An enumeration of key modifier masks.
///
/// [SDL Docs](https://wiki.libsdl.org/SDL_Keymod)
enum KeyMod {
  /// 0 (no modifier is applicable)
  none,

  /// the left Shift key is down
  lShift,

  /// the right Shift key is down
  rShift,

  /// the left Ctrl (Control) key is down
  lCtrl,

  /// the right Ctrl (Control) key is down
  rCtrl,

  /// the left Alt key is down
  lAlt,

  /// the right Alt key is down
  rAlt,

  /// the left GUI key (often the Windows key) is down
  lGui,

  /// the right GUI key (often the Windows key) is down
  rGui,

  /// the Num Lock key (may be located on an extended keypad) is down
  num,

  /// the Caps Lock key is down
  caps,

  /// the !AltGr key is down
  mode,

  /// [lCtrl] || [rCtrl]
  ctrl,

  /// [lShift] || [rShift]
  shift,

  /// [lAlt] || [rAlt]
  alt,

  /// [lGui] || [rGui]
  gui,

  /// reserved for future use
  reserved,
}

/// Haptic directions.
///
/// The page in the link below is not for an enumeration, but the values of
/// this enum are taken from constants mentioned by that page.
///
/// [SDL Docs](https://wiki.libsdl.org/SDL_HapticDirection)
enum HapticDirectionType {
  /// SDL_HAPTIC_POLAR
  polar,

  /// SDL_HAPTIC_CARTESIAN
  cartesian,

  /// SDL_HAPTIC_SPHERICAL
  spherical,
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

/// The possible features of a [Haptic] device.
///
/// I have included all the constants I could find, since
/// [SDL_HapticQuery](https://wiki.libsdl.org/SDL_HapticQuery) isn't very
/// forthcoming about which values will be supported, and the code sample only
/// uses [constant].
enum HapticFeature {
  /// SDL_HAPTIC_CONSTANT
  constant,

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

  /// SDL_HAPTIC_RAMP
  ramp,

  /// SDL_HAPTIC_SPRING
  spring,

  /// SDL_HAPTIC_DAMPER
  damper,

  /// SDL_HAPTIC_INERTIA
  inertia,

  /// SDL_HAPTIC_FRICTION
  friction,

  /// SDL_HAPTIC_CUSTOM
  custom,

  /// SDL_HAPTIC_GAIN
  gain,

  /// SDL_HAPTIC_AUTOCENTER
  autocenter,

  /// SDL_HAPTIC_STATUS = 16384;
  status,

  /// SDL_HAPTIC_PAUSE
  pause,
}
