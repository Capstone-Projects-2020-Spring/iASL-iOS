# FlatMap over map and reduce

Prefer `flatMap` over `map` followed by `reduce([], +)`.

* **Identifier:** flatmap_over_map_reduce
* **Enabled by default:** Disabled
* **Supports autocorrection:** No
* **Kind:** performance
* **Analyzer rule:** No
* **Minimum Swift compiler version:** 3.0.0
* **Default configuration:** warning

## Non Triggering Examples

```swift
let foo = bar.map { $0.count }.reduce(0, +)
```

```swift
let foo = bar.flatMap { $0.array }
```

## Triggering Examples

```swift
let foo = ↓bar.map { $0.array }.reduce([], +)
```