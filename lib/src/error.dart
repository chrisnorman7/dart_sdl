/// Provides the [SdlError] class.

/// The base class for all exceptions.
class SdlError implements Exception {
  /// Create an exception.
  SdlError(this.code, this.message);

  /// The error code.
  final int code;

  /// The message.
  final String message;

  /// Pretty-print.
  @override
  String toString() => '$runtimeType ($code): $message';
}
