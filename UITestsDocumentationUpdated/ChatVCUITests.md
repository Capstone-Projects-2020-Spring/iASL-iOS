# ChatVCUITests

``` swift
class ChatVCUITests: XCTestCase
```

## Inheritance

`XCTestCase`

## Methods

### `setUp()`

``` swift
override func setUp()
```

### `tearDown()`

``` swift
override func tearDown()
```

### `testIfCollectionViewLoads()`

This will test if the collection view is able to load. Output is the existence of a cell in the collection view

``` swift
func testIfCollectionViewLoads()
```

### `testIfSentMessageIsPink()`

This will test if the message that was sent from the user is pink. Output is a matching color

``` swift
func testIfSentMessageIsPink()
```

### `testIfReceivedMessageIsPink()`

This will test if the message that was sent from the partner is gray. Output is a matching color

``` swift
func testIfReceivedMessageIsPink()
```

### `testMessageSent()`

This will test if a message sends and appears in the chatVC. Output is the existence of a message bubble

``` swift
func testMessageSent()
```

### `testIfKeyboardDisappearsOnTappedElsewhere()`

Checks if the keyboard goes away if you tap somewhere else on the screen. Output is a boolean variable defining success

``` swift
func testIfKeyboardDisappearsOnTappedElsewhere()
```
