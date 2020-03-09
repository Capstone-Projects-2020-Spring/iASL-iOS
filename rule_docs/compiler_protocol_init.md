# Compiler Protocol Init

The initializers declared in compiler protocols such as `ExpressibleByArrayLiteral` shouldn't be called directly.

* **Identifier:** compiler_protocol_init
* **Enabled by default:** Enabled
* **Supports autocorrection:** No
* **Kind:** lint
* **Analyzer rule:** No
* **Minimum Swift compiler version:** 3.0.0
* **Default configuration:** warning

## Non Triggering Examples

```swift
let set: Set<Int> = [1, 2]

```

```swift
let set = Set(array)

```

## Triggering Examples

```swift
let set = ↓Set(arrayLiteral: 1, 2)

```

```swift
let set = ↓Set.init(arrayLiteral: 1, 2)

```