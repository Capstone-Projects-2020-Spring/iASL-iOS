# NotesVCUITests

``` swift
class NotesVCUITests: XCTestCase
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

### `testHandleDeleteNoteAreYouSure()`

Test if the user is prompted for a deletion note reassurance by checking for an alert

``` swift
func testHandleDeleteNoteAreYouSure()
```

### `testShowNoteFromTableView()`

Test if a note can be dislayed from a table view by checking for the existence of an element from the next view controller

``` swift
func testShowNoteFromTableView()
```

### `testCreateNoteButtonTapped()`

Test if the create a note button works by seeing if an element in the next view controller exists as output

``` swift
func testCreateNoteButtonTapped()
```

### `testBackButton()`

Test if the back button works by seeing if an element in the previous view controller exists as output

``` swift
func testBackButton()
```
