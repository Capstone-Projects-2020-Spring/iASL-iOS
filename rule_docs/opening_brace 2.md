# Opening Brace Spacing

Opening braces should be preceded by a single space and on the same line as the declaration.

* **Identifier:** opening_brace
* **Enabled by default:** Enabled
* **Supports autocorrection:** Yes
* **Kind:** style
* **Analyzer rule:** No
* **Minimum Swift compiler version:** 3.0.0
* **Default configuration:** warning

## Non Triggering Examples

```swift
func abc() {
}
```

```swift
[].map() { $0 }
```

```swift
[].map({ })
```

```swift
if let a = b { }
```

```swift
while a == b { }
```

```swift
guard let a = b else { }
```

```swift
if
	let a = b,
	let c = d
	where a == c
{ }
```

```swift
while
	let a = b,
	let c = d
	where a == c
{ }
```

```swift
guard
	let a = b,
	let c = d
	where a == c else
{ }
```

```swift
struct Rule {}

```

```swift
struct Parent {
	struct Child {
		let foo: Int
	}
}

```

```swift
func f(rect: CGRect) {
   {
      let centre = CGPoint(x: rect.midX, y: rect.midY)
      print(centre)
   }()
}
```

## Triggering Examples

```swift
func abc()↓{
}
```

```swift
func abc()
	↓{ }
```

```swift
[].map()↓{ $0 }
```

```swift
[].map( ↓{ } )
```

```swift
if let a = b↓{ }
```

```swift
while a == b↓{ }
```

```swift
guard let a = b else↓{ }
```

```swift
if
	let a = b,
	let c = d
	where a == c↓{ }
```

```swift
while
	let a = b,
	let c = d
	where a == c↓{ }
```

```swift
guard
	let a = b,
	let c = d
	where a == c else↓{ }
```

```swift
struct Rule↓{}

```

```swift
struct Rule
↓{
}

```

```swift
struct Rule

	↓{
}

```

```swift
struct Parent {
	struct Child
	↓{
		let foo: Int
	}
}

```

```swift
// Get the current thread's TLS pointer. On first call for a given thread,
// creates and initializes a new one.
internal static func getPointer()
  -> UnsafeMutablePointer<_ThreadLocalStorage>
{ // <- here
  return _swift_stdlib_threadLocalStorageGet().assumingMemoryBound(
    to: _ThreadLocalStorage.self)
}
```

```swift
func run_Array_method1x(_ N: Int) {
  let existentialArray = array!
  for _ in 0 ..< N * 100 {
    for elt in existentialArray {
      if !elt.doIt()  {
        fatalError("expected true")
      }
    }
  }
}

func run_Array_method2x(_ N: Int) {

}
```