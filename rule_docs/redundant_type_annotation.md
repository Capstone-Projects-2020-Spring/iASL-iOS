# Redundant Type Annotation

Variables should not have redundant type annotation

* **Identifier:** redundant_type_annotation
* **Enabled by default:** Disabled
* **Supports autocorrection:** Yes
* **Kind:** idiomatic
* **Analyzer rule:** No
* **Minimum Swift compiler version:** 3.0.0
* **Default configuration:** warning

## Non Triggering Examples

```swift
var url = URL()
```

```swift
var url: CustomStringConvertible = URL()
```

```swift
@IBInspectable var color: UIColor = UIColor.white
```

## Triggering Examples

```swift
var url↓:URL=URL()
```

```swift
var url↓:URL = URL(string: "")
```

```swift
var url↓: URL = URL()
```

```swift
let url↓: URL = URL()
```

```swift
lazy var url↓: URL = URL()
```

```swift
let alphanumerics↓: CharacterSet = CharacterSet.alphanumerics
```

```swift
class ViewController: UIViewController {
  func someMethod() {
    let myVar↓: Int = Int(5)
  }
}
```