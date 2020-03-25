# Nesting

Types should be nested at most 1 level deep, and statements should be nested at most 5 levels deep.

* **Identifier:** nesting
* **Enabled by default:** Enabled
* **Supports autocorrection:** No
* **Kind:** metrics
* **Analyzer rule:** No
* **Minimum Swift compiler version:** 3.0.0
* **Default configuration:** (type_level) w: 1, (statement_level) w: 5

## Non Triggering Examples

```swift
class Class0 { class Class1 {} }

```

```swift
func func0() {
    func func1() {
        func func2() {
            func func3() {
                func func4() {
                    func func5() {
                    }
                }
            }
        }
    }
}
```

```swift
struct Class0 { struct Class1 {} }

```

```swift
func func0() {
    func func1() {
        func func2() {
            func func3() {
                func func4() {
                    func func5() {
                    }
                }
            }
        }
    }
}
```

```swift
enum Class0 { enum Class1 {} }

```

```swift
func func0() {
    func func1() {
        func func2() {
            func func3() {
                func func4() {
                    func func5() {
                    }
                }
            }
        }
    }
}
```

```swift
enum Enum0 { enum Enum1 { case Case } }
```

## Triggering Examples

```swift
class A { class B { ↓class C {} } }

```

```swift
struct A { struct B { ↓struct C {} } }

```

```swift
enum A { enum B { ↓enum C {} } }

```

```swift
func func0() {
    func func1() {
        func func2() {
            func func3() {
                func func4() {
                    func func5() {
                        ↓func func6() {
                        }
                    }
                }
            }
        }
    }
}
```