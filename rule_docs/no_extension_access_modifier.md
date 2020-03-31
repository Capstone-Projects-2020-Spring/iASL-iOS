# No Extension Access Modifier

Prefer not to use extension access modifiers

* **Identifier:** no_extension_access_modifier
* **Enabled by default:** Disabled
* **Supports autocorrection:** No
* **Kind:** idiomatic
* **Analyzer rule:** No
* **Minimum Swift compiler version:** 3.0.0
* **Default configuration:** error

## Non Triggering Examples

```swift
extension String {}
```

```swift


 extension String {}
```

## Triggering Examples

```swift
↓private extension String {}
```

```swift
↓public 
 extension String {}
```

```swift
↓open extension String {}
```

```swift
↓internal extension String {}
```

```swift
↓fileprivate extension String {}
```