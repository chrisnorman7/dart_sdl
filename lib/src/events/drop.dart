/// Provides drag and drop events.
import 'dart:ffi';

import 'package:ffi/ffi.dart';

import '../extensions.dart';
import '../sdl.dart';
import '../sdl_bindings.dart';
import 'base.dart';

/// A drag and drop event.
///
/// [SDL Docs](https://wiki.libsdl.org/SDL_DropEvent)
class DropEvent extends Event with WindowMixin {
  /// Create an event.
  DropEvent(
    super.sdl,
    super.timestamp,
    this.type,
    this.file,
    final int windowId,
  ) {
    this.windowId = windowId;
  }

  /// Create an instance from an SDL event.
  factory DropEvent.fromSdlEvent(final Sdl sdl, final SDL_DropEvent event) {
    final filename = event.file.cast<Utf8>().toDartString();
    sdl.sdl.SDL_free(event.file.cast<Void>());
    return DropEvent(
      sdl,
      event.timestamp,
      event.type.toDropEventType(),
      filename,
      event.windowID,
    );
  }

  /// The type of this event.
  final DropEventType type;

  ///  The filename for this event.
  final String file;
}
