# Identical Operands

Comparing two identical operands is likely a mistake.

* **Identifier:** identical_operands
* **Enabled by default:** Disabled
* **Supports autocorrection:** No
* **Kind:** lint
* **Analyzer rule:** No
* **Minimum Swift compiler version:** 3.0.0
* **Default configuration:** warning

## Non Triggering Examples

```swift
1 == 2
```

```swift
foo == bar
```

```swift
prefixedFoo == foo
```

```swift
foo.aProperty == foo.anotherProperty
```

```swift
self.aProperty == self.anotherProperty
```

```swift
"1 == 1"
```

```swift
self.aProperty == aProperty
```

```swift
lhs.aProperty == rhs.aProperty
```

```swift
lhs.identifier == rhs.identifier
```

```swift
i == index
```

```swift
$0 == 0
```

```swift
keyValues?.count ?? 0 == 0
```

```swift
string == string.lowercased()
```

```swift
let num: Int? = 0
_ = num != nil && num == num?.byteSwapped
```

```swift
num == num!.byteSwapped
```

```swift
1 != 2
```

```swift
foo != bar
```

```swift
prefixedFoo != foo
```

```swift
foo.aProperty != foo.anotherProperty
```

```swift
self.aProperty != self.anotherProperty
```

```swift
"1 != 1"
```

```swift
self.aProperty != aProperty
```

```swift
lhs.aProperty != rhs.aProperty
```

```swift
lhs.identifier != rhs.identifier
```

```swift
i != index
```

```swift
$0 != 0
```

```swift
keyValues?.count ?? 0 != 0
```

```swift
string != string.lowercased()
```

```swift
let num: Int? = 0
_ = num != nil && num != num?.byteSwapped
```

```swift
num != num!.byteSwapped
```

```swift
1 === 2
```

```swift
foo === bar
```

```swift
prefixedFoo === foo
```

```swift
foo.aProperty === foo.anotherProperty
```

```swift
self.aProperty === self.anotherProperty
```

```swift
"1 === 1"
```

```swift
self.aProperty === aProperty
```

```swift
lhs.aProperty === rhs.aProperty
```

```swift
lhs.identifier === rhs.identifier
```

```swift
i === index
```

```swift
$0 === 0
```

```swift
keyValues?.count ?? 0 === 0
```

```swift
string === string.lowercased()
```

```swift
let num: Int? = 0
_ = num != nil && num === num?.byteSwapped
```

```swift
num === num!.byteSwapped
```

```swift
1 !== 2
```

```swift
foo !== bar
```

```swift
prefixedFoo !== foo
```

```swift
foo.aProperty !== foo.anotherProperty
```

```swift
self.aProperty !== self.anotherProperty
```

```swift
"1 !== 1"
```

```swift
self.aProperty !== aProperty
```

```swift
lhs.aProperty !== rhs.aProperty
```

```swift
lhs.identifier !== rhs.identifier
```

```swift
i !== index
```

```swift
$0 !== 0
```

```swift
keyValues?.count ?? 0 !== 0
```

```swift
string !== string.lowercased()
```

```swift
let num: Int? = 0
_ = num != nil && num !== num?.byteSwapped
```

```swift
num !== num!.byteSwapped
```

```swift
1 > 2
```

```swift
foo > bar
```

```swift
prefixedFoo > foo
```

```swift
foo.aProperty > foo.anotherProperty
```

```swift
self.aProperty > self.anotherProperty
```

```swift
"1 > 1"
```

```swift
self.aProperty > aProperty
```

```swift
lhs.aProperty > rhs.aProperty
```

```swift
lhs.identifier > rhs.identifier
```

```swift
i > index
```

```swift
$0 > 0
```

```swift
keyValues?.count ?? 0 > 0
```

```swift
string > string.lowercased()
```

```swift
let num: Int? = 0
_ = num != nil && num > num?.byteSwapped
```

```swift
num > num!.byteSwapped
```

```swift
1 >= 2
```

```swift
foo >= bar
```

```swift
prefixedFoo >= foo
```

```swift
foo.aProperty >= foo.anotherProperty
```

```swift
self.aProperty >= self.anotherProperty
```

```swift
"1 >= 1"
```

```swift
self.aProperty >= aProperty
```

```swift
lhs.aProperty >= rhs.aProperty
```

```swift
lhs.identifier >= rhs.identifier
```

```swift
i >= index
```

```swift
$0 >= 0
```

```swift
keyValues?.count ?? 0 >= 0
```

```swift
string >= string.lowercased()
```

```swift
let num: Int? = 0
_ = num != nil && num >= num?.byteSwapped
```

```swift
num >= num!.byteSwapped
```

```swift
1 < 2
```

```swift
foo < bar
```

```swift
prefixedFoo < foo
```

```swift
foo.aProperty < foo.anotherProperty
```

```swift
self.aProperty < self.anotherProperty
```

```swift
"1 < 1"
```

```swift
self.aProperty < aProperty
```

```swift
lhs.aProperty < rhs.aProperty
```

```swift
lhs.identifier < rhs.identifier
```

```swift
i < index
```

```swift
$0 < 0
```

```swift
keyValues?.count ?? 0 < 0
```

```swift
string < string.lowercased()
```

