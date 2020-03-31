# Number Separator

Underscores should be used as thousand separator in large decimal numbers.

* **Identifier:** number_separator
* **Enabled by default:** Disabled
* **Supports autocorrection:** Yes
* **Kind:** style
* **Analyzer rule:** No
* **Minimum Swift compiler version:** 3.0.0
* **Default configuration:** warning, minimum_length: 0

## Non Triggering Examples

```swift
let foo = -100
```

```swift
let foo = -1_000
```

```swift
let foo = -1_000_000
```

```swift
let foo = -1.000_1
```

```swift
let foo = -1_000_000.000_000_1
```

```swift
let binary = -0b10000
```

```swift
let binary = -0b1000_0001
```

```swift
let hex = -0xA
```

```swift
let hex = -0xAA_BB
```

```swift
let octal = -0o21
```

```swift
let octal = -0o21_1
```

```swift
let exp = -1_000_000.000_000e2
```

```swift
let foo: Double = -(200)
```

```swift
let foo: Double = -(200 / 447.214)
```

```swift
let foo = +100
```

```swift
let foo = +1_000
```

```swift
let foo = +1_000_000
```

```swift
let foo = +1.000_1
```

```swift
let foo = +1_000_000.000_000_1
```

```swift
let binary = +0b10000
```

```swift
let binary = +0b1000_0001
```

```swift
let hex = +0xA
```

```swift
let hex = +0xAA_BB
```

```swift
let octal = +0o21
```

```swift
let octal = +0o21_1
```

```swift
let exp = +1_000_000.000_000e2
```

```swift
let foo: Double = +(200)
```

```swift
let foo: Double = +(200 / 447.214)
```

```swift
let foo = 100
```

```swift
let foo = 1_000
```

```swift
let foo = 1_000_000
```

```swift
let foo = 1.000_1
```

```swift
let foo = 1_000_000.000_000_1
```

```swift
let binary = 0b10000
```

```swift
let binary = 0b1000_0001
```

```swift
let hex = 0xA
```

```swift
let hex = 0xAA_BB
```

```swift
let octal = 0o21
```

```swift
let octal = 0o21_1
```

```swift
let exp = 1_000_000.000_000e2
```

```swift
let foo: Double = (200)
```

```swift
let foo: Double = (200 / 447.214)
```

## Triggering Examples

```swift
let foo = ↓-10_0
```

```swift
let foo = ↓-1000
```

```swift
let foo = ↓-1000e2
```

```swift
let foo = ↓-1000E2
```

```swift
let foo = ↓-1__000
```

```swift
let foo = ↓-1.0001
```

```swift
let foo = ↓-1_000_000.000000_1
```

```swift
let foo = ↓-1000000.000000_1
```

```swift
let foo = +↓10_0
```

```swift
let foo = +↓1000
```

```swift
let foo = +↓1000e2
```

```swift
let foo = +↓1000E2
```

```swift
let foo = +↓1__000
```

```swift
let foo = +↓1.0001
```

```swift
let foo = +↓1_000_000.000000_1
```

```swift
let foo = +↓1000000.000000_1
```

```swift
let foo = ↓10_0
```

```swift
let foo = ↓1000
```

```swift
let foo = ↓1000e2
```

```swift
let foo = ↓1000E2
```

```swift
let foo = ↓1__000
```

```swift
let foo = ↓1.0001
```

```swift
let foo = ↓1_000_000.000000_1
```

```swift
let foo = ↓1000000.000000_1
```

```swift
let foo: Double = ↓-(100000)
```

```swift
let foo: Double = ↓-(10.000000_1)
```

```swift
let foo: Double = ↓-(123456 / ↓447.214214)
```

```swift
let foo: Double = +(↓100000)
```

```swift
let foo: Double = +(↓10.000000_1)
```

```swift
let foo: Double = +(↓123456 / ↓447.214214)
```

```swift
let foo: Double = (↓100000)
```

```swift
let foo: Double = (↓10.000000_1)
```

```swift
let foo: Double = (↓123456 / ↓447.214214)
```