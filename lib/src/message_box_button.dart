/// Provides the [MessageBoxButton] class.
import 'enumerations.dart';
import 'sdl_bindings.dart';

/// A button for use in an SDL message box.
///
/// This is a more friendly interface to [SDL_MessageBoxButtonData].
///
/// [SDL Docs](https://wiki.libsdl.org/SDL_MessageBoxButtonData)
class MessageBoxButton {
  /// Create a button.
  MessageBoxButton(this.text, {this.id = 0, List<MessageBoxButtonFlags>? flags})
      : flags = flags ?? [];

  /// Flags for this button.
  final List<MessageBoxButtonFlags> flags;

  /// The ID of this button.
  final int id;

  /// The text of this button.
  final String text;
}
