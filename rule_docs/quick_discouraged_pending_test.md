# Quick Discouraged Pending Test

Discouraged pending test. This test won't run while it's marked as pending.

* **Identifier:** quick_discouraged_pending_test
* **Enabled by default:** Disabled
* **Supports autocorrection:** No
* **Kind:** lint
* **Analyzer rule:** No
* **Minimum Swift compiler version:** 3.0.0
* **Default configuration:** warning

## Non Triggering Examples

```swift
class TotoTests: QuickSpec {
   override func spec() {
       describe("foo") {
           describe("bar") { }
           context("bar") {
               it("bar") { }
           }
           it("bar") { }
           itBehavesLike("bar")
       }
   }
}
```

## Triggering Examples

```swift
class TotoTests: QuickSpec {
   override func spec() {
       ↓xdescribe("foo") { }
   }
}
```

```swift
class TotoTests: QuickSpec {
   override func spec() {
       ↓xcontext("foo") { }
   }
}
```

```swift
class TotoTests: QuickSpec {
   override func spec() {
       ↓xit("foo") { }
   }
}
```

```swift
class TotoTests: QuickSpec {
   override func spec() {
       describe("foo") {
           ↓xit("bar") { }
       }
   }
}
```

```swift
class TotoTests: QuickSpec {
   override func spec() {
       context("foo") {
           ↓xit("bar") { }
       }
   }
}
```

```swift
class TotoTests: QuickSpec {
   override func spec() {
       describe("foo") {
           context("bar") {
               ↓xit("toto") { }
           }
       }
   }
}
```

```swift
class TotoTests: QuickSpec {
   override func spec() {
       ↓pending("foo")
   }
}
```

```swift
class TotoTests: QuickSpec {
   override func spec() {
       ↓xitBehavesLike("foo")
   }
}
```