# Implicitly Unwrapped Optional

Implicitly unwrapped optionals should be avoided when possible.

* **Identifier:** implicitly_unwrapped_optional
* **Enabled by default:** Disabled
* **Supports autocorrection:** No
* **Kind:** idiomatic
* **Analyzer rule:** No
* **Minimum Swift compiler version:** 3.0.0
* **Default configuration:** warning, mode: allExceptIBOutlets

## Non Triggering Examples

```swift
@IBOutlet private var label: UILabel!
```

```swift
@IBOutlet var label: UILabel!
```

```swift
@IBOutlet var label: [UILabel!]
```

```swift
if !boolean {}
```

```swift
let int: Int? = 42
```

```swift
let int: Int? = nil
```

## Triggering Examples

```swift
let label: UILabel!
```

```swift
let IBOutlet: UILabel!
```

```swift
let labels: [UILabel!]
```

```swift
var ints: [Int!] = [42, nil, 42]
```

```swift
let label: IBOutlet!
```

```swift
let int: Int! = 42
```

```swift
let int: Int! = nil
```

```swift
var int: Int! = 42
```

```swift
let int: ImplicitlyUnwrappedOptional<Int>
```

```swift
let collection: AnyCollection<Int!>
```

```swift
func foo(int: Int!) {}
```