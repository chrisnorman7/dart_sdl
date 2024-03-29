import 'package:dart_sdl/dart_sdl.dart';

Future<void> main() async {
  final sdl = Sdl()..init();
  final window = sdl.createWindow('Events Example');
  await for (final event in sdl.events) {
    window.title = event.toString();
    if (event is QuitEvent) {
      break;
    } else if (event is KeyboardEvent) {
      window.title = '${event.key.keycode} (${event.key.modifiers}';
      if (event.key.keycode == KeyCode.q && event.key.modifiers.isEmpty ||
          event.key.keycode == KeyCode.escape) {
        window.destroy();
        break;
      }
    } else if (event is TextInputEvent) {
      window.title = event.text;
    }
  }
  sdl.quit();
}
