// ignore_for_file: avoid_print
/// An example with sensors.
import 'package:dart_sdl/dart_sdl.dart';

/// Run the example.
void main() {
  final sdl = Sdl()..init();
  print('Number of sensors: ${sdl.numSensors}');
  sdl.quit();
}
