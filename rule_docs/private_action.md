# Private Actions

IBActions should be private.

* **Identifier:** private_action
* **Enabled by default:** Disabled
* **Supports autocorrection:** No
* **Kind:** lint
* **Analyzer rule:** No
* **Minimum Swift compiler version:** 3.0.0
* **Default configuration:** warning

## Non Triggering Examples

```swift
class Foo {
	@IBAction private func barButtonTapped(_ sender: UIButton) {}
}

```

```swift
struct Foo {
	@IBAction private func barButtonTapped(_ sender: UIButton) {}
}

```

```swift
class Foo {
	@IBAction fileprivate func barButtonTapped(_ sender: UIButton) {}
}

```

```swift
struct Foo {
	@IBAction fileprivate func barButtonTapped(_ sender: UIButton) {}
}

```

```swift
private extension Foo {
	@IBAction func barButtonTapped(_ sender: UIButton) {}
}

```

```swift
fileprivate extension Foo {
	@IBAction func barButtonTapped(_ sender: UIButton) {}
}

```

## Triggering Examples

```swift
class Foo {
	@IBAction ↓func barButtonTapped(_ sender: UIButton) {}
}

```

```swift
struct Foo {
	@IBAction ↓func barButtonTapped(_ sender: UIButton) {}
}

```

```swift
class Foo {
	@IBAction public ↓func barButtonTapped(_ sender: UIButton) {}
}

```

```swift
struct Foo {
	@IBAction public ↓func barButtonTapped(_ sender: UIButton) {}
}

```

```swift
class Foo {
	@IBAction internal ↓func barButtonTapped(_ sender: UIButton) {}
}

```

```swift
struct Foo {
	@IBAction internal ↓func barButtonTapped(_ sender: UIButton) {}
}

```

```swift
extension Foo {
	@IBAction ↓func barButtonTapped(_ sender: UIButton) {}
}

```

```swift
extension Foo {
	@IBAction public ↓func barButtonTapped(_ sender: UIButton) {}
}

```

```swift
extension Foo {
	@IBAction internal ↓func barButtonTapped(_ sender: UIButton) {}
}

```

```swift
public extension Foo {
	@IBAction ↓func barButtonTapped(_ sender: UIButton) {}
}

```

```swift
internal extension Foo {
	@IBAction ↓func barButtonTapped(_ sender: UIButton) {}
}

```