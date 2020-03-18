# Identifier Name

Identifier names should only contain alphanumeric characters and start with a lowercase character or should only contain capital letters. In an exception to the above, variable names may start with a capital letter when they are declared static and immutable. Variable names should not be too long or too short.

* **Identifier:** identifier_name
* **Enabled by default:** Enabled
* **Supports autocorrection:** No
* **Kind:** style
* **Analyzer rule:** No
* **Minimum Swift compiler version:** 3.0.0
* **Default configuration:** (min_length) w/e: 3/2, (max_length) w/e: 40/60, excluded: [], allowed_symbols: [], validates_start_with_lowercase: true

## Non Triggering Examples

```swift
let myLet = 0
```

```swift
var myVar = 0
```

```swift
private let _myLet = 0
```

```swift
class Abc { static let MyLet = 0 }
```

```swift
let URL: NSURL? = nil
```

```swift
let XMLString: String? = nil
```

```swift
override var i = 0
```

```swift
enum Foo { case myEnum }
```

```swift
func isOperator(name: String) -> Bool
```

```swift
func typeForKind(_ kind: SwiftDeclarationKind) -> String
```

```swift
func == (lhs: SyntaxToken, rhs: SyntaxToken) -> Bool
```

```swift
override func IsOperator(name: String) -> Bool
```

```swift
enum Foo { case `private` }
```

```swift
enum Foo { case value(String) }
```

## Triggering Examples

```swift
↓let MyLet = 0
```

```swift
↓let _myLet = 0
```

```swift
private ↓let myLet_ = 0
```

```swift
↓let myExtremelyVeryVeryVeryVeryVeryVeryLongLet = 0
```

```swift
↓var myExtremelyVeryVeryVeryVeryVeryVeryLongVar = 0
```

```swift
private ↓let _myExtremelyVeryVeryVeryVeryVeryVeryLongLet = 0
```

```swift
↓let i = 0
```

```swift
↓var id = 0
```

```swift
private ↓let _i = 0
```

```swift
↓func IsOperator(name: String) -> Bool
```

```swift
enum Foo { case ↓MyEnum }
```