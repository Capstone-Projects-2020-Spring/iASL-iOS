# ChatMessageCell

``` swift
class ChatMessageCell: UICollectionViewCell
```

## Inheritance

`UICollectionViewCell`

## Initializers

### `init(frame:)`

``` swift
override init(frame: CGRect)
```

### `init?(coder:)`

``` swift
required init?(coder: NSCoder)
```

## Properties

### `textView`

``` swift
let textView: UITextView
```

### `bubbleView`

``` swift
let bubbleView: UIView
```

### `bubbleViewWidthAnchor`

``` swift
var bubbleViewWidthAnchor: NSLayoutConstraint?
```

### `bubbleViewRightAnchor`

``` swift
var bubbleViewRightAnchor: NSLayoutConstraint?
```

### `bubbleViewLeftAnchor`

``` swift
var bubbleViewLeftAnchor: NSLayoutConstraint?
```

## Methods

### `bubbleViewSetup()`

``` swift
func bubbleViewSetup()
```

### `textViewSetup()`

``` swift
func textViewSetup()
```
