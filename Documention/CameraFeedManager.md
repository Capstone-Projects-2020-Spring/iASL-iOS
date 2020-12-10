# CameraFeedManager

This class manages all camera related functionality

``` swift
class CameraFeedManager: NSObject
```

## Inheritance

`AVCaptureVideoDataOutputSampleBufferDelegate`, `NSObject`

## Initializers

### `init(previewView:)`

``` swift
init(previewView: PreviewView)
```

## Properties

### `session`

``` swift
let session: AVCaptureSession
```

### `previewView`

``` swift
let previewView: PreviewView
```

### `sessionQueue`

``` swift
let sessionQueue
```

### `cameraConfiguration`

``` swift
var cameraConfiguration: CameraConfiguration
```

### `videoDataOutput`

``` swift
var videoDataOutput
```

### `isSessionRunning`

``` swift
var isSessionRunning
```

### `delegate`

``` swift
var delegate: CameraFeedManagerDelegate?
```

## Methods

### `checkCameraConfigurationAndStartSession()`

This method starts an AVCaptureSession based on whether the camera configuration was successful.

``` swift
func checkCameraConfigurationAndStartSession()
```

### `stopSession()`

This method stops a running an AVCaptureSession.

``` swift
func stopSession()
```

### `resumeInterruptedSession(withCompletion:)`

This method resumes an interrupted AVCaptureSession.

``` swift
func resumeInterruptedSession(withCompletion completion: @escaping (Bool) -> Void)
```

### `startSession()`

This method starts the AVCaptureSession
\*

``` swift
private func startSession()
```

### `attemptToConfigureSession()`

This method requests for camera permissions and handles the configuration of the session and stores the result of configuration.

``` swift
private func attemptToConfigureSession()
```

### `requestCameraAccess(completion:)`

This method requests for camera permissions.

``` swift
private func requestCameraAccess(completion: @escaping (Bool) -> Void)
```

### `configureSession()`

This method handles all the steps to configure an AVCaptureSession.

``` swift
private func configureSession()
```

### `addVideoDeviceInput()`

This method tries to an AVCaptureDeviceInput to the current AVCaptureSession.

``` swift
private func addVideoDeviceInput() -> Bool
```

### `addVideoDataOutput()`

This method tries to an AVCaptureVideoDataOutput to the current AVCaptureSession.

``` swift
private func addVideoDataOutput() -> Bool
```

### `addObservers()`

``` swift
private func addObservers()
```

### `removeObservers()`

``` swift
private func removeObservers()
```

### `sessionWasInterrupted(notification:)`

``` swift
@objc func sessionWasInterrupted(notification: Notification)
```

### `sessionInterruptionEnded(notification:)`

``` swift
@objc func sessionInterruptionEnded(notification: Notification)
```

### `sessionRuntimeErrorOccured(notification:)`

``` swift
@objc func sessionRuntimeErrorOccured(notification: Notification)
```

### `captureOutput(_:didOutput:from:)`

This method delegates the CVPixelBuffer of the frame seen by the camera currently.

``` swift
func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection)
```
