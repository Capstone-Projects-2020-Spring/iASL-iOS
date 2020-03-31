# Comma Spacing

There should be no space before and one after any comma.

* **Identifier:** comma
* **Enabled by default:** Enabled
* **Supports autocorrection:** Yes
* **Kind:** style
* **Analyzer rule:** No
* **Minimum Swift compiler version:** 3.0.0
* **Default configuration:** warning

## Non Triggering Examples

```swift
func abc(a: String, b: String) { }
```

```swift
abc(a: "string", b: "string"
```

```swift
enum a { case a, b, c }
```

```swift
func abc(
  a: String,  // comment
  bcd: String // comment
) {
}

```

```swift
func abc(
  a: String,
  bcd: String
) {
}

```

```swift
#imageLiteral(resourceName: "foo,bar,baz")
```

## Triggering Examples

```swift
func abc(a: String↓ ,b: String) { }
```

```swift
func abc(a: String↓ ,b: String↓ ,c: String↓ ,d: String) { }
```

```swift
abc(a: "string"↓,b: "string"
```

```swift
enum a { case a↓ ,b }
```

```swift
let result = plus(
    first: 3↓ , // #683
    second: 4
)

```