# RemoteConversationVCTests

``` swift
class RemoteConversationVCTests: XCTestCase
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

### `testObserveUserMessagesSuccess()`

Test if the observe user messages function can run by looking for a boolean representing success as a result

``` swift
func testObserveUserMessagesSuccess()
```

### `testObserveUserMessages()`

Test if the observe user messages function can fail by looking for a boolean representing failure as a result

``` swift
func testObserveUserMessages()
```

### `testObserveDeleteMessagesSuccess()`

Test if the observe delete messages function can run by looking for a boolean representing success as a result

``` swift
func testObserveDeleteMessagesSuccess()
```

### `testObserveDeleteMessagesFailure()`

Test if the observe delete messages function can fail by looking for a boolean representing failure as a result

``` swift
func testObserveDeleteMessagesFailure()
```

### `testHandleDeleteNote()`

Test if the delete note function can delete a note by seeing if an array of messages is one less. Output is a boolean representing a successful test

``` swift
func testHandleDeleteNote()
```
