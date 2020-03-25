# Implicit Return

Prefer implicit returns in closures, functions and getters.

* **Identifier:** implicit_return
* **Enabled by default:** Disabled
* **Supports autocorrection:** Yes
* **Kind:** style
* **Analyzer rule:** No
* **Minimum Swift compiler version:** 3.0.0
* **Default configuration:** warning, included: [closure, function, getter]

## Non Triggering Examples

```swift
if foo {
  return 0
}
```

```swift
foo.map { $0 + 1 }
```

```swift
foo.map({ $0 + 1 })
```

```swift
foo.map { value in value + 1 }
```

```swift
[1, 2].first(where: {
    true
})
```

```swift
func foo() -> Int {
    0
}
```

```swift
class Foo {
    func foo() -> Int { 0 }
}
```

```swift
var foo: Bool { true }
```

```swift
class Foo {
    var bar: Int {
        get {
            0
        }
    }
}
```

```swift
class Foo {
    static var bar: Int {
        0
    }
}
```

## Triggering Examples

```swift
foo.map { value in
    return value + 1
}
```

```swift
foo.map {
    return $0 + 1
}
```

```swift
foo.map({ return $0 + 1})
```

```swift
[1, 2].first(where: {
    return true
})
```

```swift
func foo() -> Int {
    return 0
}
```

```swift
class Foo {
    func foo() -> Int { return 0 }
}
```

```swift
var foo: Bool { return true }
```

```swift
class Foo {
    var bar: Int {
        get {
            return 0
        }
    }
}
```

```swift
class Foo {
    static var bar: Int {
        return 0
    }
}
```