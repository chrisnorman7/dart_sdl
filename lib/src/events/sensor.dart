/// Provides sensor events.
import '../sdl.dart';
import '../sdl_bindings.dart';
import 'base.dart';

/// A sensor update event.
///
/// Exposes [SDL_SensorEvent].
class SensorEvent extends Event {
  /// Create an event.
  SensorEvent(
      {required Sdl sdl,
      required int timestamp,
      required this.sensor,
      required this.data1,
      required this.data2,
      required this.data3,
      required this.data4,
      required this.data5,
      required this.data6})
      : super(sdl, timestamp);

  /// The ID of the sensor that was used.
  final int sensor;

  /// Data 1.
  final double data1;

  /// Data 2.
  final double data2;

  /// Data 3.
  final double data3;

  /// Data 4.
  final double data4;

  /// Data 5.
  final double data5;

  /// Data 6.
  final double data6;
}
