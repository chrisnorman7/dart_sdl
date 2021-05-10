/// Provides the [Button] class.
import 'enumerations.dart';
import 'sdl_bindings.dart';

/// A button for use in an SDL message box.
///
/// This is a more friendly interface to [SDL_MessageBoxButtonData].
///
/// [SDL Docs](https://wiki.libsdl.org/SDL_MessageBoxButtonData)
class Button {
  /// Create a button.
  Button(this.text, {this.id = 0, this.flags = ButtonFlags.noDefaults});

  /// Flags for this button.
  final ButtonFlags flags;

  /// The ID of this button.
  final int id;

  /// The text of this button.
  final String text;
}
