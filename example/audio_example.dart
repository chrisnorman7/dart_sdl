// ignore_for_file: avoid_print
import 'package:dart_sdl/dart_sdl.dart';

Future<void> main() async {
  final sdl = Sdl()..init();
  print(sdl.sdl.SDL_GetNumAudioDrivers());
  for (final driver in sdl.audioDrivers) {
    print('Driver #${driver.index}: ${driver.name}');
  }
  print('Current driver is ${sdl.audioDriver.name}.');
  print('Output devices:');
  for (final device in sdl.outputAudioDevices) {
    print('Device #${device.index}: ${device.name}.');
  }
  print('Input devices:');
  for (final device in sdl.inputAudioDevices) {
    print('Device #${device.index}: ${device.name}.');
  }
  final device = sdl.openAudioDevice(isCapture: false);
  print('Opened audio device ID: ${device.id}.');
  final waveFile = WaveFile(sdl, 'sound.wav');
  print('Loaded file ${waveFile.filename}.');
  device
    ..queueAudio(waveFile)
    ..play();
  print('Queue size is ${device.queueSize}.');
  await Future<void>.delayed(Duration(seconds: 2));
  device.close();
  sdl.quit();
  print('Done.');
}
