// ignore_for_file: avoid_print

import 'package:dart_sdl/dart_sdl.dart';

void main() {
  final sdl = Sdl()..init();
  print('Joysticks: ${sdl.numJoysticks}.');
  for (var i = 0; i < sdl.numJoysticks; i++) {
    final j = sdl.openJoystick(i);
    if (j.attached == false) {
      print('Failed to open joystick #$i.');
      continue;
    }
    print('#$i: ${j.name}.');
    print('Is a game controller: ${sdl.isGameController(i)}.');
    print('Power level: ${j.powerLevel}.');
    print('Number of axes: ${j.numAxes}.');
    print('Number of balls: ${j.numBalls}.');
    print('Number of buttons: ${j.numButtons}.');
    print('Number of hats: ${j.numHats}.');
    j.close();
  }
  sdl.quit();
}
