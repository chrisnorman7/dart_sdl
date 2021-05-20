/// Provides various enumerations for use with SDL.
import 'sdl.dart';

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

/// The type of a keyboard event.
enum KeyboardEventType {
  /// A key up event.
  up,

  /// A key down event.
  down,
}

/// The state of a key.
enum KeyState {
  /// Key is pressed.
  pressed,

  /// Key is released.
  released,
}

/// The types of SDL events that can be emitted.
enum EventType {
  /// Mouse events:

  /// The mouse moved.
  ///
  /// [SDL_MOUSEMOTION](https://wiki.libsdl.org/SDL_MouseMotionEvent)
  mouseMotion,

  /// A mouse button was pressed.
  ///
  /// [SDL_MOUSEBUTTONDOWN](https://wiki.libsdl.org/SDL_MouseButtonEvent)
  mouseButtonDown,

  /// A mouse button was released.
  ///
  /// [SDL_MOUSEBUTTONUP](https://wiki.libsdl.org/SDL_MouseButtonEvent)
  mouseButtonUp,

  /// Mouse wheel motion.
  ///
  /// [SDL_MOUSEWHEEL](https://wiki.libsdl.org/SDL_MouseWheelEvent)
  mouseWheel,

  /// Joystick events:

  /// Joystick axis motion.
  ///
  /// [SDL_JOYAXISMOTION](https://wiki.libsdl.org/SDL_JoyAxisEvent)
  joyAxisMotion,

  /// Joystick trackball motion.
  ///
  /// [SDL_JOYBALLMOTION](https://wiki.libsdl.org/SDL_JoyBallEvent)
  joyBallMotion,

  /// Joystick hat position changed.
  ///
  /// [SDL_JOYHATMOTION](https://wiki.libsdl.org/SDL_JoyHatEvent)
  joyHatMotion,

  /// A joystick button was pressed.
  ///
  /// [SDL_JOYBUTTONDOWN](https://wiki.libsdl.org/SDL_JoyButtonEvent)
  joyButtonDown,

  /// A joystick button was released.
  ///
  /// [SDL_JOYBUTTONUP](https://wiki.libsdl.org/SDL_JoyButtonEvent)
  joyButtonUp,

  /// A joystick device was connected.
  ///
  /// [SDL_JOYDEVICEADDED](https://wiki.libsdl.org/SDL_JoyDeviceEvent)
  joyDeviceAdded,

  /// A joystick device was disconnected.
  ///
  /// [SDL_JOYDEVICEREMOVED](https://wiki.libsdl.org/SDL_JoyDeviceEvent)
  joyDeviceRemoved,

  /// Controller events:

  /// Controller axis motion.
  ///
  /// [SDL_CONTROLLERAXISMOTION](https://wiki.libsdl.org/SDL_ControllerAxisEvent)
  controllerAxisMotion,

  /// A controller button was pressed.
  ///
  /// [SDL_CONTROLLERBUTTONDOWN](https://wiki.libsdl.org/SDL_ControllerButtonEvent)
  controllerButtonDown,

  /// A controller button was released.
  ///
  /// [SDL_CONTROLLERBUTTONUP](https://wiki.libsdl.org/SDL_ControllerButtonEvent)
  controllerButtonUp,

  /// A controller was connected.
  ///
  /// [SDL_CONTROLLERDEVICEADDED](https://wiki.libsdl.org/SDL_ControllerDeviceEvent)
  controllerDeviceAdded,

  /// A controller was removed.
  ///
  /// [SDL_CONTROLLERDEVICEREMOVED](https://wiki.libsdl.org/SDL_ControllerDeviceEvent)
  controllerDeviceRemoved,

  /// A controller mapping was updated.
  ///
  /// [SDL_CONTROLLERDEVICEREMAPPED](https://wiki.libsdl.org/SDL_ControllerDeviceEvent)
  controllerDeviceRemapped,

  /// Touch events:

  /// The user has touched an input device.
  ///
  /// [SDL_FINGERDOWN](https://wiki.libsdl.org/SDL_TouchFingerEvent)
  fingerDown,

  /// The user stopped touching an input device.
  ///
  /// [SDL_FINGERUP](https://wiki.libsdl.org/SDL_TouchFingerEvent)
  fingerUp,

  /// The user is dragging finger on an input device.
  ///
  /// [SDL_FINGERMOTION](https://wiki.libsdl.org/SDL_TouchFingerEvent)
  fingerMotion,

  /// Gesture events:

  /// [SDL_DOLLARGESTURE](https://wiki.libsdl.org/SDL_DollarGestureEvent)
  dollarGesture,

  /// [SDL_DOLLARRECORD](https://wiki.libsdl.org/SDL_DollarGestureEvent)
  dollarRecord,

  /// [SDL_MULTIGESTURE](https://wiki.libsdl.org/SDL_MultiGestureEvent)
  multiGesture,

  /// Clipboard events

  /// The clipboard changed.
  clipboardUpdate,

  /// Drag and drop events:

  /// The system requests a file open.
  ///
  /// [SDL_DROPFILE](https://wiki.libsdl.org/SDL_DropEvent)
  dropFile,

  /// Text/plain drag-and-drop event.
  ///
  /// [SDL_DROPTEXT](https://wiki.libsdl.org/SDL_DropEvent)
  dropText,

  /// A new set of drops is beginning (>= SDL 2.0.5).
  ///
  /// [SDL_DROPBEGIN](https://wiki.libsdl.org/SDL_DropEvent)
  dropBegin,

  /// The current set of drops are now complete (>= SDL 2.0.5).
  ///
  /// [SDL_DROPCOMPLETE](https://wiki.libsdl.org/SDL_DropEvent)
  dropComplete,

  /// Audio hotplug events:

  /// A new audio device is available (>= SDL 2.0.4).
  ///
  /// [SDL_AUDIODEVICEADDED](https://wiki.libsdl.org/SDL_AudioDeviceEvent)
  audioDeviceAdded,

  /// An audio device has been removed (>= SDL 2.0.4).
  ///
  /// [SDL_AUDIODEVICEREMOVED](https://wiki.libsdl.org/SDL_AudioDeviceEvent)
  audioDeviceRemoved,

  /// Render events:

  /// The render targets have been reset and their contents need to be updated
  /// (>= SDL 2.0.2).
  renderTargetsReset,

  /// The device has been reset and all textures need to be recreated (>= SDL
  /// 2.0.4).
  renderDeviceReset,

  /// These are for your use, and should be allocated with
  /// [Sdl.registerEvents].

  /// A user-specified event.
  userEvent,

  /// Used only for bounding internal arrays.
  lastEvent,
}
