# Empty Enum Arguments

Arguments can be omitted when matching enums with associated types if they are not used.

* **Identifier:** empty_enum_arguments
* **Enabled by default:** Enabled
* **Supports autocorrection:** Yes
* **Kind:** style
* **Analyzer rule:** No
* **Minimum Swift compiler version:** 3.0.0
* **Default configuration:** warning

## Non Triggering Examples

```swift
switch foo {
case .bar: break
}
```

```swift
switch foo {
case .bar(let x): break
}
```

```swift
switch foo {
case let .bar(x): break
}
```

```swift
switch (foo, bar) {
case (_, _): break
}
```

```swift
switch foo {
case "bar".uppercased(): break
}
```

```swift
switch (foo, bar) {
case (_, _) where !something: break
}
```

```swift
switch foo {
case (let f as () -> String)?: break
}
```

```swift
switch foo {
default: break
}
```

## Triggering Examples

```swift
switch foo {
case .bar↓(_): break
}
```

```swift
switch foo {
case .bar↓(): break
}
```

```swift
switch foo {
case .bar↓(_), .bar2↓(_): break
}
```

```swift
switch foo {
case .bar↓() where method() > 2: break
}
```

```swift
func example(foo: Foo) {
    switch foo {
    case case .bar↓(_):
        break
    }
}
```