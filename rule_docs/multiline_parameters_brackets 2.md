# Multiline Parameters Brackets

Multiline parameters should have their surrounding brackets in a new line.

* **Identifier:** multiline_parameters_brackets
* **Enabled by default:** Disabled
* **Supports autocorrection:** No
* **Kind:** style
* **Analyzer rule:** No
* **Minimum Swift compiler version:** 3.0.0
* **Default configuration:** warning

## Non Triggering Examples

```swift
func foo(param1: String, param2: String, param3: String)
```

```swift
func foo(
    param1: String, param2: String, param3: String
)
```

```swift
func foo(
    param1: String,
    param2: String,
    param3: String
)
```

```swift
class SomeType {
    func foo(param1: String, param2: String, param3: String)
}
```

```swift
class SomeType {
    func foo(
        param1: String, param2: String, param3: String
    )
}
```

```swift
class SomeType {
    func foo(
        param1: String,
        param2: String,
        param3: String
    )
}
```

```swift
func foo<T>(param1: T, param2: String, param3: String) -> T { /* some code */ }
```

## Triggering Examples

```swift
func foo(↓param1: String, param2: String,
         param3: String
)
```

```swift
func foo(
    param1: String,
    param2: String,
    param3: String↓)
```

```swift
class SomeType {
    func foo(↓param1: String, param2: String,
             param3: String
    )
}
```

```swift
class SomeType {
    func foo(
        param1: String,
        param2: String,
        param3: String↓)
}
```

```swift
func foo<T>(↓param1: T, param2: String,
         param3: String
) -> T
```