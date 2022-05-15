# Changelog

## [0.10.0]

### Changed

* Updated the minimum SDK constraint.
* Updated all dependencies.
* Regenerated the bindings.

## [0.9.7]

### Changed

* Updated the minimum SDK constraint.

## [0.9.6]

### Changed

* Updated analysis options.

## [0.9.5]

### Added

* Added the `InitFlags` class.

## [0.9.4]

### Changed

* `TextEditingEvent` no longer inherits from `TextInput event` ([#6](https://github.com/chrisnorman7/dart_sdl/issues/6)).

## [0.9.3]

### Added

* Bound some more rumble functions.

## [0.9.2]

### Fixed

* Look in the local directory for a library file if the script directory doesn't contain one.

## [0.9.1]

### Fixed

* Resolve script name properly.

## [0.9.0]

### Changed

* Inferred library names are always anchored at the directory where the main script is running.
* Updated SDL2 to 2.0.20 ([#3](https://github.com/chrisnorman7/dart_sdl/issues/3)).
* Shortened key code and scan code member names ([#4](https://github.com/chrisnorman7/dart_sdl/issues/4)).

## [0.8.9]

### Changed

* Use an absolute path when loading the dynamic library on Linux.

## [0.8.8]

### Changed

* Use the more generic library name "libSDL2.so" under Linux.

## [0.8.7]

### Changed

* Updated the package description.

## [0.8.6]

### Added

* Autodetect home brew library name for OS X.

## [0.8.5]

### Fixed

* Changed the library name for OS X.

## [0.8.4]

### Fixed

* Fixed overflow in the handling of the text input event.

## [0.8.3]

### Added

* Bound [sdl_GetPrefPath](https://wiki.libsdl.org/SDL_GetPrefPath).
* Bound [SDL_GetBasePath](https://wiki.libsdl.org/SDL_GetBasePath).

## [0.8.2]

### Changed

* You can now specify the path to the SDL library.
* Library names for Linux and Mac OS X can now be automatically inferred.

## [0.8.1]

### Fixed

* Fixed some broken doc links.

## [0.8.0]

### Changed

* Renamed `SdlButton` to `MessageBoxButton` to bring it (almost) in line with the [SDL docs](https://wiki.libsdl.org/SDL_MessageBoxButtonData).

## [0.7.0]

### Changed

* Renamed `Button` to `SdlButton`.

## [0.6.1]

### Added

* Added a window example.

### Changed

* New `SdlObject` instances no longer need to call `super.destroy`.
* Fixed a bug with `Window.destroy`.

## [0.6.0]

### Added

* Start using `MessageBoxFlags.error` (thanks to Mohamed Sulaiman for reporting that oversight).
* Added the `List<int>.xor` extension method.
* Added `SdlObject.destroy`, which must be overridden for any new dsl object.

### Changed

* Made *most* SDL objects subclasses of `SdlObject`.
* Use code generation to generate enums.
* Changed API to be in line with the generated enums.

## [0.5.0]

### Changed

* Changed the signature for the haptic effects constructors.
* Hopefully plugged a load of memory leaks.

## [0.4.1]

### Added

* Added the `Sdl.getEvents` stream, which allows you to specify a delay between polling for events.

## [0.4.0]

### Changed

* Increased the minimum SDK value.

## [0.3.6]

### Added

* Added the `getAxisSmall` method to the `GameController` class.

## [0.3.5]

### Added

* Added a `smallValue` member to the `JoyAxisEvent` and `ControllerAxisEvent` classes.

## [0.3.4]

### Added

* [SDL_HapticQuery](https://wiki.libsdl.org/SDL_HapticQuery)

## [0.3.3]

### Added

* [SDL_Delay](https://wiki.libsdl.org/SDL_Delay)
* [SDL_GetKeyboardFocus](https://wiki.libsdl.org/SDL_GetKeyboardFocus)
* [SDL_GetKeyboardState](https://wiki.libsdl.org/SDL_GetKeyboardState)
* [SDL_GetKeyFromName](https://wiki.libsdl.org/SDL_GetKeyFromName)
* [SDL_GetKeyFromScancode](https://wiki.libsdl.org/SDL_GetKeyFromScancode)
* [SDL_GetKeyName](https://wiki.libsdl.org/SDL_GetKeyName)
* [SDL_GetModState](https://wiki.libsdl.org/SDL_GetModState)
* [SDL_GetScancodeFromKey](https://wiki.libsdl.org/SDL_GetScancodeFromKey)
* [SDL_GetScancodeFromName](https://wiki.libsdl.org/SDL_GetScancodeFromName)
* [SDL_GetScancodeName](https://wiki.libsdl.org/SDL_GetScancodeName)
* [SDL_HasScreenKeyboardSupport](https://wiki.libsdl.org/SDL_HasScreenKeyboardSupport)
* [SDL_IsScreenKeyboardShown](https://wiki.libsdl.org/SDL_IsScreenKeyboardShown)
* [SDL_IsTextInputActive](https://wiki.libsdl.org/SDL_IsTextInputActive)
* [SDL_Keymod](https://wiki.libsdl.org/SDL_Keymod)
* [SDL_SetModState](https://wiki.libsdl.org/SDL_SetModState)
* [SDL_StartTextInput](https://wiki.libsdl.org/SDL_StartTextInput)
* [SDL_StopTextInput](https://wiki.libsdl.org/SDL_StopTextInput)
* [SDL_CaptureMouse](https://wiki.libsdl.org/SDL_CaptureMouse)
* [SDL_GetMouseFocus](https://wiki.libsdl.org/SDL_GetMouseFocus)
* [SDL_GetRelativeMouseMode](https://wiki.libsdl.org/SDL_GetRelativeMouseMode)
* [SDL_SetRelativeMouseMode](https://wiki.libsdl.org/SDL_SetRelativeMouseMode)
* [SDL_ShowCursor](https://wiki.libsdl.org/SDL_ShowCursor)
* [SDL_WarpMouseGlobal](https://wiki.libsdl.org/SDL_WarpMouseGlobal)
* [SDL_WarpMouseInWindow](https://wiki.libsdl.org/SDL_WarpMouseInWindow)
* [SDL_NumSensors](https://wiki.libsdl.org/SDL_NumSensors)
* [SDL_HapticClose](https://wiki.libsdl.org/SDL_HapticClose)
* [SDL_HapticCondition](https://wiki.libsdl.org/SDL_HapticCondition)
* [SDL_HapticConstant](https://wiki.libsdl.org/SDL_HapticConstant)
* [SDL_HapticDestroyEffect](https://wiki.libsdl.org/SDL_HapticDestroyEffect)
* [SDL_HapticDirection](https://wiki.libsdl.org/SDL_HapticDirection)
* [SDL_HapticEffect](https://wiki.libsdl.org/SDL_HapticEffect)
* [SDL_HapticGetEffectStatus](https://wiki.libsdl.org/SDL_HapticGetEffectStatus)
* [SDL_HapticEffectSupported](https://wiki.libsdl.org/SDL_HapticEffectSupported)
* [SDL_HapticIndex](https://wiki.libsdl.org/SDL_HapticIndex)
* [SDL_HapticName](https://wiki.libsdl.org/SDL_HapticName)
* [SDL_HapticNewEffect](https://wiki.libsdl.org/SDL_HapticNewEffect)
* [SDL_HapticNumAxes](https://wiki.libsdl.org/SDL_HapticNumAxes)
* [SDL_HapticNumEffects](https://wiki.libsdl.org/SDL_HapticNumEffects)
* [SDL_HapticNumEffectsPlaying](https://wiki.libsdl.org/SDL_HapticNumEffectsPlaying)
* [SDL_HapticOpen](https://wiki.libsdl.org/SDL_HapticOpen)
* [SDL_HapticOpened](https://wiki.libsdl.org/SDL_HapticOpened)
* [SDL_HapticOpenFromMouse](https://wiki.libsdl.org/SDL_HapticOpenFromMouse)
* [SDL_HapticOpenFromJoystick](https://wiki.libsdl.org/SDL_HapticOpenFromJoystick)
* [SDL_JoystickIsHaptic](https://wiki.libsdl.org/SDL_JoystickIsHaptic)
* [SDL_MouseIsHaptic](https://wiki.libsdl.org/SDL_MouseIsHaptic)
* [SDL_NumHaptics](https://wiki.libsdl.org/SDL_NumHaptics)
* [SDL_HapticPause](https://wiki.libsdl.org/SDL_HapticPause)
* [SDL_HapticRumbleInit](https://wiki.libsdl.org/SDL_HapticRumbleInit)
* [SDL_HapticRumblePlay](https://wiki.libsdl.org/SDL_HapticRumblePlay)
* [SDL_HapticRumbleStop](https://wiki.libsdl.org/SDL_HapticRumbleStop)
* [SDL_HapticRumbleSupported](https://wiki.libsdl.org/SDL_HapticRumbleSupported)
* [SDL_HapticRunEffect](https://wiki.libsdl.org/SDL_HapticRunEffect)
* [SDL_HapticSetAutocenter](https://wiki.libsdl.org/SDL_HapticSetAutocenter)
* [SDL_HapticSetGain](https://wiki.libsdl.org/SDL_HapticSetGain)
* [SDL_HapticStopAll](https://wiki.libsdl.org/SDL_HapticStopAll)
* [SDL_HapticStopEffect](https://wiki.libsdl.org/SDL_HapticStopEffect)
* [SDL_HapticUnpause](https://wiki.libsdl.org/SDL_HapticUnpause)
* [SDL_HapticUpdateEffect](https://wiki.libsdl.org/SDL_HapticUpdateEffect)

### Changed

* Changed the constructor for the `KeyboardKey` class.
* Changed `KeyboardKey.modifiers` to a list of `KeyMod` values.

## [0.3.1]

### Changed

* Fixed the doc string for `KeyboardEvent.repeat`.

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
