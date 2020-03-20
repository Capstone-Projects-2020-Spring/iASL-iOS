# Trailing Closure

Trailing closure syntax should be used whenever possible.

* **Identifier:** trailing_closure
* **Enabled by default:** Disabled
* **Supports autocorrection:** No
* **Kind:** style
* **Analyzer rule:** No
* **Minimum Swift compiler version:** 3.0.0
* **Default configuration:** warning, only_single_muted_parameter: false

## Non Triggering Examples

```swift
foo.map { $0 + 1 }

```

```swift
foo.bar()

```

```swift
foo.reduce(0) { $0 + 1 }

```

```swift
if let foo = bar.map({ $0 + 1 }) { }

```

```swift
foo.something(param1: { $0 }, param2: { $0 + 1 })

```

```swift
offsets.sorted { $0.offset < $1.offset }

```

```swift
foo.something({ return 1 }())
```

```swift
foo.something({ return $0 }(1))
```

```swift
foo.something(0, { return 1 }())
```

## Triggering Examples

```swift
↓foo.map({ $0 + 1 })

```

```swift
↓foo.reduce(0, combine: { $0 + 1 })

```

```swift
↓offsets.sorted(by: { $0.offset < $1.offset })

```

```swift
↓foo.something(0, { $0 + 1 })

```