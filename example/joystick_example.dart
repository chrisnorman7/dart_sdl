// ignore_for_file: avoid_print

import 'package:dart_sdl/dart_sdl.dart';

void main() {
  final sdl = Sdl()..init();
  print('Joysticks: ${sdl.numJoysticks}.');
  for (var i = 0; i < sdl.numJoysticks; i++) {
    print('Opening joystick #$i.');
    final j = sdl.openJoystick(i);
    if (j.attached == false) {
      print('Opening failed.');
      continue;
    }
  }
  sdl.quit();
}
