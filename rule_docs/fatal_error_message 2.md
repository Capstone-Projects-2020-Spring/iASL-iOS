# Fatal Error Message

A fatalError call should have a message.

* **Identifier:** fatal_error_message
* **Enabled by default:** Disabled
* **Supports autocorrection:** No
* **Kind:** idiomatic
* **Analyzer rule:** No
* **Minimum Swift compiler version:** 3.0.0
* **Default configuration:** warning

## Non Triggering Examples

```swift
func foo() {
  fatalError("Foo")
}
```

```swift
func foo() {
  fatalError(x)
}
```

## Triggering Examples

```swift
func foo() {
  ↓fatalError("")
}
```

```swift
func foo() {
  ↓fatalError()
}
```