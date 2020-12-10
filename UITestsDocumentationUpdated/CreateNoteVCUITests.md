# CreateNoteVCUITests

``` swift
class CreateNoteVCUITests: XCTestCase
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

### `testSaveButtonEnabledAndToggled()`

Test if the save button works by testing if the save button gets toggled. Output would be changed text

``` swift
func testSaveButtonEnabledAndToggled()
```

### `testLoadNoteWorks()`

Test if the note can load another note by tappnig on the table view and seeing if the output has some text was presented in the new VC

``` swift
func testLoadNoteWorks()
```

### `testBackButton()`

Test if the back button can get us to the previous view controller. Output is the existence of an element in the new view controller

``` swift
func testBackButton()
```
