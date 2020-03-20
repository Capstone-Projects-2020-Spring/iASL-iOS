# Function Parameter Count

Number of function parameters should be low.

* **Identifier:** function_parameter_count
* **Enabled by default:** Enabled
* **Supports autocorrection:** No
* **Kind:** metrics
* **Analyzer rule:** No
* **Minimum Swift compiler version:** 3.0.0
* **Default configuration:** warning: 5, error: 8ignores_default_parameters: true

## Non Triggering Examples

```swift
init(a: Int, b: Int, c: Int, d: Int, e: Int, f: Int) {}
```

```swift
init (a: Int, b: Int, c: Int, d: Int, e: Int, f: Int) {}
```

```swift
`init`(a: Int, b: Int, c: Int, d: Int, e: Int, f: Int) {}
```

```swift
init?(a: Int, b: Int, c: Int, d: Int, e: Int, f: Int) {}
```

```swift
init?<T>(a: T, b: Int, c: Int, d: Int, e: Int, f: Int) {}
```

```swift
init?<T: String>(a: T, b: Int, c: Int, d: Int, e: Int, f: Int) {}
```

```swift
func f2(p1: Int, p2: Int) { }
```

```swift
func f(a: Int, b: Int, c: Int, d: Int, x: Int = 42) {}
```

```swift
func f(a: [Int], b: Int, c: Int, d: Int, f: Int) -> [Int] {
    let s = a.flatMap { $0 as? [String: Int] } ?? []}}
```

```swift
override func f(a: Int, b: Int, c: Int, d: Int, e: Int, f: Int) {}
```

## Triggering Examples

```swift
↓func f(a: Int, b: Int, c: Int, d: Int, e: Int, f: Int) {}
```

```swift
↓func initialValue(a: Int, b: Int, c: Int, d: Int, e: Int, f: Int) {}
```

```swift
↓func f(a: Int, b: Int, c: Int, d: Int, e: Int, f: Int = 2, g: Int) {}
```

```swift
struct Foo {
    init(a: Int, b: Int, c: Int, d: Int, e: Int, f: Int) {}
    ↓func bar(a: Int, b: Int, c: Int, d: Int, e: Int, f: Int) {}}
```