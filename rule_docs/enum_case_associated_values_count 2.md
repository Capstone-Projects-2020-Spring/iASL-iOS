# Enum Case Associated Values Count

Number of associated values in an enum case should be low

* **Identifier:** enum_case_associated_values_count
* **Enabled by default:** Disabled
* **Supports autocorrection:** No
* **Kind:** metrics
* **Analyzer rule:** No
* **Minimum Swift compiler version:** 3.0.0
* **Default configuration:** warning: 5, error: 6

## Non Triggering Examples

```swift
enum Employee {
    case fullTime(name: String, retirement: Date, designation: String, contactNumber: Int)
    case partTime(name: String, age: Int, contractEndDate: Date)
}
```

```swift
enum Barcode {
    case upc(Int, Int, Int, Int)
}
```

## Triggering Examples

```swift
enum Employee {
    case ↓fullTime(name: String, retirement: Date, age: Int, designation: String, contactNumber: Int)
    case ↓partTime(name: String, contractEndDate: Date, age: Int, designation: String, contactNumber: Int)
}
```

```swift
enum Barcode {
    case ↓upc(Int, Int, Int, Int, Int, Int)
}
```