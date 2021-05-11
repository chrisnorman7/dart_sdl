// ignore_for_file: avoid_print
import 'package:dart_sdl/dart_sdl.dart';

/// Show some capabilities of displays.

void main() {
  final sdl = Sdl()..init();
  print('Video drivers:');
  for (var i = 0; i < sdl.numVideoDrivers; i++) {
    print('${i + 1}: ${sdl.getVideoDriver(i)}.');
  }
  print('Number of displays: ${sdl.numVideoDisplays}.');
  final d = sdl.createFirstDisplay();
  print('Name of first display is ${d.name}.');
  final b = d.bounds;
  print('Display size is ${b.width} x ${b.height}.');
  print('Number of display modes: ${d.numDisplayModes}.');
  sdl.quit();
}
