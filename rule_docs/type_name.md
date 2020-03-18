# Type Name

Type name should only contain alphanumeric characters, start with an uppercase character and span between 3 and 40 characters in length.

* **Identifier:** type_name
* **Enabled by default:** Enabled
* **Supports autocorrection:** No
* **Kind:** idiomatic
* **Analyzer rule:** No
* **Minimum Swift compiler version:** 3.0.0
* **Default configuration:** (min_length) w/e: 3/0, (max_length) w/e: 40/1000, excluded: [], allowed_symbols: [], validates_start_with_lowercase: true

## Non Triggering Examples

```swift
class MyType {}
```

```swift
private class _MyType {}
```

```swift
class AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA {}
```

```swift
class MyView_Previews: PreviewProvider
```

```swift
private class _MyView_Previews: PreviewProvider
```

```swift
struct MyType {}
```

```swift
private struct _MyType {}
```

```swift
struct AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA {}
```

```swift
struct MyView_Previews: PreviewProvider
```

```swift
private struct _MyView_Previews: PreviewProvider
```

```swift
enum MyType {}
```

```swift
private enum _MyType {}
```

```swift
enum AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA {}
```

```swift
enum MyView_Previews: PreviewProvider
```

```swift
private enum _MyView_Previews: PreviewProvider
```

```swift
typealias Foo = Void
```

```swift
private typealias Foo = Void
```

```swift
protocol Foo {
  associatedtype Bar
}
```

```swift
protocol Foo {
  associatedtype Bar: Equatable
}
```

```swift
enum MyType {
case value
}
```

## Triggering Examples

```swift
class ↓myType {}
```

```swift
class ↓_MyType {}
```

```swift
private class ↓MyType_ {}
```

```swift
class ↓My {}
```

```swift
class ↓AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA {}
```

```swift
class ↓MyView_Previews
```

```swift
private class ↓_MyView_Previews
```

```swift
class ↓MyView_Previews_Previews: PreviewProvider
```

```swift
struct ↓myType {}
```

```swift
struct ↓_MyType {}
```

```swift
private struct ↓MyType_ {}
```

```swift
struct ↓My {}
```

```swift
struct ↓AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA {}
```

```swift
struct ↓MyView_Previews
```

```swift
private struct ↓_MyView_Previews
```

```swift
struct ↓MyView_Previews_Previews: PreviewProvider
```

```swift
enum ↓myType {}
```

```swift
enum ↓_MyType {}
```

```swift
private enum ↓MyType_ {}
```

```swift
enum ↓My {}
```

```swift
enum ↓AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA {}
```

```swift
enum ↓MyView_Previews
```

```swift
private enum ↓_MyView_Previews
```

```swift
enum ↓MyView_Previews_Previews: PreviewProvider
```

```swift
typealias ↓X = Void
```

```swift
private typealias ↓Foo_Bar = Void
```

```swift
private typealias ↓foo = Void
```

```swift
typealias ↓AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA = Void
```

```swift
protocol Foo {
  associatedtype ↓X
}
```

```swift
protocol Foo {
  associatedtype ↓Foo_Bar: Equatable
}
```

```swift
protocol Foo {
  associatedtype ↓AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
}
```