# Private Outlets

IBOutlets should be private to avoid leaking UIKit to higher layers.

* **Identifier:** private_outlet
* **Enabled by default:** Disabled
* **Supports autocorrection:** No
* **Kind:** lint
* **Analyzer rule:** No
* **Minimum Swift compiler version:** 3.0.0
* **Default configuration:** warning, allow_private_set: false

## Non Triggering Examples

```swift
class Foo {
  @IBOutlet private var label: UILabel?
}

```

```swift
class Foo {
  @IBOutlet private var label: UILabel!
}

```

```swift
class Foo {
  var notAnOutlet: UILabel
}

```

```swift
class Foo {
  @IBOutlet weak private var label: UILabel?
}

```

```swift
class Foo {
  @IBOutlet private weak var label: UILabel?
}

```

## Triggering Examples

```swift
class Foo {
  @IBOutlet ↓var label: UILabel?
}

```

```swift
class Foo {
  @IBOutlet ↓var label: UILabel!
}

```