# Toggle Bool

Prefer `someBool.toggle()` over `someBool = !someBool`.

* **Identifier:** toggle_bool
* **Enabled by default:** Disabled
* **Supports autocorrection:** Yes
* **Kind:** idiomatic
* **Analyzer rule:** No
* **Minimum Swift compiler version:** 4.2.0
* **Default configuration:** warning

## Non Triggering Examples

```swift
isHidden.toggle()

```

```swift
view.clipsToBounds.toggle()

```

```swift
func foo() { abc.toggle() }
```

```swift
view.clipsToBounds = !clipsToBounds

```

```swift
disconnected = !connected

```

## Triggering Examples

```swift
↓isHidden = !isHidden

```

```swift
↓view.clipsToBounds = !view.clipsToBounds

```

```swift
func foo() { ↓abc = !abc }
```