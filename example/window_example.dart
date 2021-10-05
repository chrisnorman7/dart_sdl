// ignore_for_file: avoid_print

import 'package:dart_sdl/dart_sdl.dart';

void main() {
  final sdl = Sdl()..init();
  final window = sdl.createWindow('Example Window');
  print('Window size: ${window.size}.');
  window.maximise();
  print('Window maximised.');
  window.minimise();
  print('Window minimised.');
  window.destroy();
  print('Window destroyed.');
  sdl.quit();
  print('Done.');
}
