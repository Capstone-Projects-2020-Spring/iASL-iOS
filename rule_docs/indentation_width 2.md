# Indentation Width

Indent code using either one tab or the configured amount of spaces, unindent to match previous indentations. Don't indent the first line.

* **Identifier:** indentation_width
* **Enabled by default:** Disabled
* **Supports autocorrection:** No
* **Kind:** style
* **Analyzer rule:** No
* **Minimum Swift compiler version:** 3.0.0
* **Default configuration:** severity: warning, indentation_width: 4include_comments: true

## Non Triggering Examples

```swift
firstLine
secondLine
```

```swift
firstLine
    secondLine
```

```swift
firstLine
	secondLine
		thirdLine

		fourthLine
```

```swift
firstLine
	secondLine
		thirdLine
//test
		fourthLine
```

```swift
firstLine
    secondLine
        thirdLine
fourthLine
```

## Triggering Examples

```swift
    firstLine
```

```swift
firstLine
        secondLine
```

```swift
firstLine
	secondLine

			fourthLine
```

```swift
firstLine
    secondLine
        thirdLine
 fourthLine
```