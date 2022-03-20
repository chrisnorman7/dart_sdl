/// Provides Android, iOS and WinRT events.
import '../sdl.dart';
import 'base.dart';

/// The OS is terminating the application.
class AppTerminatingEvent extends Event {
  /// Create the event.
  const AppTerminatingEvent(Sdl sdl, int timestamp) : super(sdl, timestamp);
}

/// The OS is low on memory.
class AppLowMemoryEvent extends Event {
  /// Create an event.
  const AppLowMemoryEvent(Sdl sdl, int timestamp) : super(sdl, timestamp);
}

/// The application is entering background.
class AppWillEnterBackgroundEvent extends Event {
  /// Create an event.
  const AppWillEnterBackgroundEvent(Sdl sdl, int timestamp)
      : super(sdl, timestamp);
}

/// The application entered background.
class AppDidEnterBackgroundEvent extends Event {
  /// Create an event.
  const AppDidEnterBackgroundEvent(Sdl sdl, int timestamp)
      : super(sdl, timestamp);
}

/// The application is entering foreground.
class AppWillEnterForegroundEvent extends Event {
  /// Create an event.
  const AppWillEnterForegroundEvent(Sdl sdl, int timestamp)
      : super(sdl, timestamp);
}

/// The application entered foreground.
class AppDidEnterForegroundEvent extends Event {
  /// Create an event.
  const AppDidEnterForegroundEvent(Sdl sdl, int timestamp)
      : super(sdl, timestamp);
}
