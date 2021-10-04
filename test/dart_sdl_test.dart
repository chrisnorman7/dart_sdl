import 'package:dart_sdl/dart_sdl.dart';
import 'package:test/test.dart';

void main() {
  group('Extension methods', () {
    test('List.xor', () {
      final flags = <MessageBoxFlags>[
        MessageBoxFlags.error,
        MessageBoxFlags.warning
      ];
      final results = [for (final f in flags) f.toInt()];
      expect(
          results,
          equals(<int>[
            MessageBoxFlags.error.toInt(),
            MessageBoxFlags.warning.toInt()
          ]));
      expect(
          results.xor(),
          equals(
              MessageBoxFlags.error.toInt() | MessageBoxFlags.warning.toInt()));
    });
  });
}
