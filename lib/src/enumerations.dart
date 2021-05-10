/// Provides various enumerations for use with SDL.

/// Hint priorities.
enum HintPriority {
  /// low priority, used for default values
  defaultPriority,

  /// medium priority
  normalPriority,

  /// high priority
  overridePriority,
}

/// Log categories.
enum LogCategory {
  /// application log
  applicationCategory,

  /// error log
  errorCategory,

  /// assert log
  assertCategory,

  /// system log
  systemCategory,

  /// audio log
  audioCategory,

  /// video log
  videoCategory,

  /// render log
  renderCategory,

  /// input log
  inputCategory,

  /// test log
  testCategory,
}

/// Various log priorities.
enum LogPriority {
  /// Verbose
  verbosePriority,

  /// Debug
  debugPriority,

  /// Info
  infoPriority,

  /// Warnings
  warnPriority,

  /// Errors
  errorPriority,

  /// Critical
  criticalPriority,
}
