# AppDelegate

``` swift
@UIApplicationMain class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate, MessagingDelegate
```

## Inheritance

`MessagingDelegate`, `UIApplicationDelegate`, `UIResponder`, `UNUserNotificationCenterDelegate`

## Properties

### `window`

``` swift
var window: UIWindow?
```

## Methods

### `application(_:didFinishLaunchingWithOptions:)`

``` swift
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool
```

### `requestTranscribePermissions()`

``` swift
func requestTranscribePermissions()
```
