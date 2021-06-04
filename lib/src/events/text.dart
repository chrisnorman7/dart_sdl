/// Provides text events.
import '../sdl.dart';
import 'base.dart';

/// Keyboard text input.
///
/// [SDL_TEXTINPUT](https://wiki.libsdl.org/SDL_TextInputEvent)
class TextInputEvent extends Event with WindowedEvent {
  /// Create an event.
  TextInputEvent(Sdl sdl, int timestamp, this.text) : super(sdl, timestamp);

  /// The text of this event.
  String text;
}

/// Keyboard text editing (composition).
///
/// [SDL_TEXTEDITING](https://wiki.libsdl.org/SDL_TextEditingEvent)
class TextEditingEvent extends TextInputEvent {
  /// Create an event.
  TextEditingEvent(
      Sdl sdl, int timestamp, int wndId, String text, this.start, this.length)
      : super(sdl, timestamp, text) {
    windowId = wndId;
  }

  /// The location where edits start.
  int start;

  /// The length of the text.
  int length;
}
