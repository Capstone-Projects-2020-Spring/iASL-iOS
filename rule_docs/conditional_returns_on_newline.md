# Conditional Returns on Newline

Conditional statements should always return on the next line

* **Identifier:** conditional_returns_on_newline
* **Enabled by default:** Disabled
* **Supports autocorrection:** No
* **Kind:** style
* **Analyzer rule:** No
* **Minimum Swift compiler version:** 3.0.0
* **Default configuration:** warning, if_only: false

## Non Triggering Examples

```swift
guard true else {
 return true
}
```

```swift
guard true,
 let x = true else {
 return true
}
```

```swift
if true else {
 return true
}
```

```swift
if true,
 let x = true else {
 return true
}
```

```swift
if textField.returnKeyType == .Next {
```

```swift
if true { // return }
```

```swift
/*if true { */ return }
```

## Triggering Examples

```swift
↓guard true else { return }
```

```swift
↓if true { return }
```

```swift
↓if true { break } else { return }
```

```swift
↓if true { break } else {       return }
```

```swift
↓if true { return "YES" } else { return "NO" }
```