/// Keyboard events:
import '../enumerations.dart';
import '../error.dart';
import '../sdl.dart';
import '../sdl_bindings.dart';
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

/// A keyboard event.
///
/// [SDL Docs](https://wiki.libsdl.org/SDL_KeyboardEvent)
class KeyboardEvent extends Event with WindowedEvent {
  /// Create an event.
  KeyboardEvent(
      Sdl sdl, int timestamp, int wndId, this.state, this.repeat, this.key)
      : super(sdl, timestamp) {
    windowId = wndId;
  }

  /// Create an instance from an SDL event.
  factory KeyboardEvent.fromSdlEvent(Sdl sdl, SDL_KeyboardEvent event) {
    final sim = event.keysym;
    final key = KeyboardKey(sim.scancode, sim.sym, sim.mod);
    PressedState s;
    switch (event.type) {
      case SDL_PRESSED:
        s = PressedState.pressed;
        break;
      case SDL_RELEASED:
        s = PressedState.released;
        break;
      default:
        throw SdlError(event.type, 'Unknown key state.');
    }
    return KeyboardEvent(
        sdl, event.timestamp, event.windowID, s, event.repeat, key);
  }

  /// Whether [key] has been pressed or released.
  final PressedState state;

  /// Non-0 if this is a repeated key.
  final int repeat;

  /// The keyboard key that was pressed or released.
  final KeyboardKey key;
}

/// The keymap changed due to a system event such as an input language or
/// keyboard layout change (>= SDL 2.0.4).
class KeymapChangedEvent extends Event {
  /// Create an event.
  KeymapChangedEvent(Sdl sdl, int timestamp) : super(sdl, timestamp);
}
