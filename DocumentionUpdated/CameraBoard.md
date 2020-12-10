# CameraBoard

``` swift
class CameraBoard: UIView
```

## Inheritance

[`CameraFeedManagerDelegate`](CameraFeedManagerDelegate), `UIView`

## Initializers

### `init(target:)`

``` swift
init(target: UIKeyInput)
```

### `init?(coder:)`

``` swift
required init?(coder: NSCoder)
```

## Properties

### `caboardView`

``` swift
let caboardView
```

### `previewView`

``` swift
let previewView
```

### `nextButton`

``` swift
let nextButton
```

### `deleteButton`

``` swift
let deleteButton
```

### `cameraUnavailableLabel`

``` swift
let cameraUnavailableLabel
```

### `resumeButton`

``` swift
let resumeButton
```

### `buttonStack`

``` swift
let buttonStack
```

### `keyboardChangeButton`

``` swift
let keyboardChangeButton
```

### `predictionButton`

``` swift
var predictionButton
```

### `predictionStack`

``` swift
let predictionStack
```

### `stringCache`

``` swift
var stringCache
```

### `lastLetter`

``` swift
var lastLetter
```

### `lastNonLetter`

``` swift
var lastNonLetter: String?
```

### `recurCount`

``` swift
var recurCount
```

### `recurCountNonLetter`

``` swift
var recurCountNonLetter
```

### `minimumConfidence`

``` swift
let minimumConfidence: Float
```

### `prediction`

``` swift
var prediction
```

### `target`

``` swift
var target: UIKeyInput?
```

### `animationDuration`

``` swift
let animationDuration
```

### `collapseTransitionThreshold`

``` swift
let collapseTransitionThreshold: CGFloat
```

### `expandThransitionThreshold`

``` swift
let expandThransitionThreshold: CGFloat
```

### `delayBetweenInferencesMs`

``` swift
let delayBetweenInferencesMs: Double
```

### `result`

``` swift
var result: Result?
```

### `initialBottomSpace`

``` swift
var initialBottomSpace: CGFloat
```

### `previousInferenceTimeMs`

``` swift
var previousInferenceTimeMs: TimeInterval
```

### `cameraCapture`

``` swift
var cameraCapture
```

### `modelDataHandler`

``` swift
var modelDataHandler: ModelDataHandler?
```

## Methods

### `willMove(toSuperview:)`

``` swift
override func willMove(toSuperview newSuperview: UIView?)
```

### `willRemoveSubview(_:)`

``` swift
override func willRemoveSubview(_ subview: UIView)
```

### `showPredictionLetterInStack(_:_:_:)`

``` swift
fileprivate func showPredictionLetterInStack(_ prediction: String, _ confidence: Float, _ count: Int)
```

### `setPredictionToDelete()`

``` swift
fileprivate func setPredictionToDelete()
```

### `setPredictiontoSpace()`

``` swift
fileprivate func setPredictiontoSpace()
```

### `setPredictionToNothing()`

``` swift
fileprivate func setPredictionToNothing()
```

### `didOutput(pixelBuffer:)`

``` swift
func didOutput(pixelBuffer: CVPixelBuffer)
```

### `predictWord()`

``` swift
func predictWord()
```

### `presentCameraPermissionsDeniedAlert()`

``` swift
func presentCameraPermissionsDeniedAlert()
```

### `presentVideoConfigurationErrorAlert()`

``` swift
func presentVideoConfigurationErrorAlert()
```

### `sessionRunTimeErrorOccured()`

``` swift
func sessionRunTimeErrorOccured()
```

### `sessionWasInterrupted(canResumeManually:)`

``` swift
func sessionWasInterrupted(canResumeManually resumeManually: Bool)
```

### `sessionInterruptionEnded()`

``` swift
func sessionInterruptionEnded()
```

### `predictionStackSetup()`

``` swift
func predictionStackSetup()
```

### `updateStack(prediction:)`

``` swift
func updateStack(prediction: [String])
```

### `predictionButtonHoldDown(_:)`

``` swift
@objc func predictionButtonHoldDown(_ sender: UIButton)
```

### `predictionButtonTapped(_:)`

``` swift
@objc func predictionButtonTapped(_ sender: UIButton)
```

### `caboardViewSetup()`

``` swift
func caboardViewSetup()
```

### `previewViewSetup()`

``` swift
func previewViewSetup()
```

### `nextButtonSetup()`

``` swift
func nextButtonSetup()
```

### `returnKeyPressed()`

``` swift
@objc func returnKeyPressed()
```

### `buttonStackSetup()`

``` swift
func buttonStackSetup()
```

### `deleteButtonSetup()`

``` swift
func deleteButtonSetup()
```

### `handleLongPress()`

``` swift
@objc func handleLongPress()
```

### `deleteChar(completion:)`

``` swift
@objc func deleteChar(completion: @escaping () -> Void)
```

### `keyboardButtonSetup()`

``` swift
func keyboardButtonSetup()
```

### `bottomCoverSetup()`

``` swift
func bottomCoverSetup()
```

### `classifyPasteboardImage()`

``` swift
@objc func classifyPasteboardImage()
```
