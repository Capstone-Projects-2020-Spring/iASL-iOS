# Dynamic Inline

Avoid using 'dynamic' and '@inline(__always)' together.

* **Identifier:** dynamic_inline
* **Enabled by default:** Enabled
* **Supports autocorrection:** No
* **Kind:** lint
* **Analyzer rule:** No
* **Minimum Swift compiler version:** 3.0.0
* **Default configuration:** error

## Non Triggering Examples

```swift
class C {
dynamic func f() {}}
```

```swift
class C {
@inline(__always) func f() {}}
```

```swift
class C {
@inline(never) dynamic func f() {}}
```

## Triggering Examples

```swift
class C {
@inline(__always) dynamic ↓func f() {}
}
```

```swift
class C {
@inline(__always) public dynamic ↓func f() {}
}
```

```swift
class C {
@inline(__always) dynamic internal ↓func f() {}
}
```

```swift
class C {
@inline(__always)
dynamic ↓func f() {}
}
```

```swift
class C {
@inline(__always)
dynamic
↓func f() {}
}
```