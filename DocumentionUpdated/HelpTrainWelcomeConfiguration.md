# HelpTrainWelcomeConfiguration

Use this to manage the configuration options of the welcome screen.

``` swift
public struct HelpTrainWelcomeConfiguration
```

## Initializers

### `init()`

empty initializer to initialize configuration of the help us train welcome screen

``` swift
public init()
```

## Properties

### `appName`

The name of your app. This will be shown (by default) as "Welcome to \<appName\>".

``` swift
var appName: String
```

### `appDescription`

The description of your app. This will be shown under the app name.

``` swift
var appDescription: String
```

### `items`

The items that will appear on the welcome screen. Create and configure them using instances of `AWSItem`.

``` swift
var items: [HelpUsTrainItem]
```

### `continueButtonText`

The text of the "Continue" button that appears at the bottom of the screen. By default this is set to `"Continue"`.

``` swift
var continueButtonText: String
```

### `dismissButtonText`

The text of the "dismissButton" button that appears at the bottom of the screen. By default this is set to `"No Thank You"`.

``` swift
var dismissButtonText: String
```

### `continueButtonAction`

The closure to be executed when the "Continue" button is pressed.

``` swift
var continueButtonAction: (() -> Void)?
```

### `dismissButtonAction`

The closure to be executed when the "No Thank You" dissmiss button is pressed.

``` swift
var dismissButtonAction: (() -> Void)?
```

### `tintColor`

The tint of the welcome screen. This color will be reflected in the color of the app name and the "Continue" button.

``` swift
var tintColor: UIColor
```
