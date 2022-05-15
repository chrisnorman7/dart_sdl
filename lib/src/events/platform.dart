/// Provides Android, iOS and WinRT events.
import 'base.dart';

/// The OS is terminating the application.
class AppTerminatingEvent extends Event {
  /// Create the event.
  const AppTerminatingEvent(super.sdl, super.timestamp);
}

/// The OS is low on memory.
class AppLowMemoryEvent extends Event {
  /// Create an event.
  const AppLowMemoryEvent(super.sdl, super.timestamp);
}

/// The application is entering background.
class AppWillEnterBackgroundEvent extends Event {
  /// Create an event.
  const AppWillEnterBackgroundEvent(super.sdl, super.timestamp);
}

/// The application entered background.
class AppDidEnterBackgroundEvent extends Event {
  /// Create an event.
  const AppDidEnterBackgroundEvent(super.sdl, super.timestamp);
}

/// The application is entering foreground.
class AppWillEnterForegroundEvent extends Event {
  /// Create an event.
  const AppWillEnterForegroundEvent(super.sdl, super.timestamp);
}

/// The application entered foreground.
class AppDidEnterForegroundEvent extends Event {
  /// Create an event.
  const AppDidEnterForegroundEvent(super.sdl, super.timestamp);
}
