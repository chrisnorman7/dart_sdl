import 'package:dart_sdl/dart_sdl.dart';
import 'package:test/test.dart';

void main() {
  group('Extension methods', () {
    test('List.xor', () {
      final flags = <MessageBoxFlags>[
        MessageBoxFlags.error,
        MessageBoxFlags.warning
      ];
      final results = [for (final f in flags) f.toSdlFlag()];
      expect(
          results,
          equals(<int>[
            MessageBoxFlags.error.toSdlFlag(),
            MessageBoxFlags.warning.toSdlFlag()
          ]));
      expect(
          results.xor(),
          equals(MessageBoxFlags.error.toSdlFlag() |
              MessageBoxFlags.warning.toSdlFlag()));
    });
  });
}
