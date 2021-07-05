// ignore_for_file: avoid_print

import 'package:dart_sdl/dart_sdl.dart';

void main() {
  final sdl = Sdl()
    ..init()
    ..createWindow('Events Example');
  while (true) {
    final event = sdl.pollEvent();
    if (event == null) {
      continue;
    } else if (event is QuitEvent) {
      break;
    } else if (event is KeyboardEvent) {
      print(event.key.keycode);
    } else {
      print(event);
    }
  }
  sdl.quit();
}
