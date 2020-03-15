# Statement Position

Else and catch should be on the same line, one space after the previous declaration.

* **Identifier:** statement_position
* **Enabled by default:** Enabled
* **Supports autocorrection:** Yes
* **Kind:** style
* **Analyzer rule:** No
* **Minimum Swift compiler version:** 3.0.0
* **Default configuration:** (statement_mode) default, (severity) warning

## Non Triggering Examples

```swift
} else if {
```

```swift
} else {
```

```swift
} catch {
```

```swift
"}else{"
```

```swift
struct A { let catchphrase: Int }
let a = A(
 catchphrase: 0
)
```

```swift
struct A { let `catch`: Int }
let a = A(
 `catch`: 0
)
```

## Triggering Examples

```swift
↓}else if {
```

```swift
↓}  else {
```

```swift
↓}
catch {
```

```swift
↓}
	  catch {
```