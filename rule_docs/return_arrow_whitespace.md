# Returning Whitespace

Return arrow and return type should be separated by a single space or on a separate line.

* **Identifier:** return_arrow_whitespace
* **Enabled by default:** Enabled
* **Supports autocorrection:** Yes
* **Kind:** style
* **Analyzer rule:** No
* **Minimum Swift compiler version:** 3.0.0
* **Default configuration:** warning

## Non Triggering Examples

```swift
func abc() -> Int {}

```

```swift
func abc() -> [Int] {}

```

```swift
func abc() -> (Int, Int) {}

```

```swift
var abc = {(param: Int) -> Void in }

```

```swift
func abc() ->
    Int {}

```

```swift
func abc()
    -> Int {}

```

## Triggering Examples

```swift
func abc()↓->Int {}

```

```swift
func abc()↓->[Int] {}

```

```swift
func abc()↓->(Int, Int) {}

```

```swift
func abc()↓-> Int {}

```

```swift
func abc()↓ ->Int {}

```

```swift
func abc()↓  ->  Int {}

```

```swift
var abc = {(param: Int)↓ ->Bool in }

```

```swift
var abc = {(param: Int)↓->Bool in }

```