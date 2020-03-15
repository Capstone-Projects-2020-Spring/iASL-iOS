# Force Try

Force tries should be avoided.

* **Identifier:** force_try
* **Enabled by default:** Enabled
* **Supports autocorrection:** No
* **Kind:** idiomatic
* **Analyzer rule:** No
* **Minimum Swift compiler version:** 3.0.0
* **Default configuration:** error

## Non Triggering Examples

```swift
func a() throws {}
do {
  try a()
} catch {}
```

## Triggering Examples

```swift
func a() throws {}
↓try! a()
```