// ignore_for_file: avoid_print
import 'package:dart_sdl/dart_sdl.dart';

void main() {
  final sdl = Sdl()..init();
  for (var i = 0; i < sdl.numJoysticks; i++) {
    final controller = sdl.openGameController(i);
    print('#$i: ${controller.name}.');
  }
  sdl.quit();
}
