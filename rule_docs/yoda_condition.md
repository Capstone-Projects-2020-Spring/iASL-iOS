# Yoda condition rule

The variable should be placed on the left, the constant on the right of a comparison operator.

* **Identifier:** yoda_condition
* **Enabled by default:** Disabled
* **Supports autocorrection:** No
* **Kind:** lint
* **Analyzer rule:** No
* **Minimum Swift compiler version:** 3.0.0
* **Default configuration:** warning

## Non Triggering Examples

```swift
if foo == 42 {}

```

```swift
if foo <= 42.42 {}

```

```swift
guard foo >= 42 else { return }

```

```swift
guard foo != "str str" else { return }
```

```swift
while foo < 10 { }

```

```swift
while foo > 1 { }

```

```swift
while foo + 1 == 2
```

```swift
if optionalValue?.property ?? 0 == 2
```

```swift
if foo == nil
```

## Triggering Examples

```swift
↓if 42 == foo {}

```

```swift
↓if 42.42 >= foo {}

```

```swift
↓guard 42 <= foo else { return }

```

```swift
↓guard "str str" != foo else { return }
```

```swift
↓while 10 > foo { }
```

```swift
↓while 1 < foo { }
```

```swift
↓if nil == foo
```