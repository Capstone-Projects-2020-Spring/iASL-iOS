# NotesTableViewCell

``` swift
class NotesTableViewCell: UITableViewCell
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

### `note`

``` swift
var note: Note?
```

### `titleLabel`

``` swift
let titleLabel: UILabel
```

### `noteLabel`

``` swift
let noteLabel: UILabel
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

### `setupTitleLabel()`

``` swift
func setupTitleLabel()
```

### `setupNoteLabel()`

``` swift
func setupNoteLabel()
```

### `setupTimestampLabel()`

``` swift
func setupTimestampLabel()
```
