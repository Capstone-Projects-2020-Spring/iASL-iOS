# Vertical Whitespace Between Cases

Include a single empty line between switch cases.

* **Identifier:** vertical_whitespace_between_cases
* **Enabled by default:** Disabled
* **Supports autocorrection:** Yes
* **Kind:** style
* **Analyzer rule:** No
* **Minimum Swift compiler version:** 3.0.0
* **Default configuration:** warning

## Non Triggering Examples

```swift
    switch x {
    case .valid:
        print("multiple ...")
        print("... lines")

    case .invalid:
        print("multiple ...")
        print("... lines")
    }
```

```swift
    switch x {
    case .valid:
        print("x is valid")

    case .invalid:
        print("x is invalid")
    }
```

```swift
    switch x {
    case 0..<5:
        print("x is valid")

    default:
        print("x is invalid")
    }
```

```swift
switch x {

case 0..<5:
    print("x is low")

case 5..<10:
    print("x is high")

default:
    print("x is invalid")

}
```

```swift
switch x {
case 0..<5:
    print("x is low")

case 5..<10:
    print("x is high")

default:
    print("x is invalid")
}
```

```swift
switch x {
case 0..<5: print("x is low")
case 5..<10: print("x is high")
default: print("x is invalid")
}
```

```swift
switch x {    
case 1:    
    print("one")    
    
default:    
    print("not one")    
}    
```

## Triggering Examples

```swift
    switch x {
    case .valid:
        print("multiple ...")
        print("... lines")
↓    case .invalid:
        print("multiple ...")
        print("... lines")
    }
```

```swift
    switch x {
    case .valid:
        print("x is valid")
↓    case .invalid:
        print("x is invalid")
    }
```

```swift
    switch x {
    case 0..<5:
        print("x is valid")
↓    default:
        print("x is invalid")
    }
```