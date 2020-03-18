# Syntactic Sugar

Shorthand syntactic sugar should be used, i.e. [Int] instead of Array<Int>.

* **Identifier:** syntactic_sugar
* **Enabled by default:** Enabled
* **Supports autocorrection:** Yes
* **Kind:** idiomatic
* **Analyzer rule:** No
* **Minimum Swift compiler version:** 3.0.0
* **Default configuration:** warning

## Non Triggering Examples

```swift
let x: [Int]
```

```swift
let x: [Int: String]
```

```swift
let x: Int?
```

```swift
func x(a: [Int], b: Int) -> [Int: Any]
```

```swift
let x: Int!
```

```swift
extension Array {
  func x() { }
}
```

```swift
extension Dictionary {
  func x() { }
}
```

```swift
let x: CustomArray<String>
```

```swift
var currentIndex: Array<OnboardingPage>.Index?
```

```swift
func x(a: [Int], b: Int) -> Array<Int>.Index
```

```swift
unsafeBitCast(nonOptionalT, to: Optional<T>.self)
```

```swift
type is Optional<String>.Type
```

```swift
let x: Foo.Optional<String>
```

## Triggering Examples

```swift
let x: ↓Array<String>
```

```swift
let x: ↓Dictionary<Int, String>
```

```swift
let x: ↓Optional<Int>
```

```swift
let x: ↓ImplicitlyUnwrappedOptional<Int>
```

```swift
func x(a: ↓Array<Int>, b: Int) -> [Int: Any]
```

```swift
func x(a: [Int], b: Int) -> ↓Dictionary<Int, String>
```

```swift
func x(a: ↓Array<Int>, b: Int) -> ↓Dictionary<Int, String>
```

```swift
let x = ↓Array<String>.array(of: object)
```

```swift
let x: ↓Swift.Optional<String>
```