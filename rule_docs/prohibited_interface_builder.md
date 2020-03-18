# Prohibited Interface Builder

Creating views using Interface Builder should be avoided.

* **Identifier:** prohibited_interface_builder
* **Enabled by default:** Disabled
* **Supports autocorrection:** No
* **Kind:** lint
* **Analyzer rule:** No
* **Minimum Swift compiler version:** 3.0.0
* **Default configuration:** warning

## Non Triggering Examples

```swift
class ViewController: UIViewController {
    var label: UILabel!
}
```

```swift
class ViewController: UIViewController {
    @objc func buttonTapped(_ sender: UIButton) {}
}
```

## Triggering Examples

```swift
class ViewController: UIViewController {
    @IBOutlet ↓var label: UILabel!
}
```

```swift
class ViewController: UIViewController {
    @IBAction ↓func buttonTapped(_ sender: UIButton) {}
}
```