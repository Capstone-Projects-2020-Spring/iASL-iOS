# AddChatVCUITests

``` swift
class AddChatVCUITests: XCTestCase
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

### `testBackButton()`

Test if the back button gets us to a new view by checking for the existence of something in the new view as output

``` swift
func testBackButton()
```
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
# Types

- [ASLKeyboardUITests](ASLKeyboardUITests)
- [AddChatVCUITests](AddChatVCUITests)
- [ChatVCUITests](ChatVCUITests)
- [CreateNoteVCUITests](CreateNoteVCUITests)
- [LoginVCUITests](LoginVCUITests)
- [MessageUITests](MessageUITests)
- [NotesVCUITests](NotesVCUITests)
- [RemoteConversationVCUITests](RemoteConversationVCUITests)
- [iASLUITests](iASLUITests)

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

# MessageUITests

``` swift
class MessageUITests: XCTestCase
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
override class func tearDown()
```

### `testSetNameLabel()`

Will check if the set name label returns a specified name from a message. Output is a matching label as one that I input

``` swift
func testSetNameLabel()
```

### `testSetMostRecentMessageLabel()`

Will check if the set most recent message label returns the most recent message in a list of messages. Output is a matching label as one that I input

``` swift
func testSetMostRecentMessageLabel()
```

### `testSetTimestampLabel()`

WIll check if the set timestamp label returns the correct time. Output is a matching label as one that I input

``` swift
func testSetTimestampLabel()
```
