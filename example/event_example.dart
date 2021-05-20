// ignore_for_file: avoid_print

import 'package:dart_sdl/dart_sdl.dart';

void main() {
  final sdl = Sdl()
    ..init()
    ..createWindow('Events Example');
  print(sdl.pollEvent());
  sdl.quit();
}
