# ViewController

``` swift
class ViewController: UIViewController
```

## Inheritance

[`CameraFeedManagerDelegate`](CameraFeedManagerDelegate), `UIViewController`

## Properties

### `remoteChatButton`

``` swift
let remoteChatButton
```

### `liveChatButton`

``` swift
let liveChatButton
```

### `notesButton`

``` swift
let notesButton
```

### `buttonStack`

``` swift
let buttonStack
```

### `liveButton`

``` swift
let liveButton
```

### `tabController`

``` swift
let tabController
```

### `outputTextView`

``` swift
let outputTextView
```

### `textViewHolder`

``` swift
let textViewHolder
```

### `speakerButton`

``` swift
let speakerButton
```

### `controlButtonStack`

``` swift
let controlButtonStack
```

### `clearButton`

``` swift
let clearButton
```

### `keyboardButton`

``` swift
let keyboardButton
```

### `trainButton`

``` swift
let trainButton
```

### `heightAnchor`

``` swift
var heightAnchor
```

### `controlViewHeightAnchor`

``` swift
var controlViewHeightAnchor
```

### `chatLogButton`

``` swift
let chatLogButton
```

### `controlView`

``` swift
let controlView
```

### `controlButton`

``` swift
let controlButton
```

### `slider`

``` swift
let slider
```

### `speechSpeedDegree`

``` swift
var speechSpeedDegree
```

### `controlButtonStackBottomAnchor`

``` swift
var controlButtonStackBottomAnchor
```

### `predictionAssistButton`

``` swift
let predictionAssistButton
```

### `speechRecognizer`

``` swift
let speechRecognizer
```

### `recognitionRequest`

``` swift
var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
```

### `recognitionTask`

``` swift
var recognitionTask: SFSpeechRecognitionTask?
```

### `audioEngine`

``` swift
let audioEngine
```

### `synthesizer`

``` swift
var synthesizer
```

### `topBar`

``` swift
let topBar
```

### `previewView`

``` swift
var previewView
```

### `cameraUnavailableLabel`

``` swift
let cameraUnavailableLabel
```

### `resumeButton`

``` swift
let resumeButton
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

### `lastNonLetter`

``` swift
var lastNonLetter: String?
```

### `lastLetter`

``` swift
var lastLetter
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

### `cameraCapture`

``` swift
var cameraCapture
```

### `modelDataHandler`

``` swift
var modelDataHandler: ModelDataHandler?
```

### `preferredStatusBarStyle`

This indicates the color of the status bar

``` swift
var preferredStatusBarStyle: UIStatusBarStyle
```

## Methods

### `traitCollectionDidChange(_:)`

``` swift
override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?)
```

### `viewWillTransition(to:with:)`

``` swift
override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator)
```

### `viewDidLoad()`

``` swift
override func viewDidLoad()
```

### `keyboardWillShow(notification:)`

``` swift
@objc func keyboardWillShow(notification: NSNotification)
```

### `keyboardWillHide(notification:)`

``` swift
@objc func keyboardWillHide(notification: NSNotification)
```

### `handleSwipeUpGesture(_:)`

``` swift
@objc func handleSwipeUpGesture(_ sender: UISwipeGestureRecognizer)
```

### `handleDownSwipeGesture(_:)`

``` swift
@objc func handleDownSwipeGesture(_ sender: UISwipeGestureRecognizer)
```

### `handleLeftSwipeGesture(_:)`

``` swift
@objc func handleLeftSwipeGesture(_ sender: UISwipeGestureRecognizer)
```

### `handleRightSwipeGesture(_:)`

``` swift
@objc func handleRightSwipeGesture(_ sender: UISwipeGestureRecognizer)
```

### `viewWillAppear(_:)`

``` swift
override func viewWillAppear(_ animated: Bool)
```

### `viewWillDisappear(_:)`

<dl>
<dt><code>!targetEnvironment(simulator)</code></dt>
<dd>

``` swift
override func viewWillDisappear(_ animated: Bool)
```

</dd>
</dl>

