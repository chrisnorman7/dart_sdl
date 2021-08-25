// ignore_for_file: avoid_print
/// An example of haptics.
import 'package:dart_sdl/dart_sdl.dart';

Future<void> main() async {
  final sdl = Sdl()..init();
  for (var i = 0; i < sdl.numJoysticks; i++) {
    final j = sdl.openJoystick(i);
    print('${j.name} is haptic: ${j.isHaptic}');
  }
  final haptics = <int, Haptic>{};
  for (var i = 0; i < sdl.numHaptics; i++) {
    if (sdl.hapticOpened(i) == true) {
      print('#${sdl.getHapticName(i)} has already been opened.');
    } else {
      final haptic = sdl.openHaptic(i)..init();
      haptics[i] = haptic;
      print('${haptic.name} (#${haptic.index})');
      print('Number of simultaneous effects: ${haptic.numEffectsPlaying}');
      print('Number of effects can store: ${haptic.numEffects}');
      print('Number of axes: ${haptic.numAxes}');
    }
  }
  if (sdl.mouseIsHaptic) {
    final Haptic = sdl.openHapticFromMouse();
    print('Mouse is haptic: ${Haptic.name}');
  } else {
    print('Mouse is not haptic.');
  }
  final window = sdl.createWindow('Haptic Example');
  await for (final event in sdl.events) {
    if (event is QuitEvent) {
      break;
    } else if (event is ControllerDeviceEvent) {
      if (event.state == DeviceState.added) {
        sdl.openGameController(event.joystickId);
      }
    } else if (event is JoyAxisEvent) {
      final haptic = haptics[event.joystickId];
      if (haptic != null) {
        if (event.value == 0) {
          haptic.rumbleStop();
        } else {
          haptic.rumblePlay(event.value.abs() / 32767, 0);
        }
      }
    }
  }
  window.destroy();
  for (final haptic in haptics.values) {
    print('Closing ${haptic.name}.');
    haptic.close();
  }
  print('Done.');
  sdl.quit();
}
