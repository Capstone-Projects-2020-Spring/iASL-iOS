# Redundant String Enum Value

String enum values can be omitted when they are equal to the enumcase name.

* **Identifier:** redundant_string_enum_value
* **Enabled by default:** Enabled
* **Supports autocorrection:** No
* **Kind:** idiomatic
* **Analyzer rule:** No
* **Minimum Swift compiler version:** 3.0.0
* **Default configuration:** warning

## Non Triggering Examples

```swift
enum Numbers: String {
  case one
  case two
}
```

```swift
enum Numbers: Int {
  case one = 1
  case two = 2
}
```

```swift
enum Numbers: String {
  case one = "ONE"
  case two = "TWO"
}
```

```swift
enum Numbers: String {
  case one = "ONE"
  case two = "two"
}
```

```swift
enum Numbers: String {
  case one, two
}
```

## Triggering Examples

```swift
enum Numbers: String {
  case one = ↓"one"
  case two = ↓"two"
}
```

```swift
enum Numbers: String {
  case one = ↓"one", two = ↓"two"
}
```

```swift
enum Numbers: String {
  case one, two = ↓"two"
}
```