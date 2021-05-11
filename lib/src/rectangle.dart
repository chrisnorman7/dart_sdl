/// Provides the [Rectangle] class.
import 'dart:math';

/// A rectangle.
///
/// [SDL Docs](https://wiki.libsdl.org/SDL_Rect)
class Rectangle {
  /// Create a rectangle.
  Rectangle(this.x, this.y, this.width, this.height);

  /// The x location of the rectangle's upper left corner.
  final int x;

  /// The y location of the rectangle's upper left corner.
  final int y;

  /// The width of the display.
  final int width;

  /// The height of the display.
  final int height;

  /// The coordinates of the display.
  Point<int> get coordinates => Point<int>(x, y);

  @override
  String toString() => '$runtimeType($x, $y)';
}
