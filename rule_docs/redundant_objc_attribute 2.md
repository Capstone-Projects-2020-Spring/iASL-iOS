# Redundant @objc Attribute

Objective-C attribute (@objc) is redundant in declaration.

* **Identifier:** redundant_objc_attribute
* **Enabled by default:** Enabled
* **Supports autocorrection:** Yes
* **Kind:** idiomatic
* **Analyzer rule:** No
* **Minimum Swift compiler version:** 4.1.0
* **Default configuration:** warning

## Non Triggering Examples

```swift
@objc private var foo: String? {}
```

```swift
@IBInspectable private var foo: String? {}
```

```swift
@objc private func foo(_ sender: Any) {}
```

```swift
@IBAction private func foo(_ sender: Any) {}
```

```swift
@GKInspectable private var foo: String! {}
```

```swift
private @GKInspectable var foo: String! {}
```

```swift
@NSManaged var foo: String!
```

```swift
@objc @NSCopying var foo: String!
```

```swift
@objcMembers
class Foo {
    var bar: Any?
    @objc
    class Bar {
        @objc
        var foo: Any?
    }
}
```

```swift
@objc
extension Foo {
    var bar: Int {
        return 0
    }
}
```

```swift
extension Foo {
    @objc
    var bar: Int { return 0 }
}
```

```swift
@objc @IBDesignable
extension Foo {
    var bar: Int { return 0 }
}
```

```swift
@IBDesignable
extension Foo {
    @objc
    var bar: Int { return 0 }
    var fooBar: Int { return 1 }
}
```

```swift
@objcMembers
class Foo: NSObject {
    @objc
    private var bar: Int {
        return 0
    }
}
```

```swift
@objcMembers
class Foo {
    class Bar: NSObject {
        @objc var foo: Any
    }
}
```

```swift
@objcMembers
class Foo {
    @objc class Bar {}
}
```

## Triggering Examples

```swift
↓@objc @IBInspectable private var foo: String? {}
```

```swift
@IBInspectable ↓@objc private var foo: String? {}
```

```swift
↓@objc @IBAction private func foo(_ sender: Any) {}
```

```swift
@IBAction ↓@objc private func foo(_ sender: Any) {}
```

```swift
↓@objc @GKInspectable private var foo: String! {}
```

```swift
@GKInspectable ↓@objc private var foo: String! {}
```

```swift
↓@objc @NSManaged private var foo: String!
```

```swift
@NSManaged ↓@objc private var foo: String!
```

```swift
↓@objc @IBDesignable class Foo {}
```

```swift
@objcMembers
class Foo {
    ↓@objc var bar: Any?
}
```

```swift
@objcMembers
class Foo {
    ↓@objc var bar: Any?
    ↓@objc var foo: Any?
    @objc
    class Bar {
        @objc
        var foo: Any?
    }
}
```

```swift
@objc
extension Foo {
    ↓@objc
    var bar: Int {
        return 0
    }
}
```

```swift
@objc @IBDesignable
extension Foo {
    ↓@objc
    var bar: Int {
        return 0
    }
}
```

```swift
@objcMembers
class Foo {
    @objcMembers
    class Bar: NSObject {
        ↓@objc var foo: Any
    }
}
```

```swift
@objc
extension Foo {
    ↓@objc
    private var bar: Int {
        return 0
    }
}
```