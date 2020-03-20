# Trailing Semicolon

Lines should not have trailing semicolons.

* **Identifier:** trailing_semicolon
* **Enabled by default:** Enabled
* **Supports autocorrection:** Yes
* **Kind:** idiomatic
* **Analyzer rule:** No
* **Minimum Swift compiler version:** 3.0.0
* **Default configuration:** warning

## Non Triggering Examples

```swift
let a = 0

```

## Triggering Examples

```swift
let a = 0↓;

```

```swift
let a = 0↓;
let b = 1

```

```swift
let a = 0↓;;

```

```swift
let a = 0↓;    ;;

```

```swift
let a = 0↓; ; ;

```