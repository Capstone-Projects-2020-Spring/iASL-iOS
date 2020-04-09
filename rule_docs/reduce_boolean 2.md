# Reduce Boolean

Prefer using `.allSatisfy()` or `.contains()` over `reduce(true)` or `reduce(false)`

* **Identifier:** reduce_boolean
* **Enabled by default:** Enabled
* **Supports autocorrection:** No
* **Kind:** performance
* **Analyzer rule:** No
* **Minimum Swift compiler version:** 4.2.0
* **Default configuration:** warning

## Non Triggering Examples

```swift
nums.reduce(0) { $0.0 + $0.1 }
```

```swift
nums.reduce(0.0) { $0.0 + $0.1 }
```

## Triggering Examples

```swift
let allNines = nums.↓reduce(true) { $0.0 && $0.1 == 9 }
```

```swift
let anyNines = nums.↓reduce(false) { $0.0 || $0.1 == 9 }
```

```swift
let allValid = validators.↓reduce(true) { $0 && $1(input) }
```

```swift
let anyValid = validators.↓reduce(false) { $0 || $1(input) }
```

```swift
let allNines = nums.↓reduce(true, { $0.0 && $0.1 == 9 })
```

```swift
let anyNines = nums.↓reduce(false, { $0.0 || $0.1 == 9 })
```

```swift
let allValid = validators.↓reduce(true, { $0 && $1(input) })
```

```swift
let anyValid = validators.↓reduce(false, { $0 || $1(input) })
```