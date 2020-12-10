# ChatUserCell

This class is for creating a custom cell in the table view of our main messaging feature screen. It handles the design of all the pieces that make up our custom cell and hanldes some logic for handling which information goes where.

``` swift
class ChatUserCell: UITableViewCell
```

## Inheritance

`UITableViewCell`

## Initializers

### `init(style:reuseIdentifier:)`

Init function that is called whenever this class is used. This calls the main set up functions for the constraints and the subviews

``` swift
override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?)
```

### `init?(coder:)`

Required init function in case of fatal error

``` swift
required init?(coder: NSCoder)
```

## Properties

### `nameLabel`

This is a closure for the label that holds the name of the chatter

``` swift
let nameLabel: UILabel
```

### `mostRecentMessageLabel`

This is a closure for the label that holds the text of the most recent message sent in the chat

``` swift
let mostRecentMessageLabel: UILabel
```

### `timestampLabel`

This is a closure for the timestamp label that holds the time that the most recently sent message was sent

``` swift
let timestampLabel: UILabel
```

### `message`

In the table view, this sets the message and does the work for getting the name of the user and the message

``` swift
var message: Message?
```

## Methods

### `setNameLabel(_:)`

Sets the name label to the name gotten by the message variable

``` swift
fileprivate func setNameLabel(_ id: String)
```

### `setMostRecentMessageLabel(_:)`

Sets the most recent message label gotten by the message variable

``` swift
fileprivate func setMostRecentMessageLabel(_ messageText: String)
```

### `setTimestampLabel(_:)`

Sets the timestamp label gotten by the message variable

``` swift
fileprivate func setTimestampLabel(_ milliseconds: Double)
```

### `layoutSubviews()`

Function for laying out the subviews

``` swift
override func layoutSubviews()
```

### `setupNameLabel()`

Adds the name label to the subview and defines where in the subveiw it will be placed

``` swift
func setupNameLabel()
```

### `setupMessageLabel()`

Adds the most recent message label to the subview and defines where in the subveiw it will be placed

``` swift
func setupMessageLabel()
```

### `setupTimestampLabel()`

Adds the timestamp label to the subview and defines where in the subveiw it will be placed

``` swift
func setupTimestampLabel()
```
