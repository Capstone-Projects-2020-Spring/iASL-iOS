# Multiline Arguments Brackets

Multiline arguments should have their surrounding brackets in a new line.

* **Identifier:** multiline_arguments_brackets
* **Enabled by default:** Disabled
* **Supports autocorrection:** No
* **Kind:** style
* **Analyzer rule:** No
* **Minimum Swift compiler version:** 3.0.0
* **Default configuration:** warning

## Non Triggering Examples

```swift
foo(param1: "Param1", param2: "Param2", param3: "Param3")
```

```swift
foo(
    param1: "Param1", param2: "Param2", param3: "Param3"
)
```

```swift
func foo(
    param1: "Param1",
    param2: "Param2",
    param3: "Param3"
)
```

```swift
foo { param1, param2 in
    print("hello world")
}
```

```swift
foo(
    bar(
        x: 5,
        y: 7
    )
)
```

```swift
AlertViewModel.AlertAction(title: "some title", style: .default) {
    AlertManager.shared.presentNextDebugAlert()
}
```

## Triggering Examples

```swift
foo(↓param1: "Param1", param2: "Param2",
         param3: "Param3"
)
```

```swift
foo(
    param1: "Param1",
    param2: "Param2",
    param3: "Param3"↓)
```

```swift
foo(↓bar(
    x: 5,
    y: 7
)
)
```

```swift
foo(
    bar(
        x: 5,
        y: 7
)↓)
```