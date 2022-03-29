/// Provides text events.
import '../sdl.dart';
import 'base.dart';

/// Keyboard text input.
///
/// [SDL_TEXTINPUT](https://wiki.libsdl.org/SDL_TextInputEvent)
class TextInputEvent extends Event with WindowMixin {
  /// Create an event.
  TextInputEvent(Sdl sdl, int timestamp, this.text) : super(sdl, timestamp);

  /// The text of this event.
  String text;
}

/// Keyboard text editing (composition).
///
/// [SDL_TEXTEDITING](https://wiki.libsdl.org/SDL_TextEditingEvent)
class TextEditingEvent extends Event with WindowMixin {
  /// Create an event.
  TextEditingEvent(
      {required Sdl sdl,
      required int timestamp,
      required int wndId,
      required this.text,
      required this.start,
      required this.length})
      : super(sdl, timestamp) {
    windowId = wndId;
  }

  /// The text of the event.
  final String text;

  /// The location where edits start.
  int start;

  /// The length of the text.
  int length;
}
