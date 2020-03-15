# Optional Enum Case Match

Matching an enum case against an optional enum without '?' is supported on Swift 5.1 and above.

* **Identifier:** optional_enum_case_matching
* **Enabled by default:** Disabled
* **Supports autocorrection:** Yes
* **Kind:** style
* **Analyzer rule:** No
* **Minimum Swift compiler version:** 5.1.0
* **Default configuration:** warning

## Non Triggering Examples

```swift
switch foo {
 case .bar: break
 case .baz: break
 default: break
}
```

```swift
switch foo {
 case (.bar, .baz): break
 case (.bar, _): break
 case (_, .baz): break
 default: break
}
```

```swift
switch (x, y) {
case (.c, _?):
    break
case (.c, nil):
    break
case (_, _):
    break
}
```

## Triggering Examples

```swift
switch foo {
 case .bar↓?: break
 case .baz: break
 default: break
}
```

```swift
switch foo {
 case Foo.bar↓?: break
 case .baz: break
 default: break
}
```

```swift
switch foo {
 case .bar↓?, .baz↓?: break
 default: break
}
```

```swift
switch foo {
 case .bar↓? where x > 1: break
 case .baz: break
 default: break
}
```

```swift
switch foo {
 case (.bar↓?, .baz↓?): break
 case (.bar↓?, _): break
 case (_, .bar↓?): break
 default: break
}
```