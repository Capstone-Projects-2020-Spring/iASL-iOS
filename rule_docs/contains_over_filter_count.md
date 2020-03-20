# Contains Over Filter Count

Prefer `contains` over comparing `filter(where:).count` to 0.

* **Identifier:** contains_over_filter_count
* **Enabled by default:** Disabled
* **Supports autocorrection:** No
* **Kind:** performance
* **Analyzer rule:** No
* **Minimum Swift compiler version:** 3.0.0
* **Default configuration:** warning

## Non Triggering Examples

```swift
let result = myList.filter(where: { $0 % 2 == 0 }).count > 1

```

```swift
let result = myList.filter { $0 % 2 == 0 }.count > 1

```

```swift
let result = myList.filter(where: { $0 % 2 == 0 }).count > 01

```

```swift
let result = myList.filter(where: { $0 % 2 == 0 }).count == 1

```

```swift
let result = myList.filter { $0 % 2 == 0 }.count == 1

```

```swift
let result = myList.filter(where: { $0 % 2 == 0 }).count == 01

```

```swift
let result = myList.filter(where: { $0 % 2 == 0 }).count != 1

```

```swift
let result = myList.filter { $0 % 2 == 0 }.count != 1

```

```swift
let result = myList.filter(where: { $0 % 2 == 0 }).count != 01

```

```swift
let result = myList.contains(where: { $0 % 2 == 0 })

```

```swift
let result = !myList.contains(where: { $0 % 2 == 0 })

```

```swift
let result = myList.contains(10)

```

## Triggering Examples

```swift
let result = ↓myList.filter(where: { $0 % 2 == 0 }).count > 0

```

```swift
let result = ↓myList.filter { $0 % 2 == 0 }.count > 0

```

```swift
let result = ↓myList.filter(where: someFunction).count > 0

```

```swift
let result = ↓myList.filter(where: { $0 % 2 == 0 }).count == 0

```

```swift
let result = ↓myList.filter { $0 % 2 == 0 }.count == 0

```

```swift
let result = ↓myList.filter(where: someFunction).count == 0

```

```swift
let result = ↓myList.filter(where: { $0 % 2 == 0 }).count != 0

```

```swift
let result = ↓myList.filter { $0 % 2 == 0 }.count != 0

```

```swift
let result = ↓myList.filter(where: someFunction).count != 0

```