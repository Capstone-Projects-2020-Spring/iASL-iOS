# Legacy Random

Prefer using `type.random(in:)` over legacy functions.

* **Identifier:** legacy_random
* **Enabled by default:** Disabled
* **Supports autocorrection:** No
* **Kind:** idiomatic
* **Analyzer rule:** No
* **Minimum Swift compiler version:** 4.2.0
* **Default configuration:** warning

## Non Triggering Examples

```swift
Int.random(in: 0..<10)

```

```swift
Double.random(in: 8.6...111.34)

```

```swift
Float.random(in: 0 ..< 1)

```

## Triggering Examples

```swift
↓arc4random(10)

```

```swift
↓arc4random_uniform(83)

```

```swift
↓drand48(52)

```