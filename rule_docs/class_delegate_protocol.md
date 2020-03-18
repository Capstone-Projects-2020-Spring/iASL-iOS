# Class Delegate Protocol

Delegate protocols should be class-only so they can be weakly referenced.

* **Identifier:** class_delegate_protocol
* **Enabled by default:** Enabled
* **Supports autocorrection:** No
* **Kind:** lint
* **Analyzer rule:** No
* **Minimum Swift compiler version:** 3.0.0
* **Default configuration:** warning

## Non Triggering Examples

```swift
protocol FooDelegate: class {}

```

```swift
protocol FooDelegate: class, BarDelegate {}

```

```swift
protocol Foo {}

```

```swift
class FooDelegate {}

```

```swift
@objc protocol FooDelegate {}

```

```swift
@objc(MyFooDelegate)
 protocol FooDelegate {}

```

```swift
protocol FooDelegate: BarDelegate {}

```

```swift
protocol FooDelegate: AnyObject {}

```

```swift
protocol FooDelegate: NSObjectProtocol {}

```

## Triggering Examples

```swift
↓protocol FooDelegate {}

```

```swift
↓protocol FooDelegate: Bar {}

```