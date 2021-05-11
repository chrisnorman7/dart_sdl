/// Provides the [SdlVersion] class.

/// Specifies the version of SDL being used.
class SdlVersion {
  /// Create the version.
  SdlVersion(this.major, this.minor, this.patch);

  /// The major version number.
  final int major;

  /// The minor version number.
  final int minor;

  /// The patch level.
  final int patch;

  /// Convert to a string.
  @override
  String toString() => '$major.$minor.$patch';
}
