# RemoteConversationVCUITests

``` swift
class RemoteConversationVCUITests: XCTestCase
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

### `testAddChatButtonGoesToNewView()`

Test if the add chat button takes the user to a new view. Ouput is the existence of an element in the next view controller

``` swift
func testAddChatButtonGoesToNewView()
```

### `testHandleDeleteNoteAreYouSure()`

Test if note checking creates an alert. Output is the existence of an alert

``` swift
func testHandleDeleteNoteAreYouSure()
```

### `testHandleLogout()`

Test if the logout button works as expected by seeing if a button on the login view becomes present. Output is the existence of an element from the login vc

``` swift
func testHandleLogout()
```
