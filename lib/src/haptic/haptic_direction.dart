/// Provides the [HapticDirection] class.
import '../extensions.dart';

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
}
