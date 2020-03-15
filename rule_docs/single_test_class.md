# Single Test Class

Test files should contain a single QuickSpec or XCTestCase class.

* **Identifier:** single_test_class
* **Enabled by default:** Disabled
* **Supports autocorrection:** No
* **Kind:** style
* **Analyzer rule:** No
* **Minimum Swift compiler version:** 3.0.0
* **Default configuration:** warning

## Non Triggering Examples

```swift
class FooTests {  }

```

```swift
class FooTests: QuickSpec {  }

```

```swift
class FooTests: XCTestCase {  }

```

## Triggering Examples

```swift
↓class FooTests: QuickSpec {  }
↓class BarTests: QuickSpec {  }
```

```swift
↓class FooTests: QuickSpec {  }
↓class BarTests: QuickSpec {  }
↓class TotoTests: QuickSpec {  }
```

```swift
↓class FooTests: XCTestCase {  }
↓class BarTests: XCTestCase {  }
```

```swift
↓class FooTests: XCTestCase {  }
↓class BarTests: XCTestCase {  }
↓class TotoTests: XCTestCase {  }
```

```swift
↓class FooTests: QuickSpec {  }
↓class BarTests: XCTestCase {  }
```

```swift
↓class FooTests: QuickSpec {  }
↓class BarTests: XCTestCase {  }
class TotoTests {  }
```