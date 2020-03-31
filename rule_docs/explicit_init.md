# Explicit Init

Explicitly calling .init() should be avoided.

* **Identifier:** explicit_init
* **Enabled by default:** Disabled
* **Supports autocorrection:** Yes
* **Kind:** idiomatic
* **Analyzer rule:** No
* **Minimum Swift compiler version:** 3.0.0
* **Default configuration:** warning

## Non Triggering Examples

```swift
import Foundation; class C: NSObject { override init() { super.init() }}
```

```swift
struct S { let n: Int }; extension S { init() { self.init(n: 1) } }
```

```swift
[1].flatMap(String.init)
```

```swift
[String.self].map { $0.init(1) }
```

```swift
[String.self].map { type in type.init(1) }
```

```swift
Observable.zip(obs1, obs2, resultSelector: MyType.init).asMaybe()
```

```swift
Observable.zip(
  obs1,
  obs2,
  resultSelector: MyType.init
).asMaybe()
```

## Triggering Examples

```swift
[1].flatMap{String↓.init($0)}
```

```swift
[String.self].map { Type in Type↓.init(1) }
```

```swift
func foo() -> [String] {
  return [1].flatMap { String↓.init($0) }
}
```

```swift
Observable.zip(
  obs1,
  obs2,
  resultSelector: { MyType.init($0, $1) }
).asMaybe()
```