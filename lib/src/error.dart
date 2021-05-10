/// Provides the [SDLException] class.

/// The base class for all exceptions.
class SDLException implements Exception {
  /// Create an exception.
  SDLException(this.code, this.message);

  /// The error code.
  final int code;

  /// The message.
  final String message;

  /// Pretty-print.
  @override
  String toString() => '$runtimeType ($code): $message';
}
