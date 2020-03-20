# Legacy Constant

Struct-scoped constants are preferred over legacy global constants.

* **Identifier:** legacy_constant
* **Enabled by default:** Enabled
* **Supports autocorrection:** Yes
* **Kind:** idiomatic
* **Analyzer rule:** No
* **Minimum Swift compiler version:** 3.0.0
* **Default configuration:** warning

## Non Triggering Examples

```swift
CGRect.infinite
```

```swift
CGPoint.zero
```

```swift
CGRect.zero
```

```swift
CGSize.zero
```

```swift
NSPoint.zero
```

```swift
NSRect.zero
```

```swift
NSSize.zero
```

```swift
CGRect.null
```

```swift
CGFloat.pi
```

```swift
Float.pi
```

## Triggering Examples

```swift
↓CGRectInfinite
```

```swift
↓CGPointZero
```

```swift
↓CGRectZero
```

```swift
↓CGSizeZero
```

```swift
↓NSZeroPoint
```

```swift
↓NSZeroRect
```

```swift
↓NSZeroSize
```

```swift
↓CGRectNull
```

```swift
↓CGFloat(M_PI)
```

```swift
↓Float(M_PI)
```