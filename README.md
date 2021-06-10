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

#### Classes

Classes have been created to reflect every member of the
[SDL_EventType](https://wiki.libsdl.org/SDL_EventType) enumeration.

#### Functions

##### `Sdl` class

* [SDL_PumpEvents](https://wiki.libsdl.org/SDL_PumpEvents)
* [SDL_RegisterEvents](https://wiki.libsdl.org/SDL_RegisterEvents)

### [Audio Device Management, Playing and Recording](https://wiki.libsdl.org/CategoryAudio)

#### Classes

* `AudioDriver`
* `AudioDevice`
* `OpenAudioDevice`
* [SDL_AudioSpec](https://wiki.libsdl.org/SDL_AudioSpec)
* `WaveFile`

#### Enumerations

* [SDL_AudioStatus](https://wiki.libsdl.org/SDL_AudioStatus)

#### Functions

##### `Sdl` class

* [SDL_GetNumAudioDrivers](https://wiki.libsdl.org/SDL_GetNumAudioDrivers)
* [SDL_GetCurrentAudioDriver](https://wiki.libsdl.org/SDL_GetCurrentAudioDriver)
* [SDL_GetNumAudioDevices](https://wiki.libsdl.org/SDL_GetNumAudioDevices)
* `outputAudioDevices`
* `inputAudioDevices`
* [SDL_OpenAudioDevice](https://wiki.libsdl.org/SDL_OpenAudioDevice)

##### `AudioDriver` class

* [SDL_GetAudioDriver](https://wiki.libsdl.org/SDL_GetAudioDriver)

##### `AudioDevice` class

* [SDL_GetAudioDeviceName](https://wiki.libsdl.org/SDL_GetAudioDeviceName)
* [SDL_OpenAudioDevice](https://wiki.libsdl.org/SDL_OpenAudioDevice)

##### `OpenAudioDevice` class

* [SDL_ClearQueuedAudio](https://wiki.libsdl.org/SDL_ClearQueuedAudio)
* [SDL_CloseAudioDevice](https://wiki.libsdl.org/SDL_CloseAudioDevice)
* [SDL_GetAudioDeviceStatus](https://wiki.libsdl.org/SDL_GetAudioDeviceStatus)
* [SDL_GetQueuedAudioSize](https://wiki.libsdl.org/SDL_GetQueuedAudioSize)
* [SDL_LockAudioDevice](https://wiki.libsdl.org/SDL_LockAudioDevice)
* [SDL_UnlockAudioDevice](https://wiki.libsdl.org/SDL_UnlockAudioDevice)
* [SDL_PauseAudioDevice](https://wiki.libsdl.org/SDL_PauseAudioDevice)
* [SDL_QueueAudio](https://wiki.libsdl.org/SDL_QueueAudio)

##### `WaveFile` class

* [SDL_LoadWAV_RW](https://wiki.libsdl.org/SDL_LoadWAV_RW)

### [Force Feedback Support](https://wiki.libsdl.org/CategoryForceFeedback)

### [Joystick Support](https://wiki.libsdl.org/CategoryJoystick)

#### Classes

#### Functions

##### `Sdl` class

* [SDL_JoystickGetDeviceGUID](https://wiki.libsdl.org/SDL_JoystickGetDeviceGUID)
* [SDL_JoystickNameForIndex](https://wiki.libsdl.org/SDL_JoystickNameForIndex)
* [SDL_JoystickOpen](https://wiki.libsdl.org/SDL_JoystickOpen)
* [SDL_JoystickInstanceID](https://wiki.libsdl.org/SDL_JoystickInstanceID)

##### `Joystick` class

* [SDL_JoystickClose](https://wiki.libsdl.org/SDL_JoystickClose)
* [SDL_JoystickCurrentPowerLevel](https://wiki.libsdl.org/SDL_JoystickCurrentPowerLevel)
* [SDL_JoystickGetAttached](https://wiki.libsdl.org/SDL_JoystickGetAttached)
* [SDL_JoystickGetAxis](https://wiki.libsdl.org/SDL_JoystickGetAxis)
* [SDL_JoystickGetBall](https://wiki.libsdl.org/SDL_JoystickGetBall)
* [SDL_JoystickGetButton](https://wiki.libsdl.org/SDL_JoystickGetButton)
* [SDL_JoystickGetHat](https://wiki.libsdl.org/SDL_JoystickGetHat)
* [SDL_JoystickName](https://wiki.libsdl.org/SDL_JoystickName)
* [SDL_JoystickNumAxes](https://wiki.libsdl.org/SDL_JoystickNumAxes)
* [SDL_JoystickNumBalls](https://wiki.libsdl.org/SDL_JoystickNumBalls)
* [SDL_JoystickNumButtons](https://wiki.libsdl.org/SDL_JoystickNumButtons)
* [SDL_JoystickNumHats](https://wiki.libsdl.org/SDL_JoystickNumHats)
* [SDL_JoystickInstanceID](https://wiki.libsdl.org/SDL_JoystickInstanceID)
* [SDL_GameControllerFromInstanceID](https://wiki.libsdl.org/SDL_GameControllerFromInstanceID)

### [Game Controller Support](https://wiki.libsdl.org/CategoryGameController)

### Enumerations

* [SDL_GameControllerAxis](https://wiki.libsdl.org/SDL_GameControllerAxis)
* [SDL_GameControllerButton](https://wiki.libsdl.org/SDL_GameControllerButton)

#### Functions

##### `Sdl` class

* [SDL_GameControllerNameForIndex](https://wiki.libsdl.org/SDL_GameControllerNameForIndex)
* [SDL_GameControllerOpen](https://wiki.libsdl.org/SDL_GameControllerOpen)
* [SDL_IsGameController](https://wiki.libsdl.org/SDL_IsGameController)

##### `SdlGameControllerAxisValues` extension

* [SDL_GameControllerGetStringForAxis](https://wiki.libsdl.org/SDL_GameControllerGetStringForAxis)

##### `SdlGameControllerButtonValues` extension

* [SDL_GameControllerGetStringForButton](https://wiki.libsdl.org/SDL_GameControllerGetStringForButton)

##### `SdlStringValues` extension

* [SDL_GameControllerGetAxisFromString](https://wiki.libsdl.org/SDL_GameControllerGetAxisFromString)
* [SDL_GameControllerGetButtonFromString](https://wiki.libsdl.org/SDL_GameControllerGetButtonFromString)

##### `GameController` class

* [SDL_GameControllerClose](https://wiki.libsdl.org/SDL_GameControllerClose)
* [SDL_GameControllerGetAttached](https://wiki.libsdl.org/SDL_GameControllerGetAttached)
* [SDL_GameControllerGetAxis](https://wiki.libsdl.org/SDL_GameControllerGetAxis)
* [SDL_GameControllerGetButton](https://wiki.libsdl.org/SDL_GameControllerGetButton)
* [SDL_GameControllerGetJoystick](https://wiki.libsdl.org/SDL_GameControllerGetJoystick)
* [SDL_GameControllerName](https://wiki.libsdl.org/SDL_GameControllerName)
