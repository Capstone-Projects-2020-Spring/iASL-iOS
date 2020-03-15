# Empty String

Prefer checking `isEmpty` over comparing `string` to an empty string literal.

* **Identifier:** empty_string
* **Enabled by default:** Disabled
* **Supports autocorrection:** No
* **Kind:** performance
* **Analyzer rule:** No
* **Minimum Swift compiler version:** 3.0.0
* **Default configuration:** warning

## Non Triggering Examples

```swift
myString.isEmpty
```

```swift
!myString.isEmpty
```

```swift
"""
foo==
"""
```

## Triggering Examples

```swift
myString↓ == ""
```

```swift
myString↓ != ""
```