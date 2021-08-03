// ignore_for_file: avoid_print

import 'package:dart_sdl/dart_sdl.dart';

void main() {
  final sdl = Sdl()..init();
  final window = sdl.createWindow('Events Example');
  while (true) {
    final event = sdl.pollEvent();
    if (event == null) {
      continue;
    } else if (event is QuitEvent) {
      break;
    } else if (event is KeyboardEvent) {
      print(event.key.keycode);
      print(event.key.scancode);
      if (event.key.keycode == KeyCode.keycode_q ||
          event.key.keycode == KeyCode.keycode_ESCAPE) {
        window.destroy();
        break;
      }
    } else {
      print(event);
    }
  }
  sdl.quit();
}