```swift
let num: Int? = 0
_ = num != nil && num < num?.byteSwapped
```

```swift
num < num!.byteSwapped
```

```swift
1 <= 2
```

```swift
foo <= bar
```

```swift
prefixedFoo <= foo
```

```swift
foo.aProperty <= foo.anotherProperty
```

```swift
self.aProperty <= self.anotherProperty
```

```swift
"1 <= 1"
```

```swift
self.aProperty <= aProperty
```

```swift
lhs.aProperty <= rhs.aProperty
```

```swift
lhs.identifier <= rhs.identifier
```

```swift
i <= index
```

```swift
$0 <= 0
```

```swift
keyValues?.count ?? 0 <= 0
```

```swift
string <= string.lowercased()
```

```swift
let num: Int? = 0
_ = num != nil && num <= num?.byteSwapped
```

```swift
num <= num!.byteSwapped
```

```swift
func evaluate(_ mode: CommandMode) -> Result<AutoCorrectOptions, CommandantError<CommandantError<()>>>
```

```swift
let array = Array<Array<Int>>()
```

```swift
guard Set(identifiers).count != identifiers.count else { return }
```

```swift
expect("foo") == "foo"
```

```swift
type(of: model).cachePrefix == cachePrefix
```

```swift
histogram[156].0 == 0x003B8D96 && histogram[156].1 == 1
```

## Triggering Examples

```swift
↓1 == 1
```

```swift
↓foo == foo
```

```swift
↓foo.aProperty == foo.aProperty
```

```swift
↓self.aProperty == self.aProperty
```

```swift
↓$0 == $0
```

```swift
↓a?.b == a?.b
```

```swift
if (↓elem == elem) {}
```

```swift
XCTAssertTrue(↓s3 == s3)
```

```swift
if let tab = tabManager.selectedTab, ↓tab.webView == tab.webView
```

```swift
↓1 != 1
```

```swift
↓foo != foo
```

```swift
↓foo.aProperty != foo.aProperty
```

```swift
↓self.aProperty != self.aProperty
```

```swift
↓$0 != $0
```

```swift
↓a?.b != a?.b
```

```swift
if (↓elem != elem) {}
```

```swift
XCTAssertTrue(↓s3 != s3)
```

```swift
if let tab = tabManager.selectedTab, ↓tab.webView != tab.webView
```

```swift
↓1 === 1
```

```swift
↓foo === foo
```

```swift
↓foo.aProperty === foo.aProperty
```

```swift
↓self.aProperty === self.aProperty
```

```swift
↓$0 === $0
```

```swift
↓a?.b === a?.b
```

```swift
if (↓elem === elem) {}
```

```swift
XCTAssertTrue(↓s3 === s3)
```

```swift
if let tab = tabManager.selectedTab, ↓tab.webView === tab.webView
```

```swift
↓1 !== 1
```

```swift
↓foo !== foo
```

```swift
↓foo.aProperty !== foo.aProperty
```

```swift
↓self.aProperty !== self.aProperty
```

```swift
↓$0 !== $0
```

```swift
↓a?.b !== a?.b
```

```swift
if (↓elem !== elem) {}
```

```swift
XCTAssertTrue(↓s3 !== s3)
```

```swift
if let tab = tabManager.selectedTab, ↓tab.webView !== tab.webView
```

```swift
↓1 > 1
```

```swift
↓foo > foo
```

```swift
↓foo.aProperty > foo.aProperty
```

```swift
↓self.aProperty > self.aProperty
```

```swift
↓$0 > $0
```

```swift
↓a?.b > a?.b
```

```swift
if (↓elem > elem) {}
```

```swift
XCTAssertTrue(↓s3 > s3)
```

```swift
if let tab = tabManager.selectedTab, ↓tab.webView > tab.webView
```

```swift
↓1 >= 1
```

```swift
↓foo >= foo
```

```swift
↓foo.aProperty >= foo.aProperty
```

```swift
↓self.aProperty >= self.aProperty
```

```swift
↓$0 >= $0
```

```swift
↓a?.b >= a?.b
```

```swift
if (↓elem >= elem) {}
```

```swift
XCTAssertTrue(↓s3 >= s3)
```

```swift
if let tab = tabManager.selectedTab, ↓tab.webView >= tab.webView
```

```swift
↓1 < 1
```

```swift
↓foo < foo
```

```swift
↓foo.aProperty < foo.aProperty
```

```swift
↓self.aProperty < self.aProperty
```

```swift
↓$0 < $0
```

```swift
↓a?.b < a?.b
```

```swift
if (↓elem < elem) {}
```

```swift
XCTAssertTrue(↓s3 < s3)
```

```swift
if let tab = tabManager.selectedTab, ↓tab.webView < tab.webView
```

```swift
↓1 <= 1
```

```swift
↓foo <= foo
```

```swift
↓foo.aProperty <= foo.aProperty
```

```swift
↓self.aProperty <= self.aProperty
```

```swift
↓$0 <= $0
```

```swift
↓a?.b <= a?.b
```

```swift
if (↓elem <= elem) {}
```

```swift
XCTAssertTrue(↓s3 <= s3)
```

```swift
if let tab = tabManager.selectedTab, ↓tab.webView <= tab.webView
```