# ModelDataHandler

This class handles all data preprocessing and makes calls to run inference on a given frame
by invoking the `Interpreter`. It then formats the inferences obtained and returns the top N
results for a successful inference.

``` swift
class ModelDataHandler
```

## Initializers

### `init?(modelFileInfo:labelsFileInfo:threadCount:)`

A failable initializer for `ModelDataHandler`. A new instance is created if the model and
labels files are successfully loaded from the app's main bundle. Default `threadCount` is 1.

``` swift
init?(modelFileInfo: FileInfo, labelsFileInfo: FileInfo, threadCount: Int = 1)
```

## Properties

### `threadCount`

The current thread count used by the TensorFlow Lite Interpreter.

``` swift
let threadCount: Int
```

### `resultCount`

The number of results to get from the model.

``` swift
let resultCount
```

### `threadCountLimit`

The number of threads that can be deployed.

``` swift
let threadCountLimit
```

### `batchSize`

How many samples propagate through the network at once

``` swift
let batchSize
```

### `inputChannels`

How many channels in the image (3 for RGB or 4 if it’s RGBA, but it shouldn’t be RGBA in our case.)

``` swift
let inputChannels
```

### `inputWidth`

the width the input is scaled to

``` swift
let inputWidth
```

### `inputHeight`

The height the input is scaled to

``` swift
let inputHeight
```

### `labels`

List of labels from the given labels file.

``` swift
var labels: [String]
```

### `interpreter`

TensorFlow Lite `Interpreter` object for performing inference on a given model.

``` swift
var interpreter: Interpreter
```

### `alphaComponent`

Information about the alpha component in RGBA data.

``` swift
let alphaComponent
```

## Methods

### `runModel(onFrame:)`

Performs image preprocessing, invokes the `Interpreter`, and processes the inference results.

``` swift
func runModel(onFrame pixelBuffer: CVPixelBuffer) -> Result?
```

### `getTopN(results:)`

Returns the top N inference results sorted in descending order.

``` swift
private func getTopN(results: [Float]) -> [Inference]
```

### `loadLabels(fileInfo:)`

Loads the labels from the labels file and stores them in the `labels` property.

``` swift
private func loadLabels(fileInfo: FileInfo)
```

### `rgbDataFromBuffer(_:byteCount:isModelQuantized:)`

Returns the RGB data representation of the given image buffer with the specified `byteCount`.

``` swift
private func rgbDataFromBuffer(_ buffer: CVPixelBuffer, byteCount: Int, isModelQuantized: Bool) -> Data?
```

  - Parameters
      - buffer: The pixel buffer to convert to RGB data.
      - byteCount: The expected byte count for the RGB data calculated using the values that the
        model was trained on: `batchSize * imageWidth * imageHeight * componentsCount`.
      - isModelQuantized: Whether the model is quantized (i.e. fixed point values rather than
        floating point values).

#### Returns

The RGB data representation of the image buffer or `nil` if the buffer could not be converted.
