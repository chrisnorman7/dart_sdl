// ignore_for_file: avoid_print
/// Demo some keyboard code.
import 'package:dart_sdl/dart_sdl.dart';

void main() {
  final sdl = Sdl()..init();
  print(sdl.getKeyboardFocus());
  final window = sdl.createWindow('Keyboard Example');
  print(sdl.getKeyboardFocus()?.title);
  final state = sdl.keyboardState;
  // Note: In my testing, the keyboard state doesn't seem to do anything with
  // this script.
  sdl.pumpEvents();
  for (final scanCode in ScanCode.values) {
    if (scanCode == ScanCode.num_scancodes) {
      continue;
    }
    if (state[scanCode.toSdlValue()] == PressedState.pressed) {
      print('$scanCode is pressed.');
    }
  }
  // Note: The next line doesn't seem to print anything in this example.
  print('Modifiers: ${sdl.modState}.');
  window.destroy();
  print(sdl.getKeyFromName(sdl.getKeyName(KeyCode.leftbracket)));
  print(sdl.getKeyFromScanCode(ScanCode.brightnessdown));
  print(sdl.getScanCodeFromName(sdl.getScanCodeName(ScanCode.slash)));
  print('Screen keyboard support: ${sdl.hasScreenKeyboardSupport}');
  sdl.quit();
}
