# HelpTrainTableCell

``` swift
private class HelpTrainTableCell: UITableViewCell
```

## Inheritance

`UITableViewCell`

## Initializers

### `init(item:)`

``` swift
init(item: HelpUsTrainItem)
```

### `init?(coder:)`

``` swift
required init?(coder aDecoder: NSCoder)
```

## Properties

### `item`

``` swift
var item: HelpUsTrainItem
```

### `itemImageView`

``` swift
var itemImageView: UIImageView!
```

### `itemTitleLabel`

``` swift
var itemTitleLabel: UILabel!
```

### `itemDescriptionLabel`

``` swift
var itemDescriptionLabel: UILabel!
```

### `topSpacerView`

``` swift
var topSpacerView: UIView!
```

### `bottomSpacerView`

``` swift
var bottomSpacerView: UIView!
```

## Methods

### `getBodyFontSize()`

``` swift
func getBodyFontSize() -> CGFloat
```

### `getImageSize()`

``` swift
func getImageSize() -> CGFloat
```

### `getCellSpacingSize()`

``` swift
func getCellSpacingSize() -> CGFloat
```
