# Changelog

## [0.3.0]

### Changed

* Make `KeyboardEvent.repeat` a boolean value.

## [0.2.0]

### Added

* Added a binding for [SDL_GetWindowFromID](https://wiki.libsdl.org/SDL_GetWindowFromID) as `Window.fromId`.

### Changed

* Changed the return type of `Joystick.controller` to `GameController?`, to
  account for the controller not being open, and an empty error string being
  present.

### Removed

* No longer cache objects.

## [0.1.3]

### Added

* Added bindings for [SDL_GameControllerEventState](https://wiki.libsdl.org/SDL_GameControllerEventState).

## [0.1.2]

### Changed

* Fixed a broken link.
* Fixed the format of the change log.

## [0.1.1]

### Changed

* Downgraded the Dart constraint.

## [0.1.0]

### Added

* Added a stream for events. Accessible as `Sdl.events`.

### Changed

* Keyboard events now use the new `ScanCode` and `KeyCode` enumerations, rather than pure integers.

## [0.0.5]

### Added

* Added audio functions.

## [0.0.4]

### Added

* Added clipboard functions to readme.

### Fixed

* Fixed the package description.

## [0.0.2]

### Added

* Added proper documentation.
* Added initialisation, window and logging functions.

## 0.0.0

### Changed

* Initial version.
