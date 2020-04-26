# CameraFeedVideoManagerDelegate

``` swift
protocol CameraFeedVideoManagerDelegate: class
```

## Inheritance

`class`

## Requirements

## didOutput(pixelBuffer:)

This method delivers the pixel buffer of the current frame seen by the device's camera.

``` swift
func didOutput(pixelBuffer: CVPixelBuffer)
```

## presentCameraPermissionsDeniedAlert()

This method initimates that the camera permissions have been denied.

``` swift
func presentCameraPermissionsDeniedAlert()
```

## presentVideoConfigurationErrorAlert()

This method initimates that there was an error in video configurtion.

``` swift
func presentVideoConfigurationErrorAlert()
```

## sessionRunTimeErrorOccured()

This method initimates that a session runtime error occured.

``` swift
func sessionRunTimeErrorOccured()
```

## sessionWasInterrupted(canResumeManually:)

This method initimates that the session was interrupted.

``` swift
func sessionWasInterrupted(canResumeManually resumeManually: Bool)
```

## sessionInterruptionEnded()

This method initimates that the session interruption has ended.

``` swift
func sessionInterruptionEnded()
```
