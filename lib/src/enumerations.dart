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
