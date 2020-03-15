# Shorthand Operator

Prefer shorthand operators (+=, -=, *=, /=) over doing the operation and assigning.

* **Identifier:** shorthand_operator
* **Enabled by default:** Enabled
* **Supports autocorrection:** No
* **Kind:** style
* **Analyzer rule:** No
* **Minimum Swift compiler version:** 3.0.0
* **Default configuration:** error

## Non Triggering Examples

```swift
foo -= 1
```

```swift
foo -= variable
```

```swift
foo -= bar.method()
```

```swift
self.foo = foo - 1
```

```swift
foo = self.foo - 1
```

```swift
page = ceilf(currentOffset - pageWidth)
```

```swift
foo = aMethod(foo - bar)
```

```swift
foo = aMethod(bar - foo)
```

```swift
foo /= 1
```

```swift
foo /= variable
```

```swift
foo /= bar.method()
```

```swift
self.foo = foo / 1
```

```swift
foo = self.foo / 1
```

```swift
page = ceilf(currentOffset / pageWidth)
```

```swift
foo = aMethod(foo / bar)
```

```swift
foo = aMethod(bar / foo)
```

```swift
foo += 1
```

```swift
foo += variable
```

```swift
foo += bar.method()
```

```swift
self.foo = foo + 1
```

```swift
foo = self.foo + 1
```

```swift
page = ceilf(currentOffset + pageWidth)
```

```swift
foo = aMethod(foo + bar)
```

```swift
foo = aMethod(bar + foo)
```

```swift
foo *= 1
```

```swift
foo *= variable
```

```swift
foo *= bar.method()
```

```swift
self.foo = foo * 1
```

```swift
foo = self.foo * 1
```

```swift
page = ceilf(currentOffset * pageWidth)
```

```swift
foo = aMethod(foo * bar)
```

```swift
foo = aMethod(bar * foo)
```

```swift
var helloWorld = "world!"
 helloWorld = "Hello, " + helloWorld
```

```swift
angle = someCheck ? angle : -angle
```

```swift
seconds = seconds * 60 + value
```

## Triggering Examples

```swift
↓foo = foo - 1

```

```swift
↓foo = foo - aVariable

```

```swift
↓foo = foo - bar.method()

```

```swift
↓foo.aProperty = foo.aProperty - 1

```

```swift
↓self.aProperty = self.aProperty - 1

```

```swift
↓foo = foo / 1

```

```swift
↓foo = foo / aVariable

```

```swift
↓foo = foo / bar.method()

```

```swift
↓foo.aProperty = foo.aProperty / 1

```

```swift
↓self.aProperty = self.aProperty / 1

```

```swift
↓foo = foo + 1

```

```swift
↓foo = foo + aVariable

```

```swift
↓foo = foo + bar.method()

```

```swift
↓foo.aProperty = foo.aProperty + 1

```

```swift
↓self.aProperty = self.aProperty + 1

```

```swift
↓foo = foo * 1

```

```swift
↓foo = foo * aVariable

```

```swift
↓foo = foo * bar.method()

```

```swift
↓foo.aProperty = foo.aProperty * 1

```

```swift
↓self.aProperty = self.aProperty * 1

```

```swift
n = n + i / outputLength
```

```swift
n = n - i / outputLength
```