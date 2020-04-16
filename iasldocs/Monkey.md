# Monkey

A general-purpose class for implementing randomised
UI tests. This class lets you schedule blocks to be
run at random or fixed intervals, and provides helper
functions to generate random coordinates.

``` swift
public class Monkey
```

It has several extensions that implement actual event
generation, using different methods. For normal usage,
you will want to look at for instance the XCTest private
API based extension.

If all you want to do is geneate some events and you do
not care about the finer details, you can just use a
test case like the following:

``` 
func testMonkey() {
    let application = XCUIApplication()

    // Workaround for bug in Xcode 7.3. Snapshots are not properly updated
    // when you initially call app.frame, resulting in a zero-sized rect.
    // Doing a random query seems to update everything properly.
    // TODO: Remove this when the Xcode bug is fixed!
    _ = application.descendants(matching: .any).element(boundBy: 0).frame

    // Initialise the monkey tester with the current device
    // frame. Giving an explicit seed will make it generate
    // the same sequence of events on each run, and leaving it
    // out will generate a new sequence on each run.
    let monkey = Monkey(frame: application.frame)
    //let monkey = Monkey(seed: 123, frame: application.frame)

    // Add actions for the monkey to perform. We just use a
    // default set of actions for this, which is usually enough.
    // Use either one of these but maybe not both.
    // XCTest private actions seem to work better at the moment.
    // UIAutomation actions seem to work only on the simulator.
    monkey.addDefaultXCTestPrivateActions()
    //monkey.addDefaultUIAutomationActions()

    // Occasionally, use the regular XCTest functionality
    // to check if an alert is shown, and click a random
    // button on it.
    monkey.addXCTestTapAlertAction(interval: 100, application: application)

    // Run the monkey test indefinitely.
    monkey.monkeyAround()
}
```

## Nested Type Aliases

## ActionClosure

``` swift
public typealias ActionClosure = () -> Void
```

## Initializers

## init(frame:)

Create a Monkey object with a randomised seed.
This instance will generate a different stream of
events each time it is created.

``` swift
public convenience init(frame: CGRect)
```

There is an XCTest bug to be aware of when finding
the frame to use. Here is an example of how to work
around this problem:

``` 
let application = XCUIApplication()

// Workaround for bug in Xcode 7.3 and later. Snapshots are not properly
// updated when you initially call app.frame, resulting in a zero-sized rect.
// Doing a random query seems to update everything properly.
_ = application.descendants(matching: .any).element(boundBy: 0).frame

let monkey = Monkey(frame: application.frame)
```

### Parameters

  - frame: The frame to generate events in. Should be set to the size of the device being tested.

## init(seed:frame:)

Create a Monkey object with a fixed seed.
This instance will generate the exact same stream of
events each time it is created.
Create a Monkey object with a randomised seed.
This instance will generate a different stream of
events each time it is created.

``` swift
public init(seed: UInt32, frame: CGRect)
```

There is an XCTest bug to be aware of when finding
the frame to use. Here is an example of how to work
around this problem:

``` 
let application = XCUIApplication()

// Workaround for bug in Xcode 7.3 and later. Snapshots are not properly
// updated when you initially call app.frame, resulting in a zero-sized rect.
// Doing a random query seems to update everything properly.
_ = application.descendants(matching: .any).element(boundBy: 0).frame

let monkey = Monkey(seed: 0, frame: application.frame)
```

### Parameters

  - seed: The random seed to use. Each value will generate a different stream of events.
  - frame: The frame to generate events in. Should be set to the size of the device being tested.

## Methods

## monkeyAround(iterations:)

Generate a number of random events.

``` swift
public func monkeyAround(iterations: Int)
```

### Parameters

  - iterations: The number of random events to generate. Does not include any fixed interval events that may also be generated.

## monkeyAround(forDuration:)

Generate random events or fixed-interval events based forever, for a specific duration or until the app crashes.

