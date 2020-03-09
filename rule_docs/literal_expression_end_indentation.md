# Literal Expression End Indentation

Array and dictionary literal end should have the same indentation as the line that started it.

* **Identifier:** literal_expression_end_indentation
* **Enabled by default:** Disabled
* **Supports autocorrection:** Yes
* **Kind:** style
* **Analyzer rule:** No
* **Minimum Swift compiler version:** 3.0.0
* **Default configuration:** warning

## Non Triggering Examples

```swift
[1, 2, 3]
```

```swift
[1,
 2
]
```

```swift
[
   1,
   2
]
```

```swift
[
   1,
   2]
```

```swift
   let x = [
       1,
       2
   ]
```

```swift
[key: 2, key2: 3]
```

```swift
[key: 1,
 key2: 2
]
```

```swift
[
   key: 0,
   key2: 20
]
```

## Triggering Examples

```swift
let x = [
   1,
   2
   ↓]
```

```swift
   let x = [
       1,
       2
↓]
```

```swift
let x = [
   key: value
   ↓]
```