# Redundant Discardable Let

Prefer `_ = foo()` over `let _ = foo()` when discarding a result from a function.

* **Identifier:** redundant_discardable_let
* **Enabled by default:** Enabled
* **Supports autocorrection:** Yes
* **Kind:** style
* **Analyzer rule:** No
* **Minimum Swift compiler version:** 3.0.0
* **Default configuration:** warning

## Non Triggering Examples

```swift
_ = foo()

```

```swift
if let _ = foo() { }

```

```swift
guard let _ = foo() else { return }

```

```swift
let _: ExplicitType = foo()
```

```swift
while let _ = SplashStyle(rawValue: maxValue) { maxValue += 1 }

```

## Triggering Examples

```swift
↓let _ = foo()

```

```swift
if _ = foo() { ↓let _ = bar() }

```