# LoginVCUITests

``` swift
class LoginVCUITests: XCTestCase
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

### `testHandleLeaveLogin()`

Test if the user can leave the login screen. Output is the existence of an element in the next view controller

``` swift
func testHandleLeaveLogin()
```

### `testToggleRegisterLoginButtonPressed()`

Test if the register button can be toggled. Output is the existence of new text in the toggle button

``` swift
func testToggleRegisterLoginButtonPressed()
```

### `testInfoSubmitButtonPressed()`

Test if the button works to submit the info for login. Output is the existence of an element in the next view controller

``` swift
func testInfoSubmitButtonPressed()
```

### `testHandleRegister()`

Test if the user can register. Output is the existence of a boolean representing a successful pass

``` swift
func testHandleRegister()
```

### `testHandleLogin()`

Test if the user can login. Output is the existence of a boolean representing a successful pass

``` swift
func testHandleLogin()
```

### `testSkipButton()`

Test if the skip button works. Output is the existence of an element in the next view controller

``` swift
func testSkipButton()
```
