# Weak Delegate

Delegates should be weak to avoid reference cycles.

* **Identifier:** weak_delegate
* **Enabled by default:** Enabled
* **Supports autocorrection:** Yes
* **Kind:** lint
* **Analyzer rule:** No
* **Minimum Swift compiler version:** 3.0.0
* **Default configuration:** warning

## Non Triggering Examples

```swift
class Foo {
  weak var delegate: SomeProtocol?
}

```

```swift
class Foo {
  weak var someDelegate: SomeDelegateProtocol?
}

```

```swift
class Foo {
  weak var delegateScroll: ScrollDelegate?
}

```

```swift
class Foo {
  var scrollHandler: ScrollDelegate?
}

```

```swift
func foo() {
  var delegate: SomeDelegate
}

```

```swift
class Foo {
  var delegateNotified: Bool?
}

```

```swift
protocol P {
 var delegate: AnyObject? { get set }
}

```

```swift
class Foo {
 protocol P {
 var delegate: AnyObject? { get set }
}
}

```

```swift
class Foo {
 var computedDelegate: ComputedDelegate {
 return bar() 
} 
}
```

## Triggering Examples

```swift
class Foo {
  ↓var delegate: SomeProtocol?
}

```

```swift
class Foo {
  ↓var scrollDelegate: ScrollDelegate?
}

```