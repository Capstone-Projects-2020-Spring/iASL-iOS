# Explicit Type Interface

Properties should have a type interface

* **Identifier:** explicit_type_interface
* **Enabled by default:** Disabled
* **Supports autocorrection:** No
* **Kind:** idiomatic
* **Analyzer rule:** No
* **Minimum Swift compiler version:** 3.0.0
* **Default configuration:** warning, excluded: [], allow_redundancy: false

## Non Triggering Examples

```swift
class Foo {
  var myVar: Int? = 0
}
```

```swift
class Foo {
  let myVar: Int? = 0
}
```

```swift
class Foo {
  static var myVar: Int? = 0
}
```

```swift
class Foo {
  class var myVar: Int? = 0
}
```

## Triggering Examples

```swift
class Foo {
  ↓var myVar = 0
}
```

```swift
class Foo {
  ↓let mylet = 0
}
```

```swift
class Foo {
  ↓static var myStaticVar = 0
}
```

```swift
class Foo {
  ↓class var myClassVar = 0
}
```

```swift
class Foo {
  ↓let myVar = Int(0)
}
```

```swift
class Foo {
  ↓let myVar = Set<Int>(0)
}
```