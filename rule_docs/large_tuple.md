# Large Tuple

Tuples shouldn't have too many members. Create a custom type instead.

* **Identifier:** large_tuple
* **Enabled by default:** Enabled
* **Supports autocorrection:** No
* **Kind:** metrics
* **Analyzer rule:** No
* **Minimum Swift compiler version:** 3.0.0
* **Default configuration:** warning: 2, error: 3

## Non Triggering Examples

```swift
let foo: (Int, Int)

```

```swift
let foo: (start: Int, end: Int)

```

```swift
let foo: (Int, (Int, String))

```

```swift
func foo() -> (Int, Int)

```

```swift
func foo() -> (Int, Int) {}

```

```swift
func foo(bar: String) -> (Int, Int)

```

```swift
func foo(bar: String) -> (Int, Int) {}

```

```swift
func foo() throws -> (Int, Int)

```

```swift
func foo() throws -> (Int, Int) {}

```

```swift
let foo: (Int, Int, Int) -> Void

```

```swift
let foo: (Int, Int, Int) throws -> Void

```

```swift
func foo(bar: (Int, String, Float) -> Void)

```

```swift
func foo(bar: (Int, String, Float) throws -> Void)

```

```swift
var completionHandler: ((_ data: Data?, _ resp: URLResponse?, _ e: NSError?) -> Void)!

```

```swift
func getDictionaryAndInt() -> (Dictionary<Int, String>, Int)?

```

```swift
func getGenericTypeAndInt() -> (Type<Int, String, Float>, Int)?

```

## Triggering Examples

```swift
↓let foo: (Int, Int, Int)

```

```swift
↓let foo: (start: Int, end: Int, value: String)

```

```swift
↓let foo: (Int, (Int, Int, Int))

```

```swift
func foo(↓bar: (Int, Int, Int))

```

```swift
func foo() -> ↓(Int, Int, Int)

```

```swift
func foo() -> ↓(Int, Int, Int) {}

```

```swift
func foo(bar: String) -> ↓(Int, Int, Int)

```

```swift
func foo(bar: String) -> ↓(Int, Int, Int) {}

```

```swift
func foo() throws -> ↓(Int, Int, Int)

```

```swift
func foo() throws -> ↓(Int, Int, Int) {}

```

```swift
func foo() throws -> ↓(Int, ↓(String, String, String), Int) {}

```

```swift
func getDictionaryAndInt() -> (Dictionary<Int, ↓(String, String, String)>, Int)?

```