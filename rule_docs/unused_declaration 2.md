# Unused Declaration

Declarations should be referenced at least once within all files linted.

* **Identifier:** unused_declaration
* **Enabled by default:** Disabled
* **Supports autocorrection:** No
* **Kind:** lint
* **Analyzer rule:** Yes
* **Minimum Swift compiler version:** 3.0.0
* **Default configuration:** severity: error, include_public_and_open: false

## Non Triggering Examples

```swift
let kConstant = 0
_ = kConstant
```

```swift
enum Change<T> {
  case insert(T)
  case delete(T)
}

extension Sequence {
  func deletes<T>() -> [T] where Element == Change<T> {
    return compactMap { operation in
      if case .delete(let value) = operation {
        return value
      } else {
        return nil
      }
    }
  }
}

let changes = [Change.insert(0), .delete(0)]
changes.deletes()
```

```swift
struct Item {}
struct ResponseModel: Codable {
    let items: [Item]

    enum CodingKeys: String, CodingKey {
        case items = "ResponseItems"
    }
}

_ = ResponseModel(items: [Item()]).items
```

```swift
class ResponseModel {
    @objc func foo() {
    }
}
_ = ResponseModel()
```

## Triggering Examples

```swift
let ↓kConstant = 0
```

```swift
struct Item {}
struct ↓ResponseModel: Codable {
    let ↓items: [Item]

    enum ↓CodingKeys: String {
        case items = "ResponseItems"
    }
}
```

```swift
class ↓ResponseModel {
    func ↓foo() {
    }
}
```