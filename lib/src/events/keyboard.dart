/// Keyboard events:
import '../enumerations.dart';
import '../sdl.dart';
import '../sdl_bindings.dart';
import '../window.dart';
import 'base.dart';

/// A keyboard key.
class KeyboardKey {
  /// Create a key.
  KeyboardKey(this.scancode, this.keycode, this.modifiers);

  /// The scancode for this key.
  final int scancode;

  /// The keycode of the key.
  final int keycode;

  /// All pressed modifiers.
  final int modifiers;

  /// Whether or not the left shift key is down.
  bool get lShift => modifiers & SDL_Keymod.KMOD_LSHIFT != 0;

  /// Whether or not the right shift key is down.
  bool get rShift => modifiers & SDL_Keymod.KMOD_RSHIFT != 0;

  /// Whether or not the left control key is down.
  bool get lCtrl => modifiers & SDL_Keymod.KMOD_LCTRL != 0;

  /// Whether or not the right control key is down.
  bool get rCtrl => modifiers & SDL_Keymod.KMOD_RCTRL != 0;

  /// Whether or not the left alt key is down.
  bool get lAlt => modifiers & SDL_Keymod.KMOD_LALT != 0;

  /// Whether or not the right alt key is down.
  bool get rAlt => modifiers & SDL_Keymod.KMOD_RALT != 0;

  /// Whether or not the left GUI key is down.
  bool get lGui => modifiers & SDL_Keymod.KMOD_LGUI != 0;

  /// Whether or not the right alt key is down.
  bool get rGui => modifiers & SDL_Keymod.KMOD_RGUI != 0;

  /// Whether or not the number lock is on or off.
  bool get numlock => modifiers & SDL_Keymod.KMOD_NUM != 0;

  /// Whether or not the capslock is on or off.
  bool get capslock => modifiers & SDL_Keymod.KMOD_CAPS != 0;

  /// Whether or not the Alt GR key is down.
  bool get altGr => modifiers & SDL_Keymod.KMOD_MODE != 0;

  /// Whether or not either control key is down.
  bool get ctrl => modifiers & SDL_Keymod.KMOD_CTRL != 0;

  /// Whether or not either shift key is down.
  bool get shift => modifiers & SDL_Keymod.KMOD_SHIFT != 0;

  /// Whether or not either alt key is down.
  bool get alt => modifiers & SDL_Keymod.KMOD_ALT != 0;

  /// Whether or not either GUI key is down.
  bool get gui => modifiers & SDL_Keymod.KMOD_GUI != 0;
}

/// A generic keyboard event.
class KeyboardEvent extends Event {
  /// Create an event.
  KeyboardEvent(Sdl sdl, int timestamp, this.type, this.windowId, this.state,
      this.repeat, this.key)
      : super(sdl, timestamp);

  /// Create an instance from an SDL event.
  factory KeyboardEvent.fromSdlEvent(Sdl sdl, SDL_KeyboardEvent event) {
    final sim = event.keysym;
    final key = KeyboardKey(sim.scancode, sim.sym, sim.mod);
    if (event.type == SDL_EventType.SDL_KEYDOWN) {
      return KeyDownEvent(
          sdl,
          event.timestamp,
          event.windowID,
          event.state == SDL_PRESSED ? KeyState.pressed : KeyState.released,
          event.repeat,
          key);
    } else {
      return KeyUpEvent(
          sdl,
          event.timestamp,
          event.windowID,
          event.state == SDL_PRESSED ? KeyState.pressed : KeyState.released,
          event.repeat,
          key);
    }
  }

  /// The type of this event.
  KeyboardEventType type;

  /// The ID of the window that emitted this event.
  final int windowId;

  /// The window that emitted this event.
  Window? get window => sdl.windows[windowId];

  /// Whether [key] is pressed or released.
  final KeyState state;

  /// Non-0 if this is a repeated key.
  final int repeat;

  /// The keyboard key that was pressed or released.
  final KeyboardKey key;
}

/// A key was pressed.
///
/// [SDL_KEYDOWN](https://wiki.libsdl.org/SDL_KeyboardEvent)
class KeyDownEvent extends KeyboardEvent {
  /// Create an event.
  KeyDownEvent(Sdl sdl, int timestamp, int windowId, KeyState state, int repeat,
      KeyboardKey key)
      : super(sdl, timestamp, KeyboardEventType.down, windowId, state, repeat,
            key);
}

/// A key was released.
///
/// [SDL_KEYUP](https://wiki.libsdl.org/SDL_KeyboardEvent)
class KeyUpEvent extends KeyboardEvent {
  /// Create an event.
  KeyUpEvent(Sdl sdl, int timestamp, int windowId, KeyState state, int repeat,
      KeyboardKey key)
      : super(
            sdl, timestamp, KeyboardEventType.up, windowId, state, repeat, key);
}

/// Keyboard text editing (composition).
///
/// [SDL_TEXTEDITING](https://wiki.libsdl.org/SDL_TextEditingEvent)
class TextEditingEvent extends Event {
  /// Create an event.
  TextEditingEvent(Sdl sdl, int timestamp) : super(sdl, timestamp);
}

/// Keyboard text input.
///
/// [SDL_TEXTINPUT](https://wiki.libsdl.org/SDL_TextInputEvent)
class TextInputEvent extends Event {
  /// Create an event.
  TextInputEvent(Sdl sdl, int timestamp) : super(sdl, timestamp);
}

/// The keymap changed due to a system event such as an input language or
/// keyboard layout change (>= SDL 2.0.4).
class KeymapChangedEvent extends Event {
  /// Create an event.
  KeymapChangedEvent(Sdl sdl, int timestamp) : super(sdl, timestamp);
}
