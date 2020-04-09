# Unused Setter Value

Setter value is not used.

* **Identifier:** unused_setter_value
* **Enabled by default:** Enabled
* **Supports autocorrection:** No
* **Kind:** lint
* **Analyzer rule:** No
* **Minimum Swift compiler version:** 3.0.0
* **Default configuration:** warning

## Non Triggering Examples

```swift
var aValue: String {
    get {
        return Persister.shared.aValue
    }
    set {
        Persister.shared.aValue = newValue
    }
}
```

```swift
var aValue: String {
    set {
        Persister.shared.aValue = newValue
    }
    get {
        return Persister.shared.aValue
    }
}
```

```swift
var aValue: String {
    get {
        return Persister.shared.aValue
    }
    set(value) {
        Persister.shared.aValue = value
    }
}
```

## Triggering Examples

```swift
var aValue: String {
    get {
        return Persister.shared.aValue
    }
    ↓set {
        Persister.shared.aValue = aValue
    }
}
```

```swift
var aValue: String {
    ↓set {
        Persister.shared.aValue = aValue
    }
    get {
        return Persister.shared.aValue
    }
}
```

```swift
var aValue: String {
    get {
        return Persister.shared.aValue
    }
    ↓set {
        Persister.shared.aValue = aValue
    }
}
```

```swift
var aValue: String {
    get {
        let newValue = Persister.shared.aValue
        return newValue
    }
    ↓set {
        Persister.shared.aValue = aValue
    }
}
```

```swift
var aValue: String {
    get {
        return Persister.shared.aValue
    }
    ↓set(value) {
        Persister.shared.aValue = aValue
    }
}
```