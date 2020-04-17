# ChatUserCell

``` swift
class ChatUserCell: UITableViewCell
```

## Inheritance

`UITableViewCell`

## Initializers

### `init(style:reuseIdentifier:)`

``` swift
override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?)
```

### `init?(coder:)`

``` swift
required init?(coder: NSCoder)
```

## Properties

### `message`

``` swift
var message: Message?
```

### `nameLabel`

``` swift
let nameLabel: UILabel
```

### `mostRecentMessageLabel`

``` swift
let mostRecentMessageLabel: UILabel
```

### `timestampLabel`

``` swift
let timestampLabel: UILabel
```

## Methods

### `layoutSubviews()`

``` swift
override func layoutSubviews()
```

### `setupNameLabel()`

``` swift
func setupNameLabel()
```

### `setupMessageLabel()`

``` swift
func setupMessageLabel()
```

### `setupTimestampLabel()`

``` swift
func setupTimestampLabel()
```
