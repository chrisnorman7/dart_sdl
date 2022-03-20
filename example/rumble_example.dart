// ignore_for_file: avoid_print

import 'package:dart_sdl/dart_sdl.dart';

Future<void> main() async {
  final sdl = Sdl()..init();
  final window = sdl.createWindow('Rumble Example');
  final joysticks = <int, Joystick>{};
  for (var i = 0; i < sdl.numJoysticks; i++) {
    final j = sdl.openJoystick(i);
    joysticks[i] = j;
    print('Opened ${j.name}.');
  }
  try {
    await for (final event in sdl.events) {
      if (event is QuitEvent) {
        break;
      } else if (event is JoyButtonEvent) {
        final id = event.joystickId;
        var j = joysticks[id];
        if (j == null) {
          j = sdl.openJoystick(id);
          joysticks[id] = j;
        }
        if (event.state == PressedState.pressed) {
          if (j.hasRumble) {
            print('Rumble on ${j.name}');
            j.rumble(duration: 500);
          } else {
            print('${j.name} cannot rumble.');
          }
        } else {
          j.rumble(duration: 0, highFrequency: 0, lowFrequency: 0);
        }
      }
    }
  } finally {
    window.destroy();
    sdl.quit();
  }
}
