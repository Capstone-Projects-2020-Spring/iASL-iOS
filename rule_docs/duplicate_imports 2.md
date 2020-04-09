# Duplicate Imports

Imports should be unique.

* **Identifier:** duplicate_imports
* **Enabled by default:** Enabled
* **Supports autocorrection:** No
* **Kind:** idiomatic
* **Analyzer rule:** No
* **Minimum Swift compiler version:** 3.0.0
* **Default configuration:** warning

## Non Triggering Examples

```swift
import A
import B
import C
```

```swift
import A.B
import A.C
```

```swift
#if DEBUG
    @testable import KsApi
#else
    import KsApi
#endif
```

```swift
import A // module
import B // module
```

```swift
#if TEST
func test() {
}
```

## Triggering Examples

```swift
import Foundation
import Dispatch
↓import Foundation
```

```swift
import Foundation
↓import Foundation.NSString
```

```swift
↓import Foundation.NSString
import Foundation
```

```swift
↓import A.B.C
import A.B
```

```swift
import A.B
↓import A.B.C
```

```swift
import A
#if DEBUG
    @testable import KsApi
#else
    import KsApi
#endif
↓import A
```

```swift
import A
↓import typealias A.Foo
```

```swift
import A
↓import struct A.Foo
```

```swift
import A
↓import class A.Foo
```

```swift
import A
↓import enum A.Foo
```

```swift
import A
↓import protocol A.Foo
```

```swift
import A
↓import let A.Foo
```

```swift
import A
↓import var A.Foo
```

```swift
import A
↓import func A.Foo
```

```swift
import A
↓import typealias A.B.Foo
```

```swift
import A
↓import struct A.B.Foo
```

```swift
import A
↓import class A.B.Foo
```

```swift
import A
↓import enum A.B.Foo
```

```swift
import A
↓import protocol A.B.Foo
```

```swift
import A
↓import let A.B.Foo
```

```swift
import A
↓import var A.B.Foo
```

```swift
import A
↓import func A.B.Foo
```

```swift
import A.B
↓import typealias A.B.Foo
```

```swift
import A.B
↓import struct A.B.Foo
```

```swift
import A.B
↓import class A.B.Foo
```

```swift
import A.B
↓import enum A.B.Foo
```

```swift
import A.B
↓import protocol A.B.Foo
```

```swift
import A.B
↓import let A.B.Foo
```

```swift
import A.B
↓import var A.B.Foo
```

```swift
import A.B
↓import func A.B.Foo
```