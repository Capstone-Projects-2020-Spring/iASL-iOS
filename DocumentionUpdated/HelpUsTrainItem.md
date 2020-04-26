# HelpUsTrainItem

An item to be displayed in the welcome screen, used to show off a feature of your app.

``` swift
public struct HelpUsTrainItem
```

## Initializers

### `init()`

Empty initializer for the items in the Help us train view.
Each item can have:

``` swift
public init()
```

## Properties

### `image`

The icon of the item. This will appear on the left side of the item.

``` swift
var image: UIImage!
```

### `title`

The title of the feature.

``` swift
var title: String!
```

### `description`

More information about the feature, displayed under the title.

``` swift
var description: String!
```
