// ignore_for_file: avoid_print

import 'package:dart_sdl/dart_sdl.dart';

Future<void> main() async {
  final sdl = Sdl()..init();
  final window = sdl.createWindow('Events Example');
  await for (final event in sdl.events) {
    print(event);
    if (event is QuitEvent) {
      break;
    } else if (event is KeyboardEvent) {
      print(event.key.keycode);
      if (event.key.keycode == KeyCode.keycode_q && event.key.modifiers == 0 ||
          event.key.keycode == KeyCode.keycode_ESCAPE) {
        window.destroy();
        break;
      }
    }
  }
  sdl.quit();
}
