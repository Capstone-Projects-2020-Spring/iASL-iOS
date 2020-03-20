# Vertical Whitespace

Limit vertical whitespace to a single empty line.

* **Identifier:** vertical_whitespace
* **Enabled by default:** Enabled
* **Supports autocorrection:** Yes
* **Kind:** style
* **Analyzer rule:** No
* **Minimum Swift compiler version:** 3.0.0
* **Default configuration:** warning, max_empty_lines: 1

## Non Triggering Examples

```swift
let abc = 0

```

```swift
let abc = 0


```

```swift
/* bcs 



*/
```

```swift
// bca 


```

## Triggering Examples

```swift
let aaaa = 0



```

```swift
struct AAAA {}




```

```swift
class BBBB {}



```