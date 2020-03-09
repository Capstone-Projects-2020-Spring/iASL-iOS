# Empty Parameters

Prefer `() -> ` over `Void -> `.

* **Identifier:** empty_parameters
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
func foo(completion: () -> Void)

```

```swift
func foo(completion: () thows -> Void)

```

```swift
let foo: (ConfigurationTests) -> Void throws -> Void)

```

```swift
let foo: (ConfigurationTests) ->   Void throws -> Void)

```

```swift
let foo: (ConfigurationTests) ->Void throws -> Void)

```

## Triggering Examples

```swift
let abc: ↓(Void) -> Void = {}

```

```swift
func foo(completion: ↓(Void) -> Void)

```

```swift
func foo(completion: ↓(Void) throws -> Void)

```

```swift
let foo: ↓(Void) -> () throws -> Void)

```