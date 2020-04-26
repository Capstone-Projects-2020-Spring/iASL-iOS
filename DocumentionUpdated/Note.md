# Note

This will hold each note that is saved in Firebase

``` swift
class Note: NSObject
```

## Inheritance

`NSObject`

## Properties

### `id`

Unique ID of the note

``` swift
var id: String?
```

### `title`

Title of the specific note

``` swift
var title: String?
```

### `text`

Text of the specific note

``` swift
var text: String?
```

### `timestamp`

The exact time the note was saved

``` swift
var timestamp: NSNumber?
```

### `ownerId`

Unique ID of the user who created this note

``` swift
var ownerId: String?
```
