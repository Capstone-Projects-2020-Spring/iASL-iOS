# File Types Order

Specifies how the types within a file should be ordered.

* **Identifier:** file_types_order
* **Enabled by default:** Disabled
* **Supports autocorrection:** No
* **Kind:** style
* **Analyzer rule:** No
* **Minimum Swift compiler version:** 3.0.0
* **Default configuration:** warning, order: [[SwiftLintFramework.FileType.supportingType], [SwiftLintFramework.FileType.mainType], [SwiftLintFramework.FileType.extension]]

## Non Triggering Examples

```swift
// Supporting Types
protocol TestViewControllerDelegate {
    func didPressTrackedButton()
}

// Main Type
class TestViewController: UIViewController {
    // Type Aliases
    typealias CompletionHandler = ((TestEnum) -> Void)

    // Subtypes
    class TestClass {
        // 10 lines
    }

    struct TestStruct {
        // 3 lines
    }

    enum TestEnum {
        // 5 lines
    }

    // Stored Type Properties
    static let cellIdentifier: String = "AmazingCell"

    // Stored Instance Properties
    var shouldLayoutView1: Bool!
    weak var delegate: TestViewControllerDelegate?
    private var hasLayoutedView1: Bool = false
    private var hasLayoutedView2: Bool = false

    // Computed Instance Properties
    private var hasAnyLayoutedView: Bool {
         return hasLayoutedView1 || hasLayoutedView2
    }

    // IBOutlets
    @IBOutlet private var view1: UIView!
    @IBOutlet private var view2: UIView!

    // Initializers
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Type Methods
    static func makeViewController() -> TestViewController {
        // some code
    }

    // Life-Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        view1.setNeedsLayout()
        view1.layoutIfNeeded()
        hasLayoutedView1 = true
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        view2.setNeedsLayout()
        view2.layoutIfNeeded()
        hasLayoutedView2 = true
    }

    // IBActions
    @IBAction func goNextButtonPressed() {
        goToNextVc()
        delegate?.didPressTrackedButton()
    }

    @objc
    func goToRandomVcButtonPressed() {
        goToRandomVc()
    }

    // MARK: Other Methods
    func goToNextVc() { /* TODO */ }

    func goToInfoVc() { /* TODO */ }

    func goToRandomVc() {
        let viewCtrl = getRandomVc()
        present(viewCtrl, animated: true)
    }

    private func getRandomVc() -> UIViewController { return UIViewController() }

    // Subscripts
    subscript(_ someIndexThatIsNotEvenUsed: Int) -> String {
        get {
            return "This is just a test"
        }

        set {
            log.warning("Just a test", newValue)
        }
    }
}

// Extensions
extension TestViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
```

```swift
// Only extensions
extension Foo {}
extension Bar {
}
```

## Triggering Examples

```swift
↓class TestViewController: UIViewController {}

// Supporting Types
protocol TestViewControllerDelegate {
    func didPressTrackedButton()
}
```

```swift
// Extensions
↓extension TestViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

class TestViewController: UIViewController {}
```

```swift
// Supporting Types
protocol TestViewControllerDelegate {
    func didPressTrackedButton()
}

↓class TestViewController: UIViewController {}

// Supporting Types
protocol TestViewControllerDelegate {
    func didPressTrackedButton()
}
```

```swift
// Supporting Types
protocol TestViewControllerDelegate {
    func didPressTrackedButton()
}

// Extensions
↓extension TestViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

class TestViewController: UIViewController {}

// Extensions
extension TestViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
```