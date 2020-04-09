# Multiple Closures with Trailing Closure

Trailing closure syntax should not be used when passing more than one closure argument.

* **Identifier:** multiple_closures_with_trailing_closure
* **Enabled by default:** Enabled
* **Supports autocorrection:** No
* **Kind:** style
* **Analyzer rule:** No
* **Minimum Swift compiler version:** 3.0.0
* **Default configuration:** warning

## Non Triggering Examples

```swift
foo.map { $0 + 1 }

```

```swift
foo.reduce(0) { $0 + $1 }

```

```swift
if let foo = bar.map({ $0 + 1 }) {

}

```

```swift
foo.something(param1: { $0 }, param2: { $0 + 1 })

```

```swift
UIView.animate(withDuration: 1.0) {
    someView.alpha = 0.0
}
```

## Triggering Examples

```swift
foo.something(param1: { $0 }) ↓{ $0 + 1 }
```

```swift
UIView.animate(withDuration: 1.0, animations: {
    someView.alpha = 0.0
}) ↓{ _ in
    someView.removeFromSuperview()
}
```