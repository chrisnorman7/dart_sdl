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
  final numHaptics = sdl.numHaptics;
  print('Number of haptic devices: $numHaptics.');
  for (var i = 0; i < sdl.numHaptics; i++) {
    if (sdl.hapticOpened(i) == true) {
      print('#${sdl.getHapticName(i)} has already been opened.');
    } else {
      final haptic = sdl.openHaptic(i)..init();
      haptics[i] = haptic;
      print('${haptic.name} (#${haptic.index})');
      print('Features: ${haptic.features}');
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
        final controller = sdl.openGameController(event.joystickId);
        window.title = 'Opened device ${controller.name}.';
        if (controller.joystick.isHaptic) {
          haptics[event.joystickId] = sdl.openHaptic(event.joystickId);
        }
      } else if (event.state == DeviceState.removed) {
        haptics.remove(event.joystickId);
        window.title = 'Controller removed.';
      }
    } else if (event is ControllerAxisEvent) {
      final haptic = haptics[event.joystickId];
      if (haptic != null) {
        if (event.value == 0) {
          haptic.rumbleStop();
        } else if ([
          GameControllerAxis.leftY,
          GameControllerAxis.rightY,
          GameControllerAxis.triggerLeft,
          GameControllerAxis.triggerRight
        ].contains(event.axis)) {
          haptic.rumblePlay(event.value.abs() / 32767, 0);
        }
      }
    } else if (event is ControllerButtonEvent) {
      if (event.button == GameControllerButton.a) {
        final effect = HapticRamp(
            direction: HapticDirection(HapticDirectionType.cartesian),
            length: 200,
            delay: 0,
            button: 0,
            interval: 500,
            start: 0,
            end: 65535,
            attackLength: 200,
            attackLevel: 100,
            fadeLength: 500,
            fadeLevel: 100);
        final supported = haptics.values.first.isSupported(effect);
        if (supported) {
          haptics.values.first
              .runEffect(haptics.values.first.newEffect(effect));
        }
        window.title = 'Ramp effect supported: $supported';
      } else if (event.button == GameControllerButton.b) {
        final effect = HapticConstant(
            direction: HapticDirection(HapticDirectionType.cartesian,
                x: 0, y: 1, z: 0),
            length: 500,
            delay: 200,
            button: 0,
            interval: 500,
            level: 65535,
            attackLength: 500,
            attackLevel: 100,
            fadeLength: 500,
            fadeLevel: 100);
        final supported = haptics.values.first.isSupported(effect);
        if (supported) {
          haptics.values.first
              .runEffect(haptics.values.first.newEffect(effect));
        }
        window.title = 'Constant effect supported: $supported';
      } else if (event.button == GameControllerButton.x) {
        for (var i = 0; i < 3; i++) {
          haptics.values.first.rumblePlay(1, 100);
          sdl.delay(400);
        }
      } else if (event.button == GameControllerButton.y) {
        final effect = HapticLeftRight(
            length: 500, largeMagnitude: 1000, smallMagnitude: 800);
        final supported = haptics.values.first.isSupported(effect);
        if (supported) {
          haptics.values.first
              .runEffect(haptics.values.first.newEffect(effect));
        }
        window.title = 'Left/right effect supported: $supported';
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
