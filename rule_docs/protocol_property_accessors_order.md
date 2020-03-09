# Protocol Property Accessors Order

When declaring properties in protocols, the order of accessors should be `get set`.

* **Identifier:** protocol_property_accessors_order
* **Enabled by default:** Enabled
* **Supports autocorrection:** Yes
* **Kind:** style
* **Analyzer rule:** No
* **Minimum Swift compiler version:** 3.0.0
* **Default configuration:** warning

## Non Triggering Examples

```swift
protocol Foo {
 var bar: String { get set }
 }
```

```swift
protocol Foo {
 var bar: String { get }
 }
```

```swift
protocol Foo {
 var bar: String { set }
 }
```

## Triggering Examples

```swift
protocol Foo {
 var bar: String { ↓set get }
 }
```