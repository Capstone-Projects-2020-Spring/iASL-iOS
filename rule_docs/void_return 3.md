# Void Return

Prefer `-> Void` over `-> ()`.

* **Identifier:** void_return
* **Enabled by default:** Enabled
* **Supports autocorrection:** Yes
* **Kind:** style
* **Analyzer rule:** No
* **Minimum Swift compiler version:** 3.0.0
* **Default configuration:** warning

## Non Triggering Examples

```swift
let abc: () -> Void = {}

```

```swift
let abc: () -> (VoidVoid) = {}

```

```swift
func foo(completion: () -> Void)

```

```swift
let foo: (ConfigurationTests) -> () throws -> Void)

```

```swift
let foo: (ConfigurationTests) ->   () throws -> Void)

```

```swift
let foo: (ConfigurationTests) ->() throws -> Void)

```

```swift
let foo: (ConfigurationTests) -> () -> Void)

```

## Triggering Examples

```swift
let abc: () -> ↓() = {}

```

```swift
let abc: () -> ↓(Void) = {}

```

```swift
let abc: () -> ↓(   Void ) = {}

```

```swift
func foo(completion: () -> ↓())

```

```swift
func foo(completion: () -> ↓(   ))

```

```swift
func foo(completion: () -> ↓(Void))

```

```swift
let foo: (ConfigurationTests) -> () throws -> ↓())

```