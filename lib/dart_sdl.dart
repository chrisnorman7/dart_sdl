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
export 'src/button.dart';
export 'src/display.dart';
export 'src/enumerations.dart';
export 'src/error.dart';
export 'src/events/application.dart';
export 'src/events/base.dart';
export 'src/events/platform.dart';
export 'src/sdl.dart';
export 'src/sdl_bindings.dart';
export 'src/window.dart';
