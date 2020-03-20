# Vertical Whitespace before Closing Braces

Don't include vertical whitespace (empty line) before closing braces.

* **Identifier:** vertical_whitespace_closing_braces
* **Enabled by default:** Disabled
* **Supports autocorrection:** Yes
* **Kind:** style
* **Analyzer rule:** No
* **Minimum Swift compiler version:** 3.0.0
* **Default configuration:** N/A

## Non Triggering Examples

```swift
        )
}
    }
}
```

```swift
    print("x is 5")
}
```

```swift
    print("x is 5")
}
```

```swift
    print("x is 5")
}
```

```swift
/*
    class X {

        let x = 5

    }
*/
```

```swift
[
1,
2,
3
]
```

```swift
[1, 2].map { $0 }.filter {
```

```swift
[1, 2].map { $0 }.filter { num in
```

```swift
class Name {
    run(5) { x in print(x) }
}
```

```swift
foo(
x: 5,
y:6
)
```

## Triggering Examples

```swift
        )
}
↓
    }
}
```

```swift
    print("x is 5")
↓

}
```

```swift
    print("x is 5")
↓
}
```

```swift
    print("x is 5")
↓    
}
```

```swift
[
1,
2,
3
↓
]
```

```swift
class Name {
    run(5) { x in print(x) }
↓
}
```

```swift
foo(
x: 5,
y:6
↓
)
```