``` swift
public func monkeyAround(forDuration duration: TimeInterval = .infinity)
```

### Parameters

  - duration: The duration for which to generate the random events. Set to `.infinity` by default.

## actRandomly()

Generate one random event.

``` swift
public func actRandomly()
```

## actRegularly()

Generate any pending fixed-interval events.

``` swift
public func actRegularly()
```

## addAction(weight:action:)

Add a block for generating randomised events.

``` swift
public func addAction(weight: Double, action: @escaping ActionClosure)
```

### Parameters

  - weight: The relative probability of this event being generated. Can be any value larger than zero. Probabilities will be normalised to the sum of all relative probabilities.
  - action: The block to run when this event is generated.

## addAction(interval:action:)

Add a block for fixed-interval events.

``` swift
public func addAction(interval: Int, action: @escaping ActionClosure)
```

### Parameters

  - interval: How often to generate this event. One of these events will be generated after this many randomised events have been generated.
  - action: The block to run when this event is generated.

## randomInt(lessThan:)

Generate a random `Int`.

``` swift
public func randomInt(lessThan: Int) -> Int
```

### Parameters

  - lessThan: The returned value will be less than this value, and greater than or equal to zero.

## randomUInt(lessThan:)

Generate a random `UInt`.

``` swift
public func randomUInt(lessThan: UInt) -> UInt
```

### Parameters

  - lessThan: The returned value will be less than this value, and greater than or equal to  zero.

## randomCGFloat(lessThan:)

Generate a random `CGFloat`.

``` swift
public func randomCGFloat(lessThan: CGFloat = 1) -> CGFloat
```

### Parameters

  - lessThan: The returned value will be less than this value, and greater than or equal to zero.

## randomPoint()

Generate a random `CGPoint` inside the frame of the app.

``` swift
public func randomPoint() -> CGPoint
```

## randomPointAvoidingPanelAreas()

Generate a random `CGPoint` inside the frame of the app,
avoiding the areas at the top and bottom of the screen
that trigger a panel pull-out.

``` swift
public func randomPointAvoidingPanelAreas() -> CGPoint
```

## randomPoint(inRect:)

Generate a random `CGPoint` inside the given `CGRect`.

``` swift
public func randomPoint(inRect rect: CGRect) -> CGPoint
```

### Parameters

  - inRect: The rect within which to pick the point.

## randomRect()

Generate a random `CGRect` inside the frame of the app.

``` swift
public func randomRect() -> CGRect
```

## randomRect(sizeFraction:)

Generate a random `CGRect` inside the frame of the app,
sized to a given fraction of the whole frame.

``` swift
public func randomRect(sizeFraction: CGFloat) -> CGRect
```

### Parameters

  - sizeFraction: The fraction of the size of the frame to use as the of the area for generated points.

## randomClusteredPoints(count:)

Generate an array of random `CGPoints` in a loose cluster.

``` swift
public func randomClusteredPoints(count: Int) -> [CGPoint]
```

### Parameters

  - count: Number of points to generate.

## addDefaultUIAutomationActions()

Add a sane default set of event generation actions
using the private UIAutomation API. Use this function if you
just want to generate some events, and do not have
strong requirements on exactly which ones you need.

``` swift
public func addDefaultUIAutomationActions()
```

## addUIAutomationSingleTapAction(weight:)

Add an action that generates a single tap event
using the private UIAutomation API.

``` swift
public func addUIAutomationSingleTapAction(weight: Double)
```

### Parameters

  - weight: The relative probability of this event being generated. Can be any value larger than zero. Probabilities will be normalised to the sum of all relative probabilities.

## addUIAutomationTapAction(weight:multipleTapProbability:multipleTouchProbability:longPressProbability:)

Add an action that generates a tap, with a possibility for
multiple taps with multiple fingers, or long taps, using
the private UIAutomation API.

``` swift
public func addUIAutomationTapAction(weight: Double, multipleTapProbability: Double = 0.05, multipleTouchProbability: Double = 0.05, longPressProbability: Double = 0.05)
```

