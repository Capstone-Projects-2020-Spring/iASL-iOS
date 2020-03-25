# ExpiringTodo

TODOs and FIXMEs should be resolved prior to their expiry date.

* **Identifier:** expiring_todo
* **Enabled by default:** Disabled
* **Supports autocorrection:** No
* **Kind:** lint
* **Analyzer rule:** No
* **Minimum Swift compiler version:** 3.0.0
* **Default configuration:** (approaching_expiry_severity) warning, (reached_or_passed_expiry_severity) error

## Non Triggering Examples

```swift
// notaTODO:

```

```swift
// notaFIXME:

```

```swift
// TODO: [12/31/9999]

```

```swift
// TODO(note)

```

```swift
// FIXME(note)

```

```swift
/* FIXME: */

```

```swift
/* TODO: */

```

```swift
/** FIXME: */

```

```swift
/** TODO: */

```

## Triggering Examples

```swift
// TODO: [10/14/2019]

```

```swift
// FIXME: [10/14/2019]

```