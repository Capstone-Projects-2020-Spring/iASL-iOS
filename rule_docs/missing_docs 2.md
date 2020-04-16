# Missing Docs

Declarations should be documented.

* **Identifier:** missing_docs
* **Enabled by default:** Disabled
* **Supports autocorrection:** No
* **Kind:** lint
* **Analyzer rule:** No
* **Minimum Swift compiler version:** 4.1.0
* **Default configuration:** warning: open, public

## Non Triggering Examples

```swift
/// docs
public class A {
/// docs
public func b() {}
}
/// docs
public class B: A { override public func b() {} }
```

```swift
import Foundation
/// docs
public class B: NSObject {
// no docs
override public var description: String { fatalError() } }
```

```swift
/// docs
public class A {
    deinit {}
}
```

```swift
public extension A {}
```

## Triggering Examples

```swift
public func a() {}

```

```swift
// regular comment
public func a() {}

```

```swift
/* regular comment */
public func a() {}

```

```swift
/// docs
public protocol A {
// no docs
var b: Int { get } }
/// docs
public struct C: A {

public let b: Int
}
```