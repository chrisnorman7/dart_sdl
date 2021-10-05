/// Provides the [SdlObject] class.
import 'dart:ffi';

import 'package:ffi/ffi.dart';

import 'sdl.dart';

/// The base class for all SDL objects.
class SdlObject<T extends NativeType> {
  /// Create an instance.
  SdlObject(this.sdl, this.handle);

  /// The SDL bindings to use.
  final Sdl sdl;

  /// The pointer for this object.
  final Pointer<T> handle;

  /// How this object should be destroyed.
  void destroy() => calloc.free(handle);
}
