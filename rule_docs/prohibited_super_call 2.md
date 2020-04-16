# Prohibited calls to super

Some methods should not call super

* **Identifier:** prohibited_super_call
* **Enabled by default:** Disabled
* **Supports autocorrection:** No
* **Kind:** lint
* **Analyzer rule:** No
* **Minimum Swift compiler version:** 3.0.0
* **Default configuration:** warning, excluded: [[]], included: [["*"]]

## Non Triggering Examples

```swift
class VC: UIViewController {
    override func loadView() {
    }
}
```

```swift
class NSView {
    func updateLayer() {
        self.method1()
    }
}
```

```swift
public class FileProviderExtension: NSFileProviderExtension {
    override func providePlaceholder(at url: URL, completionHandler: @escaping (Error?) -> Void) {
        guard let identifier = persistentIdentifierForItem(at: url) else {
            completionHandler(NSFileProviderError(.noSuchItem))
            return
        }
    }
}
```

## Triggering Examples

```swift
class VC: UIViewController {
    override func loadView() {↓
        super.loadView()
    }
}
```

```swift
class VC: NSFileProviderExtension {
    override func providePlaceholder(at url: URL, completionHandler: @escaping (Error?) -> Void) {↓
        self.method1()
        super.providePlaceholder(at:url, completionHandler: completionHandler)
    }
}
```

```swift
class VC: NSView {
    override func updateLayer() {↓
        self.method1()
        super.updateLayer()
        self.method2()
    }
}
```

```swift
class VC: NSView {
    override func updateLayer() {↓
        defer {
            super.updateLayer()
        }
    }
}
```