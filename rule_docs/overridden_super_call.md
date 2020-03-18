# Overridden methods call super

Some overridden methods should always call super

* **Identifier:** overridden_super_call
* **Enabled by default:** Disabled
* **Supports autocorrection:** No
* **Kind:** lint
* **Analyzer rule:** No
* **Minimum Swift compiler version:** 3.0.0
* **Default configuration:** warning, excluded: [[]], included: [["*"]]

## Non Triggering Examples

```swift
class VC: UIViewController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}
```

```swift
class VC: UIViewController {
    override func viewWillAppear(_ animated: Bool) {
        self.method1()
        super.viewWillAppear(animated)
        self.method2()
    }
}
```

```swift
class VC: UIViewController {
    override func loadView() {
    }
}
```

```swift
class Some {
    func viewWillAppear(_ animated: Bool) {
    }
}
```

```swift
class VC: UIViewController {
    override func viewDidLoad() {
    defer {
        super.viewDidLoad()
        }
    }
}
```

## Triggering Examples

```swift
class VC: UIViewController {
    override func viewWillAppear(_ animated: Bool) {↓
        //Not calling to super
        self.method()
    }
}
```

```swift
class VC: UIViewController {
    override func viewWillAppear(_ animated: Bool) {↓
        super.viewWillAppear(animated)
        //Other code
        super.viewWillAppear(animated)
    }
}
```

```swift
class VC: UIViewController {
    override func didReceiveMemoryWarning() {↓
    }
}
```