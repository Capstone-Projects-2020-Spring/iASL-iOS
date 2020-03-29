# Unused Capture List

Unused reference in a capture list should be removed.

* **Identifier:** unused_capture_list
* **Enabled by default:** Enabled
* **Supports autocorrection:** No
* **Kind:** lint
* **Analyzer rule:** No
* **Minimum Swift compiler version:** 4.2.0
* **Default configuration:** warning

## Non Triggering Examples

```swift
[1, 2].map { [weak self] num in
    self?.handle(num)
}
```

```swift
let failure: Failure = { [weak self, unowned delegate = self.delegate!] foo in
    delegate.handle(foo, self)
}
```

```swift
numbers.forEach({
    [weak handler] in
    handler?.handle($0)
})
```

```swift
withEnvironment(apiService: MockService(fetchProjectResponse: project)) {
    [Device.phone4_7inch, Device.phone5_8inch, Device.pad].forEach { device in
        device.handle()
    }
}
```

```swift
{ [foo] _ in foo.bar() }()
```

```swift
sizes.max().flatMap { [(offset: offset, size: $0)] } ?? []
```

## Triggering Examples

```swift
[1, 2].map { [↓weak self] num in
    print(num)
}
```

```swift
let failure: Failure = { [weak self, ↓unowned delegate = self.delegate!] foo in
    self?.handle(foo)
}
```

```swift
let failure: Failure = { [↓weak self, ↓unowned delegate = self.delegate!] foo in
    print(foo)
}
```

```swift
numbers.forEach({
    [weak handler] in
    print($0)
})
```

```swift
withEnvironment(apiService: MockService(fetchProjectResponse: project)) { [↓foo] in
    [Device.phone4_7inch, Device.phone5_8inch, Device.pad].forEach { device in
        device.handle()
    }
}
```

```swift
{ [↓foo] in _ }()
```