### `presentUnableToResumeSessionAlert()`

``` swift
func presentUnableToResumeSessionAlert()
```

### `prepare(for:sender:)`

Prepare for Segue to next storyboard view controller.

``` swift
override func prepare(for segue: UIStoryboardSegue, sender: Any?)
```

### `classifyPasteboardImage()`

``` swift
@objc func classifyPasteboardImage()
```

### `didOutput(pixelBuffer:)`

``` swift
func didOutput(pixelBuffer: CVPixelBuffer)
```

### `sessionWasInterrupted(canResumeManually:)`

``` swift
func sessionWasInterrupted(canResumeManually resumeManually: Bool)
```

### `sessionInterruptionEnded()`

``` swift
func sessionInterruptionEnded()
```

### `sessionRunTimeErrorOccured()`

``` swift
func sessionRunTimeErrorOccured()
```

### `presentCameraPermissionsDeniedAlert()`

``` swift
func presentCameraPermissionsDeniedAlert()
```

### `presentVideoConfigurationErrorAlert()`

``` swift
func presentVideoConfigurationErrorAlert()
```

### `previewViewSetup()`

``` swift
func previewViewSetup()
```

### `topBarSetup()`

``` swift
func topBarSetup()
```

### `cameraUnavailableLabelSetup()`

``` swift
func cameraUnavailableLabelSetup()
```

### `resumeButtonSetup()`

``` swift
func resumeButtonSetup()
```

### `remoteChatButtonSetup()`

``` swift
func remoteChatButtonSetup()
```

### `remoteChatButtonTapped()`

``` swift
@objc func remoteChatButtonTapped()
```

### `liveButtonSetup()`

``` swift
func liveButtonSetup()
```

### `liveButtonTapped()`

``` swift
@objc func liveButtonTapped()
```

### `notesButtonSetup()`

``` swift
func notesButtonSetup()
```

### `checkIfLoggedOut()`

checks if there is a user logged in. If there is not, it opens the login VC

``` swift
func checkIfLoggedOut()
```

### `notesButtonTapped()`

``` swift
@objc func notesButtonTapped()
```

### `textViewHolderSetup()`

``` swift
func textViewHolderSetup()
```

### `outputTextViewSetup()`

``` swift
func outputTextViewSetup()
```

### `speak()`

``` swift
func speak()
```

### `speakerButtonSetup()`

``` swift
func speakerButtonSetup()
```

### `speakerButtonTapped()`

``` swift
@objc func speakerButtonTapped()
```

### `trainButtonSetup()`

``` swift
func trainButtonSetup()
```

### `clearButtonSetup()`

``` swift
func clearButtonSetup()
```

### `clearButtonTapped()`

``` swift
@objc func clearButtonTapped()
```

### `controlButtonStackSetup()`

``` swift
func controlButtonStackSetup()
```

### `keyboardButtonSetup()`

``` swift
func keyboardButtonSetup()
```

### `keyboardButtonTapped()`

``` swift
@objc func keyboardButtonTapped()
```

### `controlViewSetup()`

``` swift
func controlViewSetup()
```

### `controlButtonSetup()`

``` swift
func controlButtonSetup()
```

### `controlButtonTapped(_:)`

``` swift
@objc func controlButtonTapped(_ sender: UIButton)
```

### `chatLogButtonSetup()`

``` swift
func chatLogButtonSetup()
```

### `predictionAssistButtonSetup()`

``` swift
func predictionAssistButtonSetup()
```

### `predictionAssistButtonTapped()`

``` swift
@objc func predictionAssistButtonTapped()
```

### `collapseButtonTapped()`

``` swift
@objc func collapseButtonTapped()
```

### `sliderSetup()`

``` swift
func sliderSetup()
```

### `changeValue(_:)`

``` swift
@objc func changeValue(_ sender: UISlider)
```

### `deleteCharacter()`

``` swift
func deleteCharacter()
```

### `addSpace()`

``` swift
func addSpace()
```

### `executeASLtoText()`

``` swift
func executeASLtoText()
```
