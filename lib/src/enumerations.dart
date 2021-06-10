/// Provides various enumerations for use with SDL.

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
