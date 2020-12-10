# ChatMessageCell

This is a custom cell for the collection view we use in the chat view contoller. It creates and handles the bubbles for each message sent and received and their location on the view.

``` swift
class ChatMessageCell: UICollectionViewCell
```

## Inheritance

`UICollectionViewCell`

## Initializers

### `init(frame:)`

This is called each time the collection view cell is used. It is being used to call the set up functions for the message bubbles and the text view that holds the text

``` swift
override init(frame: CGRect)
```

### `init?(coder:)`

Required function for checking if there is a fatal error

``` swift
required init?(coder: NSCoder)
```

## Properties

### `bubbleViewWidthAnchor`

Reference variable for the message bubble view's width anchor. Helpful for later changing the bubble from a pink sender to a gray receiver message.

``` swift
var bubbleViewWidthAnchor: NSLayoutConstraint?
```

### `bubbleViewRightAnchor`

Reference variable for the messaging bubble view's right anchor. Helpful for later changing the bubble from a pink sender to a gray receiver message.

``` swift
var bubbleViewRightAnchor: NSLayoutConstraint?
```

### `bubbleViewLeftAnchor`

Reference variable for the messaging bubble view's left anchor. Helpful for later changing the bubble from a pink sender to a gray receiver message.

``` swift
var bubbleViewLeftAnchor: NSLayoutConstraint?
```

### `textView`

This is the textview that holds the actual text of a message sent or received

``` swift
let textView: UITextView
```

### `bubbleView`

This is a custom view closure that shapes the message bubbles

``` swift
let bubbleView: UIView
```

## Methods

### `bubbleViewSetup()`

Adds the bubble view to the subview and sets the constraints for the bubble view

``` swift
func bubbleViewSetup()
```

### `textViewSetup()`

Adds the text view to the subview and defines the constraints for the text view

``` swift
func textViewSetup()
```
