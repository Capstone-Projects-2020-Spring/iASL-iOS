# Convenience Type

Types used for hosting only static members should be implemented as a caseless enum to avoid instantiation.

* **Identifier:** convenience_type
* **Enabled by default:** Disabled
* **Supports autocorrection:** No
* **Kind:** idiomatic
* **Analyzer rule:** No
* **Minimum Swift compiler version:** 4.1.0
* **Default configuration:** warning

## Non Triggering Examples

```swift
enum Math { // enum
  public static let pi = 3.14
}
```

```swift
// class with inheritance
class MathViewController: UIViewController {
  public static let pi = 3.14
}
```

```swift
@objc class Math: NSObject { // class visible to Obj-C
  public static let pi = 3.14
}
```

```swift
struct Math { // type with non-static declarations
  public static let pi = 3.14
  public let randomNumber = 2
}
```

```swift
class DummyClass {}
```

## Triggering Examples

```swift
↓struct Math {
  public static let pi = 3.14
}
```

```swift
↓class Math {
  public static let pi = 3.14
}
```

```swift
↓struct Math {
  public static let pi = 3.14
  @available(*, unavailable) init() {}
}
```