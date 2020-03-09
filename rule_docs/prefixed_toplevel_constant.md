# Prefixed Top-Level Constant

Top-level constants should be prefixed by `k`.

* **Identifier:** prefixed_toplevel_constant
* **Enabled by default:** Disabled
* **Supports autocorrection:** No
* **Kind:** style
* **Analyzer rule:** No
* **Minimum Swift compiler version:** 3.0.0
* **Default configuration:** warning, only_private: false

## Non Triggering Examples

```swift
private let kFoo = 20.0
```

```swift
public let kFoo = false
```

```swift
internal let kFoo = "Foo"
```

```swift
let kFoo = true
```

```swift
struct Foo {
   let bar = 20.0
}
```

```swift
private var foo = 20.0
```

```swift
public var foo = false
```

```swift
internal var foo = "Foo"
```

```swift
var foo = true
```

```swift
var foo = true, bar = true
```

```swift
var foo = true, let kFoo = true
```

```swift
let
   kFoo = true
```

```swift
var foo: Int {
   return a + b
}
```

```swift
let kFoo = {
   return a + b
}()
```

## Triggering Examples

```swift
private let ↓Foo = 20.0
```

```swift
public let ↓Foo = false
```

```swift
internal let ↓Foo = "Foo"
```

```swift
let ↓Foo = true
```

```swift
let ↓foo = 2, ↓bar = true
```

```swift
var foo = true, let ↓Foo = true
```

```swift
let
    ↓foo = true
```

```swift
let ↓foo = {
   return a + b
}()
```