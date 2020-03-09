# Untyped Error in Catch

Catch statements should not declare error variables without type casting.

* **Identifier:** untyped_error_in_catch
* **Enabled by default:** Disabled
* **Supports autocorrection:** Yes
* **Kind:** idiomatic
* **Analyzer rule:** No
* **Minimum Swift compiler version:** 3.0.0
* **Default configuration:** warning

## Non Triggering Examples

```swift
do {
  try foo()
} catch {}
```

```swift
do {
  try foo()
} catch Error.invalidOperation {
} catch {}
```

```swift
do {
  try foo()
} catch let error as MyError {
} catch {}
```

```swift
do {
  try foo()
} catch var error as MyError {
} catch {}
```

## Triggering Examples

```swift
do {
  try foo()
} ↓catch var error {}
```

```swift
do {
  try foo()
} ↓catch let error {}
```

```swift
do {
  try foo()
} ↓catch let someError {}
```

```swift
do {
  try foo()
} ↓catch var someError {}
```

```swift
do {
  try foo()
} ↓catch let e {}
```

```swift
do {
  try foo()
} ↓catch(let error) {}
```

```swift
do {
  try foo()
} ↓catch (let error) {}
```