# Lower ACL than parent

Ensure definitions have a lower access control level than their enclosing parent

* **Identifier:** lower_acl_than_parent
* **Enabled by default:** Disabled
* **Supports autocorrection:** No
* **Kind:** lint
* **Analyzer rule:** No
* **Minimum Swift compiler version:** 3.0.0
* **Default configuration:** warning

## Non Triggering Examples

```swift
public struct Foo { public func bar() {} }
```

```swift
internal struct Foo { func bar() {} }
```

```swift
struct Foo { func bar() {} }
```

```swift
open class Foo { public func bar() {} }
```

```swift
open class Foo { open func bar() {} }
```

```swift
fileprivate struct Foo { private func bar() {} }
```

```swift
private struct Foo { private func bar(id: String) }
```

```swift
extension Foo { public func bar() {} }
```

```swift
private struct Foo { fileprivate func bar() {} }
```

```swift
private func foo(id: String) {}
```

```swift
private class Foo { func bar() {} }
```

## Triggering Examples

```swift
struct Foo { public ↓func bar() {} }
```

```swift
enum Foo { public ↓func bar() {} }
```

```swift
public class Foo { open ↓func bar() }
```

```swift
class Foo { public private(set) ↓var bar: String? }
```

```swift
private class Foo { internal ↓func bar() {} }
```