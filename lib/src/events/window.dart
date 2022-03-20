/// Provides window events.
import 'dart:ffi';
import 'dart:math';

import '../sdl.dart';
import '../sdl_bindings.dart';
import '../window.dart';
import 'base.dart';

/// A window state change.
///
/// [SDL_WINDOWEVENT](https://wiki.libsdl.org/SDL_WindowEvent)
///
/// There should be subclasses for each member of
/// [SDL_WindowEventId](https://wiki.libsdl.org/SDL_WindowEventID).
class WindowEvent extends Event {
  /// Create the event.
  const WindowEvent(Sdl sdl, int timestamp, this.windowId)
      : super(sdl, timestamp);

  /// The ID of the window which emitted this event.
  final int windowId;

  /// Get the window which emitted this event.
  Window? get window => Window.fromId(sdl, windowId);
}

/// A window has been shown.
class WindowShownEvent extends WindowEvent {
  /// Create an event.
  const WindowShownEvent(Sdl sdl, int timestamp, int windowId)
      : super(sdl, timestamp, windowId);
}

/// A window has been hidden.
class WindowHiddenEvent extends WindowEvent {
  /// Create an event.
  const WindowHiddenEvent(Sdl sdl, int timestamp, int windowId)
      : super(sdl, timestamp, windowId);
}

/// A window has been exposed and should be redrawn.
class WindowExposedEvent extends WindowEvent {
  /// Create a new event.
  const WindowExposedEvent(Sdl sdl, int timestamp, int windowId)
      : super(sdl, timestamp, windowId);
}

/// A window has been moved.
class WindowMovedEvent extends WindowEvent {
  /// Create a new event.
  const WindowMovedEvent(Sdl sdl, int timestamp, int windowId, this.position)
      : super(sdl, timestamp, windowId);

  /// The new position of the window.
  final Point<int> position;
}

/// A window has been resized.
class WindowResizedEvent extends WindowEvent {
  /// Create a new event.
  const WindowResizedEvent(Sdl sdl, int timestamp, int windowId, this.size)
      : super(sdl, timestamp, windowId);

  /// The new size of the window.
  final WindowSize size;
}

/// The size of a window has changed.
class WindowSizeChangedEvent extends WindowEvent {
  /// Create a new event.
  const WindowSizeChangedEvent(Sdl sdl, int timestamp, int windowId)
      : super(sdl, timestamp, windowId);
}

/// A window has been minimised.
class WindowMinimizedEvent extends WindowEvent {
  /// Create a new event.
  const WindowMinimizedEvent(Sdl sdl, int timestamp, int windowId)
      : super(sdl, timestamp, windowId);
}

/// A window has been maximised.
class WindowMaximizedEvent extends WindowEvent {
  /// Create a new event.
  const WindowMaximizedEvent(Sdl sdl, int timestamp, int windowId)
      : super(sdl, timestamp, windowId);
}

/// A window has been restored.
class WindowRestoredEvent extends WindowEvent {
  /// Create a new event.
  const WindowRestoredEvent(Sdl sdl, int timestamp, int windowId)
      : super(sdl, timestamp, windowId);
}

/// A window has gained focus.
class WindowEnterEvent extends WindowEvent {
  /// Create a new event.
  const WindowEnterEvent(Sdl sdl, int timestamp, int windowId)
      : super(sdl, timestamp, windowId);
}

/// A window has lost mouse focus.
class WindowLeaveEvent extends WindowEvent {
  /// Create a new event.
  const WindowLeaveEvent(Sdl sdl, int timestamp, int windowId)
      : super(sdl, timestamp, windowId);
}

/// A window has gained keyboard focus.
class WindowFocusGainedEvent extends WindowEvent {
  /// Create a new event.
  const WindowFocusGainedEvent(Sdl sdl, int timestamp, int windowId)
      : super(sdl, timestamp, windowId);
}

/// A window has lost keyboard focus.
class WindowFocusLostEvent extends WindowEvent {
  /// Create a new event.
  const WindowFocusLostEvent(Sdl sdl, int timestamp, int windowId)
      : super(sdl, timestamp, windowId);
}

/// The window manager requests that the window be closed.
class WindowClosedEvent extends WindowEvent {
  /// Create a new event.
  const WindowClosedEvent(Sdl sdl, int timestamp, int windowId)
      : super(sdl, timestamp, windowId);
}

/// A window is being offered focus.
class WindowTakeFocusEvent extends WindowEvent {
  /// Create a new event.
  const WindowTakeFocusEvent(Sdl sdl, int timestamp, int windowId)
      : super(sdl, timestamp, windowId);
}

/// A window had an abnormal hit test.
class WindowHitTestEvent extends WindowEvent {
  /// Create a new event.
  const WindowHitTestEvent(Sdl sdl, int timestamp, int windowId)
      : super(sdl, timestamp, windowId);
}

/// SDL_WINDOWEVENT_ICCPROF_CHANGED.
class IccprofChangedEvent extends WindowEvent {
  /// Create an instance.
  const IccprofChangedEvent(Sdl sdl, int timestamp, int windowId)
      : super(sdl, timestamp, windowId);
}

/// SDL_WINDOWEVENT_DISPLAY_CHANGED.
class DisplayChangedEvent extends WindowEvent {
  /// Create an instance.
  const DisplayChangedEvent(
      Sdl sdl, int timestamp, int windowId, this.displayId)
      : super(sdl, timestamp, windowId);

  /// The ID of the new display (presumably).
  final int displayId;
}

/// A system specific event.
///
/// [SDL_SYSWMEVENT](https://wiki.libsdl.org/SDL_SysWMEvent)
class SysWmEvent extends Event {
  /// Create an event.
  const SysWmEvent(Sdl sdl, int timestamp, this.msg) : super(sdl, timestamp);

  /// Some platform-dependant data.
  final Pointer<SDL_SysWMmsg> msg;
}
