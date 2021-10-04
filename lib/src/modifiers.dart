/// Provides SDL modifiers in the form of an enum.
import 'sdl_bindings.dart';

/// Binds [SDL_Keymod].
enum KeyMod {
  /// KMOD_NONE = 0
  none,

  /// KMOD_LSHIFT = 1
  lShift,

  /// KMOD_RSHIFT = 2
  rShift,

  /// KMOD_LCTRL = 64
  lCtrl,

  /// KMOD_RCTRL = 128
  rCtrl,

  /// KMOD_LALT = 256
  lAlt,

  /// KMOD_RALT = 512
  rAlt,

  /// KMOD_LGUI = 1024
  lGui,

  /// KMOD_RGUI = 2048
  rGui,

  /// KMOD_NUM = 4096
  num,

  /// KMOD_CAPS = 8192
  caps,

  /// KMOD_MODE = 16384
  mode,

  /// KMOD_RESERVED = 32768
  reserved,

  /// KMOD_CTRL = 192
  ctrl,

  /// KMOD_SHIFT = 3
  shift,

  /// KMOD_ALT = 768
  alt,

  /// KMOD_GUI = 3072
  gui,
}
