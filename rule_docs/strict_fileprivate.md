# Strict fileprivate

`fileprivate` should be avoided.

* **Identifier:** strict_fileprivate
* **Enabled by default:** Disabled
* **Supports autocorrection:** No
* **Kind:** idiomatic
* **Analyzer rule:** No
* **Minimum Swift compiler version:** 3.0.0
* **Default configuration:** warning

## Non Triggering Examples

```swift
extension String {}
```

```swift
private extension String {}
```

```swift
public
extension String {}
```

```swift
open extension
  String {}
```

```swift
internal extension String {}
```

## Triggering Examples

```swift
↓fileprivate extension String {}
```

```swift
↓fileprivate
  extension String {}
```

```swift
↓fileprivate extension
  String {}
```

```swift
extension String {
  ↓fileprivate func Something(){}
}
```

```swift
class MyClass {
  ↓fileprivate let myInt = 4
}
```

```swift
class MyClass {
  ↓fileprivate(set) var myInt = 4
}
```

```swift
struct Outter {
  struct Inter {
    ↓fileprivate struct Inner {}
  }
}
```