### Parameters

  - weight: The relative probability of this event being generated. Can be any value larger than zero. Probabilities will be normalised to the sum of all relative probabilities.
  - multipleTapProbability: Probability that the tap event will tap multiple times. Between 0 and 1.
  - multipleTouchProbability: Probability that the tap event will use multiple fingers. Between 0 and 1.
  - longPressProbability: Probability that the tap event will be a long press. Between 0 and 1.

## addUIAutomationDragAction(weight:)

Add an action that generates a drag event from one random
screen position to another using the private UIAutomation API.

``` swift
public func addUIAutomationDragAction(weight: Double)
```

### Parameters

  - weight: The relative probability of this event being generated. Can be any value larger than zero. Probabilities will be normalised to the sum of all relative probabilities.

## addUIAutomationFlickAction(weight:)

Add an action that generates a flick event from one random
screen position to another using the private UIAutomation API.

``` swift
public func addUIAutomationFlickAction(weight: Double)
```

### Parameters

  - weight: The relative probability of this event being generated. Can be any value larger than zero. Probabilities will be normalised to the sum of all relative probabilities.

## addUIAutomationPinchCloseAction(weight:)

Add an action that generates a pinch close gesture
at a random screen position using the private UIAutomation API.

``` swift
public func addUIAutomationPinchCloseAction(weight: Double)
```

### Parameters

  - weight: The relative probability of this event being generated. Can be any value larger than zero. Probabilities will be normalised to the sum of all relative probabilities.

## addUIAutomationPinchOpenAction(weight:)

Add an action that generates a pinch open gesture
at a random screen position using the private UIAutomation API.

``` swift
public func addUIAutomationPinchOpenAction(weight: Double)
```

### Parameters

  - weight: The relative probability of this event being generated. Can be any value larger than zero. Probabilities will be normalised to the sum of all relative probabilities.

## addUIAutomationRotateAction(weight:)

Add an action that generates a rotation gesture
at a random screen position over a random angle
using the private UIAutomation API.

``` swift
public func addUIAutomationRotateAction(weight: Double)
```

### Parameters

  - weight: The relative probability of this event being generated. Can be any value larger than zero. Probabilities will be normalised to the sum of all relative probabilities.

## addUIAutomationOrientationAction(weight:)

Add an action that generates a device rotation event
using the private UIAutomation API.

``` swift
public func addUIAutomationOrientationAction(weight: Double)
```

### Parameters

  - weight: The relative probability of this event being generated. Can be any value larger than zero. Probabilities will be normalised to the sum of all relative probabilities.

## addUIAutomationClickVolumeUpAction(weight:)

Add an action that generates a volume up click event
using the private UIAutomation API.

``` swift
public func addUIAutomationClickVolumeUpAction(weight: Double)
```

### Parameters

  - weight: The relative probability of this event being generated. Can be any value larger than zero. Probabilities will be normalised to the sum of all relative probabilities.

## addUIAutomationClickVolumeDownAction(weight:)

Add an action that generates a volume down click event
using the private UIAutomation API.

``` swift
public func addUIAutomationClickVolumeDownAction(weight: Double)
```

### Parameters

  - weight: The relative probability of this event being generated. Can be any value larger than zero. Probabilities will be normalised to the sum of all relative probabilities.

## addUIAutomationShakeAction(weight:)

Add an action that generates a shake event
using the private UIAutomation API.

``` swift
public func addUIAutomationShakeAction(weight: Double)
```

### Parameters

  - weight: The relative probability of this event being generated. Can be any value larger than zero. Probabilities will be normalised to the sum of all relative probabilities.

## addUIAutomationLockAction(weight:)

Add an action that generates a lock button click event and
subsequent unlock drag event using the private UIAutomation API.

``` swift
public func addUIAutomationLockAction(weight: Double)
```

