# Mark

MARK comment should be in valid format. e.g. '// MARK: ...' or '// MARK: - ...'

* **Identifier:** mark
* **Enabled by default:** Enabled
* **Supports autocorrection:** Yes
* **Kind:** lint
* **Analyzer rule:** No
* **Minimum Swift compiler version:** 3.0.0
* **Default configuration:** warning

## Non Triggering Examples

```swift
// MARK: good

```

```swift
// MARK: - good

```

```swift
// MARK: -

```

```swift
// BOOKMARK
```

```swift
//BOOKMARK
```

```swift
// BOOKMARKS
```

## Triggering Examples

```swift
↓//MARK: bad
```

```swift
↓// MARK:bad
```

```swift
↓//MARK:bad
```

```swift
↓//  MARK: bad
```

```swift
↓// MARK:  bad
```

```swift
↓// MARK: -bad
```

```swift
↓// MARK:- bad
```

```swift
↓// MARK:-bad
```

```swift
↓//MARK: - bad
```

```swift
↓//MARK:- bad
```

```swift
↓//MARK: -bad
```

```swift
↓//MARK:-bad
```

```swift
↓//Mark: bad
```

```swift
↓// Mark: bad
```

```swift
↓// MARK bad
```

```swift
↓//MARK bad
```

```swift
↓// MARK - bad
```

```swift
↓//MARK : bad
```

```swift
↓// MARKL:
```

```swift
↓// MARKR 
```

```swift
↓// MARKK -
```

```swift
↓/// MARK:
```

```swift
↓/// MARK bad
```

```swift
↓//MARK:- Top-Level bad mark
↓//MARK:- Another bad mark
struct MarkTest {}
↓// MARK:- Bad mark
extension MarkTest {}
```