# XCTFail Message

An XCTFail call should include a description of the assertion.

* **Identifier:** xctfail_message
* **Enabled by default:** Enabled
* **Supports autocorrection:** No
* **Kind:** idiomatic
* **Analyzer rule:** No
* **Minimum Swift compiler version:** 3.0.0
* **Default configuration:** warning

## Non Triggering Examples

```swift
func testFoo() {
  XCTFail("bar")
}
```

```swift
func testFoo() {
  XCTFail(bar)
}
```

## Triggering Examples

```swift
func testFoo() {
  ↓XCTFail()
}
```

```swift
func testFoo() {
  ↓XCTFail("")
}
```