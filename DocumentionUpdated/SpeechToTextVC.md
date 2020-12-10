# SpeechToTextVC

``` swift
class SpeechToTextVC: UIViewController
```

## Inheritance

`SFSpeechRecognizerDelegate`, `UIViewController`, `UIViewController`

## Properties

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

### `textView`

``` swift
let textView
```

### `liveButton`

``` swift
let liveButton
```

### `supportedInterfaceOrientations`

``` swift
var supportedInterfaceOrientations: UIInterfaceOrientationMask
```

## Methods

### `viewDidLoad()`

``` swift
override func viewDidLoad()
```

### `viewWillTransition(to:with:)`

``` swift
override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator)
```

### `viewDidAppear(_:)`

``` swift
override public func viewDidAppear(_ animated: Bool)
```

### `startRecording()`

``` swift
private func startRecording() throws
```

### `speechRecognizer(_:availabilityDidChange:)`

``` swift
public func speechRecognizer(_ speechRecognizer: SFSpeechRecognizer, availabilityDidChange available: Bool)
```

### `record()`

``` swift
func record()
```

### `textViewSetup()`

``` swift
func textViewSetup()
```

### `liveButtonSetup()`

``` swift
func liveButtonSetup()
```

### `liveButtonTapped()`

``` swift
@objc func liveButtonTapped()
```

### `viewDidLoad()`

``` swift
override func viewDidLoad()
```
