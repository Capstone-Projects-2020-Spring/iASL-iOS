# NotesTableViewCell

This class is a custom table view cell for the table view in our notes feature. It handles the constraints for each subview and also helps with some logic in setting the note information in its proper place.

``` swift
class NotesTableViewCell: UITableViewCell
```

## Inheritance

`UITableViewCell`

## Initializers

### `init(style:reuseIdentifier:)`

Function called every time this table view cell is used. It is being used to call the setup function for the subviews of this table view cell.

``` swift
override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?)
```

### `init?(coder:)`

Required function for checking if there was a fatal error

``` swift
required init?(coder: NSCoder)
```

## Properties

### `note`

This is of type Note from our custom swift class and it helps with the logic of setting the note information in each table view cell. It sets the title, the text, and the time.

``` swift
var note: Note?
```

### `titleLabel`

A closure for the note title label

``` swift
let titleLabel: UILabel
```

### `noteLabel`

A closure for the label for the text of a note

``` swift
let noteLabel: UILabel
```

### `timestampLabel`

A closure for the label for the time a note was created

``` swift
let timestampLabel: UILabel
```

## Methods

### `setNoteLabel(_:)`

Sets the note label from the note variable

``` swift
fileprivate func setNoteLabel(_ noteText: String)
```

### `setTimestampLabel(_:)`

Sets the timestamp label from the note variable

``` swift
fileprivate func setTimestampLabel(_ milliseconds: Double)
```

### `layoutSubviews()`

Function for laying out the subviews

``` swift
override func layoutSubviews()
```

### `setupTitleLabel()`

Adds the title label to the subview and defines the constraints of the title label

``` swift
func setupTitleLabel()
```

### `setupNoteLabel()`

Adds the note label to the subview and defines the constraints of the note label

``` swift
func setupNoteLabel()
```

### `setupTimestampLabel()`

Adds the timestamp label to the subview and defines the constraints of the timestamp label

``` swift
func setupTimestampLabel()
```
