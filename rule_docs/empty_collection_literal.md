# Empty Collection Literal

Prefer checking `isEmpty` over comparing collection to an empty array or dictionary literal.

* **Identifier:** empty_collection_literal
* **Enabled by default:** Disabled
* **Supports autocorrection:** No
* **Kind:** performance
* **Analyzer rule:** No
* **Minimum Swift compiler version:** 3.0.0
* **Default configuration:** warning

## Non Triggering Examples

```swift
myArray = []
```

```swift
myArray.isEmpty
```

```swift
!myArray.isEmpty
```

```swift
myDict = [:]
```

## Triggering Examples

```swift
myArray↓ == []
```

```swift
myArray↓ != []
```

```swift
myArray↓ == [ ]
```

```swift
myDict↓ == [:]
```

```swift
myDict↓ != [:]
```

```swift
myDict↓ == [: ]
```

```swift
myDict↓ == [ :]
```

```swift
myDict↓ == [ : ]
```