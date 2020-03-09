# Notification Center Detachment

An object should only remove itself as an observer in `deinit`.

* **Identifier:** notification_center_detachment
* **Enabled by default:** Enabled
* **Supports autocorrection:** No
* **Kind:** lint
* **Analyzer rule:** No
* **Minimum Swift compiler version:** 3.0.0
* **Default configuration:** warning

## Non Triggering Examples

```swift
class Foo {
   deinit {
       NotificationCenter.default.removeObserver(self)
   }
}
```

```swift
class Foo {
   func bar() {
       NotificationCenter.default.removeObserver(otherObject)
   }
}
```

## Triggering Examples

```swift
class Foo {
   func bar() {
       ↓NotificationCenter.default.removeObserver(self)
   }
}
```