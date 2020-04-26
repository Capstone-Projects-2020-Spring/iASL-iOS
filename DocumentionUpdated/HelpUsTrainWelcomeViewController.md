# HelpUsTrainWelcomeViewController

The view controller that displayes the welcome screen.

``` swift
public class HelpUsTrainWelcomeViewController: UIViewController
```

## Inheritance

`UIViewController`

## Properties

### `configuration`

The configuration for the welcome screen to use.

``` swift
var configuration: HelpTrainWelcomeConfiguration!
```

### `itemsTableViewManager`

``` swift
var itemsTableViewManager: HelpUsTrainItemsTableViewManager!
```

### `scrollView`

``` swift
let scrollView
```

### `contentView`

``` swift
let contentView
```

### `welcomeToLabel`

``` swift
let welcomeToLabel
```

### `appNameLabel`

``` swift
let appNameLabel
```

### `appDescriptionLabel`

``` swift
let appDescriptionLabel
```

### `itemsTableView`

``` swift
let itemsTableView
```

### `continueButton`

``` swift
let continueButton
```

### `dismissButton`

``` swift
let dismissButton
```

### `marginSize`

``` swift
var marginSize: CGFloat
```

## Methods

### `viewDidLoad()`

``` swift
override public func viewDidLoad()
```

### `viewDidAppear(_:)`

``` swift
override public func viewDidAppear(_ animated: Bool)
```

### `continueButtonTapped()`

``` swift
@objc private func continueButtonTapped()
```

### `dismissButtonTapped()`

``` swift
@objc private func dismissButtonTapped()
```

### `getHeaderFontSize()`

``` swift
func getHeaderFontSize() -> CGFloat
```

### `getSubtitleFontSize()`

``` swift
func getSubtitleFontSize() -> CGFloat
```

### `getMarginSize()`

``` swift
func getMarginSize() -> CGFloat
```

### `getButtonSize()`

``` swift
func getButtonSize() -> CGFloat
```
