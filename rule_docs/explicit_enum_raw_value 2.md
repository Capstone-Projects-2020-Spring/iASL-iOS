# Explicit Enum Raw Value

Enums should be explicitly assigned their raw values.

* **Identifier:** explicit_enum_raw_value
* **Enabled by default:** Disabled
* **Supports autocorrection:** No
* **Kind:** idiomatic
* **Analyzer rule:** No
* **Minimum Swift compiler version:** 3.0.0
* **Default configuration:** warning

## Non Triggering Examples

```swift
enum Numbers {
  case int(Int)
  case short(Int16)
}
```

```swift
enum Numbers: Int {
  case one = 1
  case two = 2
}
```

```swift
enum Numbers: Double {
  case one = 1.1
  case two = 2.2
}
```

```swift
enum Numbers: String {
  case one = "one"
  case two = "two"
}
```

```swift
protocol Algebra {}
enum Numbers: Algebra {
  case one
}
```

## Triggering Examples

```swift
enum Numbers: Int {
  case one = 10, ↓two, three = 30
}
```

```swift
enum Numbers: NSInteger {
  case ↓one
}
```

```swift
enum Numbers: String {
  case ↓one
  case ↓two
}
```

```swift
enum Numbers: String {
   case ↓one, two = "two"
}
```

```swift
enum Numbers: Decimal {
  case ↓one, ↓two
}
```