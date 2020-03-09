# Private Unit Test

Unit tests marked private are silently skipped.

* **Identifier:** private_unit_test
* **Enabled by default:** Enabled
* **Supports autocorrection:** No
* **Kind:** lint
* **Analyzer rule:** No
* **Minimum Swift compiler version:** 3.0.0
* **Default configuration:** warning: XCTestCase

## Non Triggering Examples

```swift
"class FooTest: XCTestCase {
    func test1() {}
    internal func test2() {}
    public func test3() {}
}
```

```swift
internal class FooTest: XCTestCase {
    func test1() {}
    internal func test2() {}
    public func test3() {}
}
```

```swift
public class FooTest: XCTestCase {
    func test1() {}
    internal func test2() {}
    public func test3() {}
}
```

```swift
@objc private class FooTest: XCTestCase {
    @objc private func test1() {}
        internal func test2() {}
        public func test3() {}
}
```

```swift
private class Foo: NSObject {
    func test1() {}
    internal func test2() {}
    public func test3() {}
}
```

```swift
private class Foo {
    func test1() {}
    internal func test2() {}
    public func test3() {}
}
```

```swift
public class FooTest: XCTestCase {
    func test1(param: Int) {}
}
```

## Triggering Examples

```swift
private ↓class FooTest: XCTestCase {
    func test1() {}
        internal func test2() {}
        public func test3() {}
        private func test4() {}
}
```

```swift
class FooTest: XCTestCase {
    func test1() {}
        internal func test2() {}
        public func test3() {}
        private ↓func test4() {}
}
```

```swift
internal class FooTest: XCTestCase {
    func test1() {}
        internal func test2() {}
        public func test3() {}
        private ↓func test4() {}
}
```

```swift
public class FooTest: XCTestCase {
    func test1() {}
        internal func test2() {}
        public func test3() {}
        private ↓func test4() {}
}
```