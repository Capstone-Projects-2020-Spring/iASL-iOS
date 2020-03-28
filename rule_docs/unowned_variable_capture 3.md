# Unowned Variable Capture

Prefer capturing references as weak to avoid potential crashes.

* **Identifier:** unowned_variable_capture
* **Enabled by default:** Disabled
* **Supports autocorrection:** No
* **Kind:** lint
* **Analyzer rule:** No
* **Minimum Swift compiler version:** 5.0.0
* **Default configuration:** warning

## Non Triggering Examples

```swift
foo { [weak self] in _ }
```

```swift
foo { [weak self] param in _ }
```

```swift
foo { [weak bar] in _ }
```

```swift
foo { [weak bar] param in _ }
```

```swift
foo { bar in _ }
```

```swift
foo { $0 }
```

## Triggering Examples

```swift
foo { [↓unowned self] in _ }
```

```swift
foo { [↓unowned bar] in _ }
```

```swift
foo { [bar, ↓unowned self] in _ }
```