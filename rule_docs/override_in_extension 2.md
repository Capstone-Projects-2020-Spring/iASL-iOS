# Override in Extension

Extensions shouldn't override declarations.

* **Identifier:** override_in_extension
* **Enabled by default:** Disabled
* **Supports autocorrection:** No
* **Kind:** lint
* **Analyzer rule:** No
* **Minimum Swift compiler version:** 3.0.0
* **Default configuration:** warning

## Non Triggering Examples

```swift
extension Person {
  var age: Int { return 42 }
}

```

```swift
extension Person {
  func celebrateBirthday() {}
}

```

```swift
class Employee: Person {
  override func celebrateBirthday() {}
}

```

```swift
class Foo: NSObject {}
extension Foo {
    override var description: String { return "" }
}
```

```swift
struct Foo {
    class Bar: NSObject {}
}
extension Foo.Bar {
    override var description: String { return "" }
}
```

## Triggering Examples

```swift
extension Person {
  override ↓var age: Int { return 42 }
}

```

```swift
extension Person {
  override ↓func celebrateBirthday() {}
}

```