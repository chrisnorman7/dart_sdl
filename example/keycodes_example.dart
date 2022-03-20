import 'package:dart_sdl/dart_sdl.dart';

/// A more complicated keyboard example.
Future<void> main() async {
  final sdl = Sdl()..init();
  final window = sdl.createWindow('Keycodes Example');
  final ms = (1000 / 60).round();
  while (true) {
    Event? event;
    do {
      event = sdl.pollEvent();
    } while (event != null);
    final keyState = sdl.keyboardState;
    if (keyState[ScanCode.escape.toSdlValue()] == PressedState.pressed) {
      break;
    } else {
      for (final scanCode in ScanCode.values) {
        if (scanCode == ScanCode.num_scancodes) {
          continue;
        }
        if (keyState[scanCode.toSdlValue()] == PressedState.pressed) {
          window.title = scanCode.toString();
        }
      }
    }
    await Future<void>.delayed(Duration(milliseconds: ms));
  }
  window.destroy();
  sdl.quit();
}
