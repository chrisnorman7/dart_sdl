/// Keyboard events:
import '../extensions.dart';
import '../keycodes.dart';
import '../modifiers.dart';
import '../sdl.dart';
import '../sdl_bindings.dart';
import 'base.dart';

/// A keyboard key.
class KeyboardKey {
  /// Create a key.
  const KeyboardKey(
      {required this.scancode, required this.keycode, required this.modifiers});

  /// The scancode for this key.
  final ScanCode scancode;

  /// The keycode of the key.
  final KeyCode keycode;

  /// All pressed modifiers.
  final Set<KeyMod> modifiers;
}

/// A keyboard event.
///
/// [SDL Docs](https://wiki.libsdl.org/SDL_KeyboardEvent)
class KeyboardEvent extends Event with WindowMixin {
  /// Create an event.
  KeyboardEvent(
      Sdl sdl, int timestamp, int wndId, this.state, this.repeat, this.key)
      : super(sdl, timestamp) {
    windowId = wndId;
  }

  /// Create an instance from an SDL event.
  factory KeyboardEvent.fromSdlEvent(Sdl sdl, SDL_KeyboardEvent event) {
    final sim = event.keysym;
    final key = KeyboardKey(
        scancode: sim.scancode.toScanCode(),
        keycode: sim.sym.toKeyCode(),
        modifiers: sim.mod.toModifiersSet());
    return KeyboardEvent(sdl, event.timestamp, event.windowID,
        event.state.toPressedState(), sdl.getBool(event.repeat), key);
  }

  /// Whether [key] has been pressed or released.
  final PressedState state;

  /// Whether or not this event is a repeat.
  final bool repeat;

  /// The keyboard key that was pressed or released.
  final KeyboardKey key;
}

/// The keymap changed due to a system event such as an input language or
/// keyboard layout change (>= SDL 2.0.4).
class KeymapChangedEvent extends Event {
  /// Create an event.
  const KeymapChangedEvent(Sdl sdl, int timestamp) : super(sdl, timestamp);
}
