# PreviewView

Displays a preview of the image being processed. By default, this uses the device's camera frame,
but will use a still image copied from clipboard if `shouldUseClipboardImage` is set to true.

``` swift
class PreviewView: UIView
```

## Inheritance

`UIView`

## Properties

### `shouldUseClipboardImage`

Use a still image copied from clipboard for testing in Simulator.

``` swift
var shouldUseClipboardImage: Bool
```

### `imageView`

An object that displays a single image in our interface.

``` swift
var imageView: UIImageView
```

### `image`

An object that manages image data.

``` swift
var image: UIImage?
```

### `previewLayer`

A Core Animation layer that displays the video as it’s captured.

``` swift
var previewLayer: AVCaptureVideoPreviewLayer
```

### `session`

An object that manages capture activity and coordinates the flow of data from input devices to capture outputs.

``` swift
var session: AVCaptureSession?
```

### `layerClass`

``` swift
var layerClass: AnyClass
```
