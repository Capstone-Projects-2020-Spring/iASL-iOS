# Multiline Literal Brackets

Multiline literals should have their surrounding brackets in a new line.

* **Identifier:** multiline_literal_brackets
* **Enabled by default:** Disabled
* **Supports autocorrection:** No
* **Kind:** style
* **Analyzer rule:** No
* **Minimum Swift compiler version:** 3.0.0
* **Default configuration:** warning

## Non Triggering Examples

```swift
let trio = ["harry", "ronald", "hermione"]
let houseCup = ["gryffinder": 460, "hufflepuff": 370, "ravenclaw": 410, "slytherin": 450]
```

```swift
let trio = [
    "harry",
    "ronald",
    "hermione"
]
let houseCup = [
    "gryffinder": 460,
    "hufflepuff": 370,
    "ravenclaw": 410,
    "slytherin": 450
]
```

```swift
let trio = [
    "harry", "ronald", "hermione"
]
let houseCup = [
    "gryffinder": 460, "hufflepuff": 370,
    "ravenclaw": 410, "slytherin": 450
]
```

```swift
    _ = [
        1,
        2,
        3,
        4,
        5, 6,
        7, 8, 9
    ]
```

## Triggering Examples

```swift
let trio = [↓"harry",
            "ronald",
            "hermione"
]
```

```swift
let houseCup = [↓"gryffinder": 460, "hufflepuff": 370,
                "ravenclaw": 410, "slytherin": 450
]
```

```swift
let trio = [
    "harry",
    "ronald",
    "hermione"↓]
```

```swift
let houseCup = [
    "gryffinder": 460, "hufflepuff": 370,
    "ravenclaw": 410, "slytherin": 450↓]
```

```swift
class Hogwarts {
    let houseCup = [
        "gryffinder": 460, "hufflepuff": 370,
        "ravenclaw": 410, "slytherin": 450↓]
}
```

```swift
    _ = [
        1,
        2,
        3,
        4,
        5, 6,
        7, 8, 9↓]
```

```swift
    _ = [↓1, 2, 3,
         4, 5, 6,
         7, 8, 9
    ]
```