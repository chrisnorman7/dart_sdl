/// Dart bindings for sdl.
///
/// Start by creating an [Sdl] instance:
///
/// ```
/// final sdl = Sdl(DynamicLibrary.open('sdl2.dll'));
/// ```
///
/// Next, you need to initialise the library:
///
/// ```
/// sdl.init();
/// ```
///
/// For more information, see the
/// [SDL API docs](https://wiki.libsdl.org/APIByCategory).
library dart_sdl;

import 'src/sdl.dart';

export 'src/audio/device.dart';
export 'src/audio/driver.dart';
export 'src/audio/spec.dart';
export 'src/audio/wave_file.dart';
export 'src/display.dart';
export 'src/enumerations.dart';
export 'src/error.dart';
export 'src/events/application.dart';
export 'src/events/audio.dart';
export 'src/events/base.dart';
export 'src/events/clipboard.dart';
export 'src/events/display.dart';
export 'src/events/drop.dart';
export 'src/events/game_controller.dart';
export 'src/events/gestures.dart';
export 'src/events/joystick.dart';
export 'src/events/keyboard.dart';
export 'src/events/mouse.dart';
export 'src/events/platform.dart';
export 'src/events/renderer.dart';
export 'src/events/sensor.dart';
export 'src/events/text.dart';
export 'src/events/touch_finger.dart';
export 'src/events/user.dart';
export 'src/events/window.dart';
export 'src/extensions.dart';
export 'src/game_controller.dart';
export 'src/haptic/haptic.dart';
export 'src/haptic/haptic_direction.dart';
export 'src/haptic/haptic_effect.dart';
export 'src/haptic/haptic_features.dart';
export 'src/joystick.dart';
export 'src/keycodes.dart';
export 'src/message_box_button.dart';
export 'src/modifiers.dart';
export 'src/sdl.dart';
export 'src/window.dart';
