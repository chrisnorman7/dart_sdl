/// Provides the [HapticDirection] class.
import 'dart:ffi';

import 'package:ffi/ffi.dart';

import '../enumerations.dart';
import '../extensions.dart';
import '../sdl_bindings.dart';

/// A structure that contains a haptic direction.
class HapticDirection {
  /// Create an instance.
  HapticDirection(this.type, {this.x, this.y, this.z});

  /// The type of this direction.
  final HapticDirectionType type;

  /// The x coordinate of the encoded direction.
  int? x;

  /// The y coordinate of the encoded direction.
  int? y;

  /// The z coordinate of the encoded direction.
  int? z;

  /// Get a pointer.
  Pointer<SDL_HapticDirection> getPointer() {
    final ptr = calloc<SDL_HapticDirection>();
    ptr.ref.type = type.toSdlValue();
    var value = x;
    if (value != null) {
      ptr.ref.dir[0] = value;
    }
    value = y;
    if (value != null) {
      ptr.ref.dir[1] = value;
    }
    value = z;
    if (value != null) {
      ptr.ref.dir[2] = value;
    }
    return ptr;
  }
}
