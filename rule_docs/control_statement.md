# Control Statement

`if`, `for`, `guard`, `switch`, `while`, and `catch` statements shouldn't unnecessarily wrap their conditionals or arguments in parentheses.

* **Identifier:** control_statement
* **Enabled by default:** Enabled
* **Supports autocorrection:** Yes
* **Kind:** style
* **Analyzer rule:** No
* **Minimum Swift compiler version:** 3.0.0
* **Default configuration:** warning

## Non Triggering Examples

```swift
if condition {

```

```swift
if (a, b) == (0, 1) {

```

```swift
if (a || b) && (c || d) {

```

```swift
if (min...max).contains(value) {

```

```swift
if renderGif(data) {

```

```swift
renderGif(data)

```

```swift
for item in collection {

```

```swift
for (key, value) in dictionary {

```

```swift
for (index, value) in enumerate(array) {

```

```swift
for var index = 0; index < 42; index++ {

```

```swift
guard condition else {

```

```swift
while condition {

```

```swift
} while condition {

```

```swift
do { ; } while condition {

```

```swift
switch foo {

```

```swift
do {
} catch let error as NSError {
}
```

```swift
foo().catch(all: true) {}
```

```swift
if max(a, b) < c {

```

```swift
switch (lhs, rhs) {

```

## Triggering Examples

```swift
↓if (condition) {

```

```swift
↓if(condition) {

```

```swift
↓if (condition == endIndex) {

```

```swift
↓if ((a || b) && (c || d)) {

```

```swift
↓if ((min...max).contains(value)) {

```

```swift
↓for (item in collection) {

```

```swift
↓for (var index = 0; index < 42; index++) {

```

```swift
↓for(item in collection) {

```

```swift
↓for(var index = 0; index < 42; index++) {

```

```swift
↓guard (condition) else {

```

```swift
↓while (condition) {

```

```swift
↓while(condition) {

```

```swift
} ↓while (condition) {

```

```swift
} ↓while(condition) {

```

```swift
do { ; } ↓while(condition) {

```

```swift
do { ; } ↓while (condition) {

```

```swift
↓switch (foo) {

```

```swift
do {
} ↓catch(let error as NSError) {
}
```

```swift
↓if (max(a, b) < c) {

```