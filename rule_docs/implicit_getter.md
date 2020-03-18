# Implicit Getter

Computed read-only properties and subscripts should avoid using the get keyword.

* **Identifier:** implicit_getter
* **Enabled by default:** Enabled
* **Supports autocorrection:** No
* **Kind:** style
* **Analyzer rule:** No
* **Minimum Swift compiler version:** 3.0.0
* **Default configuration:** warning

## Non Triggering Examples

```swift
class Foo {
    var foo: Int {
        get { return 3 }
        set { _abc = newValue }
    }
}
```

```swift
class Foo {
    var foo: Int {
        return 20
    }
}
```

```swift
class Foo {
    static var foo: Int {
        return 20
    }
}
```

```swift
class Foo {
    static var foo: Int {
        get { return 3 }
        set { _abc = newValue }
    }
}
```

```swift
class Foo {
    var foo: Int
}
```

```swift
class Foo {
    var foo: Int {
        return getValueFromDisk()
    }
}
```

```swift
class Foo {
    var foo: String {
        return "get"
    }
}
```

```swift
protocol Foo {
    var foo: Int { get }
```

```swift
protocol Foo {
    var foo: Int { get set }
```

```swift
class Foo {
    var foo: Int {
        struct Bar {
            var bar: Int {
                get { return 1 }
                set { _ = newValue }
            }
        }

        return Bar().bar
    }
}
```

```swift
var _objCTaggedPointerBits: UInt {
    @inline(__always) get { return 0 }
}
```

```swift
var next: Int? {
    mutating get {
        defer { self.count += 1 }
        return self.count
    }
}
```

```swift
extension Foo {
    var bar: Bool {
        get { _bar }
        set { self._bar = newValue }
    }
}
```

```swift
extension Foo {
    var bar: Bool {
        get { _bar }
        set(newValue) { self._bar = newValue }
    }
}
```

```swift
class Foo {
    subscript(i: Int) -> Int {
        return 20
    }
}
```

```swift
class Foo {
    subscript(i: Int) -> Int {
        get { return 3 }
        set { _abc = newValue }
    }
}
```

```swift
protocol Foo {
    subscript(i: Int) -> Int { get }
}
```

```swift
protocol Foo {
    subscript(i: Int) -> Int { get set }
}
```

## Triggering Examples

```swift
class Foo {
    var foo: Int {
        ↓get {
            return 20
        }
    }
}
```

```swift
class Foo {
    var foo: Int {
        ↓get{ return 20 }
    }
}
```

```swift
class Foo {
    static var foo: Int {
        ↓get {
            return 20
        }
    }
}
```

```swift
var foo: Int {
    ↓get { return 20 }
}
```

```swift
class Foo {
    @objc func bar() {}
    var foo: Int {
        ↓get {
            return 20
        }
    }
}
```

```swift
extension Foo {
    var bar: Bool {
        ↓get { _bar }
    }
}
```

```swift
class Foo {
    subscript(i: Int) -> Int {
        ↓get {
            return 20
        }
    }
}
```