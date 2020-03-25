# Reduce Into

Prefer `reduce(into:_:)` over `reduce(_:_:)` for copy-on-write types

* **Identifier:** reduce_into
* **Enabled by default:** Disabled
* **Supports autocorrection:** No
* **Kind:** performance
* **Analyzer rule:** No
* **Minimum Swift compiler version:** 4.0.0
* **Default configuration:** warning

## Non Triggering Examples

```swift
let foo = values.reduce(into: "abc") { $0 += "\($1)" }
```

```swift
values.reduce(into: Array<Int>()) { result, value in
    result.append(value)
}
```

```swift
let rows = violations.enumerated().reduce(into: "") { rows, indexAndViolation in
    rows.append(generateSingleRow(for: indexAndViolation.1, at: indexAndViolation.0 + 1))
}
```

```swift
zip(group, group.dropFirst()).reduce(into: []) { result, pair in
    result.append(pair.0 + pair.1)
}
```

```swift
let foo = values.reduce(into: [String: Int]()) { result, value in
    result["\(value)"] = value
}
```

```swift
let foo = values.reduce(into: Dictionary<String, Int>.init()) { result, value in
    result["\(value)"] = value
}
```

```swift
let foo = values.reduce(into: [Int](repeating: 0, count: 10)) { result, value in
    result.append(value)
}
```

```swift
let foo = values.reduce(MyClass()) { result, value in
    result.handleValue(value)
    return result
}
```

## Triggering Examples

```swift
let bar = values.↓reduce("abc") { $0 + "\($1)" }
```

```swift
values.↓reduce(Array<Int>()) { result, value in
    result += [value]
}
```

```swift
let rows = violations.enumerated().↓reduce("") { rows, indexAndViolation in
    return rows + generateSingleRow(for: indexAndViolation.1, at: indexAndViolation.0 + 1)
}
```

```swift
zip(group, group.dropFirst()).↓reduce([]) { result, pair in
    result + [pair.0 + pair.1]
}
```

```swift
let foo = values.↓reduce([String: Int]()) { result, value in
    var result = result
    result["\(value)"] = value
    return result
}
```

```swift
let bar = values.↓reduce(Dictionary<String, Int>.init()) { result, value in
    var result = result
    result["\(value)"] = value
    return result
}
```

```swift
let bar = values.↓reduce([Int](repeating: 0, count: 10)) { result, value in
    return result + [value]
}
```