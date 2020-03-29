# Valid IBInspectable

@IBInspectable should be applied to variables only, have its type explicit and be of a supported type

* **Identifier:** valid_ibinspectable
* **Enabled by default:** Enabled
* **Supports autocorrection:** No
* **Kind:** lint
* **Analyzer rule:** No
* **Minimum Swift compiler version:** 3.0.0
* **Default configuration:** warning

## Non Triggering Examples

```swift
class Foo {
  @IBInspectable private var x: Int
}

```

```swift
class Foo {
  @IBInspectable private var x: String?
}

```

```swift
class Foo {
  @IBInspectable private var x: String!
}

```

```swift
class Foo {
  @IBInspectable private var count: Int = 0
}

```

```swift
class Foo {
  private var notInspectable = 0
}

```

```swift
class Foo {
  private let notInspectable: Int
}

```

```swift
class Foo {
  private let notInspectable: UInt8
}

```

## Triggering Examples

```swift
class Foo {
  @IBInspectable private ↓let count: Int
}

```

```swift
class Foo {
  @IBInspectable private ↓var insets: UIEdgeInsets
}

```

```swift
class Foo {
  @IBInspectable private ↓var count = 0
}

```

```swift
class Foo {
  @IBInspectable private ↓var count: Int?
}

```

```swift
class Foo {
  @IBInspectable private ↓var count: Int!
}

```

```swift
class Foo {
  @IBInspectable private ↓var x: ImplicitlyUnwrappedOptional<Int>
}

```

```swift
class Foo {
  @IBInspectable private ↓var count: Optional<Int>
}

```

```swift
class Foo {
  @IBInspectable private ↓var x: Optional<String>
}

```

```swift
class Foo {
  @IBInspectable private ↓var x: ImplicitlyUnwrappedOptional<String>
}

```