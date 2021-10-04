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
    print('$i: ${j.name} (#${j.instanceId}).');
    if (sdl.isGameController(i)) {
      final controller = j.controller ?? sdl.openGameController(j.instanceId);
      print('Controller: ${controller.name}.');
    } else {
      print('Not a controller.');
    }
    print('Type: ${j.type}.');
    print('Power level: ${j.powerLevel}.');
    print('Number of axes: ${j.numAxes}.');
    print('Number of balls: ${j.numBalls}.');
    print('Number of buttons: ${j.numButtons}.');
    print('Number of hats: ${j.numHats}.');
    j
      ..close()
      ..destroy();
  }
  sdl.quit();
}
