/// Provides display events.
import '../enumerations.dart';
import '../sdl.dart';
import '../sdl_bindings.dart';
import 'base.dart';

/// A generic display event.
class DisplayEvent extends Event {
  /// Create an event.
  DisplayEvent(
      {required Sdl sdl,
      required int timestamp,
      required this.displayIndex,
      required this.eventID,
      required this.padding1,
      required this.padding2,
      required this.padding3,
      required this.data1})
      : super(sdl, timestamp);

  /// Create an instance from [event].
  DisplayEvent.fromEvent(Sdl sdl, SDL_Event event)
      : data1 = event.display.data1,
        displayIndex = event.display.display,
        eventID = event.display.event.toDisplayEventID(),
        padding1 = event.display.padding1,
        padding2 = event.display.padding2,
        padding3 = event.display.padding3,
        super(sdl, event.display.timestamp);

  /// The associated display index.
  final int displayIndex;

  /// The ID of the event.
  final DisplayEventID eventID;

  /// Padding 1.
  final int padding1;

  /// Padding 2.
  final int padding2;

  /// Padding 3.
  final int padding3;

  /// Data 1.
  final int data1;
}
