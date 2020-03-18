# Trailing Comma

Trailing commas in arrays and dictionaries should be avoided/enforced.

* **Identifier:** trailing_comma
* **Enabled by default:** Enabled
* **Supports autocorrection:** Yes
* **Kind:** style
* **Analyzer rule:** No
* **Minimum Swift compiler version:** 3.0.0
* **Default configuration:** warning, mandatory_comma: false

## Non Triggering Examples

```swift
let foo = [1, 2, 3]

```

```swift
let foo = []

```

```swift
let foo = [:]

```

```swift
let foo = [1: 2, 2: 3]

```

```swift
let foo = [Void]()

```

```swift
let example = [ 1,
 2
 // 3,
]
```

```swift
foo([1: "\(error)"])

```

## Triggering Examples

```swift
let foo = [1, 2, 3↓,]

```

```swift
let foo = [1, 2, 3↓, ]

```

```swift
let foo = [1, 2, 3   ↓,]

```

```swift
let foo = [1: 2, 2: 3↓, ]

```

```swift
struct Bar {
 let foo = [1: 2, 2: 3↓, ]
}

```

```swift
let foo = [1, 2, 3↓,] + [4, 5, 6↓,]

```

```swift
let example = [ 1,
2↓,
 // 3,
]
```

```swift
let foo = ["אבג", "αβγ", "🇺🇸"↓,]

```

```swift
class C {
 #if true
 func f() {
 let foo = [1, 2, 3↓,]
 }
 #endif
}
```

```swift
foo([1: "\(error)"↓,])

```