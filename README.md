# dart_sdl

This package wraps the [SDL](https://wiki.libsdl.org/) package.

I have been implementing functions as I needed them. As such, this library is
not complete. I of course welcome
[issues](https://github.com/chrisnorman7/dart_sdl/issues/new).

## Reading this document

Since most names in Dart are camelCase translations from their SDL equivalents,
only links to SDL functions are included.

For each section of the [API](https://wiki.libsdl.org/APIByCategory), a link to
the category is provided, followed by a few sections:

### Classes

In some cases it is necessary to create Dart-side classes to replace SDL
structs. Links to the SDL originals should be listed in this section.

### Enumerations

Where an SDL enum has been translated to dart, a link to the original enum
should be placed in this section.

### Functions

This section should contain subsections for each Dart class that methods are
attached to.

Each section heading should be a link to the Dart class the method is attached
to, and each entry in the function list should be a link to the original SDL
function.

## Progress

### [Initialization and Shutdown](https://wiki.libsdl.org/CategoryInit)

#### Functions

##### `Sdl` class

* [SDL_Init](https://wiki.libsdl.org/SDL_Init)
* [SDL_Quit](https://wiki.libsdl.org/SDL_Quit)
* [SDL_SetMainReady](https://wiki.libsdl.org/SDL_SetMainReady)
* [SDL_WasInit](https://wiki.libsdl.org/SDL_WasInit)

### [Configuration Variables](https://wiki.libsdl.org/CategoryHints)

#### Enumerations

* [SDL_HintPriority](https://wiki.libsdl.org/SDL_HintPriority)

#### Functions

##### `Sdl` class

* [SDL_SetHint](https://wiki.libsdl.org/SDL_SetHint)
* [SDL_SetHintWithPriority](https://wiki.libsdl.org/SDL_SetHintWithPriority)
* [SDL_ClearHints](https://wiki.libsdl.org/SDL_ClearHints)

### [Error Handling](https://wiki.libsdl.org/CategoryError)

#### Functions

##### `Sdl` class

* [SDL_ClearError](https://wiki.libsdl.org/SDL_ClearError)
* [SDL_GetError](https://wiki.libsdl.org/SDL_GetError)
* [SDL_SetError](https://wiki.libsdl.org/SDL_SetError)

### [Log Handling](https://wiki.libsdl.org/CategoryLog)

#### Enumerations

* [SDL_LOG_CATEGORY](https://wiki.libsdl.org/SDL_LOG_CATEGORY)
* [SDL_LogPriority](https://wiki.libsdl.org/SDL_LogPriority).

#### Functions

##### `Sdl` class

* [SDL_Log](https://wiki.libsdl.org/SDL_Log)
* [SDL_LogCritical](https://wiki.libsdl.org/SDL_LogCritical)
* [SDL_LogDebug](https://wiki.libsdl.org/SDL_LogDebug)
* [SDL_LogError](https://wiki.libsdl.org/SDL_LogError)
* [SDL_LogGetPriority](https://wiki.libsdl.org/SDL_LogGetPriority)
* [SDL_LogInfo](https://wiki.libsdl.org/SDL_LogInfo)
* [SDL_LogMessage](https://wiki.libsdl.org/SDL_LogMessage)
* [SDL_LogResetPriorities](https://wiki.libsdl.org/SDL_LogResetPriorities)
* [SDL_LogSetAllPriority](https://wiki.libsdl.org/SDL_LogSetAllPriority)
* [SDL_LogSetPriority](https://wiki.libsdl.org/SDL_LogSetPriority)
* [SDL_LogVerbose](https://wiki.libsdl.org/SDL_LogVerbose)
* [SDL_LogWarn](https://wiki.libsdl.org/SDL_LogWarn)

### [Assertions](https://wiki.libsdl.org/CategoryAssertions)

Not implemented.

### [Querying SDL Version](https://wiki.libsdl.org/CategoryVersion)

#### Classes

* [SDL_version](https://wiki.libsdl.org/SDL_version)

#### Functions

##### `Sdl` class

* [SDL_GetRevision](https://wiki.libsdl.org/SDL_GetRevision)
* [SDL_GetRevisionNumber](https://wiki.libsdl.org/SDL_GetRevisionNumber)
* [SDL_GetVersion](https://wiki.libsdl.org/SDL_GetVersion)

### [Display and Window Management](https://wiki.libsdl.org/CategoryVideo)

#### Classes

* [SDL_MessageBoxButtonData](https://wiki.libsdl.org/SDL_MessageBoxButtonData).

#### Enumerations

* [SDL_BlendMode](https://wiki.libsdl.org/SDL_BlendMode) as `BlendMode`.
* [SDL_MessageBoxButtonFlags](https://wiki.libsdl.org/SDL_MessageBoxButtonFlags)
* [SDL_MessageBoxFlags](https://wiki.libsdl.org/SDL_MessageBoxFlags)

#### Functions

##### `Sdl` class

* [SDL_CreateWindow](https://wiki.libsdl.org/SDL_CreateWindow)
* [SDL_DestroyWindow](https://wiki.libsdl.org/SDL_DestroyWindow)
* [SDL_GetNumVideoDisplays](https://wiki.libsdl.org/SDL_GetNumVideoDisplays)
* [SDL_GetNumVideoDrivers](https://wiki.libsdl.org/SDL_GetNumVideoDrivers)
* [SDL_GetVideoDriver](https://wiki.libsdl.org/SDL_GetVideoDriver)
* [SDL_GL_GetCurrentWindow](https://wiki.libsdl.org/SDL_GL_GetCurrentWindow)
* [SDL_ShowMessageBox](https://wiki.libsdl.org/SDL_ShowMessageBox)
* [SDL_ShowSimpleMessageBox](https://wiki.libsdl.org/SDL_ShowSimpleMessageBox)
* [SDL_IsScreenSaverEnabled](https://wiki.libsdl.org/SDL_IsScreenSaverEnabled)
* [SDL_DisableScreenSaver](https://wiki.libsdl.org/SDL_DisableScreenSaver)
* [SDL_EnableScreenSaver](https://wiki.libsdl.org/SDL_EnableScreenSaver)

##### `Display` class

* [SDL_GetDisplayName](https://wiki.libsdl.org/SDL_GetDisplayName)
* [SDL_GetDisplayBounds](https://wiki.libsdl.org/SDL_GetDisplayBounds)
* [SDL_GetDisplayUsableBounds](
  https://wiki.libsdl.org/SDL_GetDisplayUsableBounds)
* [SDL_GetDesktopDisplayMode](
  https://wiki.libsdl.org/SDL_GetDesktopDisplayMode)
* [SDL_GetDisplayMode](https://wiki.libsdl.org/SDL_GetDisplayMode)

##### `Window` class

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

### [Clipboard Handling](https://wiki.libsdl.org/CategoryClipboard)

#### Functions

##### `Sdl` class

* [SDL_GetClipboardText](https://wiki.libsdl.org/SDL_GetClipboardText)
* [SDL_HasClipboardText](https://wiki.libsdl.org/SDL_HasClipboardText)
* [SDL_SetClipboardText](https://wiki.libsdl.org/SDL_SetClipboardText)

### [Event Handling](https://wiki.libsdl.org/CategoryEvents)
