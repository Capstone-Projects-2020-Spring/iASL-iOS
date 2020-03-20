# Is Disjoint

Prefer using `Set.isDisjoint(with:)` over `Set.intersection(_:).isEmpty`.

* **Identifier:** is_disjoint
* **Enabled by default:** Enabled
* **Supports autocorrection:** No
* **Kind:** idiomatic
* **Analyzer rule:** No
* **Minimum Swift compiler version:** 3.0.0
* **Default configuration:** warning

## Non Triggering Examples

```swift
_ = Set(syntaxKinds).isDisjoint(with: commentAndStringKindsSet)
```

```swift
let isObjc = !objcAttributes.isDisjoint(with: dictionary.enclosedSwiftAttributes)
```

```swift
_ = Set(syntaxKinds).intersection(commentAndStringKindsSet)
```

```swift
_ = !objcAttributes.intersection(dictionary.enclosedSwiftAttributes)
```

## Triggering Examples

```swift
_ = Set(syntaxKinds).↓intersection(commentAndStringKindsSet).isEmpty
```

```swift
let isObjc = !objcAttributes.↓intersection(dictionary.enclosedSwiftAttributes).isEmpty
```