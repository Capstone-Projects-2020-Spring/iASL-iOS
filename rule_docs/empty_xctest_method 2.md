# Empty XCTest Method

Empty XCTest method should be avoided.

* **Identifier:** empty_xctest_method
* **Enabled by default:** Disabled
* **Supports autocorrection:** No
* **Kind:** lint
* **Analyzer rule:** No
* **Minimum Swift compiler version:** 3.0.0
* **Default configuration:** warning

## Non Triggering Examples

```swift
class TotoTests: XCTestCase {
    var foobar: Foobar?

    override func setUp() {
        super.setUp()
        foobar = Foobar()
    }

    override func tearDown() {
        foobar = nil
        super.tearDown()
    }

    func testFoo() {
        XCTAssertTrue(foobar?.foo)
    }

    func testBar() {
        // comment...

        XCTAssertFalse(foobar?.bar)

        // comment...
    }
}
```

```swift
class Foobar {
    func setUp() {}

    func tearDown() {}

    func testFoo() {}
}
```

```swift
class TotoTests: XCTestCase {
    func setUp(with object: Foobar) {}

    func tearDown(object: Foobar) {}

    func testFoo(_ foo: Foobar) {}

    func testBar(bar: (String) -> Int) {}
}
```

```swift
class TotoTests: XCTestCase {
    func testFoo() { XCTAssertTrue(foobar?.foo) }

    func testBar() { XCTAssertFalse(foobar?.bar) }
}
```

## Triggering Examples

```swift
class TotoTests: XCTestCase {
    override ↓func setUp() {
    }

    override ↓func tearDown() {

    }

    ↓func testFoo() {


    }

    ↓func testBar() {



    }

    func helperFunction() {
    }
}
```

```swift
class TotoTests: XCTestCase {
    override ↓func setUp() {}

    override ↓func tearDown() {}

    ↓func testFoo() {}

    func helperFunction() {}
}
```

```swift
class TotoTests: XCTestCase {
    override ↓func setUp() {
        // comment...
    }

    override ↓func tearDown() {
        // comment...
        // comment...
    }

    ↓func testFoo() {
        // comment...

        // comment...

        // comment...
    }

    ↓func testBar() {
        /*
         * comment...
         *
         * comment...
         *
         * comment...
         */
    }

    func helperFunction() {
    }
}
```

```swift
class FooTests: XCTestCase {
    override ↓func setUp() {}
}

class BarTests: XCTestCase {
    ↓func testFoo() {}
}
```