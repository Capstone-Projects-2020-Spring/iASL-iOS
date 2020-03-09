# Vertical Whitespace after Opening Braces

Don't include vertical whitespace (empty line) after opening braces.

* **Identifier:** vertical_whitespace_opening_braces
* **Enabled by default:** Disabled
* **Supports autocorrection:** Yes
* **Kind:** style
* **Analyzer rule:** No
* **Minimum Swift compiler version:** 3.0.0
* **Default configuration:** N/A

## Non Triggering Examples

```swift
/*
    class X {

        let x = 5

    }
*/
```

```swift
// [1, 2].map { $0 }.filter { num in
```

```swift
KingfisherManager.shared.retrieveImage(with: url, options: nil, progressBlock: nil) { image, _, _, _ in
    guard let img = image else { return }
```

```swift
[
1,
2,
3
]
```

```swift
[1, 2].map { $0 }.filter { num in
```

```swift
[1, 2].map { $0 }.foo()
```

```swift
class Name {
    run(5) { x in print(x) }
}
```

```swift
class X {
    struct Y {
    class Z {

```

```swift
foo(
x: 5,
y:6
)
```

```swift
if x == 5 {
	print("x is 5")
```

```swift
if x == 5 {
    print("x is 5")
```

```swift
if x == 5 {
    print("x is 5")
```

```swift
if x == 5 {
  print("x is 5")
```

```swift
struct MyStruct {
	let x = 5
```

```swift
struct MyStruct {
    let x = 5
```

```swift
struct MyStruct {
  let x = 5
```

```swift
}) { _ in
    self.dismiss(animated: false, completion: {
```

## Triggering Examples

```swift
KingfisherManager.shared.retrieveImage(with: url, options: nil, progressBlock: nil) { image, _, _, _ in
↓
    guard let img = image else { return }
```

```swift
[
↓
1,
2,
3
]
```

```swift
class Name {
↓
    run(5) { x in print(x) }
}
```

```swift
class X {
    struct Y {
↓
    class Z {

```

```swift
foo(
↓
x: 5,
y:6
)
```

```swift
if x == 5 {
↓
	print("x is 5")
```

```swift
if x == 5 {
↓

    print("x is 5")
```

```swift
if x == 5 {
↓
    print("x is 5")
```

```swift
if x == 5 {
↓
  print("x is 5")
```

```swift
struct MyStruct {
↓
	let x = 5
```

```swift
struct MyStruct {
↓
    let x = 5
```

```swift
struct MyStruct {
↓
  let x = 5
```

```swift
}) { _ in
↓
    self.dismiss(animated: false, completion: {
```