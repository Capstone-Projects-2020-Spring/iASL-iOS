# Unneeded Parentheses in Closure Argument

Parentheses are not needed when declaring closure arguments.

* **Identifier:** unneeded_parentheses_in_closure_argument
* **Enabled by default:** Disabled
* **Supports autocorrection:** Yes
* **Kind:** style
* **Analyzer rule:** No
* **Minimum Swift compiler version:** 3.0.0
* **Default configuration:** warning

## Non Triggering Examples

```swift
let foo = { (bar: Int) in }

```

```swift
let foo = { bar, _  in }

```

```swift
let foo = { bar in }

```

```swift
let foo = { bar -> Bool in return true }

```

## Triggering Examples

```swift
call(arg: { ↓(bar) in })

```

```swift
call(arg: { ↓(bar, _) in })

```

```swift
let foo = { ↓(bar) -> Bool in return true }

```

```swift
foo.map { ($0, $0) }.forEach { ↓(x, y) in }
```

```swift
foo.bar { [weak self] ↓(x, y) in }
```

```swift
[].first { ↓(temp) in
    [].first { ↓(temp) in
        [].first { ↓(temp) in
            _ = temp
            return false
        }
        return false
    }
    return false
}
```

```swift
[].first { temp in
    [].first { ↓(temp) in
        [].first { ↓(temp) in
            _ = temp
            return false
        }
        return false
    }
    return false
}
```