# Operator Usage Whitespace

Operators should be surrounded by a single whitespace when they are being used.

* **Identifier:** operator_usage_whitespace
* **Enabled by default:** Disabled
* **Supports autocorrection:** Yes
* **Kind:** style
* **Analyzer rule:** No
* **Minimum Swift compiler version:** 3.0.0
* **Default configuration:** warning

## Non Triggering Examples

```swift
let foo = 1 + 2

```

```swift
let foo = 1 > 2

```

```swift
let foo = !false

```

```swift
let foo: Int?

```

```swift
let foo: Array<String>

```

```swift
let model = CustomView<Container<Button>, NSAttributedString>()

```

```swift
let foo: [String]

```

```swift
let foo = 1 + 
  2

```

```swift
let range = 1...3

```

```swift
let range = 1 ... 3

```

```swift
let range = 1..<3

```

```swift
#if swift(>=3.0)
    foo()
#endif

```

```swift
array.removeAtIndex(-200)

```

```swift
let name = "image-1"

```

```swift
button.setImage(#imageLiteral(resourceName: "image-1"), for: .normal)

```

```swift
let doubleValue = -9e-11

```

```swift
let foo = GenericType<(UIViewController) -> Void>()

```

```swift
let foo = Foo<Bar<T>, Baz>()

```

```swift
let foo = SignalProducer<Signal<Value, Error>, Error>([ self.signal, next ]).flatten(.concat)

```

## Triggering Examples

```swift
let foo = 1↓+2

```

```swift
let foo = 1↓   + 2

```

```swift
let foo = 1↓   +    2

```

```swift
let foo = 1↓ +    2

```

```swift
let foo↓=1↓+2

```

```swift
let foo↓=1 + 2

```

```swift
let foo↓=bar

```

```swift
let range = 1↓ ..<  3

```

```swift
let foo = bar↓   ?? 0

```

```swift
let foo = bar↓??0

```

```swift
let foo = bar↓ !=  0

```

```swift
let foo = bar↓ !==  bar2

```

```swift
let v8 = Int8(1)↓  << 6

```

```swift
let v8 = 1↓ <<  (6)

```

```swift
let v8 = 1↓ <<  (6)
 let foo = 1 > 2

```