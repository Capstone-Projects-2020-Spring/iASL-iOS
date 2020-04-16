# Cyclomatic Complexity

Complexity of function bodies should be limited.

* **Identifier:** cyclomatic_complexity
* **Enabled by default:** Enabled
* **Supports autocorrection:** No
* **Kind:** metrics
* **Analyzer rule:** No
* **Minimum Swift compiler version:** 3.0.0
* **Default configuration:** warning: 10, error: 20, ignores_case_statements: false

## Non Triggering Examples

```swift
func f1() {
    if true {
        for _ in 1..5 { }
    }
    if false { }
}
```

```swift
func f(code: Int) -> Int {
    switch code {
    case 0: fallthrough
    case 0: return 1
    case 0: return 1
    case 0: return 1
    case 0: return 1
    case 0: return 1
    case 0: return 1
    case 0: return 1
    case 0: return 1
    default: return 1
    }
}
```

```swift
func f1() {
    if true {}; if true {}; if true {}; if true {}; if true {}; if true {}
    func f2() {
        if true {}; if true {}; if true {}; if true {}; if true {}
    }
}
```

## Triggering Examples

```swift
↓func f1() {
    if true {
        if true {
            if false {}
        }
    }
    if false {}
    let i = 0
    switch i {
        case 1: break
        case 2: break
        case 3: break
        case 4: break
        default: break
    }
    for _ in 1...5 {
        guard true else {
            return
        }
    }
}
```