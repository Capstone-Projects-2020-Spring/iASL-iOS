# Private over fileprivate

Prefer `private` over `fileprivate` declarations.

* **Identifier:** private_over_fileprivate
* **Enabled by default:** Enabled
* **Supports autocorrection:** Yes
* **Kind:** idiomatic
* **Analyzer rule:** No
* **Minimum Swift compiler version:** 3.0.0
* **Default configuration:** warning, validate_extensions: false

## Non Triggering Examples

```swift
extension String {}
```

```swift
private extension String {}
```

```swift
public 
 enum MyEnum {}
```

```swift
open extension 
 String {}
```

```swift
internal extension String {}
```

```swift
extension String {
  fileprivate func Something(){}
}
```

```swift
class MyClass {
  fileprivate let myInt = 4
}
```

```swift
class MyClass {
  fileprivate(set) var myInt = 4
}
```

```swift
struct Outter {
  struct Inter {
    fileprivate struct Inner {}
  }
}
```

## Triggering Examples

```swift
↓fileprivate enum MyEnum {}
```

```swift
↓fileprivate class MyClass {
  fileprivate(set) var myInt = 4
}
```