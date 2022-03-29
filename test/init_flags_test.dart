import 'package:dart_sdl/init_flags.dart';
import 'package:dart_sdl/src/sdl_bindings.dart';
import 'package:test/test.dart';

void main() {
  group(
    'InitFlags',
    () {
      test(
        'Everything',
        () {
          const flags = InitFlags.everything;
          expect(flags.flags, SDL_INIT_EVERYTHING);
          expect(flags.flags, InitFlags.everything.flags);
          expect(identical(flags, InitFlags.everything), isTrue);
        },
      );
      test(
        'timer',
        () {
          const timer = InitFlags(timer: true);
          expect(timer.flags, SDL_INIT_TIMER);
        },
      );
      test(
        'audio',
        () {
          const audio = InitFlags(audio: true);
          expect(audio.flags, SDL_INIT_AUDIO);
        },
      );
      test(
        'video',
        () {
          const video = InitFlags(video: true);
          expect(video.flags, SDL_INIT_VIDEO);
        },
      );
      test(
        'joystick',
        () {
          const joystick = InitFlags(joystick: true);
          expect(joystick.flags, SDL_INIT_JOYSTICK);
        },
      );
      test(
        'haptic',
        () {
          const haptic = InitFlags(haptic: true);
          expect(haptic.flags, SDL_INIT_HAPTIC);
        },
      );
      test(
        'gameController',
        () {
          const gameController = InitFlags(gameController: true);
          expect(gameController.flags, SDL_INIT_GAMECONTROLLER);
        },
      );
      test(
        'events',
        () {
          const events = InitFlags(events: true);
          expect(events.flags, SDL_INIT_EVENTS);
        },
      );
      test(
        'sensor',
        () {
          const sensor = InitFlags(sensor: true);
          expect(sensor.flags, SDL_INIT_SENSOR);
        },
      );
      test(
        'xor',
        () {
          const audioVideo = InitFlags(audio: true, video: true);
          expect(audioVideo.flags, SDL_INIT_AUDIO | SDL_INIT_VIDEO);
        },
      );
    },
  );
}
