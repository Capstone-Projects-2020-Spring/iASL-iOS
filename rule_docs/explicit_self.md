# Explicit Self

Instance variables and functions should be explicitly accessed with 'self.'.

* **Identifier:** explicit_self
* **Enabled by default:** Disabled
* **Supports autocorrection:** Yes
* **Kind:** style
* **Analyzer rule:** Yes
* **Minimum Swift compiler version:** 3.0.0
* **Default configuration:** warning

## Non Triggering Examples

```swift
struct A {
    func f1() {}
    func f2() {
        self.f1()
    }
}
```

```swift
struct A {
    let p1: Int
    func f1() {
        _ = self.p1
    }
}
```

## Triggering Examples

```swift
struct A {
    func f1() {}
    func f2() {
        ↓f1()
    }
}
```

```swift
struct A {
    let p1: Int
    func f1() {
        _ = ↓p1
    }
}
```