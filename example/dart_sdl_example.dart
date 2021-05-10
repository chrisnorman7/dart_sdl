// ignore_for_file: avoid_print
import 'package:dart_sdl/dart_sdl.dart';

void main() {
  final sdl = Sdl()..init();
  print('SDL version ${sdl.version}.');
  final window = sdl.createWindow('Test Window');
  sdl.showSimpleMessageBox(MessageBoxFlags.information, 'Window Creation',
      'Created window ${window.title}.',
      window: window);
  const okButtonId = 1;
  const cancelButtonId = 2;
  final id = sdl.showMessageBox(
      'SDL Example',
      'This is hello from dart.',
      [
        Button('OK', id: okButtonId, flags: ButtonFlags.returnKeyDefault),
        Button('Cancel',
            id: cancelButtonId, flags: ButtonFlags.escapeKeyDefault)
      ],
      window: window);
  window.destroy();
  sdl.quit();
  print('You pressed ${id == okButtonId ? "OK" : "Cancel"}.');
}
