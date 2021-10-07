// ignore_for_file: avoid_print
import 'package:dart_sdl/dart_sdl.dart';

void main() {
  final sdl = Sdl()..init();
  print('SDL version ${sdl.version}.');
  final window = sdl.createWindow('Test Window');
  print(window.displayMode);
  sdl.showSimpleMessageBox([
    MessageBoxFlags.information
  ], 'Window Creation', 'Created window ${window.title}.', window: window);
  const yesButtonId = 1;
  const noButtonId = 2;
  final id = sdl.showMessageBox(
      'SDL Example',
      'See the clipboard contents?',
      [
        MessageBoxButton('Yes',
            id: yesButtonId, flags: [MessageBoxButtonFlags.returnkeyDefault]),
        MessageBoxButton('No',
            id: noButtonId, flags: [MessageBoxButtonFlags.escapekeyDefault])
      ],
      window: window);
  if (id == yesButtonId) {
    print('The clipboard contains: ${sdl.getClipboardText()}');
  } else {
    print('Suit yourself.');
  }
  sdl.setClipboardText(sdl.version.toString());
  window.destroy();
  sdl.quit();
}
