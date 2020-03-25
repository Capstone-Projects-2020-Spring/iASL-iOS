# No Grouping Extension

Extensions shouldn't be used to group code within the same source file.

* **Identifier:** no_grouping_extension
* **Enabled by default:** Disabled
* **Supports autocorrection:** No
* **Kind:** idiomatic
* **Analyzer rule:** No
* **Minimum Swift compiler version:** 3.0.0
* **Default configuration:** warning

## Non Triggering Examples

```swift
protocol Food {}
extension Food {}

```

```swift
class Apples {}
extension Oranges {}

```

```swift
class Box<T> {}
extension Box where T: Vegetable {}

```

## Triggering Examples

```swift
enum Fruit {}
↓extension Fruit {}

```

```swift
↓extension Tea: Error {}
struct Tea {}

```

```swift
class Ham { class Spam {}}
↓extension Ham.Spam {}

```

```swift
extension External { struct Gotcha {}}
↓extension External.Gotcha {}

```