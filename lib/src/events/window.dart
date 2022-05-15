/// Provides window events.
import 'dart:ffi';
import 'dart:math';

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
  const WindowEvent(super.sdl, super.timestamp, this.windowId);

  /// The ID of the window which emitted this event.
  final int windowId;

  /// Get the window which emitted this event.
  Window? get window => Window.fromId(sdl, windowId);
}

/// A window has been shown.
class WindowShownEvent extends WindowEvent {
  /// Create an event.
  const WindowShownEvent(super.sdl, super.timestamp, super.windowId);
}

/// A window has been hidden.
class WindowHiddenEvent extends WindowEvent {
  /// Create an event.
  const WindowHiddenEvent(
    super.sdl,
    super.timestamp,
    super.windowId,
  );
}

/// A window has been exposed and should be redrawn.
class WindowExposedEvent extends WindowEvent {
  /// Create a new event.
  const WindowExposedEvent(
    super.sdl,
    super.timestamp,
    super.windowId,
  );
}

/// A window has been moved.
class WindowMovedEvent extends WindowEvent {
  /// Create a new event.
  const WindowMovedEvent(
    super.sdl,
    super.timestamp,
    super.windowId,
    this.position,
  );

  /// The new position of the window.
  final Point<int> position;
}

/// A window has been resized.
class WindowResizedEvent extends WindowEvent {
  /// Create a new event.
  const WindowResizedEvent(
    super.sdl,
    super.timestamp,
    super.windowId,
    this.size,
  );

  /// The new size of the window.
  final WindowSize size;
}

/// The size of a window has changed.
class WindowSizeChangedEvent extends WindowEvent {
  /// Create a new event.
  const WindowSizeChangedEvent(
    super.sdl,
    super.timestamp,
    super.windowId,
  );
}

/// A window has been minimised.
class WindowMinimizedEvent extends WindowEvent {
  /// Create a new event.
  const WindowMinimizedEvent(
    super.sdl,
    super.timestamp,
    super.windowId,
  );
}

/// A window has been maximised.
class WindowMaximizedEvent extends WindowEvent {
  /// Create a new event.
  const WindowMaximizedEvent(
    super.sdl,
    super.timestamp,
    super.windowId,
  );
}

/// A window has been restored.
class WindowRestoredEvent extends WindowEvent {
  /// Create a new event.
  const WindowRestoredEvent(
    super.sdl,
    super.timestamp,
    super.windowId,
  );
}

/// A window has gained focus.
class WindowEnterEvent extends WindowEvent {
  /// Create a new event.
  const WindowEnterEvent(super.sdl, super.timestamp, super.windowId);
}

/// A window has lost mouse focus.
class WindowLeaveEvent extends WindowEvent {
  /// Create a new event.
  const WindowLeaveEvent(super.sdl, super.timestamp, super.windowId);
}

/// A window has gained keyboard focus.
class WindowFocusGainedEvent extends WindowEvent {
  /// Create a new event.
  const WindowFocusGainedEvent(
    super.sdl,
    super.timestamp,
    super.windowId,
  );
}

/// A window has lost keyboard focus.
class WindowFocusLostEvent extends WindowEvent {
  /// Create a new event.
  const WindowFocusLostEvent(
    super.sdl,
    super.timestamp,
    super.windowId,
  );
}

/// The window manager requests that the window be closed.
class WindowClosedEvent extends WindowEvent {
  /// Create a new event.
  const WindowClosedEvent(
    super.sdl,
    super.timestamp,
    super.windowId,
  );
}

/// A window is being offered focus.
class WindowTakeFocusEvent extends WindowEvent {
  /// Create a new event.
  const WindowTakeFocusEvent(
    super.sdl,
    super.timestamp,
    super.windowId,
  );
}

/// A window had an abnormal hit test.
class WindowHitTestEvent extends WindowEvent {
  /// Create a new event.
  const WindowHitTestEvent(
    super.sdl,
    super.timestamp,
    super.windowId,
  );
}

/// SDL_WINDOWEVENT_ICCPROF_CHANGED.
class IccprofChangedEvent extends WindowEvent {
  /// Create an instance.
  const IccprofChangedEvent(
    super.sdl,
    super.timestamp,
    super.windowId,
  );
}

/// SDL_WINDOWEVENT_DISPLAY_CHANGED.
class DisplayChangedEvent extends WindowEvent {
  /// Create an instance.
  const DisplayChangedEvent(
    super.sdl,
    super.timestamp,
    super.windowId,
    this.displayId,
  );

  /// The ID of the new display (presumably).
  final int displayId;
}

/// A system specific event.
///
/// [SDL_SYSWMEVENT](https://wiki.libsdl.org/SDL_SysWMEvent)
class SysWmEvent extends Event {
  /// Create an event.
  const SysWmEvent(super.sdl, super.timestamp, this.msg);

  /// Some platform-dependant data.
  final Pointer<SDL_SysWMmsg> msg;
}