### Parameters

  - weight: The relative probability of this event being generated. Can be any value larger than zero. Probabilities will be normalised to the sum of all relative probabilities.

## addXCTestTapAlertAction(interval:application:)

Add an action that checks, at a fixed interval,
if an alert is being displayed, and if so, selects
a random button on it.

``` swift
public func addXCTestTapAlertAction(interval: Int, application: XCUIApplication)
```

### Parameters

  - interval: How often to generate this event. One of these events will be generated after this many randomised events have been generated.
  - application: The `XCUIApplication` object for the current application.

## addXCTestTapAlertAction(interval:application:)

Add an action that checks, at a fixed interval,
if an alert is being displayed, and if so, selects
a random button on it.

``` swift
public func addXCTestTapAlertAction(interval: Int, application: XCUIApplication)
```

### Parameters

  - interval: How often to generate this event. One of these events will be generated after this many randomised events have been generated.
  - application: The `XCUIApplication` object for the current application.

## addDefaultXCTestPrivateActions()

Add a sane default set of event generation actions
using the private XCTest API. Use this function if you
just want to generate some events, and do not have
strong requirements on exactly which ones you need.

``` swift
public func addDefaultXCTestPrivateActions()
```

## addXCTestTapAction(weight:multipleTapProbability:multipleTouchProbability:)

Add an action that generates a tap, with a possibility for
multiple taps with multiple fingers, using the private
XCTest API.

``` swift
public func addXCTestTapAction(weight: Double, multipleTapProbability: Double = 0.05, multipleTouchProbability: Double = 0.05)
```

### Parameters

  - weight: The relative probability of this event being generated. Can be any value larger than zero. Probabilities will be normalised to the sum of all relative probabilities.
  - multipleTapProbability: Probability that the tap event will tap multiple times. Between 0 and 1.
  - multipleTouchProbability: Probability that the tap event will use multiple fingers. Between 0 and 1.

## addXCTestLongPressAction(weight:)

Add an action that generates a long press event
using the private XCTest API.

``` swift
public func addXCTestLongPressAction(weight: Double)
```

### Parameters

  - weight: The relative probability of this event being generated. Can be any value larger than zero. Probabilities will be normalised to the sum of all relative probabilities.

## addXCTestDragAction(weight:)

Add an action that generates a drag event from one random
screen position to another using the private XCTest API.

``` swift
public func addXCTestDragAction(weight: Double)
```

### Parameters

  - weight: The relative probability of this event being generated. Can be any value larger than zero. Probabilities will be normalised to the sum of all relative probabilities.

## addXCTestPinchCloseAction(weight:)

Add an action that generates a pinch close gesture
at a random screen position using the private XCTest API.

``` swift
public func addXCTestPinchCloseAction(weight: Double)
```

### Parameters

  - weight: The relative probability of this event being generated. Can be any value larger than zero. Probabilities will be normalised to the sum of all relative probabilities.

## addXCTestPinchOpenAction(weight:)

Add an action that generates a pinch open gesture
at a random screen position using the private XCTest API.

``` swift
public func addXCTestPinchOpenAction(weight: Double)
```

### Parameters

  - weight: The relative probability of this event being generated. Can be any value larger than zero. Probabilities will be normalised to the sum of all relative probabilities.

## addXCTestRotateAction(weight:)

Add an action that generates a rotation gesture
at a random screen position over a random angle
using the private XCTest API.

``` swift
public func addXCTestRotateAction(weight: Double)
```

### Parameters

  - weight: The relative probability of this event being generated. Can be any value larger than zero. Probabilities will be normalised to the sum of all relative probabilities.

## addXCTestOrientationAction(weight:)

Add an action that generates a device rotation event
using the private XCTest API. Does not currently work\!

``` swift
public func addXCTestOrientationAction(weight: Double)
```

### Parameters

  - weight: The relative probability of this event being generated. Can be any value larger than zero. Probabilities will be normalised to the sum of all relative probabilities.
