# Duplicate Enum Cases

Enum can't contain multiple cases with the same name.

* **Identifier:** duplicate_enum_cases
* **Enabled by default:** Enabled
* **Supports autocorrection:** No
* **Kind:** lint
* **Analyzer rule:** No
* **Minimum Swift compiler version:** 3.0.0
* **Default configuration:** error

## Non Triggering Examples

```swift
enum PictureImport {
    case addImage(image: UIImage)
    case addData(data: Data)
}
```

```swift
enum A {
    case add(image: UIImage)
}
enum B {
    case add(image: UIImage)
}
```

## Triggering Examples

```swift
enum PictureImport {
    case ↓add(image: UIImage)
    case addURL(url: URL)
    case ↓add(data: Data)
}
```