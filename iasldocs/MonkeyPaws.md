# MonkeyPaws

A class that visualises input events as an overlay over
your regular UI. To use, simply instantiate it and
keep a reference to it around so that it does not get
deinited.

``` swift
public class MonkeyPaws: NSObject, CALayerDelegate
```

You will want to have some way to only instantiate it
for test usage, though, such as adding a command-line
flag to enable it.

Example usage:

``` 
var paws: MonkeyPaws?

func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    if CommandLine.arguments.contains("--MonkeyPaws") {
        paws = MonkeyPaws(view: window!)
    }
    return true
}
```

## Inheritance

`CALayerDelegate`, `NSObject`

## Nested Type Aliases

## BezierPathDrawer

``` swift
public typealias BezierPathDrawer = () -> UIBezierPath
```

## Initializers

## init(view:tapUIApplication:configuration:bezierPathDrawer:)

Create a MonkeyPaws object that will visualise input
events.

``` swift
public init(view: UIView, tapUIApplication: Bool = true, configuration: Configuration = Configuration(), bezierPathDrawer: @escaping BezierPathDrawer = MonkeyPawDrawer.monkeyHandPath)
```

### Parameters

  - view: The view to put the visualisation layer in. Usually, you will want to pass your main `UIWindow` here.
  - tapUIApplication: By default, MonkeyPaws will swizzle some methods in UIApplication to intercept events so that it can visualise them. If you do not want this, pass `false` here and provide it with events manually.
  - configuration: Configure the visual appearance of the Monkey paws. By default it uses the built in visual parameters.
  - bezierPathDrawer: Create your own visualisation by defining a bezier path drawer closure

## Methods

## append(event:)

If you have disabled UIApplication event tapping,
use this method to pass in `UIEvent` objects to
visualise.

``` swift
public func append(event: UIEvent)
```
