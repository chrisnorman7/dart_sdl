# dart_sdl

This package wraps the [SDL](https://wiki.libsdl.org/) package.

I have been implementing functions as I needed them. As such, this library is
not complete. I of course welcome
[issues](https://github.com/chrisnorman7/dart_sdl/issues/new).

Below is a list of what has been done so far.

## Progress

### [Initialization and Shutdown](https://wiki.libsdl.org/CategoryInit)

Done except for:

* [SDL_InitSubSystem](https://wiki.libsdl.org/SDL_InitSubSystem)
* [SDL_QuitSubSystem](https://wiki.libsdl.org/SDL_QuitSubSystem)
* [SDL_WinRTRunApp](https://wiki.libsdl.org/SDL_WinRTRunApp)

### [Configuration Variables](https://wiki.libsdl.org/CategoryHints)

Partly done. I haven't implemented any of the functions requiring callbacks.

I have made [SDL_HintPriority](https://wiki.libsdl.org/SDL_HintPriority) an
enum, and implemented:

* [SDL_SetHint](https://wiki.libsdl.org/SDL_SetHint)
* [SDL_SetHintWithPriority](https://wiki.libsdl.org/SDL_SetHintWithPriority)

## [Error Handling](https://wiki.libsdl.org/CategoryError)

Completely done.

### [Log Handling](https://wiki.libsdl.org/CategoryLog)

I have created enumerations for
[SDL_LOG_CATEGORY](https://wiki.libsdl.org/SDL_LOG_CATEGORY), and
[SDL_LogPriority](https://wiki.libsdl.org/SDL_LogPriority).

I haven't wrapped the following functions:

* [SDL_LogGetOutputFunction](https://wiki.libsdl.org/SDL_LogGetOutputFunction)
* [SDL_LogMessageV](https://wiki.libsdl.org/SDL_LogMessageV)
* [SDL_LogSetOutputFunction](https://wiki.libsdl.org/SDL_LogSetOutputFunction)

### [Assertions](https://wiki.libsdl.org/CategoryAssertions)

Not implemented.

### [Querying SDL Version](https://wiki.libsdl.org/CategoryVersion)

I have added the following getters on the `Sdl` class:

* [SDL_GetRevision](https://wiki.libsdl.org/SDL_GetRevision) as `revision`.
* [SDL_GetRevisionNumber](https://wiki.libsdl.org/SDL_GetRevisionNumber) as
`revisionNumber`.
* [SDL_GetVersion](https://wiki.libsdl.org/SDL_GetVersion) as `version`.

I have added the `SdlVersion` class to wrap
[SDL_version](https://wiki.libsdl.org/SDL_version).

### [Display and Window Management](https://wiki.libsdl.org/CategoryVideo)

Many of the functions from this category I farmed out to a `Window` class. You
can create windows with the `Sdl.createWindow` method, which wraps the
[SDL_CreateWindow](https://wiki.libsdl.org/SDL_CreateWindow) method.

#### Enumerations

* [SDL_BlendMode](https://wiki.libsdl.org/SDL_BlendMode) as `BlendMode`.
* [SDL_MessageBoxButtonFlags](https://wiki.libsdl.org/SDL_MessageBoxButtonFlags)
* [SDL_MessageBoxFlags](https://wiki.libsdl.org/SDL_MessageBoxFlags)

#### Functions

The following functions are wrapped by methods on the `Sdl` class:

* [SDL_CreateWindow](https://wiki.libsdl.org/SDL_CreateWindow)
* [SDL_DestroyWindow](https://wiki.libsdl.org/SDL_DestroyWindow)
* [SDL_GetNumVideoDisplays](https://wiki.libsdl.org/SDL_GetNumVideoDisplays)
* [SDL_GetNumVideoDrivers](https://wiki.libsdl.org/SDL_GetNumVideoDrivers)
* [SDL_GetVideoDriver](https://wiki.libsdl.org/SDL_GetVideoDriver)
* [SDL_GL_GetCurrentWindow](https://wiki.libsdl.org/SDL_GL_GetCurrentWindow)
* [SDL_ShowMessageBox](https://wiki.libsdl.org/SDL_ShowMessageBox)
* [SDL_ShowSimpleMessageBox](https://wiki.libsdl.org/SDL_ShowSimpleMessageBox)

I have created the `Button` class to wrap
[SDL_MessageBoxButtonData](https://wiki.libsdl.org/SDL_MessageBoxButtonData).

The following methods are wrapped by the `Sdl.screenSaverEnabled` getter /
setter:

* [SDL_IsScreenSaverEnabled](https://wiki.libsdl.org/SDL_IsScreenSaverEnabled)
(getter)
* [SDL_DisableScreenSaver](https://wiki.libsdl.org/SDL_DisableScreenSaver)
(`screenSaverEnabled = false`)
* [SDL_EnableScreenSaver](https://wiki.libsdl.org/SDL_EnableScreenSaver)
(`screenSaverEnabled = true`)

The following functions are wrapped by getters on the `Display` class:

* [SDL_GetDisplayName](https://wiki.libsdl.org/SDL_GetDisplayName)
* [SDL_GetDisplayBounds](https://wiki.libsdl.org/SDL_GetDisplayBounds)
* [SDL_GetDisplayUsableBounds](
  https://wiki.libsdl.org/SDL_GetDisplayUsableBounds)
* [SDL_GetDesktopDisplayMode](
  https://wiki.libsdl.org/SDL_GetDesktopDisplayMode)
* [SDL_GetDisplayMode](https://wiki.libsdl.org/SDL_GetDisplayMode)

The following functions are wrapped by getters on the `Window` class:

* [SDL_GetWindowBordersSize](https://wiki.libsdl.org/SDL_GetWindowBordersSize)
  * [SDL_GetWindowBrightness](https://wiki.libsdl.org/SDL_GetWindowBrightness)
* [SDL_GetWindowDisplayIndex](
https://wiki.libsdl.org/SDL_GetWindowDisplayIndex)
* [SDL_GetWindowDisplayMode](https://wiki.libsdl.org/SDL_GetWindowDisplayMode)
* [SDL_GetWindowFlags](https://wiki.libsdl.org/SDL_GetWindowFlags)
* [SDL_GetWindowGrab](https://wiki.libsdl.org/SDL_GetWindowGrab)
* [SDL_GetWindowID](https://wiki.libsdl.org/SDL_GetWindowID)
* [SDL_GetWindowMaximumSize](https://wiki.libsdl.org/SDL_GetWindowMaximumSize)
* [SDL_GetWindowMinimumSize](https://wiki.libsdl.org/SDL_GetWindowMinimumSize)
* [SDL_GetWindowOpacity](https://wiki.libsdl.org/SDL_GetWindowOpacity)
* [SDL_GetWindowPosition](https://wiki.libsdl.org/SDL_GetWindowPosition)
* [SDL_GetWindowSize](https://wiki.libsdl.org/SDL_GetWindowSize)
* [SDL_MaximizeWindow](https://wiki.libsdl.org/SDL_MaximizeWindow)
* [SDL_MinimizeWindow](https://wiki.libsdl.org/SDL_MinimizeWindow)
* [SDL_RaiseWindow](https://wiki.libsdl.org/SDL_RaiseWindow)
* [SDL_RestoreWindow](https://wiki.libsdl.org/SDL_RestoreWindow)
* [SDL_SetWindowBordered](https://wiki.libsdl.org/SDL_SetWindowBordered)
* [SDL_SetWindowBrightness](https://wiki.libsdl.org/SDL_SetWindowBrightness)
* [SDL_SetWindowDisplayMode](https://wiki.libsdl.org/SDL_SetWindowDisplayMode)
* [SDL_SetWindowFullscreen](https://wiki.libsdl.org/SDL_SetWindowFullscreen)
* [SDL_SetWindowGrab](https://wiki.libsdl.org/SDL_SetWindowGrab)
* [SDL_SetWindowInputFocus](https://wiki.libsdl.org/SDL_SetWindowInputFocus)
* [SDL_SetWindowMaximumSize](https://wiki.libsdl.org/SDL_SetWindowMaximumSize)
* [SDL_SetWindowMinimumSize](https://wiki.libsdl.org/SDL_SetWindowMinimumSize)
* [SDL_SetWindowModalFor](https://wiki.libsdl.org/SDL_SetWindowModalFor)
* [SDL_SetWindowOpacity](https://wiki.libsdl.org/SDL_SetWindowOpacity)
* [SDL_SetWindowPosition](https://wiki.libsdl.org/SDL_SetWindowPosition)
* [SDL_SetWindowResizable](https://wiki.libsdl.org/SDL_SetWindowResizable)
* [SDL_SetWindowSize](https://wiki.libsdl.org/SDL_SetWindowSize)
* [SDL_SetWindowTitle](https://wiki.libsdl.org/SDL_SetWindowTitle)
* [SDL_ShowWindow](https://wiki.libsdl.org/SDL_ShowWindow)
