# Joined Default Parameter

Discouraged explicit usage of the default separator.

* **Identifier:** joined_default_parameter
* **Enabled by default:** Disabled
* **Supports autocorrection:** Yes
* **Kind:** idiomatic
* **Analyzer rule:** No
* **Minimum Swift compiler version:** 3.0.0
* **Default configuration:** warning

## Non Triggering Examples

```swift
let foo = bar.joined()
```

```swift
let foo = bar.joined(separator: ",")
```

```swift
let foo = bar.joined(separator: toto)
```

## Triggering Examples

```swift
let foo = bar.joined(↓separator: "")
```

```swift
let foo = bar.filter(toto)
             .joined(↓separator: ""),
```

```swift
func foo() -> String {
  return ["1", "2"].joined(↓separator: "")
}
```