# RemoteConversationVCTests

``` swift
class RemoteConversationVCTests: XCTestCase
```

## Inheritance

`XCTestCase`

## Methods

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

# CreateNoteVCTests

``` swift
class CreateNoteVCTests: XCTestCase
```

## Inheritance

`XCTestCase`

## Methods

### `testHandleNewNoteSuccess()`

Test if the handle new note is successful by looking for a variable that represents success as a result

``` swift
func testHandleNewNoteSuccess()
```

### `testHandleNewNoteFailure()`

Test if the handle new note is a failure by looking for a variable that represents failure as a result

``` swift
func testHandleNewNoteFailure()
```

### `testHandleUpdateNoteSuccess()`

Test if the handle update note is successful by looking for a variable that represents success as a result

``` swift
func testHandleUpdateNoteSuccess()
```

### `testHandleUpdateNoteFailure()`

Test if the handle update note is a failure by looking for a variable that represents failure as a result

``` swift
func testHandleUpdateNoteFailure()
```

# AddChatVCTests

``` swift
class AddChatVCTests: XCTestCase
```

## Inheritance

`XCTestCase`

## Methods

### `testGetUsers()`

Test if the get users function is successful by looking for a boolean that represents success as a result

``` swift
func testGetUsers()
```

# MessageTests

``` swift
class MessageTests: XCTestCase
```

## Inheritance

`XCTestCase`

## Methods

### `testChatPartnerIsReceiver()`

Will check if the chat partner is the receiver. Output is equal chat partner IDs

``` swift
func testChatPartnerIsReceiver()
```

### `testChatPartnerIsSender()`

Will check if the chat partner is the sender. Output is equal chat partner IDs

``` swift
func testChatPartnerIsSender()
```

# ChatVCTests

``` swift
class ChatVCTests: XCTestCase
```

## Inheritance

`XCTestCase`

## Methods

### `testObserveMessagesSucceeds()`

Checks if the observe message function is successful in calling by looking for a boolean representing success as a result

``` swift
func testObserveMessagesSucceeds()
```

### `testObserveMessagesFails()`

Checks if the observe message function fails as a result of the user not being signed in by looking for a boolean representing success as a result

``` swift
func testObserveMessagesFails()
```

# NotesVCTests

``` swift
class NotesVCTests: XCTestCase
```

## Inheritance

`XCTestCase`

## Methods

### `testObserveUserNotesSuccess()`

Test if the observe user notes function can run by looking for a boolean that represents success as a result

``` swift
func testObserveUserNotesSuccess()
```

### `testObserveUserNotesFailure()`

Test if the observe user notes function can fail by looking for a boolean that represents failure as a result

``` swift
func testObserveUserNotesFailure()
```

### `testHandleDeleteNote()`

Test if the user can delete a note. Output is a boolean representing a successful test

``` swift
func testHandleDeleteNote()
```
