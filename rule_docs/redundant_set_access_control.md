# Redundant Set Access Control Rule

Property setter access level shouldn't be explicit if it's the same as the variable access level.

* **Identifier:** redundant_set_access_control
* **Enabled by default:** Enabled
* **Supports autocorrection:** No
* **Kind:** idiomatic
* **Analyzer rule:** No
* **Minimum Swift compiler version:** 4.1.0
* **Default configuration:** warning

## Non Triggering Examples

```swift
private(set) public var foo: Int
```

```swift
public let foo: Int
```

```swift
public var foo: Int
```

```swift
var foo: Int
```

```swift
private final class A {
  private(set) var value: Int
}
```

## Triggering Examples

```swift
↓private(set) private var foo: Int
```

```swift
↓fileprivate(set) fileprivate var foo: Int
```

```swift
↓internal(set) internal var foo: Int
```

```swift
↓public(set) public var foo: Int
```

```swift
open class Foo {
  ↓open(set) open var bar: Int
}
```

```swift
class A {
  ↓internal(set) var value: Int
}
```

```swift
fileprivate class A {
  ↓fileprivate(set) var value: Int
}
```