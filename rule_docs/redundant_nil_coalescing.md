# Redundant Nil Coalescing

nil coalescing operator is only evaluated if the lhs is nil, coalescing operator with nil as rhs is redundant

* **Identifier:** redundant_nil_coalescing
* **Enabled by default:** Disabled
* **Supports autocorrection:** Yes
* **Kind:** idiomatic
* **Analyzer rule:** No
* **Minimum Swift compiler version:** 3.0.0
* **Default configuration:** warning

## Non Triggering Examples

```swift
var myVar: Int?; myVar ?? 0

```

## Triggering Examples

```swift
var myVar: Int? = nil; myVar↓ ?? nil

```

```swift
var myVar: Int? = nil; myVar↓??nil

```