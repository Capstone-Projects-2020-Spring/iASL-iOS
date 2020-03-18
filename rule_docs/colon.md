# Colon

Colons should be next to the identifier when specifying a type and next to the key in dictionary literals.

* **Identifier:** colon
* **Enabled by default:** Enabled
* **Supports autocorrection:** Yes
* **Kind:** style
* **Analyzer rule:** No
* **Minimum Swift compiler version:** 3.0.0
* **Default configuration:** warning, flexible_right_spacing: false, apply_to_dictionaries: true

## Non Triggering Examples

```swift
let abc: Void

```

```swift
let abc: [Void: Void]

```

```swift
let abc: (Void, Void)

```

```swift
let abc: ([Void], String, Int)

```

```swift
let abc: [([Void], String, Int)]

```

```swift
let abc: String="def"

```

```swift
let abc: Int=0

```

```swift
let abc: Enum=Enum.Value

```

```swift
func abc(def: Void) {}

```

```swift
func abc(def: Void, ghi: Void) {}

```

```swift
let abc: String = "abc:"
```

```swift
let abc = [Void: Void]()

```

```swift
let abc = [1: [3: 2], 3: 4]

```

```swift
let abc = ["string": "string"]

```

```swift
let abc = ["string:string": "string"]

```

```swift
let abc: [String: Int]

```

```swift
func foo(bar: [String: Int]) {}

```

```swift
func foo() -> [String: Int] { return [:] }

```

```swift
let abc: Any

```

```swift
let abc: [Any: Int]

```

```swift
let abc: [String: Any]

```

```swift
class Foo: Bar {}

```

```swift
class Foo<T>: Bar {}

```

```swift
class Foo<T: Equatable>: Bar {}

```

```swift
class Foo<T, U>: Bar {}

```

```swift
class Foo<T: Equatable> {}

```

```swift
switch foo {
case .bar:
    _ = something()
}
```

```swift
object.method(x: 5, y: "string")

```

```swift
object.method(x: 5, y:
              "string")
```

```swift
object.method(5, y: "string")

```

```swift
func abc() { def(ghi: jkl) }
```

```swift
func abc(def: Void) { ghi(jkl: mno) }
```

```swift
class ABC { let def = ghi(jkl: mno) } }
```

```swift
func foo() { let dict = [1: 1] }
```

```swift
let aaa = Self.bbb ? Self.ccc : Self.ddd else {
return nil
Example("}
```

## Triggering Examples

```swift
let ↓abc:Void

```

```swift
let ↓abc:  Void

```

```swift
let ↓abc :Void

```

```swift
let ↓abc : Void

```

```swift
let ↓abc : [Void: Void]

```

```swift
let ↓abc : (Void, String, Int)

```

```swift
let ↓abc : ([Void], String, Int)

```

```swift
let ↓abc : [([Void], String, Int)]

```

```swift
let ↓abc:  (Void, String, Int)

```

```swift
let ↓abc:  ([Void], String, Int)

```

```swift
let ↓abc:  [([Void], String, Int)]

```

```swift
let ↓abc :String="def"

```

```swift
let ↓abc :Int=0

```

```swift
let ↓abc :Int = 0

```

```swift
let ↓abc:Int=0

```

```swift
let ↓abc:Int = 0

```

```swift
let ↓abc:Enum=Enum.Value

```

```swift
func abc(↓def:Void) {}

```

```swift
func abc(↓def:  Void) {}

```

```swift
func abc(↓def :Void) {}

```

```swift
func abc(↓def : Void) {}

```

```swift
func abc(def: Void, ↓ghi :Void) {}

```

```swift
let abc = [Void↓:Void]()

```

```swift
let abc = [Void↓ : Void]()

```

```swift
let abc = [Void↓:  Void]()

```

```swift
let abc = [Void↓ :  Void]()

```

```swift
let abc = [1: [3↓ : 2], 3: 4]

```

```swift
let abc = [1: [3↓ : 2], 3↓:  4]

```

```swift
let abc: [↓String : Int]

```

```swift
let abc: [↓String:Int]

```

```swift
func foo(bar: [↓String : Int]) {}

```

```swift
func foo(bar: [↓String:Int]) {}

```

```swift
func foo() -> [↓String : Int] { return [:] }

```

```swift
func foo() -> [↓String:Int] { return [:] }

```

```swift
let ↓abc : Any

```

```swift
let abc: [↓Any : Int]

```

```swift
let abc: [↓String : Any]

```

```swift
class ↓Foo : Bar {}

```

```swift
class ↓Foo:Bar {}

```

```swift
class ↓Foo<T> : Bar {}

```

```swift
class ↓Foo<T>:Bar {}

```

```swift
class ↓Foo<T, U>:Bar {}

```

```swift
class ↓Foo<T: Equatable>:Bar {}

```

```swift
class Foo<↓T:Equatable> {}

```

```swift
class Foo<↓T : Equatable> {}

```

```swift
object.method(x: 5, y↓ : "string")

```

```swift
object.method(x↓:5, y: "string")

```

```swift
object.method(x↓:  5, y: "string")

```

```swift
func abc() { def(ghi↓:jkl) }
```

```swift
func abc(def: Void) { ghi(jkl↓:mno) }
```

```swift
class ABC { let def = ghi(jkl↓:mno) } }
```

```swift
func foo() { let dict = [1↓ : 1] }
```