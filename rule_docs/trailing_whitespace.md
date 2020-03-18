# Trailing Whitespace

Lines should not have trailing whitespace.

* **Identifier:** trailing_whitespace
* **Enabled by default:** Enabled
* **Supports autocorrection:** Yes
* **Kind:** style
* **Analyzer rule:** No
* **Minimum Swift compiler version:** 3.0.0
* **Default configuration:** warning, ignores_empty_lines: false, ignores_comments: true

## Non Triggering Examples

```swift
let name: String

```

```swift
//

```

```swift
// 

```

```swift
let name: String //

```

```swift
let name: String // 

```

## Triggering Examples

```swift
let name: String 

```

```swift
/* */ let name: String 

```