# NSLocalizedString Key

Static strings should be used as key in NSLocalizedString in order to genstrings work.

* **Identifier:** nslocalizedstring_key
* **Enabled by default:** Disabled
* **Supports autocorrection:** No
* **Kind:** lint
* **Analyzer rule:** No
* **Minimum Swift compiler version:** 3.0.0
* **Default configuration:** warning

## Non Triggering Examples

```swift
NSLocalizedString("key", comment: nil)
```

```swift
NSLocalizedString("key" + "2", comment: nil)
```

## Triggering Examples

```swift
NSLocalizedString(↓method(), comment: nil)
```

```swift
NSLocalizedString(↓"key_\(param)", comment: nil)
```